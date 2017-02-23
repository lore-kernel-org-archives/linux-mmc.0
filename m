From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] [1/2] mmc: sdhci-cadence: Fix writing PHY delay
Date: Thu, 23 Feb 2017 20:28:51 +0900
Message-ID: <CAK7LNARW4zQ2OutrAfzkigt8OgMbAMbaLvTB2ZNfwbApHT=TEA@mail.gmail.com>
References: <1487250413-5769-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from condef-04.nifty.com ([202.248.20.69]:19907 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdBWLdb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2017 06:33:31 -0500
In-Reply-To: <1487250413-5769-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org

Hi.

2017-02-16 22:06 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> Add polling for ACK to be sure that data are written to PHY register.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 4b0ecb9..c946e45 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -65,11 +65,12 @@ struct sdhci_cdns_priv {
>         void __iomem *hrs_addr;
>  };
>
> -static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> +static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>                                      u8 addr, u8 data)


If you have a chance to submit v2,
I want the indent of the above line adjusted.


Otherwise,

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
