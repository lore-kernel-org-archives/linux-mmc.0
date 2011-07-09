From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Sat, 9 Jul 2011 16:33:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107091632270.15984@utopia.booyaka.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com> <m2d3hjjdd0.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49181 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab1GIWdV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Jul 2011 18:33:21 -0400
In-Reply-To: <m2d3hjjdd0.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, kishore.kadiyala@ti.com

Hi Chris,

On Sat, 9 Jul 2011, Chris Ball wrote:

> On Fri, Jul 01 2011, Balaji T K wrote:
> > Balaji T K (3):
> >   MMC: OMAP: HSMMC: Remove lazy_disable
> >   MMC: OMAP: HSMMC: add runtime pm support
> >   MMC: OMAP: HSMMC: Remove unused iclk
> 
> I've merged these three patches to mmc-next for 3.1 now.

Thanks.

> > MMC runtime patch has dependency on
> > [PATCH 0/6] OMAP2+: hwmod framework fixes [1]
> > for MMC1/MMC2 clock to get ungated after idle in OMAP4.
> >
> > Without [1] patches, MMC1/MMC2 fails to get detected on OMAP4.
> >
> > [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51457.html
> 
> I'm assuming that these patches are going to make their way to Linus via
> someone else's tree.

Yes - we will try to merge them through the new ARM upstream path.


- Paul
