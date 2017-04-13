From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mmc: cavium: Fix a shift wrapping bug
Date: Thu, 13 Apr 2017 22:47:48 +0300
Message-ID: <20170413194748.GE591@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

"dat" is a u64 and "shift" starts as 54 so this is a shift wrapping bug.

Fixes: 8047c753f3d3 ("mmc: cavium: Add core MMC driver for Cavium SOCs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index d842b6986189..54ff1363b564 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -733,7 +733,7 @@ static void do_write_request(struct cvm_mmc_host *host, struct mmc_request *mrq)
 		}
 
 		while (smi->consumed < smi->length && shift >= 0) {
-			dat |= ((u8 *)smi->addr)[smi->consumed] << shift;
+			dat |= (u64)((u8 *)smi->addr)[smi->consumed] << shift;
 			bytes_xfered++;
 			smi->consumed++;
 			shift -= 8;
