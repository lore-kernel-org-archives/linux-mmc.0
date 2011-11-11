From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCHv2 1/2] arm: samsung: support the second capability for samsung-soc
Date: Fri, 11 Nov 2011 15:35:11 +0900
Message-ID: <CAELcNGTtooNi9PMiEmXayw-j62Aumc8+Zr=PajYeVWVmfA6J6Q@mail.gmail.com>
References: <4EB1FE0E.5070902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4EB1FE0E.5070902@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi kgene

How about this patch? this patch must add the platform data.

Thanks,
Jaehoon Chung

2011/11/3 Jaehoon Chung <jh80.chung@samsung.com>:
> In mmc, there are capabilities and use the host_caps.
> That capability is expressed with bit[0:31].
> But now..already filled the bit[0:31]...
> so we need to denote with the other capability field.
> (if we want to use the cache, powerclass, etc for eMMC..this field is=
 necessary)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
> ---
> Changelog v2:
> =A0 - based-on samsung-soc's for-next tree.
>
> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 =A02 ++
> =A0arch/arm/plat-samsung/platformdata.c =A0 =A0 =A0 | =A0 =A02 ++
> =A02 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/pl=
at-samsung/include/plat/sdhci.h
> index dcff7dd..bf33ea1 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -40,6 +40,7 @@ enum clk_types {
> =A0* struct s3c_sdhci_platdata() - Platform device data for Samsung S=
DHCI
> =A0* @max_width: The maximum number of data bits supported.
> =A0* @host_caps: Standard MMC host capabilities bit field.
> + * @host_caps2: The Second Standard MMC host capabilities bit field.
> =A0* @cd_type: Type of Card Detection method (see cd_types enum above=
)
> =A0* @clk_type: Type of clock divider method (see clk_types enum abov=
e)
> =A0* @ext_cd_init: Initialize external card detect subsystem. Called =
on
> @@ -63,6 +64,7 @@ enum clk_types {
> =A0struct s3c_sdhci_platdata {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0max_width;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0host_caps;
> + =A0 =A0 =A0 unsigned int =A0 =A0host_caps2;
> =A0 =A0 =A0 =A0enum cd_types =A0 cd_type;
> =A0 =A0 =A0 =A0enum clk_types =A0clk_type;
>
> diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-sam=
sung/platformdata.c
> index 4c9a207..5ffcf46 100644
> --- a/arch/arm/plat-samsung/platformdata.c
> +++ b/arch/arm/plat-samsung/platformdata.c
> @@ -54,4 +54,6 @@ void s3c_sdhci_set_platdata(struct s3c_sdhci_platda=
ta *pd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set->host_caps |=3D pd->host_caps;
> =A0 =A0 =A0 =A0if (pd->clk_type)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set->clk_type =3D pd->clk_type;
> + =A0 =A0 =A0 if (pd->host_caps2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->host_caps2 |=3D pd->host_caps2;
> =A0}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
