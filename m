From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: omap_hsmmc: enable interface clock before calling
	mmc_host_enable()
Date: Sat, 26 Feb 2011 01:41:23 +0000
Message-ID: <20110226014123.GA29596@void.printf.net>
References: <alpine.DEB.2.00.1012071624270.13430@utopia.booyaka.com> <AANLkTikMerO+FFsCJkiX7xa5m51zmKhQbikHDxT8GPK8@mail.gmail.com> <alpine.DEB.2.00.1102251823540.6198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1102251823540.6198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-mmc@vger.kernel.org, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Paul,

On Fri, Feb 25, 2011 at 06:26:45PM -0700, Paul Walmsley wrote:
> 
> Hi Chris,
> 
> would you like to take this one, or should we merge it through the OMAP 
> tree?

Thanks for asking -- OMAP folks seem to like merging patches to host/*omap*
directly through the OMAP tree, and that's fine with me; I don't want to
get in the way of a good workflow with responsive maintainers.  I do like
the patches to be CC'd to linux-mmc@ (this one was, thanks), and I read
them and will yell if something looks bogus to me.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
