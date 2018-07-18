From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: remove output of virtual base address
Date: Wed, 18 Jul 2018 14:33:08 +0200
Message-ID: <20180718123308.vqhr5ydg6wsoavgq@flea>
References: <20180717100958.12042-1-andre.przywara@arm.com>
 <20180717114348.lv2ngzrekp5zpcmk@flea.home>
 <7cda9046-ec72-02d9-6474-0f4fbaa7e170@arm.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zkzb4lvar4w6i24e"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBBXHXTNAKGQEMUXCWMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <7cda9046-ec72-02d9-6474-0f4fbaa7e170-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--zkzb4lvar4w6i24e
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Wed, Jul 18, 2018 at 12:19:41PM +0100, Andre Przywara wrote:
> Hi,
> 
> On 17/07/18 12:43, Maxime Ripard wrote:
> > 1;5202;0c
> > On Tue, Jul 17, 2018 at 11:09:58AM +0100, Andre Przywara wrote:
> >> Recent Linux versions refuse to print actual virtual kernel addresses,
> >> to not give a hint about the location of the kernel in a randomized virtual
> >> address space. This affects the output of the sunxi MMC controller
> >> driver, which now produces the rather uninformative line:
> >>
> >> [    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8
> >>
> >> Since the virtual base address is not really interesting in the first
> >> place, let's just drop this value. We have the physical address as part
> >> of the DT node name, which is way more useful for debugging purposes.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> >> ---
> >>  drivers/mmc/host/sunxi-mmc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> >> index 8e7f3e35ee3d..811b08d2d0f2 100644
> >> --- a/drivers/mmc/host/sunxi-mmc.c
> >> +++ b/drivers/mmc/host/sunxi-mmc.c
> >> @@ -1407,7 +1407,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
> >>  	if (ret)
> >>  		goto error_free_dma;
> >>  
> >> -	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
> >> +	dev_info(&pdev->dev, "irq:%u\n", host->irq);
> > 
> > Can't we just remove it? It doesn't look like it brings much value anyway.
> 
> Yes, the IRQ value is the virtual Linux number, so equally
> non-informative. But this line is the only info message left from the
> mmc driver, so since we have scary "deferring probe" messages before,
> I'd rather leave this "success!" message in, to help debugging:
> # dmesg | grep mmc
> [    1.314211] sunxi-mmc 1c0f000.mmc: could not find pctldev for node
> /soc/pinctrl@1c20800/mmc0-pins, deferring probe
> [    1.324705] sunxi-mmc 1c11000.mmc: could not find pctldev for node
> /soc/pinctrl@1c20800/mmc2-pins, deferring probe
> [    1.737310] sunxi-mmc 1c0f000.mmc: irq:6
> [    1.771255] sunxi-mmc 1c11000.mmc: irq:7
> [    1.787003] mmc0: new high speed SDHC card at address 1234
> [    1.796029] mmcblk0: mmc0:1234 SA08G 7.21 GiB
> [    1.809093]  mmcblk0: p1 p2 p3
> ....
>
> We could just say something like: "initialized.".

Then maybe that what we should have, it's much more informative than a
interrupt number that's supposed to meant that the driver was probed
sucessfully :)

> It would be even more useful if we could print the type of MMC: SD
> card, SDIO, eMMC, but apart from eMMC vs. MMC0/1 for the A64 we
> don't have this information (not even the index number) at this
> level, I think.

My understanding is that you don't have access to that information at
probe time. Once the host is probed, the MMC device is going to be
discovered, and only then you'll be able to identify which card is
connected on the other side.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--zkzb4lvar4w6i24e--
