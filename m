From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 9/9] ARM: add DMA support to sh7372, enable DMA for SDHI
Date: Wed, 26 May 2010 14:12:31 -0700
Message-ID: <20100526141231.38e85b58.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
	<Pine.LNX.4.64.1005041424330.4925@axis700.grange>
	<20100512155224.65eba9ee.akpm@linux-foundation.org>
	<Pine.LNX.4.64.1005130851030.4671@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59561 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754776Ab0EZVNO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 17:13:14 -0400
In-Reply-To: <Pine.LNX.4.64.1005130851030.4671@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org

On Thu, 13 May 2010 08:57:06 +0200 (CEST)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> On Wed, 12 May 2010, Andrew Morton wrote:
> 
> > On Tue, 4 May 2010 16:07:15 +0200 (CEST)
> > Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > 
> > > This patch depends on patch series from Magnus for shmobile, adding INTC 
> > > and clock support. This patch wasn't there in the first version of this 
> > > series.
> > 
> > Where is that patch series now?
> 
> AFAIU, these are two patch series - for the interrupt controller and for 
> the clock framework, and they are not upstream yet. So, I think, we can 
> leave patch 9/9 for later to be merged via the respective platform tree.
> 

Again, because of your lack of specificity in identifying patches I am
unable to determine whether
arm-add-dma-support-to-sh7372-enable-dma-for-sdhi.patch is presently
mergeable.

So I won't merge it.
