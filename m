From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/4] mmc: tmio: Implement SDIO IRQ
Date: Tue, 7 Dec 2010 14:39:50 +0900
Message-ID: <AANLkTimHqoHzO8-5mdTiB03sp_mB0Ose6enOXsTvT5R+@mail.gmail.com>
References: <1291656942-18100-1-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1291656942-18100-1-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Tue, Dec 7, 2010 at 2:35 AM, Arnd Hannemann <arnd@arndnet.de> wrote:
> This patch implements SDIO IRQ support for mfds which
> announce the MMC_CAP_SDIO_IRQ capability for tmio_mmc.
> Tested with a b43-based wireless SDIO card and sh_mobile_sdhi.
>
> This patch applies on top of:
> mmc: tmio_mmc: allow multi-element scatter-gather lists
> mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
> mmc: tmio: merge the private header into the driver
> mmc: tmio: implement a bounce buffer for unaligned DMA
>
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
> CC: Ian Molton <ian@mnementh.co.uk>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/mmc/host/tmio_mmc.c | =A0 54 +++++++++++++++++++++++++++++=
+++++++++++++-
> =A01 files changed, 53 insertions(+), 1 deletions(-)

Thanks for your work on this!

Just curious, did you test this change in 4-bit mode and/or 1-bit
mode? I believe that 1-bit mode support is rather simple, but 4-bit
mode requires toggling between the IRQ and DATA function which happen
to be using the same pin. It looks like the current code only deals
with 1-bit mode - perhaps 4-bit mode isn't supported by the b43
driver?

Not sure how the Linux MMC stack supports 4-bit IRQs, but the S4MI bit
in the CCCR should specify if it's allowed to enable interrupts in
between data transfers or not. Perhaps that is something we need to
deal with in the driver? Or maybe the framework needs to be extended?

Thanks,

/ magnus
