
#import "InterfaceController.h"


@interface InterfaceController() {
	
	NSTimeInterval	startTime;	// 開始時刻のメモ
	NSTimer*		timer;		// タイマーオブジェクト
}

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {

	// Watchフェイスから画面が消えたらタイマーを止める
	[self stopButtonPushed];

	[super didDeactivate];
}

#pragma mark - Timer job

// Startボタンが押された時の処理
- (IBAction)startButtonPushed {
	
	// タイマーを起動
	if(!timer) {
		timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerJob) userInfo:nil repeats:YES];
	}
	
	// ラベルの初期表示
	[_timerLabel setText:@"00:00:00"];
	
	// 開始時刻をメモする
	startTime = [NSDate timeIntervalSinceReferenceDate];
}

// Stopボタンが押された時の処理
- (IBAction)stopButtonPushed {

	// タイマーを廃棄
	[timer invalidate];
	timer = nil;
}

// 定期タイマー処理
- (void)timerJob {
	
	// 経過時間をラベルに表示
	[_timerLabel setText:[self getTimeString]];
}

- (NSString*)getTimeString {
	
	// メモした開始時刻からの差分を計算
	NSTimeInterval interval = [NSDate timeIntervalSinceReferenceDate] - startTime;
	
	// 経過時間を文字列に
	int hour = interval / (60*60);
	int min  = fmod((interval/60), 60);
	int sec  = fmod(interval, 60);
	
	return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, min, sec];
}

@end

