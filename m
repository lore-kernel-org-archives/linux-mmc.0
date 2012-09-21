From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC PATCH 01/13] ARM: davinci: move private EDMA API to
	arm/common
Date: Fri, 21 Sep 2012 07:10:52 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA8A6A9@DBDE01.ent.ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
	<1348152226-13588-2-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348152226-13588-2-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Nori,
	Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dan, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 20, 2012 at 20:13:34, Porter, Matt wrote:
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx atm) as well. This just moves
> the private EDMA API but does not support OMAP.
> =

> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/Kconfig                           |    1 +
>  arch/arm/common/Kconfig                    |    3 +
>  arch/arm/common/Makefile                   |    1 +
>  arch/arm/common/edma.c                     | 1588 ++++++++++++++++++++++=
++++++
>  arch/arm/include/asm/mach/edma.h           |  267 +++++
>  arch/arm/mach-davinci/Makefile             |    2 +-
>  arch/arm/mach-davinci/devices.c            |    3 +-
>  arch/arm/mach-davinci/dm355.c              |    2 +-
>  arch/arm/mach-davinci/dm365.c              |    2 +-
>  arch/arm/mach-davinci/dm644x.c             |    2 +-
>  arch/arm/mach-davinci/dm646x.c             |    2 +-
>  arch/arm/mach-davinci/dma.c                | 1588 ----------------------=
------


Please use =96M option, while generating patches via git-format-patch. =

This reduces the patch size if files are copied/renamed/moved.

>  arch/arm/mach-davinci/include/mach/asp.h   |    2 +-
>  arch/arm/mach-davinci/include/mach/da8xx.h |    3 +-
>  arch/arm/mach-davinci/include/mach/edma.h  |  267 -----
>  arch/arm/mach-davinci/include/mach/spi.h   |    2 +-
>  arch/arm/plat-omap/Kconfig                 |    1 +
>  17 files changed, 1872 insertions(+), 1864 deletions(-)
>  create mode 100644 arch/arm/common/edma.c
>  create mode 100644 arch/arm/include/asm/mach/edma.h
>  delete mode 100644 arch/arm/mach-davinci/dma.c
>  delete mode 100644 arch/arm/mach-davinci/include/mach/edma.h
> =


...snip...
...snip...
...snip...

>  =

> -- =

> 1.7.9.5
> =

> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> =



Regards, =

Gururaja

---------------------------------------------------------------------------=
---
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
