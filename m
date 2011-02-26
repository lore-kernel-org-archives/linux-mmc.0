From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] MMC: omap_hsmmc: enable interface clock before calling
 mmc_host_enable()
Date: Fri, 25 Feb 2011 18:43:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102251842580.6198@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012071624270.13430@utopia.booyaka.com> <AANLkTikMerO+FFsCJkiX7xa5m51zmKhQbikHDxT8GPK8@mail.gmail.com> <alpine.DEB.2.00.1102251823540.6198@utopia.booyaka.com> <20110226014123.GA29596@void.printf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38701 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab1BZBnX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 20:43:23 -0500
In-Reply-To: <20110226014123.GA29596@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, linux-omap@vger.kernel.org

Hi Chris,

On Sat, 26 Feb 2011, Chris Ball wrote:

> Thanks for asking -- OMAP folks seem to like merging patches to host/*omap*
> directly through the OMAP tree, and that's fine with me; I don't want to
> get in the way of a good workflow with responsive maintainers.  I do like
> the patches to be CC'd to linux-mmc@ (this one was, thanks), and I read
> them and will yell if something looks bogus to me.

thanks, will queue it here.


- Paul
