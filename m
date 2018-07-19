From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: remove output of virtual
 base address
Date: Thu, 19 Jul 2018 16:46:50 +0200
Message-ID: <20180719144650.hq3rtevp3gjkpvxh@flea>
References: <20180719133554.30737-1-andre.przywara@arm.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j747y5tm73hngttp"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBZOIYLNAKGQESBHOG4Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180719133554.30737-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--j747y5tm73hngttp
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Thu, Jul 19, 2018 at 02:35:54PM +0100, Andre Przywara wrote:
> Recent Linux versions refuse to print actual virtual kernel addresses,
> to not give a hint about the location of the kernel in a randomized virtual
> address space. This affects the output of the sunxi MMC controller
> driver, which now produces the rather uninformative line:
> 
> [    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8
> 
> Since the virtual base address is not really interesting in the first
> place, let's just drop this value. The same applies to Linux' notion of
> the interrupt number, which is independent from the GIC SPI number.
> We have the physical address as part of the DT node name, which is way
> more useful for debugging purposes.
> To keep a success message in the driver, we print some information that
> is not too obvious and that we learned while probing the device:
> the maximum request size and whether it uses the new timing mode.
> So the output turns into:
> sunxi-mmc 1c0f000.mmc: max request size: 16384 KB, uses new timings mode
> sunxi-mmc 1c11000.mmc: max request size: 2048 KB
> 
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> ---
> Changelog v1 ... v2:
> - dropped output of Linux interrupt number
> - added max request size and timings mode output
> 
>  drivers/mmc/host/sunxi-mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 8e7f3e35ee3d..fbbc09d82338 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1407,7 +1407,10 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto error_free_dma;
>  
> -	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
> +	dev_info(&pdev->dev, "max request size: %u KB%s\n",
> +		 mmc->max_req_size >> 10,
> +		 host->use_new_timings ? ", uses new timings mode" : "");

I really don't know how to feel about this one.

This isn't more useful to the regular user wanting to see if the
driver is probed, which is what this message should be about. 

And this one isn't clearer or more obvious than the previous one
(which was already pretty bad). I really think having some message
that basically says "MMC controller initialized" or something along
those lines would work better.

However, I can also see value in having this printed, for developers,
but maybe as dev_dbg?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--j747y5tm73hngttp--
