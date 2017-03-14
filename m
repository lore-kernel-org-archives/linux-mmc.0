From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] ARM64: Prepare Marvell IAP140 aka PXA1908
Date: Tue, 14 Mar 2017 17:30:34 +0100
Message-ID: <CAPDyKFoy-dKTk=t6cmwzbjyntZHrkSyZbtpJ0wAMUDJ5xz4viA@mail.gmail.com>
References: <20170219032000.4674-1-afaerber@suse.de> <20170219032000.4674-2-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36629 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdCNQag (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 12:30:36 -0400
Received: by mail-vk0-f44.google.com with SMTP id t8so54865557vke.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2017 09:30:35 -0700 (PDT)
In-Reply-To: <20170219032000.4674-2-afaerber@suse.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jisheng Zhang <jszhang@marvell.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Eric Miao <eric.y.miao@gmail.com>, info@andromedabox.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby>

On 19 February 2017 at 04:19, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
> Suppress COMMON_CLK_PXA and MMC_PXA for now as they don't build on arm64.
> Also suppress the deprecated SERIAL_PXA in favor of SERIAL_8250_PXA.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  arch/arm64/Kconfig.platforms | 5 +++++
>  drivers/clk/Kconfig          | 2 +-
>  drivers/mmc/host/Kconfig     | 2 +-
>  drivers/tty/serial/Kconfig   | 2 +-
>  4 files changed, 8 insertions(+), 3 deletions(-)

Please try split this up so it can be applied on each subsystem independent=
ly.

Kind regards
Uffe

>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 129cc5a..841b6c8 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -111,6 +111,11 @@ config ARCH_MVEBU
>            - Armada 7K SoC Family
>            - Armada 8K SoC Family
>
> +config ARCH_PXA
> +       bool "Marvell PXA SoC Family"
> +       help
> +         This enables support for the Marvell PXA family.
> +
>  config ARCH_QCOM
>         bool "Qualcomm Platforms"
>         select GPIOLIB
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 9356ab4..3d25f20 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -185,7 +185,7 @@ config COMMON_CLK_PWM
>           at 50% duty cycle.
>
>  config COMMON_CLK_PXA
> -       def_bool COMMON_CLK && ARCH_PXA
> +       def_bool COMMON_CLK && ARCH_PXA && ARM
>         ---help---
>           Support for the Marvell PXA SoC.
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f08691a..a650eca 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -27,7 +27,7 @@ config MMC_QCOM_DML
>
>  config MMC_PXA
>         tristate "Intel PXA25x/26x/27x Multimedia Card Interface support"
> -       depends on ARCH_PXA
> +       depends on ARCH_PXA && ARM
>         help
>           This selects the Intel(R) PXA(R) Multimedia card Interface.
>           If you have a PXA(R) platform with a Multimedia Card slot,
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 6117ac8..0713a05 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -439,7 +439,7 @@ config SERIAL_MPSC_CONSOLE
>
>  config SERIAL_PXA
>         bool "PXA serial port support (DEPRECATED)"
> -       depends on ARCH_PXA || ARCH_MMP
> +       depends on (ARCH_PXA && ARM) || ARCH_MMP
>         select SERIAL_CORE
>         select SERIAL_8250_PXA if SERIAL_8250=3Dy
>         select SERIAL_PXA_NON8250 if !SERIAL_8250=3Dy
> --
> 2.10.2
>
