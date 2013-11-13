From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v2 0/6] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr
 not supported on sabresd issues
Date: Wed, 13 Nov 2013 19:16:06 +0800
Message-ID: <CAA+hA=RxHGw8h4iSDbXsLZDpfiCVzv1x+AoVRVhrQpZx=g1X_A@mail.gmail.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
	<20131031070442.GD23549@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:57389 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab3KMLQI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2013 06:16:08 -0500
Received: by mail-qe0-f42.google.com with SMTP id df13so126019qeb.29
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2013 03:16:07 -0800 (PST)
In-Reply-To: <20131031070442.GD23549@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Dong Aisheng <b29396@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, wsa@the-dreams.de, Shawn Guo <shawn.guo@linaro.org>

Hi Chris,

On Thu, Oct 31, 2013 at 3:04 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Oct 30, 2013 at 10:09:47PM +0800, Dong Aisheng wrote:
>> Dong Aisheng (6):
>>   mmc: sdhci: clear auto cmd setting bits for no data cmds
>>   mmc: sdhci-esdhc-imx: add SDHCI_TRANSFER_MODE read function
>>   ARM: dts: sabresd: add usdhc4 support
>>   mmc: sdhci-esdhc-imx: fix cpas over write issue
>>   mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR for mx6
>>   mmc: core: mmc DDR mode should not depend on UHS_DDR50
>
> For the series:
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>

Would you help pick up this series?

Regards
Dong Aisheng

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
