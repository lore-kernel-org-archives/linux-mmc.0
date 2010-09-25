From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-s3c: fix NULL ptr access in sdhci_s3c_remove
Date: Sat, 25 Sep 2010 23:53:24 +0100
Message-ID: <20100925225324.GA30732@void.printf.net>
References: <1285251725-6210-1-git-send-email-m.szyprowski@samsung.com> <20100923120803.832975f6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100923120803.832975f6.akpm@linux-foundation.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, w.sang@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 23, 2010 at 12:08:03PM -0700, Andrew Morton wrote:
> The patch applies OK to 2.6.35.  Is the bug present there as well?  If
> so, should we fix it in earlier kernels?  If so then the way in which
> we indicate this is by adding
> 
> 	Cc: <stable@kernel.org>
> 
> to the changelog.

Marek, Kyungmin, what do you think?

Andrew, I've been waiting for an ACK from Ben Dooks, since he's listed
in MAINTAINERS for this driver, but he hasn't replied yet (I've tried 
pinging privately).  I'll plan on sending Marek's two s3c fixes to
Linus tomorrow regardless (this one with Cc: <stable@kernel.org>)
along with my MAINTAINERS update for MMC unless anyone objects.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
