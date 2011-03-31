From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
Date: Thu, 31 Mar 2011 12:16:49 +0900
Message-ID: <20110331031648.GA3225@linux-sh.org>
References: <1301453955-15759-1-git-send-email-horms@verge.net.au> <1301453955-15759-2-git-send-email-horms@verge.net.au> <AANLkTin6TdEWjQoNCGw1gV1BnzHjOQss9DA_0BRMdvNE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:39263 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756758Ab1CaDRP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Mar 2011 23:17:15 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin6TdEWjQoNCGw1gV1BnzHjOQss9DA_0BRMdvNE@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Thu, Mar 31, 2011 at 11:06:24AM +0900, Magnus Damm wrote:
> On Wed, Mar 30, 2011 at 11:59 AM, Simon Horman <horms@verge.net.au> wrote:
> > This allows a ROM-able zImage to be written to eSD and for SuperH Mobile
> > ARM to boot directly from the SDHI hardware block.
> >
> > This is achieved by the MaskROM loading the first portion of the image into
> > MERAM and then jumping to it. ?This portion contains loader code which
> > copies the entire image to SDRAM and jumps to it. From there the zImage
> > boot code proceeds as normal, uncompressing the image into its final
> > location and then jumping to it.
> >
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Hi Simon,
> 
> Thanks for your work on this. v6 of this patch looks good to me!
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Likewise. Feel free to shovel it in to the patch tracker at your leisure.

Acked-by: Paul Mundt <lethal@linux-sh.org>
