From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] [rfc] mmc, ARM: Add zboot from eSD support for SuperH
 Mobile ARM
Date: Thu, 10 Mar 2011 17:07:17 +0900
Message-ID: <AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
References: <1299743892-3668-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1299743892-3668-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Thu, Mar 10, 2011 at 4:58 PM, Simon Horman <horms@verge.net.au> wrot=
e:
> This allows a ROM-able zImage to be written to eSD and for SuperH Mob=
ile
> ARM to boot directly from the SDHI hardware block.
>
> This is achieved by the MaskROM loading the first portion of the imag=
e into
> MERAM and then jumping to it. =A0This portion contains loader code wh=
ich
> copies the entire image to SDRAM and jumps to it. From there the zIma=
ge
> boot code proceeds as normal, uncompressing the image into its final
> location and then jumping to it.
>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Nice to see some SDHI loader code!

> --- /dev/null
> +++ b/arch/arm/boot/compressed/sdhi-shmobile.c

> +#define PORT179CR =A0 =A0 =A00xe60520b3
> +#define PORT180CR =A0 =A0 =A00xe60520b4
> +#define PORT181CR =A0 =A0 =A00xe60520b5
> +#define PORT182CR =A0 =A0 =A00xe60520b6
> +#define PORT183CR =A0 =A0 =A00xe60520b7
> +#define PORT184CR =A0 =A0 =A00xe60520b8
> +
> +#define SMSTPCR3 =A0 =A0 =A0 0xe615013c
> +#define SDGENCNTA =A0 =A0 =A00xfe40009c

These...

> + =A0 =A0 =A0 /* Initialise SDHI1 */
> + =A0 =A0 =A0 /* PORT184CR: GPIO_FN_SDHICMD1 Control */
> + =A0 =A0 =A0 __raw_writeb(CR_FUNCTION1, PORT184CR);
> + =A0 =A0 =A0 /* PORT179CR: GPIO_FN_SDHICLK1 Control */
> + =A0 =A0 =A0 __raw_writeb(CR_INPUT_ENABLE|CR_FUNCTION1, PORT179CR);
> + =A0 =A0 =A0 /* PORT181CR: GPIO_FN_SDHID1_3 Control */
> + =A0 =A0 =A0 __raw_writeb(CR_FUNCTION1, PORT183CR);
> + =A0 =A0 =A0 /* PORT182CR: GPIO_FN_SDHID1_2 Control */
> + =A0 =A0 =A0 __raw_writeb(CR_FUNCTION1, PORT182CR);
> + =A0 =A0 =A0 /* PORT183CR: GPIO_FN_SDHID1_1 Control */
> + =A0 =A0 =A0 __raw_writeb(CR_FUNCTION1, PORT181CR);
> + =A0 =A0 =A0 /* PORT180CR: GPIO_FN_SDHID1_0 Control */
> + =A0 =A0 =A0 __raw_writeb(CR_FUNCTION1, PORT180CR);
> +
> + =A0 =A0 =A0 /* Enable clock to SDHI1 hardware block */
> + =A0 =A0 =A0 __raw_writel(__raw_readl(SMSTPCR3) & ~(1 << 13), SMSTPC=
R3);

=2E..and these are sh7372 specific.

If possible I'd like to reuse your SDHI code on sh73a0, so please
consider splitting up the code in a SDHI specific portion and in a
processor specific portion.

Thanks,

/ magnus
