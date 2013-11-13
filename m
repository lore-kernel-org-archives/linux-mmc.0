From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v2 0/5] mmc: sdhci-esdhc-imx: add runtime pm support
Date: Wed, 13 Nov 2013 19:18:54 +0800
Message-ID: <CAA+hA=R4JmfhP9kA55Baf_Hj-omh10avCb9iG_nVuMRaD_gD4g@mail.gmail.com>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
	<20131105020335.GC19770@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:59016 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab3KMLSz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2013 06:18:55 -0500
Received: by mail-qe0-f51.google.com with SMTP id t7so133331qeb.10
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2013 03:18:54 -0800 (PST)
In-Reply-To: <20131105020335.GC19770@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Chris,

On Tue, Nov 5, 2013 at 10:03 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Nov 04, 2013 at 04:38:24PM +0800, Dong Aisheng wrote:
>> We disable root clock in runtime pm to save power.
>>
>> Patch 2~4 are some fixes needed for enable runtime pm or it may
>> break the UHS cards(SD3.0/eMMC4.5).
>>
>> Below are some tests result i ran which passed mmc_test tool after enable rpm:
>> SDHC UHS1 on imx6q sabreauto
>> eMMC 4.5 on imx6sl evk
>> SDXC UHS1 on imx6sl evk
>> eMMC DDR on imx6q sabresd
>> SDHC on imx6q sabresd
>>
>> ChangeLog:
>> v1->v2: only patch 5 changed. Add pm_runtime_set_active
>>       based on Ulf's comments.
>>
>> Dong Aisheng (5):
>>   mmc: sdhci-pltfm: export pltfm suspend/resume api
>>   mmc: sdhci-esdhc-imx: tuning bits should not be cleared during reset
>>   mmc: sdhci-esdhc-imx: clear SDHCI_CTRL_EXEC_TUNING should not affect
>>     other bits
>>   mmc: sdhci-esdhc-imx: fix runtime pm unblance issue
>>   mmc: sdhci-esdhc-imx: add runtime pm support
>
> For the series,
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>

Would you help pick this series with Ulf's ack?

Regards
Dong Aisheng

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
