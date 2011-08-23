From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 22:22:25 +0200
Message-ID: <20110823202225.GA9433@merkur.ravnborg.org>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com> <1314114363-6767-3-git-send-email-svenkatr@ti.com> <m27h643x8k.fsf@bob.laptop.org> <20110823172851.GB1784@leaf> <874o18m2cn.fsf@blp.benpfaff.org> <20110823181359.GB3418@leaf> <m2mxf02d9h.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:19179 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1HWUW1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2011 16:22:27 -0400
Content-Disposition: inline
In-Reply-To: <m2mxf02d9h.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Josh Triplett <josh@joshtriplett.org>, blp@cs.stanford.edu, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org

On Tue, Aug 23, 2011 at 02:28:42PM -0400, Chris Ball wrote:
> Hi,
> 
> On Tue, Aug 23 2011, Josh Triplett wrote:
> > {} produces the same effect, as far as I know.
> 
> Yeah.  I prefer {0}, because {} is a gcc-ism (the ANSI grammar demands
> initializer-lists be non-empty) and is less readable for people who
> haven't seen the idiom before and are wondering what's going on.
> 
> I'm still a little confused -- the {0} or memset(0, struct ..);
> formations are used often in the kernel, even with pointers involved.
> Is the warning (Wnon_pointer_null) run against the kernel by default,
> or did Venkatraman add it manually?  If default, is it catching bugs?

It is default enabled - and trigger a lot of warnings.
But the kernel idiom is to use NULL for a null pointer - and not to use 0.

Which is why the warning was introduced.

	Sam
