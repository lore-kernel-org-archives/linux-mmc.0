Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228282D83;
	Wed, 22 May 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376205; cv=none; b=DDzOrzM6ZEiIB9U26rDmyPdxhHJ35k75A86F3GA/NCOAxvwn29wrmXk4nli2Yi0Fh4nmJrwcY3tOxchhsQ4O8R4MILSG6M+vaMgXBJGdzB+M67BL9yJUfH/ILeMMVcLGMGJJ7QufWyCG7Vj5knUNLpDn2HRC3qAJlPgf5De8d/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376205; c=relaxed/simple;
	bh=VvLSbGyx4Ux+VOikGQgOGxxi+tnKDKNejgnT3kJut4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QpxYDnZ/idkLrO+pLpcMUIN4/N02Sp9kylMlhs5TyZiC70IWRKST+qk9udBUe4ixruNUZ7hLYDEiGyEwiifi2y9Pp84wo5eKJ9uonaAiXld95si/PhPlzns0o17p6+rl1fMlSM8JwO41VCO/I9EnSfDvxJs4cj1nncSZ6ULsFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYiR6Tlq; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYiR6Tlq"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23f9c2f1df6so2186447fac.2;
        Wed, 22 May 2024 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376202; x=1716981002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q4eafAZje2FxmOlAP4l6OqzhxkKbcwCjd/0T6cMRNg=;
        b=OYiR6Tlq62cB+fpSegNLFF1/Ktghfx6mHLa6FBCjUHXKlYPABIL+TQrIf4w+AoIjXV
         51sUQ+U1seZc53BFoWVzdIQUgI70z2XL1/bQX+5Jjw132M/85JCJbh9keBuwlYG0rdmH
         65rGCpkVGSJySMz0JBD3hrBjGQ6tENd/ESfBAmKAcWdqz8anU5+gATJdce1vQuJv3x6I
         GKvGkArmpUtltuXs+FAdf1ELqLB75u1abkkE4I/OVsmmzpdJln7MzFaOgpjgAnW0n5bU
         DDCgXNoLguvRllrwK4GPRApqREyhA91J5o6JgPU5/kDd1NX+nDDkz4H/ISUJkPleWYOK
         FPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376202; x=1716981002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q4eafAZje2FxmOlAP4l6OqzhxkKbcwCjd/0T6cMRNg=;
        b=f+NAWNplmLFuBjy0waHSxDKKmdowqS9j6n8V3WL+Df3Z8wKpFyS8y9HaWrPAcThwvM
         vOQZS1jAzRu+79P7ebsoJWCs+GiRJKIYB+iNKS6KgWQ1XZOo9IHSNCnfln2OKL2wdLTm
         oa/kKw39OLFjhcoQSL5ZrpETcnAsS4UjTEpZIloHcxBA1qnehR6Ra+Sm4v6VOZEQK+Cq
         OuKMxLF0RaHVwUduHmUBKc6/dpj+gQj8w95gPIDqxEWrGOFsvbHHCuuMqLYk6jEQ60Y+
         wCAOIOCuAcws/VTgVjApmGg9FNkwAiY1A91MGa30N8b3X5sboaOMb2MisQyfpbz0W86T
         clnA==
X-Forwarded-Encrypted: i=1; AJvYcCXP0qZeONnx6OQmnXaR8nMY9qW6XUQKqP4x6bzcJOor5fXFpdbFGb2Go3Zxs9LK1is6c/WargWAZ1suvKMUe6vCWhAAVdm0Ff/qutPg
X-Gm-Message-State: AOJu0YzmyZ442jT2SW/S2E7DKP/0ylMMB6tKr+d0nS9/C9DuN+N9/Fgt
	SBI5cgtbbuv/yEGqgvx2iXyCZj+jyep3CVD99NPGf1QXes5LciTd
X-Google-Smtp-Source: AGHT+IFtYjZU+cRlzoS5cjkXeF/72LxT8KPCWqnTeOJzrCCHXofC1uROyUDVCEp2eH9VnlIC0CzqlA==
X-Received: by 2002:a05:6870:9121:b0:23d:49de:970e with SMTP id 586e51a60fabf-24c68dd9960mr1749189fac.53.1716376202496;
        Wed, 22 May 2024 04:10:02 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:10:02 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V16 12/23] mmc: sdhci-uhs2: add reset function function
Date: Wed, 22 May 2024 19:08:58 +0800
Message-Id: <20240522110909.10060-13-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522110909.10060-1-victorshihgli@gmail.com>
References: <20240522110909.10060-1-victorshihgli@gmail.com>
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

 drivers/mmc/host/sdhci-uhs2.c | 57 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 drivers/mmc/host/sdhci.c      |  3 +-
 drivers/mmc/host/sdhci.h      |  1 +
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 9cb0f1b2a37d..7652158ea151 100644
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
@@ -49,6 +53,57 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
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
+static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+
+		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+		sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
+	}
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -57,6 +112,8 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.uhs2_reset_cmd_data = sdhci_uhs2_reset_cmd_data;
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 2bfe18d29bca..caaf9fba4975 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -177,5 +177,6 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8fc3e001db74..f212da6dc2aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -236,7 +236,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
 
-static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
+bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		struct mmc_host *mmc = host->mmc;
@@ -249,6 +249,7 @@ static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(sdhci_do_reset);
 
 static void sdhci_reset_for_all(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 13703f1a3710..83d994c8d89e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -845,6 +845,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
+bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
-- 
2.25.1

