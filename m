From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC PATCH v2 00/16] DMA Engine support for AM33xx
Date: Thu, 11 Oct 2012 22:31:58 +0100
Message-ID: <CACxGe6vL2ieaYN_YhZn9=e7=prwdfwZtgPr4Ei3VMNnViib6XA@mail.gmail.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5893422129731810752=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1349982281-10785-1-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Robert Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============5893422129731810752==
Content-Type: multipart/alternative; boundary=e89a8ff243010f57f504cbcf4d68

--e89a8ff243010f57f504cbcf4d68
Content-Type: text/plain; charset=ISO-8859-1

Hey Matt,

Do you know now similar are the EDMA engines on the am33xx and am389x? I've
been working on am389x upstreaming and I'll try these patches out if it is
the same engine.

g.
On Oct 11, 2012 8:03 PM, "Matt Porter" <mporter-l0cyMroinI0@public.gmane.org> wrote:

> Changes since v1:
>         - Rebased on top of mainline from 12250d8
>         - Dropped the feature removal schedule patch
>         - Implemented dma_request_slave_channel_compat() and
>           converted the mmc and spi drivers to use it
>         - Dropped unneeded #address-cells and #size-cells from
>           EDMA DT support
>         - Moved private EDMA header to linux/platform_data/ and
>           removed some unneeded definitions
>         - Fixed parsing of optional properties
>
> TODO:
>         - Add AM33xx crossbar support to the private EDMA API
>           (any EDMA events on the crossbar are not supported)
>         - Add dmaengine support for per-channel caps so the
>           hack to set the maximum segments can be replaced with
>           a query to the dmaengine driver
>
> This series adds DMA Engine support for AM33xx, which uses
> an EDMA DMAC. The EDMA DMAC has been previously supported by only
> a private API implementation (much like the situation with OMAP
> DMA) found on the DaVinci family of SoCs.
>
> The series applies on top of mainline from
> 12250d843e8489ee00b5b7726da855e51694e792 and the following patches:
>
>         - Vaibhav's patch to fix AM33xx boot on mainline
>           https://patchwork.kernel.org/patch/1569231/
>         - dmaengine DT support from Vinod's dmaengine_dt branch in
>           git://git.infradead.org/users/vkoul/slave-dma.git since
>           027478851791df751176398be02a3b1c5f6aa824
>
> The approach taken is similar to how OMAP DMA is being converted to
> DMA Engine support. With the functional EDMA private API already
> existing in mach-davinci/dma.c, we first move that to an ARM common
> area so it can be shared. Adding DT and runtime PM support to the
> private EDMA API implementation allows it to run on AM33xx. AM33xx
> *only* boots using DT so we leverage Jon's generic DT DMA helpers to
> register EDMA DMAC with the of_dma framework and then add support
> for calling the dma_request_slave_channel() API to both the mmc
> and spi drivers.
>
> What works? Well, with this series we now have MMC and SPI support
> on AM33xx. The only caveat for MMC is that the mmc3 controller has
> its events on the crossbar and is not usable yet.
>
> This is tested on BeagleBone with a SPI framebuffer driver and SD
> card. It is regression tested on AM180x-EVM (which also makes use
> of the EDMA dmaengine driver and the EDMA private API) using SD,
> SPI flash, and the onboard audio supported by the ASoC Davinci
> driver.
>
> After this series, the plan is to convert the last in-tree user
> of the private EDMA API (davinci-pcm/mcasp) and then eliminate
> the private EDMA API by folding its functionality into
> drivers/dma/edma.c.
>
> Matt Porter (16):
>   dmaengine: edma: fix slave config dependency on direction
>   ARM: davinci: move private EDMA API to arm/common
>   ARM: edma: remove unused transfer controller handlers
>   ARM: edma: add DT and runtime PM support for AM335x
>   dmaengine: edma: enable build for AM33XX
>   dmaengine: edma: Add TI EDMA device tree binding
>   ARM: dts: add AM33XX EDMA support
>   ARM: omap: add hsmmc am33xx specific init
>   dmaengine: add dma_request_slave_channel_compat()
>   mmc: omap_hsmmc: convert to dma_request_slave_channel_compat()
>   mmc: omap_hsmmc: limit max_segs with the EDMA DMAC
>   mmc: omap_hsmmc: add generic DMA request support to the DT binding
>   ARM: dts: add AM33XX MMC support
>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
>   spi: omap2-mcspi: add generic DMA request support to the DT binding
>   ARM: dts: add AM33XX SPI support
>
>  Documentation/devicetree/bindings/dma/ti-edma.txt  |   49 +
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   25 +-
>  Documentation/devicetree/bindings/spi/omap-spi.txt |   27 +-
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/boot/dts/am335x-bone.dts                  |   23 +
>  arch/arm/boot/dts/am33xx.dtsi                      |  100 ++
>  arch/arm/common/Kconfig                            |    3 +
>  arch/arm/common/Makefile                           |    1 +
>  arch/arm/common/edma.c                             | 1781
> ++++++++++++++++++++
>  arch/arm/mach-davinci/Makefile                     |    2 +-
>  arch/arm/mach-davinci/board-da830-evm.c            |    4 +-
>  arch/arm/mach-davinci/board-da850-evm.c            |    8 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c           |    4 +-
>  arch/arm/mach-davinci/board-omapl138-hawk.c        |    8 +-
>  arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
>  arch/arm/mach-davinci/davinci.h                    |    2 +-
>  arch/arm/mach-davinci/devices-da8xx.c              |    8 +-
>  arch/arm/mach-davinci/devices-tnetv107x.c          |    6 +-
>  arch/arm/mach-davinci/devices.c                    |    7 +-
>  arch/arm/mach-davinci/dm355.c                      |    6 +-
>  arch/arm/mach-davinci/dm365.c                      |    6 +-
>  arch/arm/mach-davinci/dm644x.c                     |    6 +-
>  arch/arm/mach-davinci/dm646x.c                     |    6 +-
>  arch/arm/mach-davinci/dma.c                        | 1588
> -----------------
>  arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
>  arch/arm/mach-davinci/include/mach/edma.h          |  267 ---
>  arch/arm/mach-omap2/hsmmc.c                        |    7 +-
>  arch/arm/plat-omap/Kconfig                         |    1 +
>  drivers/dma/Kconfig                                |    2 +-
>  drivers/dma/edma.c                                 |   57 +-
>  drivers/mmc/host/davinci_mmc.c                     |    1 +
>  drivers/mmc/host/omap_hsmmc.c                      |   20 +-
>  drivers/spi/spi-omap2-mcspi.c                      |   65 +-
>  include/linux/dmaengine.h                          |   10 +
>  include/linux/mfd/davinci_voicecodec.h             |    3 +-
>  include/linux/platform_data/edma.h                 |  198 +++
>  include/linux/platform_data/spi-davinci.h          |    2 +-
>  sound/soc/davinci/davinci-evm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.h                    |    2 +-
>  sound/soc/davinci/davinci-sffsdr.c                 |    6 +-
>  41 files changed, 2361 insertions(+), 1957 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
>  create mode 100644 arch/arm/common/edma.c
>  delete mode 100644 arch/arm/mach-davinci/dma.c
>  delete mode 100644 arch/arm/mach-davinci/include/mach/edma.h
>  create mode 100644 include/linux/platform_data/edma.h
>
> --
> 1.7.9.5
>
>

