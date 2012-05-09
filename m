From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 01/16] FS: Added demand paging markers to filesystem
Date: Wed, 9 May 2012 11:03:43 -0400
Message-ID: <20120509150343.GB14916@infradead.org>
References: <1336054995-22988-1-git-send-email-svenkatr@ti.com>
 <CANfBPZ_2JeWUu7ti97CVc=ODeEi65ke9EKV6Uje0JHcCM8gYqQ@mail.gmail.com>
 <20120509003348.GM5091@dastard>
 <201205091359.40554.arnd.bergmann@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201205091359.40554.arnd.bergmann@linaro.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Dave Chinner <david@fromorbit.com>, "S, Venkatraman" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alex.lemberg@sandisk.com, ilan.smith@sandisk.com, lporzio@micron.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-mmc@vger.kernel.org

On Wed, May 09, 2012 at 01:59:40PM +0000, Arnd Bergmann wrote:
> My feeling is that we should just treat every (REQ_SYNC | REQ_READ)
> request the same and let them interrupt long-running writes,
> independent of whether it's REQ_META or demand paging.

It's funny that the CFQ scheduler used to boost metadata reads that
have REQ_META set - in fact it still does for those filesystems using
the now split out REQ_PRIO.

