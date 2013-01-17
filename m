From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: [PATCH] mmc_select_voltage only if host->ocr_avail_mmc
Date: Thu, 17 Jan 2013 15:15:25 +0000
Message-ID: <alpine.DEB.2.02.1301171456380.4978@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Ian Campbell <Ian.Campbell@eu.citrix.com>, Pierre Ossman <drzeus@drzeus.cx>
List-Id: linux-mmc@vger.kernel.org

On my platform (ARM Versatile Express Cortex A15 emulator)
host->ocr_avail_mmc is 0.
mmc_attach_mmc knows that it could be 0, in fact at the beginning of the
function it checks if host->ocr_avail_mmc is not 0 before setting
host->ocr_avail.
However later on, is going to call mmc_select_voltage regardeless of its
value. If host->ocr_avail_mmc is 0, host->ocr ends up being 0 too, and
we error out.

I admit that I am not terribly familiar with this code, but it seems to
me that we should only call mmc_select_voltage and check the return
value if host->ocr_avail_mmc.

If that is not the right fix please advise.


---

mmc_attach_mmc: only call mmc_select_voltage if host->ocr_avail_mmc

host->ocr_avail_mmc can be 0, in fact mmc_attach_mmc checks if
host->ocr_avail_mmc is not 0 before setting host->ocr_avail.

However later on, is going to call mmc_select_voltage regardeless of its
value. If host->ocr_avail_mmc is 0, host->ocr ends up being 0 too, and
mmc_select_voltage errors out.

This patch fixes that by only calling mmc_select_voltage iff
host->ocr_avail_mmc != 0.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e6e3911..0edd33b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1529,14 +1529,15 @@ int mmc_attach_mmc(struct mmc_host *host)
 		ocr &= ~0x7F;
 	}
 
-	host->ocr = mmc_select_voltage(host, ocr);
-
-	/*
-	 * Can we support the voltage of the card?
-	 */
-	if (!host->ocr) {
-		err = -EINVAL;
-		goto err;
+	if (host->ocr_avail_mmc) {
+		host->ocr = mmc_select_voltage(host, ocr);
+		/*
+		 * Can we support the voltage of the card?
+		 */
+		if (!host->ocr) {
+			err = -EINVAL;
+			goto err;
+		}
 	}
 
 	/*
