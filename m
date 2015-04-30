From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on
 Freescale iMX6SL board
Date: Thu, 30 Apr 2015 20:44:52 +0800
Message-ID: <554223C4.9030506@gmail.com>
References: <5541F3CC.4090000@gmail.com> <CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:35425 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbbD3Mo6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 08:44:58 -0400
Received: by qcbii10 with SMTP id ii10so28002686qcb.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 05:44:57 -0700 (PDT)
In-Reply-To: <CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>


On 04/30/2015 08:16 PM, Fabio Estevam wrote:
> On Thu, Apr 30, 2015 at 6:20 AM, Xuebing Wang <xbing6@gmail.com> wrote:
>> Hi linux-mmc community,
>>
>> I am working on a board which is very similar to Freescale iMX6SL EVK
>> (evaluation board), but /dev/mmcblk0 does not exist for kernel v4.0.1
> On my imx6sl-warp the eMMC is correctly detected when running kernel 4.0.
>
> Does it help if you apply this patch from 4.1-rc1?
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/sdhci.c?id=04e079cf6b24c794bbc52b04b370f84cb728540e

Fabio,

Thanks for your help.

Unfortunately, no, cherry-pick this patch from 4.1-rc1 into v4.0.1 has 
the same result.
-------------------
[    1.274968] Driver 'mmcblk' needs updating - please use bus_type methods
[    1.301492] sdhci-esdhc-imx 2190000.usdhc: No vmmc regulator found
[    1.307783] sdhci-esdhc-imx 2190000.usdhc: No vqmmc regulator found
[    1.353890] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc] 
using ADMA
[    1.365351] sdhci-esdhc-imx 2194000.usdhc: No vmmc regulator found
[    1.371563] sdhci-esdhc-imx 2194000.usdhc: No vqmmc regulator found
[    1.423823] mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] 
using ADMA
[    1.435612] sdhci-esdhc-imx 2198000.usdhc: No vmmc regulator found
[    1.441817] sdhci-esdhc-imx 2198000.usdhc: No vqmmc regulator found
[    1.493731] mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc] 
using ADMA
-------------------

It is worse if I use v4.1-rc1, it always keeps outputing below: (without 
stop)
-------------------
[   16.825778] mmc1: error -110 whilst initialising MMC card
[   16.997726] mmc1: MAN_BKOPS_EN bit is not set
-------------------


> Regards,
>
> Fabio Estevam
>

-- 
Xuebing
