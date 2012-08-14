From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [RFC/PATCH 0/2] ROW scheduling Algorithm
Date: Wed, 15 Aug 2012 04:09:21 +0900
Message-ID: <CAELcNGRQMPno=rYkTO5M7Ai-Vq+aO4EL30x5VbcyvnShjdnpgw@mail.gmail.com>
References: <1344166241-18708-1-git-send-email-tlinder@codeaurora.org>
	<502214E8.7070603@samsung.com>
	<004201cd75ec$bb701970$32504c50$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61960 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab2HNTJX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Aug 2012 15:09:23 -0400
In-Reply-To: <004201cd75ec$bb701970$32504c50$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanya Brokhman <tlinder@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, axboe@kernel.dk, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi,

i will try the test with your comment. and will share the result.
Thanks for reply.

Best Regards,
Jaehoon Chung

2012/8/9 Tanya Brokhman <tlinder@codeaurora.org>:
> Hi Chung
>
>
>> The below is my environment:
>> Kernel Version: linux-3.4
>> Card: eMMC4.5 (50MHz DDR mode, 8-bit buswidth) Host controller : dw-
>> mmc (DesignWare MMC controller) Benchmark : IOzone
>>
>> *CFQ Scheduler
>> Read : 35MB
>> Write : 17MB
>>
>> *ROW Scheduler
>> Read : 28MB
>> Write : 17MB
>>
>> How do you think about this result?
>>
>
> I run your cmd of iozone on my setup and got a bit different results:
> CFQ scheduler:
>           204800   16384   27903   27248    40345    40399
> READ:   40   MB/sec             WRITE: 27   MB/sec
>
> ROW scheduler:
> READ:   39.6 MB/sec             WRITE: 27MB/sec
>
> As you can see the results are the same for both schedulers.
> Anyway, the improvement added by ROW is in scenario of parallel read and write, which iozone doesn't do so running iozone for comparing ROW to CFQ is useless.
> If it's not too difficult I would appreciate if you could run the bellow 2 commands simultaneously on your setup:
> adb shell /data/lmdd if=internal of=/data/writefile bs=128k count=3000
> adb shell /data/lmdd if=/data/readfile of=internal bs=128k count=3000
> You'll see an improvement in throughput when using ROW over CFQ.
> We have a patch that also measures latency and we saw that read latency was also improved greatly when using ROW.
>
>
> Thanks,
> Tanya Brokhman
> ---
> Sent by an consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
