From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Mon, 2 Oct 2017 23:55:23 +0900
Message-ID: <201710022355.CHB64510.SMLFJOVQHOOtFF@I-love.SAKURA.ne.jp>
References: <20170905194739.GA31241@amd>
	<20171001093704.GA12626@amd>
	<20171001102647.GA23908@amd>
	<20171002144418.35mag5uormoqoay5@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20171002144418.35mag5uormoqoay5@dhcp22.suse.cz>
Sender: owner-linux-mm@kvack.org
To: mhocko@kernel.org, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-mmc@vger.kernel.org

Michal Hocko wrote:
> On Sun 01-10-17 12:26:47, Pavel Machek wrote:
> > Hi!
> > 
> > > I inserted u-SD card, only to realize that it is not detected as it
> > > should be. And dmesg indeed reveals:
> > 
> > Tetsuo asked me to report this to linux-mm.
> > 
> > But 2^4 is 16 pages, IIRC that can't be expected to work reliably, and
> > thus this sounds like MMC bug, not mm bug.
> 
> Well, I cannot comment on why MMC needs such a large allocation and
> whether it can safely fall back to vmalloc but __GFP_RETRY_MAYFAIL
> might help to try harder and require compaction to do more work.
> Relying on that for correctness is, of course, a different story and
> a very unreliable under memory pressure or long term fragmented memory.

Linus Walleij answered that kvmalloc() is against the design of the bounce buffer at
http://lkml.kernel.org/r/CACRpkdYirC+rh_KALgVqKZMjq2DgbW4oi9MJkmrzwn+1O+94-g@mail.gmail.com .

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
