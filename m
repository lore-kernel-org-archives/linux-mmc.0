From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing
 led
Date: Thu, 22 Sep 2016 15:24:16 +0200
Message-ID: <1474550656.11364.32.camel@suse.com>
References: <Pine.LNX.4.44L0.1609211031420.1996-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753595AbcIVN3s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 22 Sep 2016 09:29:48 -0400
In-Reply-To: <Pine.LNX.4.44L0.1609211031420.1996-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Micky Ching <micky_ching@realsil.com.cn>, Wei WANG <wei_wang@realsil.com.cn>, Roger Tseng <rogerable@realtek.com>, Ritesh Raj Sarraf <rrs@researchut.com>, linux-mmc <linux-mmc@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

On Wed, 2016-09-21 at 10:35 -0400, Alan Stern wrote:
> On Wed, 21 Sep 2016, Oliver Neukum wrote:

> > Yes, but this is not the point. A heuristic with a timeout makes
> > sense only if the uses are unpredictable. If you know with a high
> > degree of probability when the next activity comes, you ought to either
> > suspend now or not all until the next activity.
> > 
> > Likewise the heuristic is appropriate for leaf nodes. You get nothing
> > from a delay on inner nodes.
> 
> Almost true, but not quite.  When an inner node has more than one leaf
> beneath it, enabling an autosuspend delay for the inner node can make 
> sense -- particularly if the leaf activities are uncorrelated.


Well, it is true that an inner node is likelier to be woken up
depending on the number of children. That is a reason to have a longer
timeout for an inner node. But it should start when the first node goes
idle. It makes no sense to start yet another timeout when the last node
goes idle.

In terms of mathematics I think we would need to multiply the timeout
with the square root of busy children and restart it whenever a child
goes to idle.
But it seems to me that this is impractical.

So I would suggest that we are missing an API for drivers to tell the
core that they become idle for a known period of time and to propagate
that immediately up if that is the last leaf to become idle.

> > Any storage (generic sense) device
> > is an inner node. It should suspend immediately after the block
> > device which is the leaf node.
> 
> Yes.  In this case, however, the USB device has two platform devices 
> beneath it: one for SDMMC and one for MemoryStick cards.

Indeed, we can hope that the power efficient work queue used will
join the polling of both devices. Ideally we could model the mutual
exclusion.

	Regards
		Oliver



