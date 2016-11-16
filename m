From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCHv2 09/10] mmc: dw_mmc: The "clock-freq-min-max" property
 was deprecated
Date: Wed, 16 Nov 2016 17:19:44 +0800
Message-ID: <3409f8fb-1329-86e0-6e21-c190de6ae884@rock-chips.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <20161115101232.3854-10-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115101232.3854-10-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

ÔÚ 2016/11/15 18:12, Jaehoon Chung Ð´µÀ:
> The "clock-freq-min-max" property was deprecated.
> There is "max-frequency" property in drivers/mmc/core/host.c
> "max-frequency" can be replaced with "clock-freq-min-max".
> Minimum clock value might be set to 100K by default.
> Then MMC core should try to find the correct value from 400K to 100K.
> So it just needs to set Maximum clock value.
>

This is what we talked about to do :-)

Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 3 ++-
>  drivers/mmc/host/dw_mmc.c                                  | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index bfa461a..1279a22 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -59,8 +59,9 @@ Optional properties:
>    is specified and the ciu clock is specified then we'll try to set the ciu
>    clock to this at probe time.
>
> -* clock-freq-min-max: Minimum and Maximum clock frequency for card output
> +* clock-freq-min-max (DEPRECATED): Minimum and Maximum clock frequency for card output
>    clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
> +	  (Use the "max-frequency" instead of "clock-freq-min-max".)
>
>  * num-slots: specifies the number of slots supported by the controller.
>    The number of physical slots actually used could be equal or less than the
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ec0ba79..48e968a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2608,6 +2608,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  		mmc->f_min = DW_MCI_FREQ_MIN;
>  		mmc->f_max = DW_MCI_FREQ_MAX;
>  	} else {
> +		dev_info(host->dev,
> +			"'clock-freq-min-max' property was deprecated.\n");
>  		mmc->f_min = freq[0];
>  		mmc->f_max = freq[1];
>  	}
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
