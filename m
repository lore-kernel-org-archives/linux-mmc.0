From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/3] tmio: let platforms decide upon write-protection availability
Date: Sat, 22 May 2010 16:33:33 +0900
Message-ID: <20100522073332.GA17814@linux-sh.org>
References: <Pine.LNX.4.64.1005191815491.3099@axis700.grange> <20100521123827.a8d7a87a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:38316 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab0EVHdi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 May 2010 03:33:38 -0400
Content-Disposition: inline
In-Reply-To: <20100521123827.a8d7a87a.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org

On Fri, May 21, 2010 at 12:38:27PM -0700, Andrew Morton wrote:
> On Wed, 19 May 2010 20:35:57 +0200 (CEST)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > No changes to patches themselves, just re-sending with an ack added.
> > 
> > Applies on top of the
> > 
> > "[PATCH 0/10] add DMA support to tmio_mmc, using dmaengine API, use it on SH"
> > 
> > patch series.
> > 
> 
> Paul, are you planning on merging the tem patches in the
> above-mentioned series for 2.6.35-rc1?
> 
Yes, they'll be in my next round of updates for -rc1. Since I don't have
much else, I'll send those out today or tomorrow.
