From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] initialise DMA engine before MMC
Date: Wed, 23 Jun 2010 08:47:43 +0200
Message-ID: <AANLkTikndTP49meKLd1bh7De04wUHrFovpgwbIrpYGF9@mail.gmail.com>
References: <Pine.LNX.4.64.1006071312060.12965@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1006071312060.12965@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2010/6/7 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:

> To use DMA engine based DMA with MMC in a non-modular build, the DMA
> engine has to initialise before MMC.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 91874e0..b713e75 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_EISA) =A0 =A0 =A0 =A0 =A0 =A0+=3D eisa=
/
> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D lgue=
st/
> =A0obj-$(CONFIG_CPU_FREQ) =A0 =A0 =A0 =A0 +=3D cpufreq/
> =A0obj-$(CONFIG_CPU_IDLE) =A0 =A0 =A0 =A0 +=3D cpuidle/
> +obj-$(CONFIG_DMA_ENGINE) =A0 =A0 =A0 +=3D dma/
> =A0obj-$(CONFIG_MMC) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D mmc/
> =A0obj-$(CONFIG_MEMSTICK) =A0 =A0 =A0 =A0 +=3D memstick/
> =A0obj-$(CONFIG_NEW_LEDS) =A0 =A0 =A0 =A0 +=3D leds/
> @@ -102,7 +103,6 @@ obj-$(CONFIG_CRYPTO) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D crypto/
> =A0obj-$(CONFIG_SUPERH) =A0 =A0 =A0 =A0 =A0 +=3D sh/
> =A0obj-$(CONFIG_ARCH_SHMOBILE) =A0 =A0+=3D sh/
> =A0obj-$(CONFIG_GENERIC_TIME) =A0 =A0 +=3D clocksource/
> -obj-$(CONFIG_DMA_ENGINE) =A0 =A0 =A0 +=3D dma/
> =A0obj-$(CONFIG_DCA) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dca/
> =A0obj-$(CONFIG_HID) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D hid/
> =A0obj-$(CONFIG_PPC_PS3) =A0 =A0 =A0 =A0 =A0+=3D ps3/

What I did was to move my DMA engines to subsystem_initcall(), with thi=
s
approach I would have had to rearrange a lot of subsystems I think.

But if it's easier for you this way by all means do it.

Yours,
Linus Walleij
