Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5B3A287
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D6kHBoSk"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5CF0
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 03:55:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859dee28cso45736315e9.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 03:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699962957; x=1700567757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9xzvHCmaOoa5xWGnHHS8h9I/GT+m5dxekFoJRER5f1U=;
        b=D6kHBoSkc70xDLx1R6aB/g/pmNwkHmkStuZHHtq62QqKwwybCc4OMKXvTT5a5j/TQE
         LdrBGwjXFn2oDGT+Ul0jTxJllMhcBBSiD2xzYiqS+EM/rI0jjGsPzF2c2jVybJqAWQUe
         mW6UdKec87nbDJpDYBGVE92no8WkRN6Ie93Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699962957; x=1700567757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xzvHCmaOoa5xWGnHHS8h9I/GT+m5dxekFoJRER5f1U=;
        b=tuZ6P1BTqqAivbqCEXf6bx0OEojqEraOziWDvTZLUDkpEsNdqIAA78tW0fIjKmPeHK
         Y/0l/bQxwCUWyp540sZFRHyx0DKvAgSxnuz62ZqX2XvgoZ4pFVgQQO7FTOoacRAZwqeT
         V3TQaTk41e06y9FtI2tM0GMoiXn054r5ZJoBAUPWcFEerbJ1fYYxenZUi2lOIWZ5cBwG
         HrM1XKpqJugfjPBZGTaaY83HmweAhU+q8cl6QUKfZgYSPUUZS8NINFMmJnHq5d6DLqv4
         Iv3HMlUq/bO+bKd9kiizDc+KiolYb9VykPZt60HtZt1B+zjiaM4DwW1bqjbFp5ZPbBi8
         bCBA==
X-Gm-Message-State: AOJu0YwKmGoyokUu12BCwHjmRlCMz3+3pQ5AVeAbAovwyqxlIt7bQEWk
	jtWdg/neNGrtYEWP6v9aIuG+K2ALDdaS8q+EQ5LHTg==
X-Google-Smtp-Source: AGHT+IH+PgRwaOtjvfynXjyWiD2G62mM/SzLy4sifyw8k1h4lYi60YC60aAPWw5jIYfOD/QuabTbbw==
X-Received: by 2002:a05:600c:154c:b0:405:359e:ee43 with SMTP id f12-20020a05600c154c00b00405359eee43mr7680717wmg.1.1699962957545;
        Tue, 14 Nov 2023 03:55:57 -0800 (PST)
Received: from orzel1.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c4d9200b004068495910csm16612748wmp.23.2023.11.14.03.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 03:55:57 -0800 (PST)
From: =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sven van Ashbrook <svenva@google.com>,
	Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	=?UTF-8?q?Stanis=C5=82aw=20Kardach?= <skardach@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	=?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-pci-gli: Disable LPM during initialization
Date: Tue, 14 Nov 2023 11:54:49 +0000
Message-ID: <20231114115516.1585361-1-korneld@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To address IO performance commit f9e5b33934ce
("mmc: host: Improve I/O read/write performance for GL9763E")
limited LPM negotiation to runtime suspend state.
The problem is that it only flips the switch in the runtime PM
resume/suspend logic.

Disable LPM negotiation in gl9763e_add_host.
This helps in two ways:
1. It was found that the LPM switch stays in the same position after
   warm reboot. Having it set in init helps with consistency.
2. Disabling LPM during the first runtime resume leaves us susceptible
   to the performance issue in the time window between boot and the
   first runtime suspend.

Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
Cc: stable@vger.kernel.org
Signed-off-by: Kornel Dulęba <korneld@chromium.org>
---
v2: Move up gl9763e_set_low_power_negotiation to avoid having to forward
    declare it.

 drivers/mmc/host/sdhci-pci-gli.c | 54 +++++++++++++++++---------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d8a991b349a8..77911a57b12c 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1189,6 +1189,32 @@ static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
 	sdhci_writel(host, val, SDHCI_GLI_9763E_HS400_ES_REG);
 }
 
+static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
+					      bool enable)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
+
+	if (enable)
+		value &= ~GLI_9763E_CFG_LPSN_DIS;
+	else
+		value |= GLI_9763E_CFG_LPSN_DIS;
+
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+}
+
 static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
 					unsigned int timing)
 {
@@ -1297,6 +1323,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	if (ret)
 		goto cleanup;
 
+	/* Disable LPM negotiation to avoid entering L1 state. */
+	gl9763e_set_low_power_negotiation(slot, false);
+
 	return 0;
 
 cleanup:
@@ -1340,31 +1369,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 }
 
 #ifdef CONFIG_PM
-static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
-{
-	struct pci_dev *pdev = slot->chip->pdev;
-	u32 value;
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
-	value &= ~GLI_9763E_VHS_REV;
-	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
-
-	if (enable)
-		value &= ~GLI_9763E_CFG_LPSN_DIS;
-	else
-		value |= GLI_9763E_CFG_LPSN_DIS;
-
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
-	value &= ~GLI_9763E_VHS_REV;
-	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
-}
-
 static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot = chip->slots[0];
-- 
2.43.0.rc0.421.g78406f8d94-goog

