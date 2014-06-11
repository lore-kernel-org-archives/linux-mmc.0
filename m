From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v4] mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO
 host controller
Date: Wed, 11 Jun 2014 22:20:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1406112218060.2586@axis700.grange>
References: <Pine.LNX.4.64.1405312005390.20582@axis700.grange>
 <86y4x3mfhc.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63029 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbaFKUUM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jun 2014 16:20:12 -0400
In-Reply-To: <86y4x3mfhc.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, 11 Jun 2014, Chris Ball wrote:

> Hi Guennadi,
> 
> On Sat, May 31 2014, Guennadi Liakhovetski wrote:
> > This patch adds a driver for the Renesas usdhi6rol0 SD/SDIO host controller
> > in both PIO and DMA modes.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >
> > v4: replaced several numerical values with macros
> 
> Please send fixes for the compiler warnings, potential-null mrq,

Sure, it's on my todo for Saturday, is this ok?

> and
> perhaps add an ARCH_ dependency to stop this building on x86_64.

Is there a specific reason to only build it on ARM? It can be used with 
various architectures, but we can make it depend on COMPILE_TEST (or 
whatever that option is called), but I'm not sure that's required.

Thanks
Guennadi
