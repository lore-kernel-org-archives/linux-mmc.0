From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa board
Date: Wed, 8 Oct 2014 14:50:46 +0200
Message-ID: <CAPDyKFowKK2UbwQ3uUmX7yzgsyFVxQ+sKb=dh+a0_T5K4agYGw@mail.gmail.com>
References: <2750153.I3nVqzmXTP@amdc1032>
	<CAPDyKFqGS5mRpAJLkmQ3fnGKktLFDEt_pi+uaK-xCUtw1+Duvg@mail.gmail.com>
	<3871564.7PhRGhHd6U@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:49757 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451AbaJHMur (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Oct 2014 08:50:47 -0400
Received: by mail-qa0-f54.google.com with SMTP id i13so5535724qae.41
        for <linux-mmc@vger.kernel.org>; Wed, 08 Oct 2014 05:50:47 -0700 (PDT)
In-Reply-To: <3871564.7PhRGhHd6U@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Doug Anderson <dianders@google.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, "cpgs ." <cpgs@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seung-Won Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, SUNIL JOSHI <joshi@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>

On 8 October 2014 14:07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 02 October 2014 20:16:44 Ulf Hansson wrote:
>> On 2 October 2014 18:10, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>> > Regulators for MMC2 (SD card) are PVDD_TFLASH_2V8 (LDO19) for vmmc
>> > and PVDD_APIO_MMCOFF_2V8 (LDO13) for vqmmc.  Currently the device
>> > tree entry for MMC2 uses PVDD_PRE_1V8 (LDO10) for vmmc and vqmmc is
>> > not specified.  Fix it.
>> >
>> > Without this patch:
>> > - "mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators"
>> >   patch causes a SD card detection to fail
>> > - "mmc: dw_mmc: Support voltage changes" patch causes a boot hang
>> >
>> > This patch fixes both above problems.
>> >
>> > Suggested-by: Doug Anderson <dianders@google.com>
>> > Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Unless it causes a bunch non-trivial conflicts, I suggest we take this
>> through my mmc tree to not break bisectability.
>
> Have you tried if it conflicts with arm-soc? If not,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

In conflicts, but it's trivial to fix it.

Since it actually fixes a regression which is inserted from my mmc
tree, I thought it makes sense to take it through here. Anyway, the
decision is yours.

Br
Uffe
