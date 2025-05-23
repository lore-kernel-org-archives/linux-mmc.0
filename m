Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FB229B29;
	Fri, 23 May 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747996342; cv=none; b=Lw8sOxpMAunaNJ4q/UOHe3+mtL8D/xKnXUZaMWdpw6n5HajV+cQDaGojJDsqXrg9s9cWw95VamXnyzXSmlCAQYaabynLgk/Buojn86Qr7yLpp+y/uDzyrUevCNIba1tVgypwLolHo3OLrTVYJhCkClEFQbUdGLNMLr0ZdWtro4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747996342; c=relaxed/simple;
	bh=CaLM7qlKGMFaqCj7PZ7UDZswUE+4flp7+gxNf00IwjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2be+8uJpxAIlZd1wxp/fHnybyrL/CJC8hXfhwJd9i1qBWESsRVIJAN0p/hIR5MpvwdV1KEy4n7fdBteIOsAyLXN0BvjMwBcMKF1H5O964YzImS+VbRXjvU48Ef0Y2lxVp62jbk284BrzIBuunKtNLC3RExW3VWBG82Jb8BkOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5GOPTDC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5GOPTDC"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c27df0daso5233167b3a.1;
        Fri, 23 May 2025 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747996339; x=1748601139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/G5UmZrn88ByXsn3ydPT/v8elA8CV1egsk/d5ETDoI=;
        b=K5GOPTDCsxLZZJEky2HGj2qt8NitiE5A5/5rhmJmHmhIzxobxf9Zw1oy1MRGpBR0+e
         BM1fLi5HES3CBFeQKQkFHvMDh4ZabT0ze4mmKSrqgsS5RAAg/x458g4WZkL029UiFq7Q
         Gqyl42wxPDRIzvqMRk6AqaTarxaxhOo3/FydKkiYi7/YfO4umSrD99sWD8WjOcKwqvlG
         mO75oaqgt9LUHorsPwQxlGJfENXFNmh23XgL5nldjOCgDi6JQbR0EzPzYGQjwvoUodCa
         PCVTnP74QDvskkI0ACeMslQ6MFS3hP6gOp2kcPMGSYt2+aPMWuG2BoZ6owmSw9F5fKJ4
         rzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747996339; x=1748601139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/G5UmZrn88ByXsn3ydPT/v8elA8CV1egsk/d5ETDoI=;
        b=IEw4feuBK6HD3pn6CXUKp41Q/e9VwYUy5kGD6pQvPElCzncmhlFszl9k6agTEbEQ0J
         e2WvR9vaqOovceSH9L3ahOURYHv4CA/0u3Phh6qWZgjce4t0oMjrXO3wHjjHHp4U4uXK
         WZxaJVZG1MpaPGDtEC4HF0QCRNivy7Egb0ia9w+AofvePCRofSHZqRgldv8eVIygKC3a
         DPx+ZlJ3x0gHFev9u591PS0UkBzBc1MD7+yXnN67EriZR/TFLjjlNXJPaqduapT33Ic+
         2pRkWfo/obHynPgd18bhfeUprUh2jzgS6VczL/XFfE+d0KlFJDWv4Na8w55S/3zEKZW7
         Ruzg==
X-Forwarded-Encrypted: i=1; AJvYcCVre4NsvBRHUJcT2HY1nu3X3lngH8WhFifUMQpP7yO5rOsDibyGT+e1WBm24j5oKZxeve0F8oyA6+dJbI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBiK5sAGAKRTW1qU/KtdJowuOoNg1X1KAk8laWhHChT7iTUaH
	cModypo2RkBon3O+J0jdCghgOKsScY/hMBs6k5qrrWihE7MwM6Cg8Y5x
