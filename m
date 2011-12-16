From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAP3: hwmod data: disable multiblock reads on
 MMC1/2 on OMAP34xx/35xx <= ES2.1
Date: Fri, 16 Dec 2011 08:52:16 -0800
Message-ID: <CAGDS+nnWz5hW_13hHf51s-MhK8B-C_cMVLLmEpUA1pTCBJ3hbg@mail.gmail.com>
References: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
	<alpine.DEB.2.00.1112152346080.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57190 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759620Ab1LPQwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Dec 2011 11:52:18 -0500
In-Reply-To: <alpine.DEB.2.00.1112152346080.12660@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Dave Hylands <dhylands@gmail.com>

On Fri, Dec 16, 2011 at 12:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The HSMMC1/HSMMC2 host controllers on OMAP34xx and
> OMAP3503/3515/3525/3530 chips at ES levels prior to 3.0 can't do mult=
iple
> block reads[1]. =A0Mark the hwmod data appropriately.
>
> Reported by Dave Hylands <dhylands@gmail.com> and Steve Sakoman
> <sakoman@gmail.com>. =A0Thanks to Steve Sakoman for further help
> testing this patch.
>
> 1. See for example Advisory 2.1.1.128 "MMC: Multiple Block Read
> =A0 Operation Issue" in _OMAP3530/3525/3515/3503 Silicon Errata_
> =A0 Revision F (October 2010) (SPRZ278F), available from
> =A0 http://focus.ti.com/lit/er/sprz278f/sprz278f.pdf
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Dave Hylands <dhylands@gmail.com>
> Cc: Steve Sakoman <sakoman@gmail.com>
> ---
>
> The first version of this patch caused MMC hwmods to not be registere=
d on
> 36xx/37xx chips. =A0Thanks to Steve Sakoman for noting this. =A0This =
version
> fixes it - tested on 37xx BeagleBoard.

I tested this on multiple different processor versions:

OMAP3503-GP ES2.1
OMAP3503-GP ES3.1
OMAP3530-GP ES3.1
OMAP3730-GP ES1.0
OMAP3730-GP ES1.2

All worked as expected, multi-block reads were enabled for all except
OMAP3503-GP ES2.1, which displayed:

omap_hsmmc omap_hsmmc.0: multiblock reads disabled due to 35xx erratum
2.1.1.128; MMC read performance may suffer

Thanks, Paul!

Tested-by: Steve Sakoman <steve@sakoman.com>
