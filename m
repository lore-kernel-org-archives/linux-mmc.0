From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 0/6 v2] mmc: tmio: Add SDIO IRQ support
Date: Wed, 22 Dec 2010 22:54:26 +0900
Message-ID: <AANLkTi=oaLjQmz+G8_kK70JCxVfGfzv0VhRt3s9OsVXw@mail.gmail.com>
References: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
	<1292860431-16195-1-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1292860431-16195-1-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 21, 2010 at 12:53 AM, Arnd Hannemann <arnd@arndnet.de> wrot=
e:
> [PATCH 1/6 v2] mmc: tmio: implement SDIO IRQ
> [PATCH 2/6 v2] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
> [PATCH 3/6 v2] mmc: tmio: disable IRQs early in remove
> [PATCH 4/6 v2] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
> [PATCH 5/6 v2] sh: sh7724 Enable SDIO IRQs
> [PATCH 6/6 v2] [RFC] sh: sh7722 Enable SDIO IRQs
>
> These patches add SDIO IRQ support for the tmio mmc cell
> of the sh_mobile_sdhi mfd and activate the usage of
> SDIO IRQs on all SoCs where sh_mobile_sdhi is currently
> used.
>
> Changes since the earlier patchset:
> - Add TMIO_MMC_SDIO_IRQ flag, which expresses that =A0the hardware is=
 known
> =A0to support SDIO IRQ as suggested by Magnus Damm
> - Activate this flag for sh_mobile_sdhi
> - Add a patch which disables IRQs early in remove
> =A0to avoid spurious SDIO IRQs, during module unload
> - Patches 4-6 are unmodified but included for
> =A0completeness
>
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

Looking good, this patch series:

Acked-by: Magnus Damm <damm@opensource.se>

=46eel free to hack up support for sh7723 as well if you have time! =3D=
)

Cheers,

/ magnus
