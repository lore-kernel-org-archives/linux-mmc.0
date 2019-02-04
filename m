From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported
 modes declared in the device tree
Date: Mon, 4 Feb 2019 10:34:27 +0100
Message-ID: <20190204093427.vg63e5xmd7u52leh@flea>
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-3-wens@csie.org>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p42mp7wsvouznbye"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBK4O4DRAKGQEXIQRHYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190203155628.16767-3-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Blake <chrisrblake93-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--p42mp7wsvouznbye
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> The MMC device tree bindings include properties used to signal various
> signalling speed modes. Until now the sunxi driver was accepting them
> without any further filtering, while the sunxi device trees were not
> actually using them.
> 
> Since some of the H5 boards can not run at higher speed modes stably,
> we are resorting to declaring the higher speed modes per-board.
> 
> Regardless, having boards declare modes and blindly following them,
> even without proper support in the driver, is generally a bad thing.
> 
> Filter out all unsupported modes from the capabilities mask after
> the device tree properties have been parsed.
> 
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> 
> ---
> 
> This should be backported to stable kernels in case people try to run
> new device trees (that declare newly supported modes) with old kernels.
> ---
>  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7415af8c8ff6..a01433012db0 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto error_free_dma;
>  
> +	/*
> +	 * If we don't support delay chains in the SoC, we can't use any
> +	 * of the DDR speed modes. Mask them out in case the device
> +	 * tree specifies the properties for them, which gets added to
> +	 * the caps by mmc_of_parse() above.
> +	 */
> +	if (!(host->cfg->clk_delays || host->use_new_timings))
> +		mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> +			       MMC_CAP_1_2V_DDR);
> +
> +	/* TODO: UHS modes untested due to lack of supporting boards */
> +	mmc->caps &= ~MMC_CAP_UHS;

I've tested up to SDR104 and it works on the A64 at least

> +	/* TODO: This driver doesn't support HS200 and HS400 modes yet */
> +	mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);

And HS200 works too.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--p42mp7wsvouznbye--
