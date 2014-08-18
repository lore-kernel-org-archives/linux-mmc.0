From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] mmc: core: sd: check card write-protect lock while resuming
Date: Mon, 18 Aug 2014 18:00:12 +0800
Message-ID: <1408356012-18867-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: Barry Song <Baohua.Song@csr.com>, linux-mmc@vger.kernel.org, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Minda Chen <Minda.Chen@csr.com>
List-Id: linux-mmc@vger.kernel.org

From: Minda Chen <Minda.Chen@csr.com>

After suspending, unplug the sdcard, and set sd WP lock,
insert it again, then resume the system. resume codes do
not check the the sdcard write-proctect lock. now check
it.

Signed-off-by: Minda Chen <Minda.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/core/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0c44510..890557a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -910,6 +910,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	u32 cid[4];
 	u32 rocr = 0;
+	bool oldro, ro;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -922,6 +923,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
 			return -ENOENT;
 
+		if (host->ops->get_ro) {
+			ro = host->ops->get_ro(host) ? true : false;
+			oldro = mmc_card_readonly(oldcard) ? true : false;
+			if (oldro ^ ro)
+				return -ENOENT;
+		}
 		card = oldcard;
 	} else {
 		/*
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
