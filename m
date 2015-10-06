From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 3/8] mmc: sdhci-pxav3: fix error handling of armada_38x_quirks
Date: Tue, 06 Oct 2015 16:47:59 +0200
Message-ID: <87bncc9hpc.fsf@free-electrons.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<1444094562-31165-4-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1444094562-31165-4-git-send-email-mw@semihalf.com> (Marcin
	Wojtas's message of "Tue, 6 Oct 2015 03:22:37 +0200")
Sender: stable-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, jaz@semihalf.com, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Marcin,
 
 On mar., oct. 06 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> In case of armada_38x_quirks error, all clocks should be cleaned-up, same
> as after mv_conf_mbus_windows failure.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Cc: <stable@vger.kernel.org> # v4.2

Good catch.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 89a9e49..f5edf9d 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -402,7 +402,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>  		ret = armada_38x_quirks(pdev, host);
>  		if (ret < 0)
> -			goto err_clk_get;
> +			goto err_mbus_win;
>  		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>  		if (ret < 0)
>  			goto err_mbus_win;
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