--e89a8ff243010f57f504cbcf4d68
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hey Matt,</p>
<p dir=3D"ltr">Do you know now similar are the EDMA engines on the am33xx a=
nd am389x? I&#39;ve been working on am389x upstreaming and I&#39;ll try the=
se patches out if it is the same engine.</p>
<p dir=3D"ltr">g.</p>
<div class=3D"gmail_quote">On Oct 11, 2012 8:03 PM, &quot;Matt Porter&quot;=
 &lt;<a href=3D"mailto:mporter-l0cyMroinI0@public.gmane.org">mporter-l0cyMroinI0@public.gmane.org</a>&gt; wrote:<br typ=
e=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
Changes since v1:<br>
=A0 =A0 =A0 =A0 - Rebased on top of mainline from 12250d8<br>
=A0 =A0 =A0 =A0 - Dropped the feature removal schedule patch<br>
=A0 =A0 =A0 =A0 - Implemented dma_request_slave_channel_compat() and<br>
=A0 =A0 =A0 =A0 =A0 converted the mmc and spi drivers to use it<br>
=A0 =A0 =A0 =A0 - Dropped unneeded #address-cells and #size-cells from<br>
=A0 =A0 =A0 =A0 =A0 EDMA DT support<br>
=A0 =A0 =A0 =A0 - Moved private EDMA header to linux/platform_data/ and<br>
=A0 =A0 =A0 =A0 =A0 removed some unneeded definitions<br>
=A0 =A0 =A0 =A0 - Fixed parsing of optional properties<br>
<br>
TODO:<br>
=A0 =A0 =A0 =A0 - Add AM33xx crossbar support to the private EDMA API<br>
=A0 =A0 =A0 =A0 =A0 (any EDMA events on the crossbar are not supported)<br>
=A0 =A0 =A0 =A0 - Add dmaengine support for per-channel caps so the<br>
=A0 =A0 =A0 =A0 =A0 hack to set the maximum segments can be replaced with<b=
r>
=A0 =A0 =A0 =A0 =A0 a query to the dmaengine driver<br>
<br>
This series adds DMA Engine support for AM33xx, which uses<br>
an EDMA DMAC. The EDMA DMAC has been previously supported by only<br>
a private API implementation (much like the situation with OMAP<br>
DMA) found on the DaVinci family of SoCs.<br>
<br>
The series applies on top of mainline from<br>
12250d843e8489ee00b5b7726da855e51694e792 and the following patches:<br>
<br>
=A0 =A0 =A0 =A0 - Vaibhav&#39;s patch to fix AM33xx boot on mainline<br>
=A0 =A0 =A0 =A0 =A0 <a href=3D"https://patchwork.kernel.org/patch/1569231/"=
 target=3D"_blank">https://patchwork.kernel.org/patch/1569231/</a><br>
