From: Wilson & Cassie <griscruf@comcast.net>
Subject: Re: [PATCH] esdhc: fix DMA_MASK to not break mx25 DMA access
Date: Tue, 17 Jul 2012 12:32:05 -0400
Message-ID: <8D8658B1-9B29-4677-8CA8-EBEE0C42D3E6@comcast.net>
References: <AF702D0F-8919-4E98-BD6C-DF05E0EE4DDE@savantav.com> <3DC84FDD-7D96-46D6-A9F2-C3F8A47E9051@comcast.net> <20120716214711.GX30009@pengutronix.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:46146
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752517Ab2GQQhx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Jul 2012 12:37:53 -0400
In-Reply-To: <20120716214711.GX30009@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>

Patch to not set reserved bits in i.MX25 PROCTL register.  DMA stops working if those bits get set.

Signed-off-by: Wilson Callan <wilson.callan at savantsystems.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

--- linux-3.4.4/drivers/mmc/host/sdhci-esdhc-imx.c.orig	2012-07-04 13:58:16.239979741 -0400
+++ linux-3.4.4/drivers/mmc/host/sdhci-esdhc-imx.c	2012-07-04 14:34:38.939949292 -0400
@@ -310,8 +310,10 @@ static void esdhc_writeb_le(struct sdhci
 				SDHCI_CTRL_D3CD);
 		/* ensure the endianess */
 		new_val |= ESDHC_HOST_CONTROL_LE;
-		/* DMA mode bits are shifted */
-		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
+		if (!is_imx25_esdhc(imx_data)) { // bits 8&9 are reserved on mx25
+			/* DMA mode bits are shifted */
+			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
+		}
 
 		esdhc_clrset_le(host, 0xffff, new_val, reg);
 		return;

