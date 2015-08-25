From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 0/6] mmc: imx: a few fixes and new feature
Date: Tue, 25 Aug 2015 14:06:05 +0200
Message-ID: <CAPDyKFriWeJTsymd+Ha0ZY+UWjpbEdKMwZgw1hA2zZhw5khPaw@mail.gmail.com>
References: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38131 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745AbbHYMGG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:06:06 -0400
Received: by igfj19 with SMTP id j19so9163409igf.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:06:06 -0700 (PDT)
In-Reply-To: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dong Aisheng <aisheng.dong@freescale.com>, Johan Derycke <johan.derycke@barco.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 11 August 2015 at 13:38, Haibo Chen <haibo.chen@freescale.com> wrote:
> Changes for v6:
> -remove duplicate code in esdhc_set_uhs_signaling().
> -fix a typo for patch-2.
> -make commit log of patch-3 more specific.
>
> Haibo Chen (6):
>   mmc: sdhci-esdhc-imx: add imx7d support and support HS400
>   mmc: sdhci-esdhc-imx: add tuning-step setting support
>   mmc: sdhci-esdhc-imx: add imx7d support in bingding doc
>   ARM: dts: imx7d-sdb: add eMMC5.0 support
>   mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
>   mmc: sdhci-esdhc-imx: change default watermark level and burst length
>
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
>  arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
>  drivers/mmc/host/sdhci-esdhc-imx.c                 | 114 ++++++++++++++++++++-
>  include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
>  4 files changed, 130 insertions(+), 4 deletions(-)
>
> --
> 1.9.1
>

I have applied this for next - except patch4 as it needs and ack from
the IMX SOC maintainer, or it may be better to take that patch through
ARM soc...

Regarding patch3, which document the new bindings and the compatible
string, I moved this to be the first patch and fixed the spelling of
the commit message header.

Thanks!

Kind regards
Uffe
