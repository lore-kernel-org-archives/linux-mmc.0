From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 9/9 v2] ARM: mach-shmobile: add DMA support to sh7372, enable DMA for SDHI
Date: Mon, 31 May 2010 13:50:08 +0900
Message-ID: <20100531045008.GE20358@linux-sh.org>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange> <Pine.LNX.4.64.1005041424330.4925@axis700.grange> <Pine.LNX.4.64.1005231546310.3571@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:49539 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab0EaEu1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2010 00:50:27 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1005231546310.3571@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org

On Sun, May 23, 2010 at 03:49:47PM +0200, Guennadi Liakhovetski wrote:
> This adds DMA support for the sh7372 sh-mobile ARM core, using the shdma
> dmaengine driver, and uses DMA for the SDHI SD-card controller on this SoC.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v1 -> v2:
> 
> 1. updated to the current genesis tree HEAD
> 2. adjusted the topic line to match platform preferences
> 3. moved DMA platform devices to the top of the file, so that other 
> devices can reference them.
> 
> Paul, this should be ready for you to merge now.
> 
Applied, thanks.
