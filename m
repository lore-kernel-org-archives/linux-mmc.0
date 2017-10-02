From: Michal Hocko <mhocko@kernel.org>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Mon, 2 Oct 2017 16:44:18 +0200
Message-ID: <20171002144418.35mag5uormoqoay5@dhcp22.suse.cz>
References: <20170905194739.GA31241@amd>
 <20171001093704.GA12626@amd>
 <20171001102647.GA23908@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750957AbdJBOoU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 2 Oct 2017 10:44:20 -0400
Content-Disposition: inline
In-Reply-To: <20171001102647.GA23908@amd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-mm@kvack.org, penguin-kernel@I-love.SAKURA.ne.jp

On Sun 01-10-17 12:26:47, Pavel Machek wrote:
> Hi!
> 
> > I inserted u-SD card, only to realize that it is not detected as it
> > should be. And dmesg indeed reveals:
> 
> Tetsuo asked me to report this to linux-mm.
> 
> But 2^4 is 16 pages, IIRC that can't be expected to work reliably, and
> thus this sounds like MMC bug, not mm bug.

Well, I cannot comment on why MMC needs such a large allocation and
whether it can safely fall back to vmalloc but __GFP_RETRY_MAYFAIL
might help to try harder and require compaction to do more work.
Relying on that for correctness is, of course, a different story and
a very unreliable under memory pressure or long term fragmented memory.
-- 
Michal Hocko
SUSE Labs
