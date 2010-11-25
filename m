From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/5 v2] MMC: DMA for SH MMCIF
Date: Thu, 25 Nov 2010 16:29:57 +0900
Message-ID: <20101125072957.GF3270@linux-sh.org>
References: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:57811 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab0KYHaq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2010 02:30:46 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>

On Wed, Nov 24, 2010 at 11:05:08AM +0100, Guennadi Liakhovetski wrote:
> This patch series slightly cleans up the sh_mmcif MMC driver and adds a 
> DMA capability to it. One of the patches is not directly related, but is 
> required for a proper DMA functionality. V2 limits the number of request 
> segments, instead of raising the number of DMA descriptors in shdma.c. 
> This drops one patch from this series and modifies one further patch, the 
> rest remain unchanged.
> 
Looks better! All applied, thanks.
