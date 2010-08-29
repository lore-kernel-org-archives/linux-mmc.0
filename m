From: dmitry pervushin <dpervushin@gmail.com>
Subject: Re: [PATCH] sdhci - add public definition of quirks
Date: Sun, 29 Aug 2010 11:26:58 +0400
Message-ID: <1283066818.4477.2.camel@uxka.diimka.lan>
References: <1266870828.8840.22.camel@uxka.diimka.lan>
	 <20100827192823.GA23079@void.printf.net>
	 <20100827193740.GA18829@console-pimps.org>
Reply-To: dpervushin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35924 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab0H2H1E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Aug 2010 03:27:04 -0400
Received: by wyb35 with SMTP id 35so5504691wyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 29 Aug 2010 00:27:02 -0700 (PDT)
In-Reply-To: <20100827193740.GA18829@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>, Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>

On Fri, 2010-08-27 at 20:37 +0100, Matt Fleming wrote:
> On Fri, Aug 27, 2010 at 08:28:23PM +0100, Chris Ball wrote:
> > Hi,
> > 
> > Any comments on this patch from the list?
> 
> Are there no users of this patch? Who would want this? We generally
> don't add infrastructure to the kernel without a user.

This patch is superseded by commit
a7626b7a5de37bbd506b23633be95428ee81c2e4, Anton Vorontsov's patch
"sdhci-pltfm: implement platform data passing"

-- 
dmitry pervushin <dpervushin@gmail.com>
Home, sweet home...

