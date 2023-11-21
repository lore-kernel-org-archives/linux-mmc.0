Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A159110;
	Tue, 21 Nov 2023 01:12:49 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AL9BFmE41506556, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AL9BFmE41506556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 17:11:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Nov 2023 17:11:16 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 21 Nov 2023 17:11:15 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Tue, 21 Nov 2023 17:11:15 +0800
From: Jyan Chou <jyanchou@realtek.com>
To: <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <jh80.chung@samsung.com>, <riteshh@codeaurora.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <conor+dt@kernel.org>, <asutoshd@codeaurora.org>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <briannorris@chromium.org>, <doug@schmorgal.com>,
        <tonyhuang.sunplus@gmail.com>, <abel.vesa@linaro.org>,
        <william.qiu@starfivetech.com>, <jyanchou@realtek.com>
Subject: [PATCH v7][1/4] mmc: solve DMA boundary limitation of CQHCI driver
Date: Tue, 21 Nov 2023 17:10:58 +0800
Message-ID: <20231121091101.5540-2-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121091101.5540-1-jyanchou@realtek.com>
References: <20231121091101.5540-1-jyanchou@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Due to synopsys data book's description, it had a limitation
while using DMA that buffer size and start address must not
exceed 128 MB.

We add an option setup_tran_desc to make tran_desc setting flexible.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>

---
v6 -> v7:
- fix kernel test robot build errors, error: no member named
'setup_tran_desc' in 'struct cqhci_host_ops'

v4 -> v5:
- use EXPORT_SYMBOL_GPL to replace EXPORT_SYMBOL
- Fix kernel test robot build errors, let 'setup_tran_desc' to be a member in
  'const struct cqhci_host_ops'.

v2 -> v3:
- Fix auto test compile warning.

v1 -> v2:
- Export cqhci_set_tran_desc for setting the descriptor's callback function.

v0 -> v1:
- Separate different patch supports into single patch.
---
 drivers/mmc/host/cqhci-core.c | 13 ++++++++++---
 drivers/mmc/host/cqhci.h      |  8 ++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..b40bd368a955 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -474,8 +474,7 @@ static int cqhci_dma_map(struct mmc_host *host, struct mmc_request *mrq)
 	return sg_count;
 }
 
-static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
-				bool dma64)
+void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64)
 {
 	__le32 *attr = (__le32 __force *)desc;
 
@@ -495,9 +494,10 @@ static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
 		dataddr[0] = cpu_to_le32(addr);
 	}
 }
+EXPORT_SYMBOL_GPL(cqhci_set_tran_desc);
 
 static int cqhci_prep_tran_desc(struct mmc_request *mrq,
-			       struct cqhci_host *cq_host, int tag)
+				struct cqhci_host *cq_host, int tag)
 {
 	struct mmc_data *data = mrq->data;
 	int i, sg_count, len;
@@ -516,6 +516,13 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 
 	desc = get_trans_desc(cq_host, tag);
 
+#ifdef CONFIG_MMC_DW_CQE
+	if (cq_host->ops->setup_tran_desc) {
+		cq_host->ops->setup_tran_desc(data, cq_host, desc, sg_count);
+		return 0;
+	}
+#endif
+
 	for_each_sg(data->sg, sg, sg_count, i) {
 		addr = sg_dma_address(sg);
 		len = sg_dma_len(sg);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 1a12e40a02e6..713fc56127df 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -216,6 +216,7 @@ union cqhci_crypto_cfg_entry {
 struct cqhci_host_ops;
 struct mmc_host;
 struct mmc_request;
+struct mmc_data;
 struct cqhci_slot;
 
 struct cqhci_host {
@@ -293,6 +294,11 @@ struct cqhci_host_ops {
 	int (*program_key)(struct cqhci_host *cq_host,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
 #endif
+
+#ifdef CONFIG_MMC_DW_CQE
+	void (*setup_tran_desc)(struct mmc_data *data,
+				struct cqhci_host *cq_host, u8 *desc, int sg_count);
+#endif
 };
 
 static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
@@ -322,6 +328,8 @@ static inline int cqhci_suspend(struct mmc_host *mmc)
 {
 	return cqhci_deactivate(mmc);
 }
+
+void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
 int cqhci_resume(struct mmc_host *mmc);
 
 #endif
-- 
2.42.0

