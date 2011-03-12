From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/6] mmc: tmio: split core functionality, DMA and MFD glue
Date: Sun, 13 Mar 2011 01:05:27 +0900
Message-ID: <AANLkTinQB2NB---0o65Uy-axApw9DwPZoMeMBc=qmvSC@mail.gmail.com>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
	<Pine.LNX.4.64.1103110844080.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55379 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab1CLQF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Mar 2011 11:05:29 -0500
In-Reply-To: <Pine.LNX.4.64.1103110844080.23675@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Fri, Mar 11, 2011 at 4:51 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> TMIO MMC chips contain an SD / SDIO IP core from Panasonic, similar t=
o
> the one, used in MN5774 and other MN57xx controllers. These IP cores =
are
> included in many multifunction devices, in sh-mobile chips from Renes=
as,
> in the latter case they can also use DMA. Some sh-mobile implementati=
ons
> also have some other specialities, that MFD-based solutions don't hav=
e.
> This makes supporting all these features in a monolithic driver incon=
veniet
> and error-prone. This patch splits the driver into 3 parts: the core,
> the MFD glue and the DMA support. In case of a modular build, two mod=
ules
> will be built: mmc_tmio_core and mmc_tmio.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Thanks for your work on this, I'm happy to see these patches because
they make it easier for me to add multi-interrupt source to the SDHI
portion - something that is needed for sh73a0.

> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0drivers/mmc/host/Makefile =A0 =A0 =A0 | =A0 =A03 +
> =A0drivers/mmc/host/tmio_mmc.c =A0 =A0 | 1303 +----------------------=
----------------
> =A0drivers/mmc/host/tmio_mmc.h =A0 =A0 | =A0152 +++++
> =A0drivers/mmc/host/tmio_mmc_dma.c | =A0302 +++++++++
> =A0drivers/mmc/host/tmio_mmc_pio.c | =A0923 +++++++++++++++++++++++++=
++
> =A06 files changed, 1402 insertions(+), 1285 deletions(-)
> =A0create mode 100644 drivers/mmc/host/tmio_mmc.h
> =A0create mode 100644 drivers/mmc/host/tmio_mmc_dma.c
> =A0create mode 100644 drivers/mmc/host/tmio_mmc_pio.c

Something is wrong with this patch. The Makefile adds tmio_mmc_core.c
but it's not part of the diffstat above. Perhaps you're posting an
older version of the patch?

Thanks,

/ magnus
