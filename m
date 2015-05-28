From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] mmc: imx: a few clean up and fixes
Date: Thu, 28 May 2015 10:36:30 +0200
Message-ID: <CAPDyKFpAEO+Dk-pFgkE9N_OwqTqFCmSVWA_jMhbUQ4CEcpPGJw@mail.gmail.com>
References: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33501 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbbE1Igb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2015 04:36:31 -0400
Received: by qkhg32 with SMTP id g32so20722352qkh.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2015 01:36:30 -0700 (PDT)
In-Reply-To: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, b51421@freescale.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 27 May 2015 at 12:13, Dong Aisheng <aisheng.dong@freescale.com> wrote:
> Patch 1 is a small clean up.
> Patch 2-4 and 6 are small fixes.
> Patch 5 add mx6sx support.
>
> Dong Aisheng (6):
>   mmc: sdhci-esdhc-imx: merge the same register check into one place
>   mmc: sdhci-esdhc-imx: usdhc does not have missing card interrupt issue
>   mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
>   mmc: sdhci-esdhc-imx: using specific compatible string in binding doc
>   mmc: sdhci-esdhc-imx: add imx6sx support
>   mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl
>
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  9 ++++-
>  drivers/mmc/host/sdhci-esdhc-imx.c                 | 44 +++++++++++++++++-----
>  2 files changed, 43 insertions(+), 10 deletions(-)
>
> --
> 1.9.1
>

Thanks! Applied for next.

Kind regards
Uffe
