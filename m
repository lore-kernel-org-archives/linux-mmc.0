From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: Ricoh SD card reader, error on r/w lots of data.
Date: Thu, 12 Jan 2012 16:58:44 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1201121652280.5761@happy>
References: <OF3E300FC6.0B39449E-ON49257983.000AB8A4-49257983.000D42BE@mta.ricoh.co.jp>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1580141188-1326383925=:5761"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59275 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab2ALP6t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2012 10:58:49 -0500
In-Reply-To: <OF3E300FC6.0B39449E-ON49257983.000AB8A4-49257983.000D42BE@mta.ricoh.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: matsumur@nts.ricoh.co.jp, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1580141188-1326383925=:5761
Content-Type: TEXT/PLAIN; charset=ISO-2022-JP; format=flowed



Hi Chris,

Would like to know what your thoughts are on this before I start digging 
into finding a solution. I increased the current limit_us from 300ms to 
600ms and I did see much fewer IO errors reported by the driver. I see 
that we have routines in mmc/card/block.c that does recovery and reset, 
are these already in the lines of what Matsumuro-san is suggesting?

Thanks a ton
Manoj


On Thu, 12 Jan 2012, matsumur@nts.ricoh.co.jp wrote:

> Hi Manoj Iyer-san,
>
> Now, The time limit of SDXC is 500ms, but some old SD(ver.1.x) and MMC must
> be take more larger time.
>
> Regarding Ricoh SD Controller's error, I am not sure what happened.
> Do you know which timing the error occurred during data transfer ?
> If the error occurred when the transfer finishes, you can try to issue an
> abort command. After that, execute the software reset of CMD/DAT Line.  In
> that case, the driver must retry the data transfer.
>
> Thanks,
>
> Koji Matsumuro
> Ricoh Company,Ltd.
>
>
>
>
>
>
>             Manoj Iyer
>             <manoj.iyer@canon
>             ical.com>                                                宛先
>                                        Koji Matsumuro/R/RICOH@RICOH
>             2012/01/11 22:35                                           cc
>
>                                                                      件名
>                                        Ricoh SD card reader, error on r/w
>                                        lots of data.
>
>
>
>
>
>
>
>
>
>
> Koji Matsumoro San,
>
> Ricoh SD/SDHCI/MMC card readers R5C822, e823, 822 etc generate the
> following error when transferring massive amounts of data.
>
> [ 6843.012038] mmcblk0: error -110 transferring data, sector 409666, nr 2,
> cmd response 0x900, card status 0xc00
> [ 6843.014440] end_request: I/O error, dev mmcblk0, sector 409666
> [ 6843.014448] Buffer I/O error on device mmcblk0p2, logical block 131105
> [ 6843.014453] lost page write due to I/O error on mmcblk0p2
> [ 6844.371388] mmcblk0: error -110 transferring data, sector 671810, nr 2,
> cmd response 0x900, card status 0xc00
>
> There are a lot of bug reports regarding this error, I am using a 16GB
> SDHC card, and transferring around 1000 files ranging from sizes 800KB to
> 1.5MB.
>
> Looking at the kernel code, looks like in drivers/mmc/core/core.c,
> increasing the value of data timeout (limit_us to 500000), reduces the
> occurrence of these errors, but does not eliminate it. I am guessing the
> real problem is some place else, increasing time out only masks the real
> issue. Can you please suggest some options that I can try to see why this
> error might be occurring ? I tried an external USB generic SD card reader
> (not Ricoh), to do the same and I do not see these errors, only happens
> with pci based Ricoh card readers. Can you please point me in the right
> direction to look...
>
> Here is the code where I increased the data  timeout (limit_us to 500000)
> ...
> ========== drivers/mmc/core/core.c ==========
> :
> :
> /*
>          * SD cards also have an upper limit on the timeout.
>          */
>         if (mmc_card_sd(card)) {
>                 unsigned int timeout_us, limit_us;
>
>                 timeout_us = data->timeout_ns / 1000;
>                 if (mmc_host_clk_rate(card->host))
>                         timeout_us += data->timeout_clks * 1000 /
>                                 (mmc_host_clk_rate(card->host) / 1000);
>
>                 if (data->flags & MMC_DATA_WRITE)
>                         /*
>                          * The limit is really 250 ms, but that is
>                          * insufficient for some crappy cards.
>                          */
>                         limit_us = 300000;
>                 else
>                         limit_us = 100000;
>
>                 /*
>                  * SDHC cards always use these fixed values.
>                  */
>                 if (timeout_us > limit_us || mmc_card_blockaddr(card)) {
>                         data->timeout_ns = limit_us * 1000;
>                         data->timeout_clks = 0;
>                 }
>         }
> ===============================================
>
>
> Here is a test case I have been using to reproduce this issue.:
>
> * Create 1000 files with sizes 800K ~ 1.5M
> * create 4 directories on the SD card
> * copy the 1000 files to each of the 4 directories simultaneously
> * tail -f /var/log/kern.log
>
> After around a minute or so, you will see a lot of errors like what I
> pasted above.
>
> Cheers
> --
> ====================
> Manoj Iyer
> Ubuntu/Canonical
> Hardware Enablement
> ====================
>
>
>

--
====================
Manoj Iyer
Ubuntu/Canonical
Hardware Enablement
====================
--8323329-1580141188-1326383925=:5761--
