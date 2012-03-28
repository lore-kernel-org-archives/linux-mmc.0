From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add
 device tree support
Date: Wed, 28 Mar 2012 10:54:50 +0100
Message-ID: <20120328095450.GA23005@sirena.org.uk>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
 <m2aa4pkq5g.fsf@bob.laptop.org>
 <4F3CFEED.6060206@samsung.com>
 <m239abgc32.fsf@bob.laptop.org>
 <00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com>
 <m2vcn0496y.fsf@bob.laptop.org>
 <87k426vy9r.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:45010 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab2C1JzE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 05:55:04 -0400
Content-Disposition: inline
In-Reply-To: <87k426vy9r.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, 'Thomas Abraham' <thomas.abraham@linaro.org>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 27, 2012 at 11:50:24AM -0400, Chris Ball wrote:
> On Tue, Feb 21 2012, Chris Ball wrote:
> > On Tue, Feb 21 2012, Kukjin Kim wrote:

> >> I created topic branch for this we talked. You can pull that following:
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> >> v3.4-for-cjb

> >> If any problems, please kindly let me know.

> > Pushed to mmc-next, thanks.  (I'm expecting that you'll do the merge
> > to Linus.)

> I was expecting you to merge these patches, but they aren't in the
> arm-soc tree and haven't been sent to Linus, and we're in the last few
> days of the merge window.

> As a result I'm dropping this tree -- and all of the patches that I
> have on top of it -- from mmc-next so that I can get a pull request
> out.  This means that I'm dropping:

If they're already in your tree why not just send them to Linus?  Given
that everything's in git I don't understand why you'd need Kukjin to
push them separately or what the benefit of that would be?

This is all extremely frustrating fromm the contributor point of view.
