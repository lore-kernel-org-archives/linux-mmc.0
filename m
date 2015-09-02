From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/6] regulator: pbias: program pbias register offset in
 pbias driver
Date: Wed, 2 Sep 2015 08:30:16 -0700
Message-ID: <20150902153015.GR4215@atomide.com>
References: <1441190853-7133-1-git-send-email-kishon@ti.com>
 <1441190853-7133-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441190853-7133-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150902 03:51]:
> --- a/drivers/regulator/pbias-regulator.c
> +++ b/drivers/regulator/pbias-regulator.c

How about add a comment here:

/* Offset from SCM general area (and syscon) base */
  
> +static const struct pbias_of_data pbias_of_data_omap2 = {
> +	.offset = 0x230,
> +};
> +
> +static const struct pbias_of_data pbias_of_data_omap3 = {
> +	.offset = 0x2b0,
> +};
> +
> +static const struct pbias_of_data pbias_of_data_omap4 = {
> +	.offset = 0x60,
> +};
> +
> +static const struct pbias_of_data pbias_of_data_omap5 = {
> +	.offset = 0x60,
> +};
> +
> +static const struct pbias_of_data pbias_of_data_dra7 = {
> +	.offset = 0xe00,
> +};
> +
>  static const struct of_device_id pbias_of_match[] = {
>  	{ .compatible = "ti,pbias-omap", },
> +	{ .compatible = "ti,pbias-omap2", .data = &pbias_of_data_omap2, },
> +	{ .compatible = "ti,pbias-omap3", .data = &pbias_of_data_omap3, },
> +	{ .compatible = "ti,pbias-omap4", .data = &pbias_of_data_omap4, },
> +	{ .compatible = "ti,pbias-omap5", .data = &pbias_of_data_omap5, },
> +	{ .compatible = "ti,pbias-dra7", .data = &pbias_of_data_dra7, },
>  	{},
>  };
...

> @@ -129,6 +161,18 @@ static int pbias_regulator_probe(struct platform_device *pdev)
>  	if (IS_ERR(syscon))
>  		return PTR_ERR(syscon);
>  
> +	match = of_match_device(of_match_ptr(pbias_of_match), &pdev->dev);
> +	if (match && match->data) {
> +		data = match->data;
> +		offset = data->offset;
> +	} else {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!res)
> +			return -EINVAL;
> +
> +		offset = res->start;
> +	}
> +
>  	cfg.regmap = syscon;
>  	cfg.dev = &pdev->dev;
>  

Maybe add a warning here for parsing the legacy broken IORESOURCE_MEM
that's known to be broken from DT point of view?

Other than that, looks OK to me and should allow also changing to
use a generic solution, Mark may have some other comments.

Anyways, something like this is needed for v4.3-rc cycle, probably
best that Mark queues all these after review. So feel free to add
for the whole series:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
