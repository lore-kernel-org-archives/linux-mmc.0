From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH] mmc: core: Set load on vmmc and vqmmc
Date: Tue, 30 Jun 2015 21:38:45 -0700
Message-ID: <1435725525-4367-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

This is needed to get our regulators into hpm, to give enough power to our
sdhci cards to run at higher clockrates - e.g. hs200.

 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 drivers/mmc/core/core.c                       | 6 ++++++
 drivers/mmc/core/host.c                       | 4 ++++
 include/linux/mmc/host.h                      | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 0384fc3f64e8..05c8b4f59187 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -47,6 +47,8 @@ Optional properties:
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
+- vmmc-load: requested load for the vmmc regulator, in mA
+- vqmmc-load: requested load for the vqmmc regulator, in mA
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9ad73f30f744..0a8f828af59f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1455,12 +1455,18 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 			mmc->ocr_avail = ret;
 		else
 			dev_warn(dev, "Failed getting OCR mask: %d\n", ret);
+
+		if (mmc->supply.vmmc_load)
+			regulator_set_load(mmc->supply.vmmc, mmc->supply.vmmc_load);
 	}
 
 	if (IS_ERR(mmc->supply.vqmmc)) {
 		if (PTR_ERR(mmc->supply.vqmmc) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_info(dev, "No vqmmc regulator found\n");
+	} else {
+		if (mmc->supply.vqmmc_load)
+			regulator_set_load(mmc->supply.vqmmc, mmc->supply.vqmmc_load);
 	}
 
 	return 0;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 99a9c9011c50..136af25bef9d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -475,6 +475,10 @@ int mmc_of_parse(struct mmc_host *host)
 			host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
 	}
 
+	/* Parse regulator load requests */
+	of_property_read_u32(np, "vmmc-load", &host->supply.vmmc_load);
+	of_property_read_u32(np, "vqmmc-load", &host->supply.vqmmc_load);
+
 	/* Parse Write Protection */
 	ro_cap_invert = of_property_read_bool(np, "wp-inverted");
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1369e54faeb7..e4e2a26bab41 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -197,6 +197,8 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	u32 vmmc_load;			/* Load request for vmmc */
+	u32 vqmmc_load;			/* Load request for vqmmc */
 };
 
 struct mmc_host {
-- 
1.8.2.2
