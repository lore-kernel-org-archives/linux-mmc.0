From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: MMC card removal during suspend
Date: Thu, 01 Oct 2015 18:43:14 +0900
Message-ID: <560D0032.4030505@samsung.com>
References: <CAJ=nTsuXgR4Fmjriy32LvbO49Yk_q0RYBV1S2FwHG+hZgG3aRw@mail.gmail.com>
 <CAPDyKFraSBSeRebD7VXbo8TTquSK4qUnqO6GvfRa-ye--7JXuA@mail.gmail.com>
 <CAJ=nTsuy2aD66DSc5kmEi79OjzPsXdOC2bx5-GxS=xy8LMCA=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60553 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbbJAJnR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2015 05:43:17 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NVJ00FBFCC3XZ10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 Oct 2015 18:43:15 +0900 (KST)
In-reply-to: <CAJ=nTsuy2aD66DSc5kmEi79OjzPsXdOC2bx5-GxS=xy8LMCA=Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mirza Krak <mirza.krak@hostmobility.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 10/01/2015 01:10 AM, Mirza Krak wrote:
> Hi again.
> 
> Thank you for your response Ulf.
> 
> I am going to start over though since I did not get everything right
> the first time.
> 
> As stated I am running the 4.1.5 Linux kernel and what I am actually
> using is a SD card. The host driver is sdhci-esdhc-imx.c.
> 
> And my initial issue was that on resume I get the following:
> [   31.848397] mmc0: card never left busy state
> [   31.848412] mmc0: error -110 during resume (card was removed?)
> [   31.848550] PM: resume of devices complete after 2062.936 msecs
> [   31.931086] PM: Finishing wakeup.
> [   31.931102] Restarting tasks ... done.
> [   31.954336] mmc0: card dade removed
> [   32.358711] mmc0: host does not support reading read-only switch,
> assuming write-enable
> [   32.391857] mmc0: new SD card at address aaaa
> [   32.418228] mmcblk0: mmc0:aaaa SU02G 1.84 GiB
> [   32.446402]  mmcblk0: p1
> [   32.835907] EXT4-fs (mmcblk0p1): recovery complete
> [   32.840873] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
> data mode. Opts: (null)
> 
> And that was the reason of my initial questions on what is supposed to
> happen when suspending.

Almost MMC cards supposed that should be removed. So we are using "non-removable" property in dt-file.
By default, assume that card can be removed.
Since sd-card can be changed during suspend.
(we don't know whether card is changed or not if it doesn't register to wakeup source,)

> 
> The card IS actually "removed" when in suspended state since we cut
> the power-rail completely to the SD card.
> 
> I assume that this is a sdhci-esdhc-imx issue, but then I wonder what
> would be a proper fix for this.

Sorry, i don't fully understand what problem you want to fix. :)

Best Regards,
Jaehoon Chung

> 
> As stated before I get around this problem by adding a HACK to force
> removal of the SD card before suspending in mmc_pm_notify.
> 
> Sorry if I am spamming but I am trying to learn :).
> 
> Best Regards
> 
> Mirza Krak
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

