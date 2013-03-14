From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 4/5] mmc: mxcmmc: enable DMA support on mpc512x
Date: Thu, 14 Mar 2013 22:18:16 +0100
Message-ID: <20130314221816.1e4c93c1@crub>
References: <1363279254-22351-1-git-send-email-agust@denx.de>
	<1363279254-22351-6-git-send-email-agust@denx.de>
	<20130314201139.GS1906@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46626 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab3CNVSS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 17:18:18 -0400
In-Reply-To: <20130314201139.GS1906@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org

On Thu, 14 Mar 2013 21:11:39 +0100
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Thu, Mar 14, 2013 at 05:40:53PM +0100, Anatolij Gustschin wrote:
> > Add SDHC DMA channel description to the mpc512x device
> > tree to enable slave channel requesting in the mxcmmc
> > driver.
> > 
> > mpc512x DMA engine doesn't support endianness conversion
> > when reading/writing data from peripheral's FIFO, so we
> > have to swap data buffers before each DMA write and after
> > each DMA read transfer manually.
> > 
> > Since chained SDHC DMA transfers are not supported on
> > mpc512x, limit 'max_segs' tunable parameter to one and
> > initialise it to 64 only when running on i.MX platforms.
> 
> They are also not supported on the older i.MX platforms. Shouldn't this
> be handled in the DMA driver?

This could be handled in the DMA driver, but up to now nobody
cared to extend the DMA driver so.

Anatolij
