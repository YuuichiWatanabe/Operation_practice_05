//
//  TestService1.swift
//  Operation_practice_05
//
//  Created by yuichi.watanabe on 2016/10/04.
//  Copyright © 2016年 yuichi.watanabe. All rights reserved.
//
/* viewControllerが呼び出す、処理の集まった機能群を想定
 * このクラスは、業務要件に沿ったアクティビティを実現させるために
 * 複数のOperationを制御して実現させる
 * サービス指向の構築でクラス設計してみる
 */
/* 例：ログイン認証
 * 1.ユーザーが存在するか(ID/PW) ? 存在する : 存在しない
 * 2.権限が存在するか ? ユーザーの権限あり : ユーザーの権限なし
 */
/* 例：出社準備
 * 1.顔を洗う
 * 2.健康 ? 健康 : 病気
 * 2-false. 病気の報告 -> 終了
 * 2-true. 並列　新聞を読む　＆　(朝食を食べる -> 歯を磨く)
 * 3. 服を着替える
 */
/* 例：顧客IDの採番
 * 1.顧客区分を取得する ? 企業 : 個人
 * 1-false. 個人の最終番号を取得
 * 1-true. 企業の最終番号を取得
 * 2. 次の番号を算出する
 * 3. 番号に顧客区分の文字列を付加する
 * 4. その番号 return
 */

import Foundation


class TestService1 : NSObject
{
    let intProperty : Int
    
    init( intProperty i: Int )
    {
        self.intProperty = i
    }
    
    /// **ログイン認証(例)**
    /// 1.ユーザーが存在するか(ID/PW) ? 存在する : 存在しない
    /// 2.権限が存在するか ? ユーザーの権限あり : ユーザーの権限なし
    // 書けてるけど、ダサいなー
    func loginAuthentication() -> Bool // ログイン認証
    {
        var isAuthenticated = false
        
        let testOperation3  = TestOperation3()
        
// memo: 直列で行いたい場合、completionBlockではどうしてもサブスレットに飛んでしまうため使えない
//       結果、一つのoperationとやりとりする形に。operationの中から続きのoperationを続けるチェーンになる
//       無理やり感がすごい。柔軟な業務フローを表現しにくいし、見通しも悪い、オブジェクト指向と言えない
//       と壁にぶつかれたところで、今度はキューを導入してどう改善されるか検証していきたい
//       他のアクティビティ例も用意したが、この書き方は面倒。気が進まず
//        let testOperation4  = TestOperation4()
//
//            testOperation3.completionBlock = {
//                DispatchQueue.main.sync {
//                    if testOperation3.getResultValue() {
//                        testOperation4.start()
//                        testOperation4.waitUntilFinished() // start直後でないとstartすらされなくなる
//                    }
//                    else {
//                        testOperation4.cancel()
//                    }
//                }
//            }
//            testOperation4.completionBlock = {
//                DispatchQueue.main.sync {
//                    if testOperation4.getResultValue() {
//                        isAuthenticated = true
//                    }
//                }
//            }
            testOperation3.start()
            testOperation3.waitUntilFinished() // start直後でないとstartすらされなくなる
        isAuthenticated = testOperation3.getResultValue()
        
            // koko?
        print("loginAuthentication:last: \(isAuthenticated) \(Thread.current)")
        // 3 -> 4 -> return と順番に行いたいが スレッドがmainから外れるので先に最後ききてしまう。comp部がsubスレッドだから
        // その後なんとか、直列に動作させてみた
        return isAuthenticated
    }
    
    
    func attendancePreparation() // 出勤の準備
    {
        
    }
    
    
    func numberingCustomerID() // 顧客IDの採番
    {
        
    }
    
    
    

    
    
}
