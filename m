From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 11/25] mmc: mmci: add validate_data callback
Date: Tue, 2 Oct 2018 14:09:13 +0200
Message-ID: <1538482167-13819-12-git-send-email-ludovic.Barre@st.com>
References: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds validate_data callback at mmci_host_ops
to check specific constraints of variant.
Move mmci_validate_data function to regroup mmci_host_ops interfaces.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++------------------
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1835d77..c8fdb24 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -233,24 +233,6 @@ static int mmci_card_busy(struct mmc_host *mmc)
 	return busy;
 }
 
-/*
- * Validate mmc prerequisites
- */
-static int mmci_validate_data(struct mmci_host *host,
-			      struct mmc_data *data)
-{
-	if (!data)
-		return 0;
-
-	if (!is_power_of_2(data->blksz)) {
-		dev_err(mmc_dev(host->mmc),
-			"unsupported block size (%d bytes)\n", data->blksz);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void mmci_reg_delay(struct mmci_host *host)
 {
 	/*
@@ -384,6 +366,27 @@ void mmci_dma_release(struct mmci_host *host)
 		host->ops->dma_release(host);
 }
 
+/*
+ * Validate mmc prerequisites
+ */
+static int mmci_validate_data(struct mmci_host *host,
+			      struct mmc_data *data)
+{
+	if (!data)
+		return 0;
+
+	if (!is_power_of_2(data->blksz)) {
+		dev_err(mmc_dev(host->mmc),
+			"unsupported block size (%d bytes)\n", data->blksz);
+		return -EINVAL;
+	}
+
+	if (host->ops && host->ops->validate_data)
+		return host->ops->validate_data(host, data);
+
+	return 0;
+}
+
 int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
 {
 	int err;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2c9e679..9e701d8 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,6 +273,7 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
+	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*prep_data)(struct mmci_host *host, struct mmc_data *data,
 			 bool next);
 	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
-- 
2.7.4
