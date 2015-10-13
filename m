From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH v2] mmc: core: Allow specifying current consumption
Date: Mon, 12 Oct 2015 18:00:32 -0700
Message-ID: <1444698032-9051-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1435725525-4367-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:11675 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752735AbbJMBAh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2015 21:00:37 -0400
In-Reply-To: <1435725525-4367-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

This allows us to specify expected current consumption of the vmmc and
vqmmc regulators. This is needed to bring the supplying regulators out
of their low-power-mode while accessing the mmc.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

The sd specification states that if the host can provide more than 150mA this
should be indicated in the "XPC value in the argument of ACMD41" for SDXC
cards. Should this be tied in with the added property as well?

Changes since v1:
- Property name and description updated to clarify intention

 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 drivers/mmc/core/core.c                       | 6 ++++++
 drivers/mmc/core/host.c                       | 4 ++++
 include/linux/mmc/host.h                      | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 0384fc3f64e8..7514083a9f55 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -47,6 +47,8 @@ Optional properties:
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
+- vmmc-active-current: current required from the vmmc regulator, in uA
+- vqmmc-active-current: current required from the vqmmc regulator, in uA
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 23fa221ce803..603f40136306 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1469,12 +1469,18 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 			mmc->ocr_avail = ret;
 		else
 			dev_warn(dev, "Failed getting OCR mask: %d\n", ret);
+
+		if (mmc->supply.vmmc_current)
+			regulator_set_load(mmc->supply.vmmc, mmc->supply.vmmc_current);
 	}
 
 	if (IS_ERR(mmc->supply.vqmmc)) {
 		if (PTR_ERR(mmc->supply.vqmmc) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_info(dev, "No vqmmc regulator found\n");
+	} else {
+		if (mmc->supply.vqmmc_current)
+			regulator_set_load(mmc->supply.vqmmc, mmc->supply.vqmmc_current);
 	}
 
 	return 0;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 970e6906930b..ede508d63fb5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -235,6 +235,10 @@ int mmc_of_parse(struct mmc_host *host)
 			host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
 	}
 
+	/* Parse regulator load requests */
+	of_property_read_u32(np, "vmmc-active-current", &host->supply.vmmc_current);
+	of_property_read_u32(np, "vqmmc-active-current", &host->supply.vqmmc_current);
+
 	/* Parse Write Protection */
 	ro_cap_invert = of_property_read_bool(np, "wp-inverted");
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8673ffe3d86e..640d8dbb8559 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -197,6 +197,8 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	u32 vmmc_current;		/* Requested current for vmmc */
+	u32 vqmmc_current;		/* Requested current for vqmmc */
 };
 
 struct mmc_host {
-- 
2.4.2

