From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
 autoloading feature
Date: Thu, 11 Mar 2010 10:39:44 -0800
Message-ID: <20100311183944.GJ2900@atomide.com>
References: <618f0c911003100612l33b1fec9s163720a5a93a1787@mail.gmail.com>
 <20100310224110.GW2900@atomide.com>
 <618f0c911003110708s5015f2bftb443b9ea57cb6477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50527 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934117Ab0CKSi0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2010 13:38:26 -0500
Content-Disposition: inline
In-Reply-To: <618f0c911003110708s5015f2bftb443b9ea57cb6477@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>

* Venkatraman S <svenkatr@ti.com> [100311 07:04]:
> Tony Lindgren wrote:
> >
> > Does the driver still work in PIO mode?
> >
> > We need to have the drivers capable to fail over to PIO mode
> > as the DMA channels can run out.
> >
> 
>    The driver doesn't have an automatic fallback to PIO,
> even without my patch. A error return from omap_request_dma is
> propogated all the way back to the transfer request.
>   The decision to use_dma (the variable) is unaltered.

OK, that might explain some nasty surprises then..

With these patches, does the driver still work in PIO mode though?
 
>    Infact, it would be easier to implement a runtime fallback after
> this patch is
> merged as I have separated out the capability and runtime selection.
> (dma_caps and dma_in_use).

Sounds good to me, thanks for looking into it.

Regards,

Tony
