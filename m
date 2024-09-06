Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280851CC8BC;
	Fri,  6 Sep 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618107; cv=none; b=BPISv8ysEaesO0nIFIQDowTBs1+yTvhQ+vCjOlj2mnQdA7gsP2sF6AtBgAA1P6HEiEPmezD2vZ6D8LgqSpnAC0SM66MNfuAWXJNdKyav+DDwSUdc3Tb/2AbzOW6VQVonwK5KfgYo4OziMZbm3d40OIgCYv0blv4gGam6VKAgLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618107; c=relaxed/simple;
	bh=tNWL2yxo2uDQa0iyKVclsZm+e2qhVUxxzq34g14C8ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIIDmIMRUTKy68RIT3stynk/r/zYLGLniaeuciOcUOAk8PmbsEizxxx0VAo70CBhz80OEPefftrj3x5qxFU2/UHfLLrCqvL03QQfRlcIDwcstcoQMOp95sP0q1z3iknJqf7nTZ/t+Rg7RUtr1DeeDe4nwp6x4tDgtXEZDMi5lHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuLJVEuM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuLJVEuM"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71788bfe60eso1502580b3a.1;
        Fri, 06 Sep 2024 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618105; x=1726222905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u5k+9P7fnLwaL1GZATBK9ZKcQNGMTg+CrJ1EQReTio=;
        b=IuLJVEuM/uy5/uMJ9tdPw3t2iGpdfeA3te+Z47ia9qLSbXKnQYI6JLXEYHvaD+tABv
         gSC19xu79zDH4SziPlvRQU8gP78rkSWJgl1I/7ZSRX8Eo69VSIPKZJRoNhKXtIWIw2zb
         Vbu/DAUH+SEkJbTkA6TvOs6BrgqPCyln9kwSqRRFDJ62k8C5TDBqCHs5WjDS3Z9ETWnD
         TUu4kqsKk7PHCCZDa84lD0YNSzqR537WHwO8ZUIW14tgZUPjot1CyPs7BG0S8ud1KvC9
         /FrPSKxQXil2wLLtYtwxQG5laynqNcOQn4sDp5Q+L7/LE3TMckNP7Qf553sz+xjT2rZg
         bSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618105; x=1726222905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u5k+9P7fnLwaL1GZATBK9ZKcQNGMTg+CrJ1EQReTio=;
        b=pv2w+eskj/QEVWwFFWZ2OFTBNtt3N8bwY0W7ZHrtCzQ9sQzdpUldekuKjdX3Aivux5
         py7hErlVPG3GbOTgWOWUfXDnPO7W8WhrCGBrJusIrhWLrvyfBj+xLH9oTxRuMvH2hJJ8
         sA7NcGP5dlBTv6ze4aNxpWU+xLO2+m52X2Glr79ztKmdY47nn0RF6NvO7dh4RbMJCu+v
         ZMF546USU37iMO0Nysx0uHAEcTdLgowFZ3Xou5SyX44B/aq200PsoRcxJBpNPu7yzBsz
         gwBwXdyOLjNS1gQ6KiAnj8Q6TGvqoYkzRzLGSYe+I2edifuXQq8aOgbfh65eojHTMKLu
         AvkA==
X-Forwarded-Encrypted: i=1; AJvYcCW1b1tCKMPH2QrjQ6DP7QlTtTJJHjNfRh+NP2JT5pmc0zzw5YA7/2+1W8OdjnflR4eIor29EvFjX78x36c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYaUzU/Zhi7QMU9TihCr4aV4ttCTmlUlcMuUHRCBb3+MkJH8dK
	VXpXGBq29wF885qP3KCJGPfQnByINb3wXBshrECgEgdKGFMak0za
X-Google-Smtp-Source: AGHT+IGd2NrT1k4kQqbfWLsUDCjD4ioybm9VLp/58SwCFJK9zJhuefQBdB8SlDosUja507wd2A5TZQ==
X-Received: by 2002:a05:6a00:99f:b0:717:87af:fca0 with SMTP id d2e1a72fcca58-718d5c3644amr2835065b3a.0.1725618105315;
        Fri, 06 Sep 2024 03:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:21:45 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V21 11/22] mmc: sdhci-uhs2: add reset function
Date: Fri,  6 Sep 2024 18:20:38 +0800
Message-Id: <20240906102049.7059-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906102049.7059-1-victorshihgli@gmail.com>
References: <20240906102049.7059-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V17:
 - Move the sdhci_uhs2_reset_cmd_data() to the other patch it was used
   for the first time.

Updates in V16:
 - Add sdhci_uhs2_reset_cmd_data() function.

Updates in V15:
 - Refer the SD Host Controller Standard Specification Section 3.10
   to add reset command data mechanism.

Updates in V14:
 - Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so drop
   sdhci_uhs2_mode() and use mmc_card_uhs2() instead of sdhci_uhs2_mode().

Updates in V13:
 - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.

Updates in V8:
 - Adjust the position of matching brackets.

Updates in V6:
 - Remove unnecessary functions and simplify code.

---

 drivers/mmc/host/sdhci-uhs2.c | 37 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 9cb0f1b2a37d..3d16f1ef9344 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -10,7 +10,9 @@
  *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/iopoll.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -21,6 +23,8 @@
 #define SDHCI_UHS2_DUMP(f, x...) \
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
+#define UHS2_RESET_TIMEOUT_100MS		100000
+
 void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 {
 	if (!(mmc_card_uhs2(host->mmc)))
@@ -49,6 +53,39 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+/**
+ * sdhci_uhs2_reset - invoke SW reset
+ * @host: SDHCI host
+ * @mask: Control mask
+ *
+ * Invoke SW reset, depending on a bit in @mask and wait for completion.
+ */
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
+{
+	u32 val;
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL)
+		host->clock = 0;
+
+	/* hw clears the bit when it's done */
+	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
+				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
+		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
+			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
+		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 2bfe18d29bca..caaf9fba4975 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -177,5 +177,6 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

