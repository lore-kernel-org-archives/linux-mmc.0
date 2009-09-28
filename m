From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Mon, 28 Sep 2009 15:59:00 -0700
Message-ID: <20090928155900.36dfda0b.akpm@linux-foundation.org>
References: <1254160714.31101.3.camel@localhost>
	<20090928181046.GA4791@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38884 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753230AbZI1W70 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 18:59:26 -0400
In-Reply-To: <20090928181046.GA4791@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: ohad@bencohen.org, philipl@overt.org, ian@mnementh.co.uk, pierre@ossman.eu, roberto.foglietta@gmail.com, david.vrabel@csr.com, linux-mmc@vger.kernel.org

On Mon, 28 Sep 2009 19:10:48 +0100
Matt Fleming <matt@console-pimps.org> wrote:

> >  
> > +	if ((ocr & MMC_VDD_165_195) && !(host->caps & MMC_CAP_VDD_165_195)) {
> > +		printk(KERN_WARNING "%s: SDIO card claims to support the "
> > +			"incompletely defined 'low voltage range'. This "
> > +			"will be ignored.\n", mmc_hostname(host));
> > +		ocr &= ~MMC_VDD_165_195;
> > +	}
> > +
> >  	host->ocr = mmc_select_voltage(host, ocr);
> >  
> >  	/*
> 
> 
> I know you copied this warning from the old code

It'd be better to avoid copying anything at all.  Are we missing
code-sharing opportunities here?

> but does anyone think
> it's worth making this warning a bit clearer? e.g,
> 
> > +		printk(KERN_WARNING "%s: SDIO card claims to support the "
> > +			"incompletely defined 'low voltage range', but the "
> > +			"host controller does not. This voltage range"
> > +			"will be ignored.\n", mmc_hostname(host));

That looks better to me.
