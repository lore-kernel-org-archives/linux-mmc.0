From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v3 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Sat, 18 Mar 2017 02:23:30 +0900
Message-ID: <CAK7LNAQGOeZVqvc=6Agq2xN5B5cBMtaCAkS8-V6uBoO1ziSSuw@mail.gmail.com>
References: <1489754302-10996-1-git-send-email-piotrs@cadence.com> <1489754503-16559-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489754503-16559-1-git-send-email-piotrs@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Piotr,

2017-03-17 21:41 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> DTS properties are used instead of fixed data
> because PHY settings can be different for different chips/boards.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v2:
> - dts part was removed from this patch
> - most delays were moved from dts file
>   to data associated with an SoC specific compatible
> - remove unrelated changes
> ---
> Changes for v3:
> - move all delays back to dts because they are also boards dependent
> - prefix all of the Cadence-specific properties with cdns prefix
> - put checking delay properties inside the for loop
>   instead of using a lot of single if expressions


I am OK with this approach
because I do not have a better idea.

Only two minor comments below.





> @@ -62,10 +66,33 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP     40
>
> +static const struct of_device_id sdhci_cdns_match[];
> +

You forgot to remove this.



> @@ -227,6 +267,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         struct sdhci_cdns_priv *priv;
>         struct clk *clk;
>         int ret;
> +       struct device *dev = &pdev->dev;
>
>         clk = devm_clk_get(&pdev->dev, NULL);


If you add "dev", please use it for devm_clk_get, too.




-- 
Best Regards
Masahiro Yamada
