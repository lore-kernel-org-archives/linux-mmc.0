From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] mmc: sunxi: remove output of virtual
 base address
Date: Tue, 24 Jul 2018 10:46:17 +0200
Message-ID: <20180724084617.fqgrhyuz3xx72l4g@flea>
References: <20180723153431.8669-1-andre.przywara@arm.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vbm63uevf4hfdsah"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBW6O3PNAKGQEASFGQ7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180723153431.8669-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--vbm63uevf4hfdsah
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Jul 23, 2018 at 04:34:31PM +0100, Andre Przywara wrote:
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
> To keep a success message in the driver, we make this purpose explicit
> with the word "initialized", plus print some information that is not too
> obvious and that we learned while probing the device:
> the maximum request size and whether it uses the new timing mode.
> So the output turns into:
> [    1.750626] sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB, uses new timings mode
> [    1.786699] sunxi-mmc 1c11000.mmc: initialized, max. request size: 2048 KB
> 
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--vbm63uevf4hfdsah--
