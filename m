From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 2/2] mmc: sdhci: disable MMC_CAP_NEEDS_POLL in
	nonremovable case
Date: Mon, 27 Sep 2010 16:02:18 +0100
Message-ID: <20100927150218.GB11578@void.printf.net>
References: <1285576940-27587-1-git-send-email-matt@console-pimps.org> <1285576940-27587-3-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56325 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab0I0PCT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Sep 2010 11:02:19 -0400
Content-Disposition: inline
In-Reply-To: <1285576940-27587-3-git-send-email-matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>, zhangfei gao <zhangfei.gao@gmail.com>

Hi Matt,

On Mon, Sep 27, 2010 at 09:42:20AM +0100, Matt Fleming wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> When a controller requires SDHCI_QUIRK_BROKEN_CARD_DETECTION, we poll
> for card insertion/removal, and that creates interrupts.  There's no
> need to be doing this if we have a non-removable card.
> 
> This patch requires cards to be removable before we're willing to set
> MMC_CAP_NEEDS_POLL.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Matt Fleming <matt@console-pimps.org>
> [cjb: modified changelog and code indentation]
> Signed-off-by: Chris Ball <cjb@laptop.org>

Thanks, applied to mmc-next with Wolfram's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
