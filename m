From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC PATCH 2/7] mmc: sh_mobile_sdhi: Add actual clock rate support
Date: Thu, 30 Apr 2015 19:34:40 +0300
Message-ID: <554259A0.9030307@cogentembedded.com>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk> <1430397081.5802.41.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430397081.5802.41.camel@xylophone.i.decadent.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Shinobu Uehara <shinobu.uehara.xc@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 04/30/2015 03:31 PM, Ben Hutchings wrote:

> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

> It is necessary to stop the SD clock before using
> the actual clock in case of SDHI controller.

> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>   drivers/mmc/host/sh_mobile_sdhi.c |   14 ++++++++++++++
>   1 file changed, 14 insertions(+)

> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 6906a905cd54..92a58c6007fe 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -136,6 +136,18 @@ static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
>   	clk_disable_unprepare(priv->clk);
>   }
>
> +static void sh_mobile_sdhi_set_clk_div(struct platform_device *pdev, int clk)
> +{
> +	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +
> +	if (clk == true) {

    'clk' is *int*. Perhaps, should be just *if* (clk)?

> +		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
> +				sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x00ff);
> +	}
> +}
> +
>   static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
>   {
>   	int timeout = 1000;
[...]

WBR, Sergei

