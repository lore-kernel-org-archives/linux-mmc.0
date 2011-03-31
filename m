From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
Date: Thu, 31 Mar 2011 11:06:24 +0900
Message-ID: <AANLkTin6TdEWjQoNCGw1gV1BnzHjOQss9DA_0BRMdvNE@mail.gmail.com>
References: <1301453955-15759-1-git-send-email-horms@verge.net.au>
	<1301453955-15759-2-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1301453955-15759-2-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 30, 2011 at 11:59 AM, Simon Horman <horms@verge.net.au> wro=
te:
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
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Hi Simon,

Thanks for your work on this. v6 of this patch looks good to me!

Acked-by: Magnus Damm <damm@opensource.se>
