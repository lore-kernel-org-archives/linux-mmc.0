From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH] sdhci-s3c: fix NULL ptr access in sdhci_s3c_remove
Date: Mon, 27 Sep 2010 08:09:11 +0200
Message-ID: <003501cb5e0a$84430620$8cc91260$%szyprowski@samsung.com>
References: <1285251725-6210-1-git-send-email-m.szyprowski@samsung.com>
 <20100923120803.832975f6.akpm@linux-foundation.org>
 <20100925225324.GA30732@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100925225324.GA30732@void.printf.net>
Content-language: pl
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, w.sang@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Hello,

On Sunday, September 26, 2010 12:53 AM Chris Ball wrote:

> On Thu, Sep 23, 2010 at 12:08:03PM -0700, Andrew Morton wrote:
> > The patch applies OK to 2.6.35.  Is the bug present there as well?  If
> > so, should we fix it in earlier kernels?  If so then the way in which
> > we indicate this is by adding
> >
> > 	Cc: <stable@kernel.org>
> >
> > to the changelog.
> 
> Marek, Kyungmin, what do you think?
> 
> Andrew, I've been waiting for an ACK from Ben Dooks, since he's listed
> in MAINTAINERS for this driver, but he hasn't replied yet (I've tried
> pinging privately).  I'll plan on sending Marek's two s3c fixes to
> Linus tomorrow regardless (this one with Cc: <stable@kernel.org>)
> along with my MAINTAINERS update for MMC unless anyone objects.

I'm sorry, I was on holidays. You are right, both fixes should go to 2.6.36
as well

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
