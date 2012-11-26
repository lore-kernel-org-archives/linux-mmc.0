From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined
 reference to `__aeabi_uldivmod'
Date: Mon, 26 Nov 2012 14:02:31 +0800
Message-ID: <20121126060231.GA24503@localhost>
References: <50b2a62c.slEE/d1mNq4kUCUf%fengguang.wu@intel.com>
 <110EED8CC96DFC488B7E717A2027A27C235D56@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48058 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311Ab2KZGCe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Nov 2012 01:02:34 -0500
Content-Disposition: inline
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C235D56@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Zhang Haijun-B42677 <B42677@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Mon, Nov 26, 2012 at 05:54:33AM +0000, Huang Changming-R66093 wrote:
> Hi, Robot
> I don't find the `__aeabi_uldivmod' in branch 'mmc-next' of linux-mmc tree.
> Could you point out which file use it?
> 
> This patch just use the 'div_u64' to calculate the timeout in order to avoid overflow.

Hi! This is confirmed to fix the problem:

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 48ad361..daf0636 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -921,7 +921,7 @@ static inline void set_data_timeout(struct mmc_omap_host *host, struct mmc_reque
 	u16 reg;
 
 	cycle_ns = 1000000000 / host->current_slot->fclk_freq;
-	timeout = req->data->timeout_ns / cycle_ns;
+	timeout = div_u64(req->data->timeout_ns, cycle_ns);
 	timeout += req->data->timeout_clks;
 
 	/* Check if we need to use timeout multiplier register */
