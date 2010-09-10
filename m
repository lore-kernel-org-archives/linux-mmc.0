From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: USB SD Host Controller (USHC) driver
Date: Fri, 10 Sep 2010 21:25:14 +0100
Message-ID: <20100910202514.GC2623@void.printf.net>
References: <1283436908-12097-1-git-send-email-david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53234 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238Ab0IJUZR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Sep 2010 16:25:17 -0400
Content-Disposition: inline
In-Reply-To: <1283436908-12097-1-git-send-email-david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Hi David,

On Thu, Sep 02, 2010 at 02:15:08PM +0000, David Vrabel wrote:
> Add a driver for USB SD Host Controller devices.  These devices are
> Cypress Astoria chips with firmware compliant with issue 2 of CSR's USHC
> specification.
> 
> Signed-off-by: David Vrabel <david.vrabel@csr.com>
> ---
> Changes since v1:
> - Clarified Kconfig help text.
> - mmc->f_min is 400 kHz.
> 
> Andrew, please queue for 2.6.37.

Thanks, applied to mmc-next with the following change as per
"mmc: Remove distinction between hw and phys segments".
Would you like to submit a MAINTAINERS entry for this driver?

diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
index 2d0cc2c..b4ead4a 100644
--- a/drivers/mmc/host/ushc.c
+++ b/drivers/mmc/host/ushc.c
@@ -456,8 +456,7 @@ static int ushc_probe(struct usb_interface *intf, const struct usb_device_id *id
 	mmc->caps |= (ushc->caps & USHC_GET_CAPS_HIGH_SPD) ? MMC_CAP_SD_HIGHSPEED : 0;
 
 	mmc->max_seg_size  = 512*511;
-	mmc->max_hw_segs   = 1;
-	mmc->max_phys_segs = 1;
+	mmc->max_segs      = 1;
 	mmc->max_req_size  = 512*511;
 	mmc->max_blk_size  = 512;
 	mmc->max_blk_count = 511;

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
