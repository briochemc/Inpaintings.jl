# This uses MATLAB's definition of the `peaks` function to test `inpaint_nans`

peaks(x, y) = 3 * (1 - x)^2 * exp(-(x^2) - (y + 1)^2) -
    10 * (x/5 - x^3 - y^5) * exp(-x^2 - y^2) -
    1/3 * exp(-(x + 1)^2 - y^2)

xs = LinRange(-3, 3, 50)
ys = LinRange(-3, 3, 50)
Z = [peaks(x, y) for y in ys, x in xs]

# Remove some values in blocks
# Remove some values at random indices (pregenerated for determinism of the test)
# pregenerated via `rand(CartesianIndices(size(Z)), 10)`
# Note I made sure no NaN on the border, need to figure out why different from MATLAB there
idx = [
 vec(CartesianIndices((1:10, 1:10)))
 vec(CartesianIndices((20:40, 20:35)))
 CartesianIndex(45, 8)
 CartesianIndex(41, 24)
 CartesianIndex(5, 30)
 CartesianIndex(15, 22)
 CartesianIndex(17, 18)
 CartesianIndex(9, 11)
 CartesianIndex(3, 21)
 CartesianIndex(42, 26)
 CartesianIndex(16, 16)
 CartesianIndex(22, 42)
]



@testset "Testing on $Type" for T in (Float16, Float32, Float64)
    Z_T = convert.(T, Z)
    @testset "with missing values" begin
        Z_with_missing_values_T = convert(Array{Union{Missing, eltype(Z_T)}} ,Z_T)
        Z_with_missing_values_T[idx] .= missing
        Z_inpainted_missing_T = inpaint(Z_with_missing_values_T)
        @test Z_inpainted_missing_T == inpaint(ismissing, Z_with_missing_values_T)
        @test Z_inpainted_missing_T == inpaint(Z_with_missing_values_T, missing)
    end
    @testset "with NaN values" begin
        Z_with_NaN_values_T = copy(Z_T)
        Z_with_NaN_values_T[idx] .= NaN
        Z_inpainted_NaN_T = inpaint(Z_with_NaN_values_T)
        @test Z_inpainted_NaN_T == inpaint(isnan, Z_with_NaN_values_T)
        @test Z_inpainted_NaN_T == inpaint(Z_with_NaN_values_T, NaN)
    end
end

@testset "Inpainting `NaN`s or `missing`s is the same" begin
    Z_with_missing_values = convert(Array{Union{Missing, eltype(Z)}} ,Z)
    Z_with_missing_values[idx] .= missing
    Z_inpainted_missing = inpaint(Z_with_missing_values)
    Z_with_NaN_values = copy(Z)
    Z_with_NaN_values[idx] .= NaN
    Z_inpainted_NaN = inpaint(Z_with_NaN_values)
    @test Z_inpainted_NaN == Z_inpainted_missing
end

#using Plots
#contourf(ys, xs, Z)
#contourf(ys, xs, Z_with_NaNs)
#contourf(ys, xs, Z_reconstructed)



