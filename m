From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH 00/07] sh: SuperH Mobile SDHI changes
Date: Fri, 2 Oct 2009 19:23:28 +0100
Message-ID: <c09aa50a0910021123x61c7ea01k40baa3fa90028c3e@mail.gmail.com>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:54830 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbZJBSXp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 14:23:45 -0400
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, lethal@linux-sh.org, akpm@linux-foundation.org

I'm ok with the superH patches now. Those that depend on my patchset
which will be waiting on ASIC3 (my patchset needs to support ASIC3 to
avoid breaking already merged drivers).

Andrew: am I passing MMC patches via you?

2009/10/2 Magnus Damm <magnus.damm@gmail.com>:
> sh: SuperH Mobile SDHI changes
>
> [PATCH 01/07] mfd: Add SuperH Mobile SDHI platform driver
> [PATCH 02/07] mmc: Add SuperH to the tmio-mmc Kconfig
> [PATCH 03/07] mmc: Remove const from tmio-mmc platform data
> [PATCH 04/07] sh: SDHI platform data to the Migo-R board
> [PATCH 05/07] sh: SDHI platform data to the AP325RXA board
> [PATCH 06/07] sh: SDHI platform data to the SE7724 board
> [PATCH 07/07] sh: SDHI platform data to the kfr2r09 board
>
> These patches contain the SuperH specific changes needed for
> the tmio-mmc driver to work with SuperH Mobile SDHI hardware.
>
> The tmio-mmc patch 0001-MMC-hardware-abstraction-for-CNF-area.patch
> by Ian Molton is needed for correct run time behaviour. Without
> this patch the tmio-mmc probe() fails gracefully.
>
> I suggest merging the series in the SuperH tree. Not sure about
> the best way to merge the patch by Ian.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
> =A0arch/sh/boards/board-ap325rxa.c =A0 =A0 | =A0 52 ++++++------
> =A0arch/sh/boards/mach-kfr2r09/setup.c | =A0 33 +++++++
> =A0arch/sh/boards/mach-migor/setup.c =A0 | =A0 52 ++++++------
> =A0arch/sh/boards/mach-se/7724/setup.c | =A0 33 +++++++
> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +
> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01
> =A0drivers/mfd/sh_mobile_sdhi.c =A0 =A0 =A0 =A0| =A0149 +++++++++++++=
+++++++++++++++++++++-
> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02
> =A0include/linux/mfd/tmio.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02
> =A09 files changed, 279 insertions(+), 53 deletions(-)
>



--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
