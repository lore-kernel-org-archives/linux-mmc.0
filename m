From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] au1xmmc.c: use resource_size()
Date: Fri, 27 Aug 2010 20:11:34 +0100
Message-ID: <20100827191134.GF20407@void.printf.net>
References: <BD79186B4FD85F4B8E60E381CAEE19090200E9FB@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53276 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040Ab0H0TLn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:11:43 -0400
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200E9FB@mi8nycmail19.Mi8.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org

From: H Hartley Sweeten <hsweeten@visionengravers.com>
Date: Mon, 14 Dec 2009 14:28:06 -0500

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
[cjb: rebased patch against Linus]
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/au1xmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index c8da5d3..e14b866 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -964,7 +964,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 		goto out1;
 	}
 
-	host->ioarea = request_mem_region(r->start, r->end - r->start + 1,
+	host->ioarea = request_mem_region(r->start, resource_size(r),
 					   pdev->name);
 	if (!host->ioarea) {
 		dev_err(&pdev->dev, "mmio already in use\n");
-- 
1.7.0.1

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
