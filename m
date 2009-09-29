From: Philip Langdale <philipl@overt.org>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Mon, 28 Sep 2009 19:25:48 -0700
Message-ID: <20090928192548.11da5c3c@fido2.homeip.net>
References: <1254160269.10634.15.camel@localhost>
	<4AC0FBF0.6090007@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from usul.overt.org ([204.11.33.43]:48124 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbZI2DE1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Sep 2009 23:04:27 -0400
In-Reply-To: <4AC0FBF0.6090007@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, "p hilipl"@overt.org, ian@mnementh.co.uk, matt@console-pimps.org, pierre@ossman.eu, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

On Mon, 28 Sep 2009 19:09:52 +0100
David Vrabel <david.vrabel@csr.com> wrote:

> Ohad Ben-Cohen wrote:
> > From: Ohad Ben-Cohen <ohad@wizery.com>
> > 
> > To allow the usage of MMC_VDD_165_195, host capability
> > MMC_CAP_VDD_165_195 is introduced. This is necessary
> > because MMC_VDD_165_195 is currently reserved/undefined.
> 
> The host already reports what voltages it supports (in
> mmc_host::ocr_avail) so a seperate MMC_CAP_* isn't needed.
> 
> This interpretation of the reserved bits in the OCR should only done
> for certain cards where the bits actually do mean 1.8 V operation
> (with v2.0 signalling) is possible.
> 
> That's a fair amount of work so perhaps in the interim something like
> this:
> 
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -494,6 +494,9 @@ int mmc_attach_sdio(struct mmc_host *host, u32
> ocr) ocr &= ~0x7F;
>  	}
> 
> +	if (ocr & MMC_VDD_165_195)
> +		printk(KERN_WARNING "%s: warning: card claims
> non-standard 1.65-1.95 V support"
> +
>  	host->ocr = mmc_select_voltage(host, ocr);
> 
>  	/*
> 
> And revisit this if these bits either: a) gain a (different) standard
> meaning; or b) some other card uses these bits in a different
> non-standard way.  Neither seems likely.

Hi David,

Ok, that sounds reasonable, but my concern is a controller that
publishes support for MMC_VDD_165_195 for mmc cards but doesn't
claim support for SDIO cards - particularly considering the
signalling implications you mentioned. Now, maybe you don't see
this happening in the wild, but it seems to me that it has to
be possible. It seems that to guard against this, you'd need a
host cap that says "165_195 for SD" and if it's not present,
mask it out of the OCR when dealing with SD/IO cards.

Am I being too paranoid?

--phil
