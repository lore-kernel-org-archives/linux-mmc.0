From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] sdhci - add public definition of quirks
Date: Fri, 27 Aug 2010 20:37:40 +0100
Message-ID: <20100827193740.GA18829@console-pimps.org>
References: <1266870828.8840.22.camel@uxka.diimka.lan>
 <20100827192823.GA23079@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:56219 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753149Ab0H0Thl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 15:37:41 -0400
Content-Disposition: inline
In-Reply-To: <20100827192823.GA23079@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: dmitry pervushin <dpervushin@gmail.com>, linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>, Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>

On Fri, Aug 27, 2010 at 08:28:23PM +0100, Chris Ball wrote:
> Hi,
> 
> Any comments on this patch from the list?

Are there no users of this patch? Who would want this? We generally
don't add infrastructure to the kernel without a user.