# @testset "Comparison with MATLAB" begin
#     Z_with_NaN_values = copy(Z)
#     Z_with_NaN_values[idx] .= NaN
#     Z_inpainted_NaN = inpaint(Z_with_NaN_values)#=
#     MATLAB code used to compare both values:
# 
#     Z = peaks(50) ;
#     Z_with_NaNs = Z ;
#     Z_with_NaNs(1:10, 1:10) = nan ;
#     Z_with_NaNs(20:40, 20:35) = nan ;
#     Z_with_NaNs(45, 8) = nan ;
#     Z_with_NaNs(41, 24) = nan ;
#     Z_with_NaNs(5, 30) = nan ;
#     Z_with_NaNs(15, 22) = nan ;
#     Z_with_NaNs(17, 18) = nan ;
#     Z_with_NaNs(9, 11) = nan ;
#     Z_with_NaNs(3, 21) = nan ;
#     Z_with_NaNs(42, 26) = nan ;
#     Z_with_NaNs(16, 16) = nan ;
#     Z_with_NaNs(22, 42) = nan ;
#     Z_reconstructed0 = inpaint_nans(Z_with_NaNs) ;
#     inan = find(isnan(Z_with_NaNs)) ;
#     format long
#     for_test_with_Julia = Z_reconstructed0(inan)
# 
#     Z_reconstructed3 = inpaint_nans(Z_with_NaNs, 3) ;
#     inan = find(isnan(Z_with_NaNs)) ;
#     format long
#     for_test_with_Julia = Z_reconstructed3(inan)
#     =#
#     #output from MATLAB (with added `[` and `]` to create an array in Julia):
#     for_test_with_Julia0 = [
#       -0.029498484825455
#       -0.026388649032511
#       -0.023224164811533
#       -0.019959714697592
#       -0.016570534539756
#       -0.013067274772867
#       -0.009515737748511
#       -0.006061284483498
#       -0.002954053931593
#       -0.000562233983451
#       -0.024738859622865
#       -0.021849554031150
#       -0.018886708512840
#       -0.015846133780332
#       -0.012745515609159
#       -0.009632984965416
#       -0.006596031513876
#       -0.003768591556022
#       -0.001332853175635
#        0.000486275908415
#       -0.020033882848309
#       -0.017374667993280
#       -0.014606428114350
#       -0.011757181715958
#       -0.008877257234395
#       -0.006043559300535
#       -0.003362033848600
#       -0.000966148114188
#        0.000989133038145
#        0.002331476799184
#       -0.015447533892928
#       -0.012992036440880
#       -0.010369686528229
#       -0.007632954622375
#       -0.004857137895978
#       -0.002143656346511
#        0.000379107679895
#        0.002560141558851
#        0.004236580202934
#        0.005247311276165
#       -0.011060562686287
#       -0.008755973865576
#       -0.006200733071729
#       -0.003462516608642
#       -0.000631555553168
#        0.002173486132572
#        0.004801671545321
#        0.007071916420969
#        0.008786181682142
#        0.009758475053551
#       -0.006974002641464
#       -0.004752793731375
#       -0.002171426761450
#        0.000700684972057
#        0.003775005310586
#        0.006932448068480
#        0.010012028603876
#        0.012803850132208
#        0.015056088124606
#        0.016513669823151
#       -0.003306656703570
#       -0.001102305535409
#        0.001590577322355
#        0.004720027170229
#        0.008225081189160
#        0.012017691152981
#        0.015960720685646
#        0.019843008634245
#        0.023362422101999
#        0.026151282842149
#       -0.000184793939314
#        0.002048303388213
#        0.004900640697375
#        0.008361573956673
#        0.012432323559789
#        0.017104013738851
#        0.022326545579092
#        0.027959080144713
#        0.033703122438236
#        0.039058183237819
#        0.022750875077404
#        0.002276664167332
#        0.004542189596323
#        0.007530709533852
#        0.011296841495850
#        0.015941569838531
#        0.021595958353736
#        0.028391819043663
#        0.036391951923893
#        0.045452985557788
#        0.054969855759669
#        0.004000278866272
#        0.006245896531532
#        0.009246891348237
#        0.013138306385561
#        0.018148210657288
#        0.024608390703909
#        0.032949462589523
#        0.043633483822409
#        0.056996977310186
#        0.072401999091913
#        0.065371006725438
#        1.129882922629364
#        1.988620826083542
#        3.303724922677607
#        3.009995700318911
#        2.522280335893179
#        1.935724677977175
#        1.335626062214603
#        0.786514582285719
#        0.329257265994138
#       -0.012311657560658
#       -0.219872146405397
#       -0.271552277631725
#       -0.141161352351552
#        0.193031222412800
#        0.733937769112330
#        1.452862117914674
#        2.285084082216744
#        3.137081028104408
#        3.903712648745315
#        4.489649932804268
#        4.827799745843459
#        4.888793767353252
#        4.679011144603867
#       -0.347745054253215
#        3.591122343685997
#        3.386431769732992
#        2.989300926148785
#        2.491065998125949
#        1.967669764377622
#        1.478074025887852
#        1.064190275208859
#        0.755382062315507
#        0.575505763016592
#        0.548067726710194
#        0.695792892311918
#        1.033891923622987
#        1.559825281387967
#        2.244540055312318
#        3.029924614704668
#        3.834745050730286
#        4.567802105281467
#        5.144058732563776
#        5.498221851097060
#        5.591050052762111
#        5.406096358679440
#       -0.936349385455035
#        3.605222930686874
#        3.517335900783082
#        3.238434122298406
#        2.855954919299696
#        2.438128155347086
#        2.038640173647655
#        1.698757563008107
#        1.450453032091489
#        1.320251698895966
#        1.331587825880717
#        1.503653343197570
#        1.846464367099045
#        2.354023174309642
#        2.998800289086334
#        3.730582290842233
#        4.481087430169427
#        5.173391472916311
#        5.733154387927366
#        6.097701028234379
#        6.219428978194833
#        6.061349487151569
#        3.341357929388249
#        3.401575746573586
#        3.271910711435003
#        3.032861610516547
#        2.745867386925606
#        2.460181939071189
#        2.215800804391726
#        2.045583984772825
#        1.977088264304427
#        2.033220296675575
#        2.230770425339385
#        2.576833101618545
#        3.064353679782952
#        3.668809993104651
#        4.347878437474010
#        5.044864254124493
#        5.695141212675974
#        6.233486881758082
#        6.599558704652425
#        6.739079041437797
#        6.599355170330182
#        2.841380838344105
#        3.073456166079014
#        3.117835543539121
#        3.043622374128044
#        2.905309952338734
#        2.748350998076220
#        2.611441878223756
#        2.527655274298543
#        2.524998203677983
#        2.626108194716650
#        2.846717602988466
#        3.193021104984742
#        3.658761902188411
#        4.223260384941719
#        4.851462918644687
#        5.496387500127723
#        6.103345823932464
#        6.614403076650654
#        6.971000687331017
#        7.112617051973382
#        6.969952192873624
#        6.455710135848094
#        2.189987011895347
#        2.601613306675576
#        2.830176991678914
#        2.929371693158437
#        2.945987309168736
#        2.921841403893273
#        2.894361950105836
#        2.896616319559052
#        2.956982539367739
#        3.098305237796421
#        3.336388427291948
#        3.677980326506684
#        4.118785337685906
#        4.642244485161791
#        5.219696188434319
#        5.812064622822803
#        6.372579171173087
#        6.849441367135294
#        7.187041793446022
#        7.324410700631058
#        7.189911243175136
#        1.499102206008667
#        2.077388586895414
#        2.480649448955863
#        2.744936031990387
#        2.908506629225304
#        3.009228703433169
#        3.083001636885966
#        3.162638262674267
#        3.276847250223310
#        3.449043317003553
#        3.695861784634070
#        4.025492679764202
#        4.436186506668263
#        4.915390513008766
#        5.439864987537813
#        5.976810042364554
#        6.485601875796809
#        6.919335844318305
#        7.225116240194605
#        7.341923924819143
#        7.194750301845644
#        5.671431293467855
#        0.884976745598062
#        1.596898607694587
#        2.145528754368911
#        2.549428323356424
#        2.837808701585293
#        3.043913463270044
#        3.201453776487057
#        3.342469255905483
#        3.495756563611108
#        3.685408445321751
#        3.929282174234797
#        4.237455450145543
#        4.610911349574935
#        5.040762116817356
#        5.508232517431887
#        5.985389442096245
#        6.436293972558468
#        6.817960282276927
#        7.080307178891673
#        7.164193256342912
#        6.996570380585938
#        0.444088620428157
#        1.241814847582343
#        1.891185699808595
#        2.395684939700155
#        2.775482579377672
#        3.058382230098587
#        3.274952160955224
#        3.455673493226433
#        3.628960314423669
#        3.819456857567038
#        4.046366814253769
#        4.321829435780246
#        4.649535475282198
#        5.023840615981928
#        5.429561704253726
#        5.842449022088037
#        6.230076247051698
#        6.552659960890115
#        6.763181050163189
#        6.806159870783462
#        6.614524945211913
#        0.234143026191824
#        1.063859732965861
#        1.762110299946653
#        2.321268475171566
#        2.753040279660386
#        3.079093031388457
#        3.325844012225440
#        3.521330696754089
#        3.693008503739355
#        3.865840121979854
#        4.060395549437099
#        4.290964061600172
#        4.563882881385299
#        4.876370906745426
#        5.216093759549064
#        5.561498942421485
#        5.882714719785381
#        6.142595115742952
#        6.297397705775117
#        6.296646212478618
#        6.081963803990073
#       -1.304113302100942
#        0.264864119862779
#        1.076767534905692
#        1.774265809474048
#        2.343112646917163
#        2.787626544439828
#        3.123004601683320
#        3.370727451872211
#        3.555626497313267
#        3.703693791323439
#        3.840036588436643
#        3.986682118643480
#        4.160251632071094
#        4.369784660342527
#        4.615119318391659
#        4.886173709300114
#        5.163249686938340
#        5.418184266253171
#        5.615930452864633
#        5.716069561318138
#        5.673903109796492
#        5.441147050863004
#        0.500333652721862
#        1.257203202530716
#        1.914959741995662
#        2.456713472452514
#        2.880827599256626
#        3.196218253087131
#        3.419070278721062
#        3.570536270531234
#        3.674846322700917
#        3.757268272879267
#        3.841591356006739
#        3.947190141471677
#        4.086100541045631
#        4.260738248358979
#        4.462819505382224
#        4.673731340154781
#        4.866178492601913
#        5.006592712913562
#        5.057688910784330
#        4.980774095119175
#        4.737944237149260
#        0.871317132785956
#        1.553561990059058
#        2.148519470287879
#        2.639408555952556
#        3.020287826420123
#        3.294544498578586
#        3.473185081860170
#        3.573522819462547
#        3.617946861824382
#        3.632124219155846
#        3.642188172961322
#        3.671009216682895
#        3.734223756720642
#        3.837018520427409
#        3.972574469877225
#        4.122600578288115
#        4.259745752323171
#        4.351151777011490
#        4.362241567613848
#        4.260135177997217
#        4.016808341160816
#        1.293398270865739
#        1.899455740342281
#        2.425447790453951
#        2.856109671892609
#        3.183005879423897
#        3.405214180617262
#        3.529016116126332
#        3.567878338476723
#        3.542344731244552
#        3.478834009327804
#        3.406616801634568
#        3.353091136842986
#        3.338392516317580
#        3.370892533942903
#        3.445003032596680
#        3.541973003387718
#        3.633374594962175
#        3.686159961794112
#        3.667883809165214
#        3.551069123415919
#        3.316664558966580
#        1.685519048949281
#        2.227541307184004
#        2.691800278815853
#        3.065171251558803
#        3.338693484603954
#        3.508577040151510
#        3.576871840363392
#        3.553065919655749
#        3.455666675448214
#        3.312047105069654
#        3.155349430381984
#        3.018564528651713
#        2.927319796961117
#        2.893701358602887
#        2.913230225978237
#        2.966013724717622
#        3.021614156201549
#        3.045966592750502
#        3.008230606101403
#        2.885938504463028
#        2.668055678350101
#        1.983687274849697
#        2.479169011918075
#        2.895395379835811
#        3.222088867593804
#        3.451629521473798
#        3.578581931945603
#        3.601031762927470
#        3.524104542910332
#        3.363713088576560
#        3.147842640850084
#        2.913547220732306
#        2.699762770641832
#        2.538059845382889
#        2.444573857034302
#        2.416046232820994
#        2.431362332110222
#        2.457920410509647
#        2.460515951035668
#        2.409821718940406
#        2.288130310799809
#        2.091506309587206
#        1.138103428467866
#     ]
# 
#     inan = findall(@. isnan(Z_with_NaNs))
#     @test Z_inpainted_NaN[inan] ≈ for_test_with_Julia0
# end