From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 00/31] Clean up amba/primecell bus support
Date: Sat, 21 Jan 2012 09:59:57 +0900
Message-ID: <010301ccd7d7$fec781d0$fc568570$%kim@samsung.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-reply-to: <20120120092207.GD1068-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: 'Russell King - ARM Linux' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'STEricsson' <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>
Cc: 'Viresh Kumar' <viresh.kumar-qxv4g6HH51o@public.gmane.org>, 'Rajeev Kumar' <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, 'Linus Walleij' <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, 'Scott Branden' <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, 'Srinidhi Kasagar' <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, 'Ryan Mallon' <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Rob Herring' <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, 'Hartley Sweeten' <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, 'Jiandong Zheng' <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, 'Chris Ball' <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, 'Sascha Hauer' <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, 'Alessandro Rubini' <rubini-9wsNiZum9E8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> This patch set cleans up the AMBA/Primecell bus support.  Contained
> within this set are:
> 
> 1. Patches 1-5 - Allocation APIs
>    It seems several places in the kernel want to allocate and register
>    amba_device structures.  Let's make this official, and common code.
>    So we introduce amba_device_alloc(), amba_device_add(), and
>    amba_device_put() APIs, which provide the necessary support safely
>    for this.
> 
>    Convert the DT, ux500, Integrator/AP and mxs code to use these APIs
>    rather than their private version.
> 
> 2. Patches 6-17 - NO_IRQ cleanup
>    Making IRQ number 0 mean 'no irq' for the AMBA drivers and bus layer.
>    We get rid of NO_IRQ initializers in this across various platforms,
>    and make the bus layer warn if '-1' is passed in a device as an IRQ.
>    This prevents new occurances of NO_IRQ initializers for this bus type
>    going by unspotted.
> 
> 3. Patches 18-31 - static initializers
>    Provide a standardized set of initializers for statically declared
>    AMBA devices.  We provide two - one for the simpler APB devices,
>    and one for AHB devices.  The major difference between these two is
>    the setting of the DMA mask - APB peripherals do not have DMA
>    capability themselves.
> 
> While updating (3), I came across new additions in Spear3xx and the
> Samsung directories which added AMBA devices, which are declared
> globally.  The Spear3xx devices are used in other files, so that's
> fine.
> 
> Samsung devices don't seem to be - and that needs fixing (did someone
> not run checkpatch or sparse on these changes?)  Please send fixes.
> 
Yeah, you're right. They in Samsung directories are not used anywhere else. So statically declaration can be used.
As a note, I always run checkpatch but sparse before applying but unfortunately, checkpatch didn't complain about that.

Let me check where fixes are needed in Samsung directories then send it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Acks for these patches are welcome.
> 
>  arch/arm/mach-bcmring/core.c                   |   23 +-----
>  arch/arm/mach-ep93xx/core.c                    |   46 ++---------
>  arch/arm/mach-exynos/dma.c                     |   38 ++-------
>  arch/arm/mach-integrator/core.c                |   70 +++-------------
>  arch/arm/mach-integrator/impd1.c               |    9 +--
>  arch/arm/mach-integrator/integrator_cp.c       |   49 ++---------
>  arch/arm/mach-lpc32xx/phy3250.c                |   32 +------
>  arch/arm/mach-mxs/devices.c                    |    8 +-
>  arch/arm/mach-mxs/devices/amba-duart.c         |    2 +-
>  arch/arm/mach-netx/fb.c                        |   13 +---
>  arch/arm/mach-nomadik/board-nhk8815.c          |   17 +---
>  arch/arm/mach-nomadik/cpu-8815.c               |    9 +--
>  arch/arm/mach-omap2/emu.c                      |   26 +------
>  arch/arm/mach-realview/core.h                  |   20 +----
>  arch/arm/mach-realview/realview_eb.c           |   78 +++++++++---------
>  arch/arm/mach-realview/realview_pb1176.c       |   78 +++++++++---------
>  arch/arm/mach-realview/realview_pb11mp.c       |   78 +++++++++---------
>  arch/arm/mach-realview/realview_pba8.c         |   78 +++++++++---------
>  arch/arm/mach-realview/realview_pbx.c          |   78 +++++++++---------
>  arch/arm/mach-s5p64x0/dma.c                    |   22 +----
>  arch/arm/mach-s5pc100/dma.c                    |   38 ++-------
>  arch/arm/mach-s5pv210/dma.c                    |   38 ++-------
>  arch/arm/mach-spear3xx/spear300.c              |   14 +---
>  arch/arm/mach-spear3xx/spear3xx.c              |   27 +-----
>  arch/arm/mach-spear6xx/spear6xx.c              |   10 +-
>  arch/arm/mach-u300/core.c                      |   85 ++++----------------
>  arch/arm/mach-ux500/devices-common.c           |   13 +--
>  arch/arm/mach-versatile/core.c                 |   70 ++++++++--------
>  arch/arm/mach-versatile/core.h                 |   20 +----
>  arch/arm/mach-versatile/versatile_pb.c         |   18 ++--
>  arch/arm/mach-vexpress/core.h                  |   17 ----
>  arch/arm/mach-vexpress/ct-ca9x4.c              |    8 +-
>  arch/arm/mach-vexpress/include/mach/ct-ca9x4.h |    2 +-
>  arch/arm/mach-vexpress/v2m.c                   |   20 ++--
>  drivers/amba/bus.c                             |  105 ++++++++++++++++++------
>  drivers/mmc/host/mmci.c                        |    2 +-
>  drivers/of/platform.c                          |    6 +-
>  include/linux/amba/bus.h                       |   36 ++++++++
>  38 files changed, 488 insertions(+), 815 deletions(-)
