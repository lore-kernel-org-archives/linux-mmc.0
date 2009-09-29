From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Tue, 29 Sep 2009 06:53:29 +0100
Message-ID: <20090929055328.GB4791@console-pimps.org>
References: <1254160714.31101.3.camel@localhost>
 <20090928181046.GA4791@console-pimps.org>
 <20090928155900.36dfda0b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:59889 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbZI2Fx5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2009 01:53:57 -0400
Content-Disposition: inline
In-Reply-To: <20090928155900.36dfda0b.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ohad@bencohen.org, philipl@overt.org, ian@mnementh.co.uk, pierre@ossman.eu, roberto.foglietta@gmail.com, david.vrabel@csr.com, linux-mmc@vger.kernel.org

On Mon, Sep 28, 2009 at 03:59:00PM -0700, Andrew Morton wrote:
> On Mon, 28 Sep 2009 19:10:48 +0100
> Matt Fleming <matt@console-pimps.org> wrote:
> 
> > >  
> > > +	if ((ocr & MMC_VDD_165_195) && !(host->caps & MMC_CAP_VDD_165_195)) {
> > > +		printk(KERN_WARNING "%s: SDIO card claims to support the "
> > > +			"incompletely defined 'low voltage range'. This "
> > > +			"will be ignored.\n", mmc_hostname(host));
> > > +		ocr &= ~MMC_VDD_165_195;
> > > +	}
> > > +
> > >  	host->ocr = mmc_select_voltage(host, ocr);
> > >  
> > >  	/*
> > 
> > 
> > I know you copied this warning from the old code
> 
> It'd be better to avoid copying anything at all.  Are we missing
> code-sharing opportunities here?
> 

No, Ohad's commit 27cce39f555def6f5ebe7f03d69ccc44ab25f0b2 "sdio: do not
ignore MMC_VDD_165_195" deleted this warning and this commit is just
bringing it back from the dead.

It seems that Philip and David have other ideas on how they want to
handle this voltage range so this patch probably doesn't need picking
up.
