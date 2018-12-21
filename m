From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Constify driver data
Date: Fri, 21 Dec 2018 15:56:41 +0200
Message-ID: <4c01046b-2b83-f124-34c8-a6feac8aca95@intel.com>
References: <20181218232652.12700-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218232652.12700-1-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 19/12/18 1:26 AM, Andrey Smirnov wrote:
> Variant specific driver data doesn't change at run-time, so mark it as
> const to reflect that.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f44e49014a44..39ace4f1036b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -148,38 +148,38 @@ struct esdhc_soc_data {
>  	u32 flags;
>  };
>  
> -static struct esdhc_soc_data esdhc_imx25_data = {
> +static const struct esdhc_soc_data esdhc_imx25_data = {
>  	.flags = ESDHC_FLAG_ERR004536,
>  };
>  
> -static struct esdhc_soc_data esdhc_imx35_data = {
> +static const struct esdhc_soc_data esdhc_imx35_data = {
>  	.flags = ESDHC_FLAG_ERR004536,
>  };
>  
> -static struct esdhc_soc_data esdhc_imx51_data = {
> +static const struct esdhc_soc_data esdhc_imx51_data = {
>  	.flags = 0,
>  };
>  
> -static struct esdhc_soc_data esdhc_imx53_data = {
> +static const struct esdhc_soc_data esdhc_imx53_data = {
>  	.flags = ESDHC_FLAG_MULTIBLK_NO_INT,
>  };
>  
> -static struct esdhc_soc_data usdhc_imx6q_data = {
> +static const struct esdhc_soc_data usdhc_imx6q_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING,
>  };
>  
> -static struct esdhc_soc_data usdhc_imx6sl_data = {
> +static const struct esdhc_soc_data usdhc_imx6sl_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
>  			| ESDHC_FLAG_HS200,
>  };
>  
> -static struct esdhc_soc_data usdhc_imx6sx_data = {
> +static const struct esdhc_soc_data usdhc_imx6sx_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>  
> -static struct esdhc_soc_data usdhc_imx7d_data = {
> +static const struct esdhc_soc_data usdhc_imx7d_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400,
> 
