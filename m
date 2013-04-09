From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH v2 2/2] mmc: mxs-mmc: add non-removable property
Date: Tue, 9 Apr 2013 17:21:29 +0200
Message-ID: <516431F9.8010302@digi.com>
References: <1365166070-9370-1-git-send-email-mkl@pengutronix.de> <1365166070-9370-3-git-send-email-mkl@pengutronix.de> <51643053.7030302@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.16]:21708 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761860Ab3DIPVk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Apr 2013 11:21:40 -0400
In-Reply-To: <51643053.7030302@digi.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, cjb@laptop.org, aletes.xgr@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>

On 04/09/2013 05:14 PM, Hector Palacios wrote:
> @@ -95,7 +97,8 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>          struct mxs_mmc_host *host =3D mmc_priv(mmc);
>          struct mxs_ssp *ssp =3D &host->ssp;
>
> -       return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
> +       return host->non_removable || host->broken_cd ||
> +              !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
>                   BM_SSP_STATUS_CARD_DETECT);
>   }

Sorry, I missed your original XOR here, when merging my changes:

@@ -95,7 +97,8 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
         struct mxs_mmc_host *host =3D mmc_priv(mmc);
         struct mxs_ssp *ssp =3D &host->ssp;

-       return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+       return host->non_removable || host->broken_cd ||
+              !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+                BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
  }

  static void mxs_mmc_reset(struct mxs_mmc_host *host)


Regards,
--=20
H=E9ctor Palacios