=A0 =A0 =A0 =A0 - dmaengine DT support from Vinod&#39;s dmaengine_dt branch=
 in<br>
=A0 =A0 =A0 =A0 =A0 git://<a href=3D"http://git.infradead.org/users/vkoul/s=
lave-dma.git" target=3D"_blank">git.infradead.org/users/vkoul/slave-dma.git=
</a> since<br>
=A0 =A0 =A0 =A0 =A0 027478851791df751176398be02a3b1c5f6aa824<br>
<br>
The approach taken is similar to how OMAP DMA is being converted to<br>
DMA Engine support. With the functional EDMA private API already<br>
existing in mach-davinci/dma.c, we first move that to an ARM common<br>
area so it can be shared. Adding DT and runtime PM support to the<br>
private EDMA API implementation allows it to run on AM33xx. AM33xx<br>
*only* boots using DT so we leverage Jon&#39;s generic DT DMA helpers to<br=
>
register EDMA DMAC with the of_dma framework and then add support<br>
for calling the dma_request_slave_channel() API to both the mmc<br>
and spi drivers.<br>
<br>
What works? Well, with this series we now have MMC and SPI support<br>
on AM33xx. The only caveat for MMC is that the mmc3 controller has<br>
its events on the crossbar and is not usable yet.<br>
<br>
This is tested on BeagleBone with a SPI framebuffer driver and SD<br>
card. It is regression tested on AM180x-EVM (which also makes use<br>
of the EDMA dmaengine driver and the EDMA private API) using SD,<br>
SPI flash, and the onboard audio supported by the ASoC Davinci<br>
driver.<br>
<br>
After this series, the plan is to convert the last in-tree user<br>
of the private EDMA API (davinci-pcm/mcasp) and then eliminate<br>
the private EDMA API by folding its functionality into<br>
drivers/dma/edma.c.<br>
<br>
Matt Porter (16):<br>
=A0 dmaengine: edma: fix slave config dependency on direction<br>
=A0 ARM: davinci: move private EDMA API to arm/common<br>
=A0 ARM: edma: remove unused transfer controller handlers<br>
=A0 ARM: edma: add DT and runtime PM support for AM335x<br>
=A0 dmaengine: edma: enable build for AM33XX<br>
=A0 dmaengine: edma: Add TI EDMA device tree binding<br>
=A0 ARM: dts: add AM33XX EDMA support<br>
=A0 ARM: omap: add hsmmc am33xx specific init<br>
=A0 dmaengine: add dma_request_slave_channel_compat()<br>
=A0 mmc: omap_hsmmc: convert to dma_request_slave_channel_compat()<br>
=A0 mmc: omap_hsmmc: limit max_segs with the EDMA DMAC<br>
=A0 mmc: omap_hsmmc: add generic DMA request support to the DT binding<br>
=A0 ARM: dts: add AM33XX MMC support<br>
=A0 spi: omap2-mcspi: convert to dma_request_slave_channel_compat()<br>
=A0 spi: omap2-mcspi: add generic DMA request support to the DT binding<br>
=A0 ARM: dts: add AM33XX SPI support<br>
<br>
=A0Documentation/devicetree/bindings/dma/ti-edma.txt =A0| =A0 49 +<br>
=A0.../devicetree/bindings/mmc/ti-omap-hsmmc.txt =A0 =A0 =A0| =A0 25 +-<br>
=A0Documentation/devicetree/bindings/spi/omap-spi.txt | =A0 27 +-<br>
=A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A01 +<br>
=A0arch/arm/boot/dts/am335x-bone.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 23 +<br>
=A0arch/arm/boot/dts/am33xx.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0100 ++<br>
=A0arch/arm/common/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A03 +<br>
=A0arch/arm/common/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A01 +<br>
=A0arch/arm/common/edma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | 1781 ++++++++++++++++++++<br>
=A0arch/arm/mach-davinci/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A02 +-<br>
=A0arch/arm/mach-davinci/board-da830-evm.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 +-<br>
=A0arch/arm/mach-davinci/board-da850-evm.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
8 +-<br>
=A0arch/arm/mach-davinci/board-dm646x-evm.c =A0 =A0 =A0 =A0 =A0 | =A0 =A04 =
+-<br>
=A0arch/arm/mach-davinci/board-omapl138-hawk.c =A0 =A0 =A0 =A0| =A0 =A08 +-=
<br>
=A0arch/arm/mach-davinci/board-tnetv107x-evm.c =A0 =A0 =A0 =A0| =A0 =A02 +-=
<br>
=A0arch/arm/mach-davinci/davinci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +-<br>
=A0arch/arm/mach-davinci/devices-da8xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A08 +-<br>
=A0arch/arm/mach-davinci/devices-tnetv107x.c =A0 =A0 =A0 =A0 =A0| =A0 =A06 =
+-<br>
=A0arch/arm/mach-davinci/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A07 +-<br>
=A0arch/arm/mach-davinci/dm355.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A06 +-<br>
=A0arch/arm/mach-davinci/dm365.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A06 +-<br>
=A0arch/arm/mach-davinci/dm644x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A06 +-<br>
=A0arch/arm/mach-davinci/dm646x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A06 +-<br>
=A0arch/arm/mach-davinci/dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| 1588 -----------------<br>
=A0arch/arm/mach-davinci/include/mach/da8xx.h =A0 =A0 =A0 =A0 | =A0 =A02 +-=
<br>
=A0arch/arm/mach-davinci/include/mach/edma.h =A0 =A0 =A0 =A0 =A0| =A0267 --=
-<br>
=A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A07 +-<br>
=A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A01 +<br>
=A0drivers/dma/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A02 +-<br>
=A0drivers/dma/edma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 57 +-<br>
=A0drivers/mmc/host/davinci_mmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A01 +<br>
=A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 20 +-<br>
=A0drivers/spi/spi-omap2-mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 65 +-<br>
=A0include/linux/dmaengine.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 10 +<br>
=A0include/linux/mfd/davinci_voicecodec.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
3 +-<br>
=A0include/linux/platform_data/edma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
198 +++<br>
=A0include/linux/platform_data/spi-davinci.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 =
+-<br>
=A0sound/soc/davinci/davinci-evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +<br>
=A0sound/soc/davinci/davinci-pcm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +<br>
=A0sound/soc/davinci/davinci-pcm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +-<br>
=A0sound/soc/davinci/davinci-sffsdr.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A06 +-<br>
=A041 files changed, 2361 insertions(+), 1957 deletions(-)<br>
=A0create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt<br>
=A0create mode 100644 arch/arm/common/edma.c<br>
=A0delete mode 100644 arch/arm/mach-davinci/dma.c<br>
=A0delete mode 100644 arch/arm/mach-davinci/include/mach/edma.h<br>
=A0create mode 100644 include/linux/platform_data/edma.h<br>
<br>
--<br>
1.7.9.5<br>
<br>
</blockquote></div>

--e89a8ff243010f57f504cbcf4d68--

--===============5893422129731810752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5893422129731810752==--
