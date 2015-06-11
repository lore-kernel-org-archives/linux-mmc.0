From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Clear MMC_CAP_1_8V_DDR in the
 SDHCI_QUIRK2_NO_1_8_V case
Date: Thu, 11 Jun 2015 13:21:39 -0300
Message-ID: <CAOMZO5Bx8Vf5-1mdV0pAyaHC1m6CpzJ5_kOz1sCBiDX+beix0A@mail.gmail.com>
References: <1434029080-11298-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34107 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbbFKQVm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jun 2015 12:21:42 -0400
In-Reply-To: <1434029080-11298-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, adrian.hunter@intel.com, Dong Aisheng <b29396@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, kevin.lemoi@savant.com, Otavio Salvador <otavio@ossystems.com.br>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, stable <stable@vger.kernel.org>

Hi Ulf,

On Thu, Jun 11, 2015 at 10:24 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:

> -       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
> +       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
>                 caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>                        SDHCI_SUPPORT_DDR50);
> +               mmc->caps &= ~MMC_CAP_1_8V_DDR;
> +       }

Please discard this one. I think I found the problem inside sdhci-esdhc-imx.c.

Will send another patch later.

Thanks
