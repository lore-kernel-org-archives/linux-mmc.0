Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B87C19B3CE;
	Thu,  5 Sep 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531655; cv=none; b=EWrTo/5Y3mITeKpVuyzOM3neGfLwkAQS7mdx3Irc6P9Gf0STNXmvEpSnleKaXOu7Eb5CoHMtXExcPnniciFnDPWcnf/9ppulYIakYeqhIfVXUq5JbnoSKNT5b+kNyYguBU0G0fllhfjxowHvx/70kn4NkpU/k7IwKlyIM9vsaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531655; c=relaxed/simple;
	bh=tNWL2yxo2uDQa0iyKVclsZm+e2qhVUxxzq34g14C8ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DtzdPUcde+rl9DN+tNi9xQqsi2TPs73hNEHZSC/xZB3OZXEuRltHQQnER43v8wZC7fNE1FiDNDsL9FQs9qaImo4RJizVKoQtV2S0VSlmOeRyyS4dr7DL+Ez3LS9goFipq3JZ9an9IKBC2nZzQeVqLHwXCOLMrHuyVibg8VNj2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bApjoL1E; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bApjoL1E"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-714226888dfso470991b3a.1;
        Thu, 05 Sep 2024 03:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531653; x=1726136453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u5k+9P7fnLwaL1GZATBK9ZKcQNGMTg+CrJ1EQReTio=;
        b=bApjoL1EQ/ySMZHNzz2FrnXAndj1ksiBDJoatO+sYGycm5UNhcWPkuxVx1XDbhNQY3
         ZOyexvxuJrBFvdJFanLI1mR9X/tBpknAdCP1RC5HWcREH+iVK9Y8breYRY4aYr2z6P3A
         URA0dhXiTQ7qJmUpg/j/+HM5o7Hq351sF5msROmBKuodOhpHEJdxvEWaybBy8wBAVUSu
         o40px0oAp9A3mWdr47ANPi5hW2sPQ1jVHn4fFIMXswPYB8LP9MUoc5ELRCTJM8swWVP8
         2SnpQo4eyTOS6NGkgFSWcZod2usLG+RK0A8ylSdKorcA2R+lQj3ikLRhciVRDggayb5G
         vgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531653; x=1726136453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u5k+9P7fnLwaL1GZATBK9ZKcQNGMTg+CrJ1EQReTio=;
        b=l51c7yu2fDAAOQcMnlQIYa4RahgGjR/o4j5CNK3FAiiWA+4T/RhxEqcVmxZUA6Nqnc
         G2tcirdrgMqc4HcvwFtvAhICG3EWBaLA3UglyNF7o+JPqCLTxVgtAknlYyrVKXEQQBvg
         0Mh1RmXGz1BMMHULTpkE25hs9oUrib2PKRJuW9CWq+rssAwsKiIPUykg3V9ICxwHo7Yb
         g1T3tOS3hGRFtSYyVofkVRYRKZpkOfJpMjMNB1CJVrWPsGqOMdyjBAwX8wx945GGiOz9
         KLDTgXBjK9aOrx6bM3PsFnFnU3LZr9V0KEQLguXz1wiZP+FgIKBE0l1HhZTEIkUL5Avt
         8eLw==
X-Forwarded-Encrypted: i=1; AJvYcCWYvj/B8gFECdYi+3vMNaZ0hkF6vLAgGqffbFAYd49yn/MCjdALNKmYKpeaJwb9Uhj86uqwzZGLw8fYql8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1zSWs4vI6i7G3pRJstLJlnSowhQZftUajYo0b4RhrKAMO+/k
	IQtpK+b6SfjXbfiRWMv3enWOZWtGv/8BnIUC4gTzWrMe7fVsZcg322ClCkpN
X-Google-Smtp-Source: AGHT+IHdVbjH5ybtVkFEOZz1egMiiZh5tR1ekjmDIp05QXA3dfTHUIGqi4pYabzdpygX/VKPUNpnVg==
X-Received: by 2002:a05:6a21:3946:b0:1ce:cb6e:5e00 with SMTP id adf61e73a8af0-1cecb6e6010mr17503315637.50.1725531653065;
        Thu, 05 Sep 2024 03:20:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:20:52 -0700 (PDT)
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
Subject: [PATCH V20 11/22] mmc: sdhci-uhs2: add reset function
Date: Thu,  5 Sep 2024 18:19:49 +0800
Message-Id: <20240905102000.5020-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905102000.5020-1-victorshihgli@gmail.com>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
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

