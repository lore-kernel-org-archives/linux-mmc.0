From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 21/31] ARM: amba: realview: get rid of private platform
 amba_device initializer
Date: Tue, 24 Jan 2012 16:00:44 +0000
Message-ID: <20120124160044.GM19798@mudshark.cambridge.arm.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-mmc@vger.kernel.org

Hi Russell,

On Fri, Jan 20, 2012 at 09:29:30AM +0000, Russell King - ARM Linux wrot=
e:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-realview/core.h            |   20 ++++-----------
>  arch/arm/mach-realview/realview_eb.c     |   38 +++++++++++++++-----=
----------
>  arch/arm/mach-realview/realview_pb1176.c |   38 +++++++++++++++-----=
----------
>  arch/arm/mach-realview/realview_pb11mp.c |   38 +++++++++++++++-----=
----------
>  arch/arm/mach-realview/realview_pba8.c   |   38 +++++++++++++++-----=
----------
>  arch/arm/mach-realview/realview_pbx.c    |   38 +++++++++++++++-----=
----------
>  6 files changed, 100 insertions(+), 110 deletions(-)

After applying this patch, I get compile-time errors in realview_*.c.
E.g.:

arch/arm/mach-realview/realview_pb1176.c:158:1: error: =E2=80=98AACI=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:159:1: error: =E2=80=98MMCI0=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:160:1: error: =E2=80=98KMI0=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:161:1: error: =E2=80=98KMI1=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:162:1: error: =E2=80=98PB1176_=
UART4=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:165:1: error: =E2=80=98PB1176_=
SMC=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:166:1: error: =E2=80=98SCTL=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:167:1: error: =E2=80=98PB1176_=
WATCHDOG=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:168:1: error: =E2=80=98PB1176_=
GPIO0=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:169:1: error: =E2=80=98GPIO1=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:170:1: error: =E2=80=98GPIO2=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:171:1: error: =E2=80=98PB1176_=
RTC=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:172:1: error: =E2=80=98SCI=E2=80=
=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:173:1: error: =E2=80=98PB1176_=
UART0=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:174:1: error: =E2=80=98PB1176_=
UART1=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:175:1: error: =E2=80=98PB1176_=
UART2=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:176:1: error: =E2=80=98PB1176_=
UART3=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:177:1: error: =E2=80=98PB1176_=
SSP=E2=80=99 undeclared here (not in a function)
arch/arm/mach-realview/realview_pb1176.c:178:1: error: =E2=80=98PB1176_=
CLCD=E2=80=99 undeclared here (not in a function)

> diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/c=
ore.h
> index 735b57a..b1c6097 100644
> --- a/arch/arm/mach-realview/core.h
> +++ b/arch/arm/mach-realview/core.h
> @@ -28,21 +28,11 @@
>  #include <asm/setup.h>
>  #include <asm/leds.h>
>=20
> -#define AMBA_DEVICE(name,busid,base,plat)                      \
> -static struct amba_device name##_device =3D {                    \
> -       .dev            =3D {                                     \
> -               .coherent_dma_mask =3D ~0,                        \
> -               .init_name =3D busid,                             \
> -               .platform_data =3D plat,                          \
> -       },                                                      \
> -       .res            =3D {                                     \
> -               .start  =3D REALVIEW_##base##_BASE,               \
> -               .end    =3D (REALVIEW_##base##_BASE) + SZ_4K - 1, \
> -               .flags  =3D IORESOURCE_MEM,                       \
> -       },                                                     =20

Which is because the old AMBA_DEVICE macro munges REALVIEW_ and _BASE
around the peripheral identifier...

> +#define APB_DEVICE(name, busid, base, plat)                    \
> +static AMBA_APB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
> +
> +#define AHB_DEVICE(name, busid, base, plat)                    \
> +static AMBA_AHB_DEVICE(name, busid, 0, base, base##_IRQ, plat)

=2E..whereas the new macros just use base directly.

=46ixing the macro solves the build problem:


diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/cor=
e.h
index b1c6097..f8f2c0a 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -29,10 +29,10 @@
 #include <asm/leds.h>
=20
 #define APB_DEVICE(name, busid, base, plat)                    \
-static AMBA_APB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
+static AMBA_APB_DEVICE(name, busid, 0, REALVIEW_##base##_BASE, base##_=
IRQ, plat)
=20
 #define AHB_DEVICE(name, busid, base, plat)                    \
-static AMBA_AHB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
+static AMBA_AHB_DEVICE(name, busid, 0, REALVIEW_##base##_BASE, base##_=
IRQ, plat)
=20
 struct machine_desc;
=20

but then I see a warning during boot:

[    1.669654] ------------[ cut here ]------------
[    1.684021] WARNING: at drivers/amba/bus.c:514 amba_device_add+0x1b4=
/0x1d0()
[    1.705585] Modules linked in:
[    1.715195] [<c0013a00>] (unwind_backtrace+0x0/0xfc) from [<c03d1350=
>] (dump_stack+0x20/0x24)
[    1.741288] [<c03d1350>] (dump_stack+0x20/0x24) from [<c001f9b8>] (w=
arn_slowpath_common+0x5c/0x74)
[    1.768689] [<c001f9b8>] (warn_slowpath_common+0x5c/0x74) from [<c00=
1f9fc>] (warn_slowpath_null+0x2c/0x34)
[    1.798165] [<c001f9fc>] (warn_slowpath_null+0x2c/0x34) from [<c023d=
cd4>] (amba_device_add+0x1b4/0x1d0)
[    1.826857] [<c023dcd4>] (amba_device_add+0x1b4/0x1d0) from [<c023dd=
84>] (amba_device_register+0x94/0xc4)
[    1.856106] [<c023dd84>] (amba_device_register+0x94/0xc4) from [<c05=
51934>] (realview_pb1176_init+0x74/0xac)
[    1.886120] [<c0551934>] (realview_pb1176_init+0x74/0xac) from [<c05=
4d60c>] (customize_machine+0x24/0x30)
[    1.915340] [<c054d60c>] (customize_machine+0x24/0x30) from [<c00087=
9c>] (do_one_initcall+0x48/0x1a0)
[    1.943505] [<c000879c>] (do_one_initcall+0x48/0x1a0) from [<c054b87=
0>] (kernel_init+0x80/0x128)
[    1.970378] [<c054b870>] (kernel_init+0x80/0x128) from [<c000ea78>] =
(kernel_thread_exit+0x0/0x8)
[    1.997192] ---[ end trace 1b75b31a2719ed1e ]---

I suspect that comes from PB1176_GPIO0_IRQ being -1.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
