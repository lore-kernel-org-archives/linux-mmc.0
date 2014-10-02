From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 9/9] omap_hsmmc: remove unused slot_id parameter
Date: Thu, 2 Oct 2014 09:45:29 -0700
Message-ID: <20141002164528.GM3122@atomide.com>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
 <1411983179-28677-10-git-send-email-afenkart@gmail.com>
 <20141002164252.GE7933@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141002164252.GE7933@saruman>
Sender: linux-omap-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com
List-Id: linux-mmc@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [141002 09:43]:
> On Mon, Sep 29, 2014 at 11:32:59AM +0200, Andreas Fenkart wrote:
> > omap_hsmmc only supports one slot. So slot id is always zero, and
> > slot id is never used in the callbacks
> 
> I wonder if this will break slot multiplexing on n8x0.

It's a different driver from this. This series separates out
the omap_mmc (with slot multiplexing) and omap_mmc_hs with no
slot multiplexing.

Regards,

Tony
