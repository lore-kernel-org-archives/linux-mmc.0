From: "Tanya Brokhman" <tlinder@codeaurora.org>
Subject: RE: [RFC/PATCH 0/2] ROW scheduling Algorithm
Date: Thu, 9 Aug 2012 08:06:25 +0300
Message-ID: <004201cd75ec$bb701970$32504c50$@codeaurora.org>
References: <1344166241-18708-1-git-send-email-tlinder@codeaurora.org> <502214E8.7070603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <502214E8.7070603@samsung.com>
Content-language: he
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: axboe@kernel.dk, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chung


> The below is my environment:
> Kernel Version: linux-3.4
> Card: eMMC4.5 (50MHz DDR mode, 8-bit buswidth) Host controller : dw-
> mmc (DesignWare MMC controller) Benchmark : IOzone
> 
> *CFQ Scheduler
> Read : 35MB
> Write : 17MB
> 
> *ROW Scheduler
> Read : 28MB
> Write : 17MB
> 
> How do you think about this result?
> 

I run your cmd of iozone on my setup and got a bit different results:
CFQ scheduler:
          204800   16384   27903   27248    40345    40399
READ:	40   MB/sec 		WRITE: 27   MB/sec

ROW scheduler:
READ:	39.6 MB/sec		WRITE: 27MB/sec

As you can see the results are the same for both schedulers.
Anyway, the improvement added by ROW is in scenario of parallel read and write, which iozone doesn't do so running iozone for comparing ROW to CFQ is useless.
If it's not too difficult I would appreciate if you could run the bellow 2 commands simultaneously on your setup:
adb shell /data/lmdd if=internal of=/data/writefile bs=128k count=3000 
adb shell /data/lmdd if=/data/readfile of=internal bs=128k count=3000
You'll see an improvement in throughput when using ROW over CFQ.
We have a patch that also measures latency and we saw that read latency was also improved greatly when using ROW.


Thanks,
Tanya Brokhman
---
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