X-Gm-Gg: ASbGncsz5bWOT3ouTMC8Ss0GQoLhrkMZyo6YwfpC8z9hdiyBcFi2fShA4G3fp+TLUuf
	LA7qorFF2oqTNU5LbMoCkGM7++WOTrz7M5vypUbdmmh0SuA6Mtzo2LtBUC8Vz/cCVgIaDkleFFT
	Y2OqrpfXHngNA8vAQV4rB3/urfLXxDRg32HSpw63VJIKSUae4CFUDOO1b+VXV1WtLDvgDYP52Av
	6QRhXnehOuEpDCrU/YVdTBZurpYZRdPZFJ/Q8SxcXRs1QQcDsTTqJS4M0JdsBl50eec+Se3sCM1
	AIM0q0QgcJvUvQgGQtcBUFeVkvUBCWZxJ+50YKpWuAHWgJ2YyW3AAtLiX46Yz+ozyMscXw==
X-Google-Smtp-Source: AGHT+IE8n7ANt0J4xSuKvCU54Hs5XUy5w0mXHr3XIZWRO6ZoOCCnlRjA5m1vz91HC07YPDhLVlCMMA==
X-Received: by 2002:a05:6a00:91d3:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-742a9786a79mr35798652b3a.1.1747996339409;
        Fri, 23 May 2025 03:32:19 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:c299:a1bd:2b60:56b8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c882sm13066424b3a.55.2025.05.23.03.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:32:19 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Ben.Chuang@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V2 2/2] mmc: sdhci-uhs2: Adjust some error messages and register dump for SD UHS-II card
Date: Fri, 23 May 2025 18:31:52 +0800
Message-ID: <20250523103152.6210-3-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523103152.6210-1-victorshihgli@gmail.com>
References: <20250523103152.6210-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Adjust some error messages to debug mode and register dump to dynamic
debug mode to avoid causing misunderstanding it is an error.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 18 +++++++++---------
 drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index c53b64d50c0d..9ff867aee985 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -99,8 +99,8 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
 	/* hw clears the bit when it's done */
 	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
 				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
-		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
-			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
+		DBG("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
+		    mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
 		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
 		return;
 	}
@@ -335,8 +335,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
 	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
 			      100, UHS2_INTERFACE_DETECT_TIMEOUT_100MS, true,
 			      host, SDHCI_PRESENT_STATE)) {
-		pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
-		sdhci_dumpregs(host);
+		DBG("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dbg_dumpregs(host, "UHS2 interface detect timeout in 100ms");
 		return -EIO;
 	}
 
@@ -345,8 +345,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
 
 	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
 			      100, UHS2_LANE_SYNC_TIMEOUT_150MS, true, host, SDHCI_PRESENT_STATE)) {
-		pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
-		sdhci_dumpregs(host);
+		DBG("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
+		sdhci_dbg_dumpregs(host, "UHS2 Lane sync fail in 150ms");
 		return -EIO;
 	}
 
@@ -417,12 +417,12 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 		host->ops->uhs2_pre_detect_init(host);
 
 	if (sdhci_uhs2_interface_detect(host)) {
-		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
+		DBG("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
 	}
 
 	if (sdhci_uhs2_init(host)) {
-		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
+		DBG("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
 		return -EIO;
 	}
 
@@ -504,7 +504,7 @@ static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
 	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
 			      100, UHS2_CHECK_DORMANT_TIMEOUT_100MS, true, host,
 			      SDHCI_PRESENT_STATE)) {
-		pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
+		DBG("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
 		sdhci_dumpregs(host);
 		return -EIO;
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f9d65dd0f2b2..70ada1857a4c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -900,4 +900,20 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+#define SDHCI_DBG_ANYWAY 0
+#elif defined(DEBUG)
+#define SDHCI_DBG_ANYWAY 1
+#else
+#define SDHCI_DBG_ANYWAY 0
+#endif
+
+#define sdhci_dbg_dumpregs(host, fmt)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) ||	SDHCI_DBG_ANYWAY)	\
+		sdhci_dumpregs(host);					\
+} while (0)
+
 #endif /* __SDHCI_HW_H */
-- 
2.43.0

