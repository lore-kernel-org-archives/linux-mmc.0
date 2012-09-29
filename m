From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 0/3] Add modules to support realtek PCIE card reader
Date: Sat, 29 Sep 2012 17:29:42 +0200
Message-ID: <20120929152942.GA11412@liondog.tnic>
References: <cover.1347330871.git.wei_wang@realsil.com.cn>
 <50664814.30407@turmel.org>
 <20120929110730.GA27797@liondog.tnic>
 <87d315osjm.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59432 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143Ab2I2P3p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 29 Sep 2012 11:29:45 -0400
Content-Disposition: inline
In-Reply-To: <87d315osjm.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: wei_wang@realsil.com.cn, gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>, Phil Turmel <philip@turmel.org>, sameo@linux.intel.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, arnd@arndb.de, oakad@yahoo.com

On Sat, Sep 29, 2012 at 09:41:17AM -0400, Chris Ball wrote:
> On Sat, Sep 29 2012, Borislav Petkov wrote:
> > So, I think that this driver has seen a bunch of testing and reviewing
> > and we might start considering upstreaming it. There are a bunch of
> > laptops integrating those readers and maybe a single three-month-ish -rc
> > period of testing wouldn't hurt before it appears upstream.
> >
> > Now, AFAICT, there is another driver in staging which supports the same
> > or a subset of the cardreaders this driver does so I don't know what
> > Realsil want to do with that. Wei?
> > 
> > And since this driver touches multiple drivers/{mfd,mmc,memstick}
> > subdirs, maybe akpm would like to merge it? At least I haven't seen any
> > other maintainers complaining about its design or wanting to take it so
> 
> I think you've missed the mails -- Alex Dubov has acked the memstick
> portion, Samuel Ortiz has said he'll push the MFD driver for 3.7,
> and I've pushed the MMC driver into mmc-next for 3.7.  So, I think
> we should merge it.  I don't think we need akpm, since there are no
> build-time dependencies involved.

Great, all is taken care of then.

Only the staging driver remains, I believe the CONFIG_RTS_PSTOR one. Wei?

Thanks.

-- 
Regards/Gruss,
    Boris.
