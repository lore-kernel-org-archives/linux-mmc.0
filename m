From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] tmio: let platforms decide upon write-protection
 availability
Date: Fri, 21 May 2010 12:38:27 -0700
Message-ID: <20100521123827.a8d7a87a.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.1005191815491.3099@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43368 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758213Ab0EUTif (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 May 2010 15:38:35 -0400
In-Reply-To: <Pine.LNX.4.64.1005191815491.3099@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Wed, 19 May 2010 20:35:57 +0200 (CEST)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> No changes to patches themselves, just re-sending with an ack added.
> 
> Applies on top of the
> 
> "[PATCH 0/10] add DMA support to tmio_mmc, using dmaengine API, use it on SH"
> 
> patch series.
> 

Paul, are you planning on merging the tem patches in the
above-mentioned series for 2.6.35-rc1?

