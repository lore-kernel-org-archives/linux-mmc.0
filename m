From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-s3c: add platform_8bit_width()
Date: Wed, 12 Jan 2011 03:27:00 +0000
Message-ID: <20110112032700.GA28143@void.printf.net>
References: <4D2CF631.4080402@samsung.com> <20110112022030.GA27414@void.printf.net> <4D2D1900.1020200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50023 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756190Ab1ALD1D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Jan 2011 22:27:03 -0500
Content-Disposition: inline
In-Reply-To: <4D2D1900.1020200@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ben Dooks <ben-linux@fluff.org>

Hi Jaehoon,

On Wed, Jan 12, 2011 at 11:59:12AM +0900, Jaehoon Chung wrote:
> Hi Chris.
> 
> Thanks for your comments.
> So i fixed them, and resend the patch.

Thanks!  I've pushed it to mmc-next.

> We have 8-bit width support bu is not a v3 controller.
> So we need platform_8bit_width() to support 8-bit buswidth.
> Also we need MMC_CAP_8_BIT_DATA, so we add it in platdata.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

I made one more change -- the rest of sdhci-s3c.c uses kerneldoc format
function comments, but your patch doesn't have the correct kerneldoc syntax:

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 89f019f..5309ab9 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -277,12 +277,14 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->clock = clock;
 }
 
-/*
+/**
  * sdhci_s3c_platform_8bit_width - support 8bit buswidth
+ * @host: The SDHCI host being queried
+ * @width: MMC_BUS_WIDTH_ macro for the bus width being requested
  *
  * We have 8-bit width support but is not a v3 controller.
  * So we add platform_8bit_width() and support 8bit width.
- **/
+ */
 static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;


Ben, feel free to yell if you object to the final version of the patch,
else I'll merge it for .39.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
