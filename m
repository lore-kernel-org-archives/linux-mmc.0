Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01D202649;
	Fri, 18 Oct 2024 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248847; cv=none; b=OnkrMPIE//7IymkOVNJXlBpqcjsULT61h5i7p9lACLxBr29h4af55cIIXxZoLf6k74TLiV5uIR7Qf2npQKdIbkHuaAaHb6nzgAa5nfz2aoHWQNq462gn98peuC/a73q8SJCey8jYYxh1vZn5wFIjDtqiZ9LixqJ/VN728TSaB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248847; c=relaxed/simple;
	bh=CdA3SI06ubeqqm9CRejDKr9MVIb3Sm3bm+DpHuLlSdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTutHia2/rdBfSV2mxSAfkch/b83Od/ZkJ3+Vq4CUA0BJgUc9Oe4nW8tzqWd7HXeMYOG1RXeXWtNjuaaeD6v/kz2dJCL1EEMwOZ234uOziwJSmNPKI4jQ+3xibqHNNFgopS/rM+5ZbiCevhd5WhDCGjDHX4C0jnrIMisgbutDNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpqOSyLu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpqOSyLu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b5affde14so13851245ad.3;
        Fri, 18 Oct 2024 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248845; x=1729853645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpaYtlLd3mQ+A9z10aDKxE+hmD+tiwgrXgbBd5u7JA4=;
        b=JpqOSyLuFoBSsPaUiEFqRiUreOGRmJciMi4Rjle3lfGWxBJb8UD6uz49XrP7jrZylv
         ZLYEkGvfLDsEvL++jjx4Af5iat6AJ56COOAM+NUlZyzG97cr0SPjq4GYnOTCF+PgzsC2
         fUnkIwKNYJa2dy7qYiHVpelcKWtc5oaSuDfsJbRm5w2ZtHsGWYUrXooQej3UEfmW2uOG
         lkGqLjphovNf8DbgtQ/UqXXwIljVAejSpvTbyqaO1qYsGtLpTmENMRFqEjCTga6ygLUf
         /SMvmdbNjTw2bOLpe9rAbZ4no/v9Jb02NeoUeAKnUrCfYiJyoY1q5N5YclS9FqKnc8Sy
         yO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248845; x=1729853645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpaYtlLd3mQ+A9z10aDKxE+hmD+tiwgrXgbBd5u7JA4=;
        b=RaDoYmiojeQJ1AhDnD995gVQbt6GTNZiqUUxGJyZFR1mAP/qLqm18CPQ0uwG7k+2FK
         aTqa8dxYC7hfJaOAh9cDksZCbKxlbJxbkre+u6STzXfShLe998HABxow8IrvGyiD9Id7
         RhLbexGLHMSPSANTM5aw4QLyeFTnJfasA8SN5iIu3kDScL4hNZxIp9GYn5XrBoDHitG+
         pg2Tkjz+TmDYpaqUeZjSM9ThE2j3ho8VXYS0Wcy89MxD+nEKLpkt/FOLCjbNvfQrSGmk
         0fMn1OwHuDV7ztHcis9kLFnac5xB5Qk7veLfDEz3+xgZfOJlHJzQWcFz/qd4fzUXBBA+
         8LsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX73/bb3dv3H/fLYfuG9v1YWZ7bfIlg50M3Zbvw2mlKNKQ1yNGmrj1KLT9SZKfvV/u3l7XMMhfTijzTAGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhkJuEZ2x84ZcpH3//ze3aJ+kaGlojNJmC5qbno+tRmo+/Xl8
	UxW4ZMpb8f9umuk7nqAQK8dO5qHsj3hGUG1Xs1AN2eccprND+5tH
X-Google-Smtp-Source: AGHT+IEwk7mdcOEMVWejwyQAdFkTXJjHgCrwya9POzb0LiOF9F0qebux0nNG9SdsXoohvLdv9+lGqg==
X-Received: by 2002:a17:903:2303:b0:20c:ab29:8133 with SMTP id d9443c01a7336-20e5a89a930mr25317875ad.27.1729248844856;
        Fri, 18 Oct 2024 03:54:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47a:11ee:3789:3bcf:d64f:bc9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fa20esm10237455ad.234.2024.10.18.03.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:54:04 -0700 (PDT)
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
Subject: [PATCH V23 05/16] mmc: sdhci-uhs2: add reset function
Date: Fri, 18 Oct 2024 18:53:22 +0800
Message-Id: <20241018105333.4569-6-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
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
index 14514710e763..71c60952a40a 100644
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

