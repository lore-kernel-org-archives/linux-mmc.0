Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A8183091
	for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352076; cv=none; b=CFoneVFkc98wNsUH4PxeCJHV71yKUsSeVUiz1xbkcyhKJD9VzjoW1vUKP/1Zf4LP1deQdzwnQDdIxi3tA4PrYYz1lMZRp3pwuvpJjpJ0CgtLHpZDI92h3i6dXXL0vMVtrvSWywhLAxo1CbUtRp2aGGqFooVvRv/D1vQlUMG2CDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352076; c=relaxed/simple;
	bh=bRnsqPjlpf6NUN1IFMZ6LKGlsK8GfqGqN7+JygH5XGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fStsGgfOrnJK8Kb3EB81CxHreU6rTDVcGkzWjEye2vWa5SkOQpd2tpOUBvfAGHFSFNWYjv5QEPC6JwclNQNl3EqjqQfLu1rUzYuj+OXrP+44Fpw8rwVhP09uWMQOcZnzYCyHZzYL5Ql+bu3BXw2gNiFFyQ5GnlzOayA9hu+mfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmbYjkTN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmbYjkTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718352075; x=1749888075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRnsqPjlpf6NUN1IFMZ6LKGlsK8GfqGqN7+JygH5XGw=;
  b=EmbYjkTNMc050yBG0vb6Xxr/xccvJxRK3DMHw156rkLzXv0G9/YcObji
   DT3G73toW6F6zAwdmmY/kZQXZ0ZucBMR1zhDKixAY5CNXh88rcN21dcjq
   kLQqVjEBxREjBwgIoFZBGENQldkXtyaIfpQI7L1n18C80daVE3l6gWQMp
   CajtWRzsk5IuTYyhmEuiC3peOPxY4CEb++Twd89ca8w3N1ZLNy3/U2W7T
   +cfTrMsUCRKDdJSLsRYCn3Gw9V+kvq+MIYGIJAaNpZgDV9DrGlwGF0Uig
   Fyh2TUsDj8QxhzTJnGQdFkGnFouOfD0lWHZfnRXTWUhMb8gGzrQBvrhw4
   g==;
X-CSE-ConnectionGUID: jy4BfL8CSJ+B/mN4ebrCzw==
X-CSE-MsgGUID: nQd5xbnRTc2SQS1O6O6kEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14962018"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="14962018"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:01:14 -0700
X-CSE-ConnectionGUID: ittuEPA7RY2krr5VDD5ysQ==
X-CSE-MsgGUID: 7btGJ8F2RXCtWPW2gRk8rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45382889"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.10])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:01:12 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: [PATCH 3/3] mmc: sdhci: Eliminate SDHCI_QUIRK_UNSTABLE_RO_DETECT
Date: Fri, 14 Jun 2024 11:00:51 +0300
Message-Id: <20240614080051.4005-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614080051.4005-1-adrian.hunter@intel.com>
References: <20240614080051.4005-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

SDHCI_QUIRK_UNSTABLE_RO_DETECT is used by only one driver variant.
It was added in 2011 by commit 82b0e23a295c ("mmc: sdhci: Fix read-only
detection with JMicron 388 chip").

Simplify sdhci by moving the logic to the only place it is used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 27 ++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.c          | 31 ++++++-------------------------
 drivers/mmc/host/sdhci.h          |  3 +--
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 23e6ba70144c..ed45ed0bdafd 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1319,6 +1319,23 @@ static const struct sdhci_pci_fixes sdhci_intel_mrfld_mmc = {
 	.probe_slot	= intel_mrfld_mmc_probe_slot,
 };
 
+#define JMB388_SAMPLE_COUNT	5
+
+static int jmicron_jmb388_get_ro(struct mmc_host *mmc)
+{
+	int i, ro_count;
+
+	ro_count = 0;
+	for (i = 0; i < JMB388_SAMPLE_COUNT; i++) {
+		if (sdhci_get_ro(mmc) > 0) {
+			if (++ro_count > JMB388_SAMPLE_COUNT / 2)
+				return 1;
+		}
+		msleep(30);
+	}
+	return 0;
+}
+
 static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 {
 	u8 scratch;
@@ -1403,11 +1420,6 @@ static int jmicron_probe(struct sdhci_pci_chip *chip)
 		return ret;
 	}
 
-	/* quirk for unsable RO-detection on JM388 chips */
-	if (chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_SD ||
-	    chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_ESD)
-		chip->quirks |= SDHCI_QUIRK_UNSTABLE_RO_DETECT;
-
 	return 0;
 }
 
@@ -1462,6 +1474,11 @@ static int jmicron_probe_slot(struct sdhci_pci_slot *slot)
 
 	slot->host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST;
 
+	/* Handle unstable RO-detection on JM388 chips */
+	if (slot->chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_SD ||
+	    slot->chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_ESD)
+		slot->host->mmc_host_ops.get_ro = jmicron_jmb388_get_ro;
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 112584aa0772..a20df9383b20 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2513,8 +2513,9 @@ int sdhci_get_cd_nogpio(struct mmc_host *mmc)
 }
 EXPORT_SYMBOL_GPL(sdhci_get_cd_nogpio);
 
-static int sdhci_check_ro(struct sdhci_host *host)
+int sdhci_get_ro(struct mmc_host *mmc)
 {
+	struct sdhci_host *host = mmc_priv(mmc);
 	bool allow_invert = false;
 	int is_readonly;
 
@@ -2522,10 +2523,10 @@ static int sdhci_check_ro(struct sdhci_host *host)
 		is_readonly = 0;
 	} else if (host->ops->get_ro) {
 		is_readonly = host->ops->get_ro(host);
-	} else if (mmc_can_gpio_ro(host->mmc)) {
-		is_readonly = mmc_gpio_get_ro(host->mmc);
+	} else if (mmc_can_gpio_ro(mmc)) {
+		is_readonly = mmc_gpio_get_ro(mmc);
 		/* Do not invert twice */
-		allow_invert = !(host->mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+		allow_invert = !(mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
 	} else {
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
@@ -2539,27 +2540,7 @@ static int sdhci_check_ro(struct sdhci_host *host)
 
 	return is_readonly;
 }
-
-#define SAMPLE_COUNT	5
-
-static int sdhci_get_ro(struct mmc_host *mmc)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-	int i, ro_count;
-
-	if (!(host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT))
-		return sdhci_check_ro(host);
-
-	ro_count = 0;
-	for (i = 0; i < SAMPLE_COUNT; i++) {
-		if (sdhci_check_ro(host)) {
-			if (++ro_count > SAMPLE_COUNT / 2)
-				return 1;
-		}
-		msleep(30);
-	}
-	return 0;
-}
+EXPORT_SYMBOL_GPL(sdhci_get_ro);
 
 static void sdhci_hw_reset(struct mmc_host *mmc)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 957c7a917ffb..f531b617f28d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -437,8 +437,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
-/* The read-only detection via SDHCI_PRESENT_STATE register is unstable */
-#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<31)
 
 	unsigned int quirks2;	/* More deviations from spec. */
 
@@ -788,6 +786,7 @@ void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 int sdhci_get_cd_nogpio(struct mmc_host *mmc);
+int sdhci_get_ro(struct mmc_host *mmc);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
-- 
2.34.1

