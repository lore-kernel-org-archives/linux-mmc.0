From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: possible regression on 3.13 when calling flush_dcache_page
Date: Fri, 13 Dec 2013 10:59:09 +0900
Message-ID: <20131213015909.GA8845@lge.com>
References: <20131212143149.GI12099@ldesroches-Latitude-E6320>
 <20131212143618.GJ12099@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131212143618.GJ12099@ldesroches-Latitude-E6320>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 12, 2013 at 03:36:19PM +0100, Ludovic Desroches wrote:
> fix mmc mailing list address error
> 
> On Thu, Dec 12, 2013 at 03:31:50PM +0100, Ludovic Desroches wrote:
> > Hi,
> > 
> > With v3.13-rc3 I have an error when the atmel-mci driver calls
> > flush_dcache_page (log at the end of the message).
> > 
> > Since I didn't have it before, I did a git bisect and the commit introducing
> > the error is the following one:
> > 
> > 106a74e slab: replace free and inuse in struct slab with newly introduced active
> > 
> > I don't know if this commit has introduced a bug or if it has revealed a bug
> > in the atmel-mci driver.

Hello,

I think that this commit may not introduce a bug. This patch remove one
variable on slab management structure and replace variable name. So there
is no functional change.

I doubt that side-effect of this patch reveals a bug in other place.
Side-effect is reduced memory usage for slab management structure. It would
makes some slabs have more objects with more density since slab management
structure is sometimes on the page for objects. So if it diminishes, more
objects can be in the page.

Anyway, I will look at it more. If you have any progress, please let me know.

Thanks.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
