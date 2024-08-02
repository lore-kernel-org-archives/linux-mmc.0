Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB01DF694;
	Fri,  2 Aug 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594217; cv=none; b=HmYQ7ie4cY9pYcUFl7R7rvuUEp+xdEtdd3204fdKL9GE3mjN6/pcgb2dw/fXLKIahFtgrrgpy04dFAJstoSgXEGE8qM4uFAF+ogne/bG/4JQ/SaUFi1z3lWygqhHuA9EP+2ilJsipzfkcy+lKvzVc3xQNoToBN4o3RawlGTRNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594217; c=relaxed/simple;
	bh=tNWL2yxo2uDQa0iyKVclsZm+e2qhVUxxzq34g14C8ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9XqScjweH1kV3aVd6KIaHZDGkGsbDPAI9jFUtEVmZMKH63zGVfevGKAAMXkmoqvYGEIzVyY/cVL3symTbe0fxLEnJLxuEblPtAcENIRKaQrCT/oXnUMIuuxV/1h/XBikte0gqcqe4Vl9qapXb1CRBElu8wMTohFfaK5csQ/MRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9ksI+87; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9ksI+87"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db16129143so4567981b6e.0;
        Fri, 02 Aug 2024 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594214; x=1723199014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u5k+9P7fnLwaL1GZATBK9ZKcQNGMTg+CrJ1EQReTio=;
        b=g9ksI+87yuB63kleux8DK+L+7o6C1rraM/uny/M+7g22g8npsASC4obrSgt0hJqTaZ
         D8zJlYaD3YNmlqLfkcuYCggpA+rPfy4kVSHBIwGalLBe4/x6Qh+zbxEXEZsfM0xqvJ+p
         wYNEFA7EUF32O764GsEycHrIbSkhoDTfuL3upyaCJHvP5f8rinzkanjIwfi0AYEvQ5vi
         DuHv7sAi6LqG/Jy+Tw8GQxcOs//qynhIPMJc2FFHY/6ax/r2OlFxyAtg408QIeCT2GiN
         TIQVW62IGcLZ2NN63SvD1gBXe3nHVg/olPHkbkQ8UGbM+Lr50YsOK3Jf16lwWQ6Z+YIe
         3vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594214; x=1723199014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u5k+9P7fnLwaL1GZATBK9ZKcQNGMTg+CrJ1EQReTio=;
        b=SMCPHRaHGbJ8mczQlWPf4LlQ5mchdJHb6VyWADIumGD5wkmgjAu7hgwurLEQugwLGZ
         Y2UdzGhoKSEhxNYEj060MnOS1GIGCwO0Ye5wCOro7sDvxzvo5WTyJPSB2AGlzlIahvxt
         rvRCds8cNe/x8PBGIIs9lQJQeYEQUWfmVhm2GgTlaYqpfWCwI/IQ3+B4u2OYVKm7d7D6
         JQQPut4KFjHFq90IS38gm3AG5psFYYrYdjMPNEm1lvh3i1zUh4ADNxjRUOPJuPwu6ApW
         HAnPZV1qSlWECH08ES3/ZtYBsEP3qQFTG+Uu+lVPJxhRVwvWCuvcqpAYs/ORjOW4ncts
         neGw==
X-Forwarded-Encrypted: i=1; AJvYcCXxRZyxdRni0h9z1zuuN35Tnl27d4SUtA9tF4l4nd4XQ3JnLeBO7RceTrWVKhv+DVoMsZXwAwPvnlgrId2xlsI0+3ZD6RDNvj4EB0Dy
X-Gm-Message-State: AOJu0YxR4TMo3NTKz6YR5fF/hRqmYKFKoDFueQ5w81U/VgxHgJTtDEBz
	vyEEJ0JYn0Ozod7N2ne2uUuknLcfDUbiId6NiTD2CgmSRJu2y9Sg
X-Google-Smtp-Source: AGHT+IF7vr/F1ggGpLR8o48nptt1ebiO5erkMILOjapG7sj4evRud4q5cBZP5TKrN9BFZh7HX0FKOA==
X-Received: by 2002:a05:6808:1385:b0:3d9:2bab:de1f with SMTP id 5614622812f47-3db558167f4mr4328450b6e.25.1722594214631;
        Fri, 02 Aug 2024 03:23:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:23:34 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V18 11/22] mmc: sdhci-uhs2: add reset function
Date: Fri,  2 Aug 2024 18:22:18 +0800
Message-Id: <20240802102229.10204-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802102229.10204-1-victorshihgli@gmail.com>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
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

