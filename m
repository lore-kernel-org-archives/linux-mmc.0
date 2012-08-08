From: "Tanya Brokhman" <tlinder@codeaurora.org>
Subject: RE: [RFC/PATCH 0/2] ROW scheduling Algorithm
Date: Wed, 8 Aug 2012 13:37:22 +0300
Message-ID: <004101cd7551$cd269130$6773b390$@codeaurora.org>
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

> Hi
> 
> I tested with this patch on my board.
> But i didn't get any performance benefit.
> Which benchmark did you use?

As I already mentioned I used lmdd. The results I published were collected using the bellow command run in parallel:
adb shell /data/lmdd if=internal of=/data/writefile bs=128k count=3000
adb shell /data/lmdd if=/data/readfile of=internal bs=128k count=3000

With lmdd we did see great improvement both in throughput and in read latency:
CFQ:	     READ  20.81 MB/sec,    WRITE  15.23 MB/sec   Worst case READ latency 230 msec     Worst case write latency   9370   msec
ROW:         READ  27.75 MB/sec      WRITE  15.34 MB/sec   Worst case READ latency   85 msec     Worst case write latency   12025 msec

ROW can be configured to perform at ~34 MB/sec throughput in the above scenario but in this configuration worst case write latency increases to ~13 sec.

> And sometime this scheduler didn't work well read/write operation.
> (i didn't know exactly what problem.)

This may be. We're still working on testing the scheduler and improving it. It's not yet totally "bug free". I've uploaded the code as RFC. 

> 
> The below is my environment:
> Kernel Version: linux-3.4
> Card: eMMC4.5 (50MHz DDR mode, 8-bit buswidth) Host controller : dw-
> mmc (DesignWare MMC controller) Benchmark : IOzone
> 

My environment is similar except the host controller which is msm-sdcc. 
Could you please give me the exact iozone command you used? I'll replay it on my setup.

Thanks,
Tanya Brokhman
---
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
