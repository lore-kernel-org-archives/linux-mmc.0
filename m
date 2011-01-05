From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] mmc: sh_mmcif: make DMA support by the driver unconditional
Date: Wed, 5 Jan 2011 16:57:58 +0900
Message-ID: <20110105075757.GC23889@linux-sh.org>
References: <Pine.LNX.4.64.1012290852530.14233@axis700.grange> <AANLkTikh5yYj_kXM6fD+SNmurXqmB_ATaKnDfWM5Cwva@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:56997 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1AEH7y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 02:59:54 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikh5yYj_kXM6fD+SNmurXqmB_ATaKnDfWM5Cwva@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Jan 05, 2011 at 10:45:49AM +0900, Magnus Damm wrote:
> On Wed, Dec 29, 2010 at 4:59 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Simplify the driver by removing the possibility to build it without the DMA
> > support and remove the respective Kconfig parameter.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Excellent, this helps against bitrot and makes kernel configuration
> easier for newbies.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Applied to rmobile/mmcif, thanks.
