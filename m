Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BF1DB940;
	Fri, 13 Sep 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223386; cv=none; b=SHufaLR+ZUwL+/cbHADBwNHixSxjLEBzOE84NkF9oCene0iIOakVBCVISV87aT8Sl1bLzFmlzLeJotTCwN4DGn5P/0RGZswoRpNXrdlfHOzVKZkWvseqmEglQLvZb2238krm2TzVzkWQrHizvZ5XEpLWWw3WVcAFJyZ/KD1cQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223386; c=relaxed/simple;
	bh=YFLqV890Z42BNuleGy/377WU3cFQMODtUvsZxEvUggE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzFmZYep0+FiYzuGL3gLL/I2538hGVIUpgzWxtqfpAPOLrUq9kSYusPdJdiEVt7jIz9NKaTZG/xeFGQLJsFn8p1BVGt0rKV1zWBNfpcxZVaKlGDoY1l5+iX0tXQTlPD+IciXmKRhfhOKVE5yR+119LDhHKiWuqPO57uVi+iMsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBZvyHKs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBZvyHKs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2055a3f80a4so14085855ad.2;
        Fri, 13 Sep 2024 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223385; x=1726828185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA8jKHOlnNb5oztdOQ8CqUpGZDm97ramC29vExw2ghw=;
        b=cBZvyHKsvfnn22Fg+krf0umqJim/e4hvoa/W9hNV3rCSsLHJWuyjn+lceAL32c4a+j
         njTlJf+7JpCxB8dwnurJnazbZHWiQ17SlAI8oMB4/raRF7T5QMBm4fYv/KYmYfX2tRuk
         JDK1GjIBj8XrqBGBgINEM1gP1TLcw9VzN8fQMOwgW65tNUgrVBPdDqpzncoBEK8IvduI
         3S/mYDHDhNKcWOWchLHOd+K/rCHigYB/dhnELKP6gTam/FC+1k5m9EQoQvAD2Z1g4EIy
         cF+gKGukoO3MEK5oq8mp+50iHpPH2W+864UigYRNkw55ABSEORkKUZP9TSnKEbzf7e+Z
         PIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223385; x=1726828185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA8jKHOlnNb5oztdOQ8CqUpGZDm97ramC29vExw2ghw=;
        b=px5S5/B+1+TJFOiL/mlRzBQwn6nqewW7ChZjsNRYoz/xh2ccFrdYZL8wOE6ctlF8do
         gxKs55q0rpoTXMM4wlgosvexy1IcHY92m652tGNF84xpte6QLujut11cJQzJUzqaGYV1
         sl9/xBJ+bP7c5B6KNCUlSAnLw3xiGMSsS2KZdTot+rECQgIuXeum3JCjmbMDVhermBlj
         odsTVG5qVsJ8YYAF8ikayvaKgWysoTO1bmfoxWWZ5hJ8o1LJPjdWwhpSmAkhKT/66pkt
         ZUfzYt9Uf+qrmVamgndTlynv+PY+GbyiWosGINLGrGlSaEzHhP/Go2pjwFvVcPQYUKPD
         KsEA==
X-Forwarded-Encrypted: i=1; AJvYcCWyBcQBH/n3bioSKM3ztZA7hhnT1s+pLCC3bfttt1/qUgaVlQT4Comh4MsNQI6pcApgePNv2Pn0e7wfBbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPF960asAGglCQnNqsIe5Dc5/lSLXReOzuEPbzv4Bnnk5h08p7
	RVrXGBw2w1KoalaovUWoI5a1BG8sVESQtGEgdB7y6eXmsLnpjWZp
X-Google-Smtp-Source: AGHT+IFDo86Kh1wDO0Bi76s7UcJVHrghgeRC5dZI/qG07qNoZ96ObwxowNSojYoSUM9scAV4D021Rw==
X-Received: by 2002:a17:903:18b:b0:202:301f:36fd with SMTP id d9443c01a7336-2076e361277mr80818475ad.18.1726223384696;
        Fri, 13 Sep 2024 03:29:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:29:44 -0700 (PDT)
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
Subject: [PATCH V22 14/22] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date: Fri, 13 Sep 2024 18:28:28 +0800
Message-Id: <20240913102836.6144-15-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
References: <20240913102836.6144-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's add_host/remove_host operation.
Any sdhci drivers which are capable of handling UHS-II cards must
call those functions instead of the corresponding sdhci's.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V22:
 - Adjust the patch order from v21 patch#18 to v22 patch#14 and
   remove unnecessary code to avoid defined but not used warnings.

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   __sdhci_uhs2_remove_host().

Updates in V13:
 - Re-order function to avoid declaration.
 - Use vqmmc2 to stead vmmc2.

Updates in V11:
 - Remove unused ocr_avail_uhs2.

Updates in V10:
 - Move some definitions of PatchV9[05/23] to PatchV10[20/23].

Updates in V8:
 - Change return type to void for __sdhci_uhs2_add_host_v4().
 - Remove unused variables in __sdhci_uhs2_add_host_v4().

Updates in V7:
 - __sdhci_add_host() to instead of __sdhci_uhs2_add_host()
   in sdhci_uhs2_add_host().
 - Cancel export state of some functions.

Updates in V6:
 - Add complete_work_fn/thread_irq_fn variables in struct sdhci_host.
 - Use complete_work_fn/thread_irq_fn variables in
   sdhci_alloc_host() and sdhci_uhs2_add_host().
 - Use sdhci_uhs2_mode() to simplify code in __sdhci_uhs2_remove_host().

---

 drivers/mmc/host/sdhci-uhs2.c | 91 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 2 files changed, 93 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 6b249eb8395a..d3af620c7b68 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/iopoll.h>
 #include <linux/bitfield.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -224,6 +225,96 @@ static void __exit sdhci_uhs2_mod_exit(void)
 }
 module_exit(sdhci_uhs2_mod_exit);
 
+/*****************************************************************************\
+ *
+ * Device allocation/registration                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static void __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2)
+		mmc->caps2 |= MMC_CAP2_SD_UHS2;
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+
+	if ((caps1 & SDHCI_CAN_VDD2_180) &&
+	    !max_current_caps2 &&
+	    !IS_ERR(mmc->supply.vqmmc2)) {
+		/* UHS2 - VDD2 */
+		int curr = regulator_get_current_limit(mmc->supply.vqmmc2);
+
+		if (curr > 0) {
+			/* convert to SDHCI_MAX_CURRENT format */
+			curr = curr / 1000;  /* convert to mA */
+			curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
+			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
+			max_current_caps2 = curr;
+		}
+	}
+
+	if (!(caps1 & SDHCI_CAN_VDD2_180))
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+}
+
+static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!mmc_card_uhs2(host->mmc))
+		return;
+
+	if (!dead)
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+}
+
+int sdhci_uhs2_add_host(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_add_host_v4(host, host->caps1);
+
+	if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
+		/* host doesn't want to enable UHS2 support */
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+
+	/* LED support not implemented for UHS2 */
+	host->quirks |= SDHCI_QUIRK_NO_LED;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_remove_host(host, 0);
+
+	sdhci_cleanup_host(host);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
+
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	__sdhci_uhs2_remove_host(host, dead);
+
+	sdhci_remove_host(host, dead);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
+
 MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
 MODULE_DESCRIPTION("MMC UHS-II Support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 9bd3f610cf8c..0e1866a6bdb6 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -181,5 +181,7 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
+int sdhci_uhs2_add_host(struct sdhci_host *host);
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

