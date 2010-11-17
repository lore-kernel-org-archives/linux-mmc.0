From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/7] mmc: sdhci-of: fix build on non-powerpc platforms
Date: Tue, 16 Nov 2010 22:32:18 -0700
Message-ID: <20101117053218.GD12813@angua.secretlab.ca>
References: <1289939635-30742-1-git-send-email-robherring2@gmail.com>
 <1289939635-30742-5-git-send-email-robherring2@gmail.com>
 <20101116214409.GC19893@pengutronix.de>
 <4CE30710.6050302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55765 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab0KQFcW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2010 00:32:22 -0500
Received: by gwj17 with SMTP id 17so907887gwj.19
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2010 21:32:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE30710.6050302@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>

On Tue, Nov 16, 2010 at 04:34:56PM -0600, Rob Herring wrote:
> On 11/16/2010 03:44 PM, Wolfram Sang wrote:
> >On Tue, Nov 16, 2010 at 02:33:52PM -0600, Rob Herring wrote:
> >>From: Rob Herring<rob.herring@calxeda.com>
> >>
> >>Explicitly include err.h, of_address.h and of_irq.h.
> >>Make use of machine_is() conditional on PPC.
> >>
> >>Signed-off-by: Rob Herring<rob.herring@calxeda.com>
> >
> >Hmm, sins of the past :/ I wonder if we can get away with less #ifdeffery, will
> >think about it...
> >
> 
> I don't want to start a long debate, but is updating a kernel
> without updating the dtb really something to worry about?

Yes, once a .dtb is merged we try very hard not to break it.  It may
need to be updated to enable more features, but the goal is to not
regress.  One of the reason being that firmware may provide a default,
but old, dtb and it is important to still be able to boot on those
systems, even if the dtb is immediately going to be updated.

That's one of the reasons why it is so important to document and
review bindings up front and make sure they make sense before we
commit to them.

That being said, there are other ways to deal with old dtbs, like
fixing up the data at platform setup time.

> Isn't a year enough of a transition period.

No.

g.

