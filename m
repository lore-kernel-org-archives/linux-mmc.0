From: Matt Porter <mporter@ti.com>
Subject: Re: [RFC PATCH 00/13] DMA Engine support for AM33xx
Date: Wed, 26 Sep 2012 09:01:52 -0400
Message-ID: <20120926130152.GB5641@beef>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EA8A79D@DBDE01.ent.ti.com>
 <20120921182211.GE16522@beef>
 <1BAFE6F6C881BF42822005164F1491C33EA8FDA9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA8FDA9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Linux Documentation List <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Dan Williams <djbw@fb.com>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Chris Ball <cjb@laptop.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 26, 2012 at 08:26:19AM +0000, Hebbar, Gururaja wrote:
> On Fri, Sep 21, 2012 at 23:52:11, Porter, Matt wrote:
> > On Fri, Sep 21, 2012 at 08:27:07AM +0000, Hebbar, Gururaja wrote:
> > > On Thu, Sep 20, 2012 at 20:13:33, Porter, Matt wrote:
> > > > This series adds DMA Engine support for AM33xx, which uses
> > > > an EDMA DMAC. The EDMA DMAC has been previously supported by on=
ly
> > > > a private API implementation (much like the situation with OMAP
> > > > DMA) found on the DaVinci family of SoCs.
> > > >=20
> > > > There are a mind-boggling number of dependencies for this serie=
s:
> > > >=20
> > > > 	- Jon Hunter's OF DMA helpers series
> > > > 	  https://patchwork.kernel.org/patch/1461061/
> > > > 	  https://patchwork.kernel.org/patch/1461051/
> > > > 	- Patch to address OF DMA helpers naming issues:
> > > > 	  https://patchwork.kernel.org/patch/1477921/
> > > > 	- EDMA DMA Engine wrapper driver in linux-next
> > > > 	  c2dde5f8f2095d7c623ff3565c1462e190272273
> > > > 	- EDMA DMA Engine wrapper driver bug fix:
> > > > 	  https://patchwork.kernel.org/patch/1474411/ =20
> > > > 	- A huge number of patches in linux-next for AM33xx boot
> > > > 	  (too numerous to list)
> > > >=20
> > > > The approach taken is similar to how OMAP DMA is being converte=
d to
> > > > DMA Engine support. With the functional EDMA private API alread=
y
> > > > existing in mach-davinci/dma.c, we first move that to an ARM co=
mmon
> > > > area so it can be shared. Adding DT and runtime PM support to t=
he
> > > > private EDMA API implementation allows it to run on AM33xx. AM3=
3xx
> > > > *only* boots using DT so we leverage Jon's generic DT DMA helpe=
rs to
> > > > register EDMA DMAC with the of_dma framework and then add suppo=
rt
> > > > for calling the dma_request_slave_channel() API to both the mmc
> > > > and spi drivers.
> > > >=20
> > > > What works? Well, with this series we now have MMC and SPI supp=
ort
> > > > on AM33xx. The only caveat for MMC is that the mmc3 controller =
has
> > > > its events on the crossbar and is not usable right now.
> > > >=20
> > > > This is tested on BeagleBone with a SPI framebuffer driver and =
SD
> > > > card.
> > > >=20
> > > > After this series, the plan is to convert the last in-tree user
> > > > of the private EDMA API (davinci-pcm/mcasp) and then eliminate
> > > > the private EDMA API by folding its functionality into
> > > > drivers/dma/edma.c.
> > > >=20
> > > > TODO:
> > > > 	add AM33xx crossbar support to the private EDMA API
> > > > 	(any EDMA events on the crossbar are not supported)
> > > >=20
> > >=20
> > >=20
> > > Can you please mention the base repo you have taken as starting p=
oint.
> > > (repo + extra patches ...).
> >=20
> > It's mainline 3.6-rc6 and you can see the complete set of patches
> > at https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-rfc=
-v1
> > after commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2
> >=20
> > > This will help us to test the code.
> > >=20
> > > This is because I looked at the patch 12/13 and I see that mmc
> > > device-node is modified. But in mainline I don=E2=80=99t see devi=
ce=20
> > > node for mmc (yet).
> >=20
> > Oops. You'll need e62a3333ae450bcdefbe22229d7bc277ae0ef645 and
> > fe97304557d2c6f7d0aaf1ea028ea48ffca366a9 which I forgot to include
> > in this series. I'll have them in for v2.
>=20
> Yesterday I tested edma patches on latest linux-next/master + merge o=
f=20
> linux-omap/for_3.7/dts_part2. Below are my observations
>=20
> 1. baseline =3D linux-next/master + merge of linux-omap/for_3.7/dts_p=
art2
> 2. on top of above branch, I applied patches [1-9]/13 of your edma=20
>    patches
> 3. few patches required trivial changes before applying
> 4. Applied dma of patches as you mentioned
> 5. add custom patch (ARM: CUSTOM: Build a uImage with dtb already=20
>    appended)
>    From https://github.com/hvaibhav/am335x-linux/commit/
>         7e72f5ed4b702c9373d19f7626f07ae31a381d53#arch/arm/Makefile

Alternatively you can run a current u-boot master build for am335x and
the appended dtb is no longer required.

> 6. Modified 9/13 patch to apply properly on latest am33xx.dtsi.
> 	a. Edma portion as it is
> 	b. mmc portion as below
> 		mmc1: mmc@48060000 {
> 			compatible =3D "ti,omap3-hsmmc";
> 			ti,hwmods =3D "mmc1";
> 			ti,dual-volt;
> 			ti,needs-special-reset;
> 			bus-width =3D <4>;
> 			vmmc-supply =3D <&vmmc_reg>;
> 			dmas =3D <&edma 24
> 				&edma 25>;
> 			dma-names =3D "tx", "rx";
> 		};
> 	c. added mmc pinmux as-well
>=20
> 7. make CROSS_COMPILE=3Darm-arago-linux-gnueabi- ARCH=3Darm distclean
>    make CROSS_COMPILE=3Darm-arago-linux-gnueabi- ARCH=3Darm=20
>    omap2plus_defconfig
>=20
> 8. enabled TI_EDMA from menuconfig (since it was not enabled for=20
>    omap2plus_defconfig
>=20
> 9. make CROSS_COMPILE=3Darm-arago-linux-gnueabi- ARCH=3Darm uImage
>    make CROSS_COMPILE=3Darm-arago-linux-gnueabi- ARCH=3Darm=20
>    uImage-dtb.am335x-evm
>=20
> With above changes, edma probe was failing at request_mem_region()=20
> Inside linux-next/arch/arm/common/edma.c --> edma_probe()
>=20
> I had to modify edma_probe as below
>=20
>=20
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index f337f81..efe2673 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1589,11 +1589,11 @@ static int __init edma_probe(struct platform_=
device *pdev)
>         for (j =3D 0; j < EDMA_MAX_CC; j++) {
>                 if (node) {
>                         int err;
> -                       err =3D of_address_to_resource(node, 0, &res[=
j]);
> +                       err =3D of_address_to_resource(node, j, &res[=
j]);
>                         if (err) {
>                                 dev_err(dev,
>                                         "unable to find 'reg' propert=
y\n");
> -                               return -EIO;
> +                               //return -EIO;
>                         }
>                         r[j] =3D &res[j];

Hrm, looks like a dts issue if it can't find the reg resource on your
integration of this. In any case, I'll look at it in v2.

> With this I was able to boot on am335x-evm and do a successful MMC=20
> copy-md5sum-compare test.

Great! Thanks for testing this.

> I believe you are looking into above issue in your v2 version.

Yes.

-Matt

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
