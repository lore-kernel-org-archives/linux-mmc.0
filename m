From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2 v2] mmc: tmio: handle missing HW interrupts
Date: Wed, 5 Jan 2011 21:22:23 +0000
Message-ID: <20110105212223.GJ9198@void.printf.net>
References: <1293628874-8140-1-git-send-email-arnd@arndnet.de> <1293628874-8140-2-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1293628874-8140-2-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Wed, Dec 29, 2010 at 02:21:13PM +0100, Arnd Hannemann wrote:
> This patch addresses this problem by introducing timeouts for outstan=
ding
> interrupts. If a hardware interrupt is missing, a soft reset will be =
performed
> to bring the hardware back to a working state.
> Tested with the SDHI hardware block in sh7372 / AP4EVB.
>=20
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

This breaks compilation without CONFIG_TMIO_MMC_DMA=3Dy, because it
attempts to compile tmio_mmc_reset_work() unconditionally even though
delayed_reset_work is only a member of tmio_mmc_host if TMIO_MMC_DMA=3D=
y:

drivers/mmc/host/tmio_mmc.c: In function =E2=80=98tmio_mmc_reset_work=E2=
=80=99:
drivers/mmc/host/tmio_mmc.c:357:31: error: =E2=80=98struct tmio_mmc_hos=
t=E2=80=99 has no member named =E2=80=98delayed_reset_work=E2=80=99

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
