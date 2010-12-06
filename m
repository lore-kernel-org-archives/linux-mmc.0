From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2 1/4]enable background operations for supported eMMC
 card
Date: Mon, 6 Dec 2010 20:34:29 +0800
Message-ID: <5D8008F58939784290FAB48F54975198320B3E49F6@shsmsx502.ccr.corp.intel.com>
References: <20101203121338.GB18655@intel.com>
 <201012061328.49738.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:13691 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab0LFMe4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 07:34:56 -0500
In-Reply-To: <201012061328.49738.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "kmpark@infradead.org" <kmpark@infradead.org>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Monday, December 06, 2010 8:29 PM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; cjb@laptop.org;
> akpm@linux-foundation.org; arjan@linux.intel.com; alan@linux.intel.com;
> kmpark@infradead.org
> Subject: Re: [PATCH v2 1/4]enable background operations for supported eMMC
> card
> 
> On Friday 03 December 2010, Chuanxiao Dong wrote:
> > From 984adc755cf2f7966a89e510a50f085e314fe347 Mon Sep 17 00:00:00 2001
> > From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > Date: Mon, 22 Nov 2010 16:31:12 +0800
> > Subject: [PATCH 1/4] mmc: Enabled background operations feature if eMMC card
> supports
> 
> These headers don't belong into a submission. If you use git-send-email,
> they get cut off automatically, otherwise just remove them as you paste
> the patch into your mail client.
>
OK. I will remove them when the next submission.

> > Background operations is a new feature defined in eMMC4.41 standard.
> > Since this feature is opertional for eMMC card, so driver only enable
> 
> s/opertional/optional/
> > @@ -54,6 +54,8 @@ struct mmc_ext_csd {
> >  	unsigned int		sec_trim_mult;	/* Secure trim multiplier  */
> >  	unsigned int		sec_erase_mult;	/* Secure erase multiplier */
> >  	unsigned int		trim_timeout;		/* In milliseconds */
> > +	unsigned int		bkops:1; /* background support bit */
> > +	unsigned int		bkops_en:1; /* background enable bit */
> >  };
> 
> Bit fields are not encouraged for kernel internal data structures,
> just use "bool" variables here.

Thanks Arnd. I will fix this.
