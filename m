Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8A1F4CB7;
	Fri, 16 May 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387658; cv=none; b=PSp/VRxSf24yWOG+/Z91GSMsxctViU1TY2h8FwjxFW2QMDF/PTo5x734O7W06dChf0S7oOXojTS822rl6JiIhuLIt6H5PhNaAtTFqo9HvpRoCMwmXDOshQxMMu+lK5jJFrlnuk6lMFUbssBIWv+f71XVaJ7jbeOOIkcI5Ex2Vf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387658; c=relaxed/simple;
	bh=7sCtWjGf9D06Cj3oOh64Vch8nFlmHXurl2sy4zalXj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su/GPVjf3oKeH37wZz4N1pPS1eg+wl/zaPmVnK1hYr5dZ3/6/oq+zurFKf/D90HrI+15kZWSQh5gthwRBat9gHXlL5591Yp0801hs+Y+AAKeEm4DsZV/1RRq2wel/KI2eTVD8RnylLZao2sAiOInvSY1ZvPf0y8oClaLvkEjy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghVqXed4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghVqXed4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74294fa4bb5so2651099b3a.1;
        Fri, 16 May 2025 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747387655; x=1747992455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdfMuiy3XMb+qdaWg+FGaZyg6nxjISiUPUAWLtCvrm8=;
        b=ghVqXed4+jtYL0GMwoHSaUWxILK8TI8eBfPtSJIaCrO/oJ1kV1+MMCYXHi9RRSUpcC
         OYTB2apCc7RuY94CH8H3y4zDYfMx4MpU7O4HlIFXvPvpegj2AJL1V25XlSFzsy9TvXCH
         1Xj0IX3wsJT73KLxzzbfIbvEWEcd5i7lqqOnSir7vQX9vgCaC7CK9ogmGrRfhun/9HNH
         4DV5Gy46PUq+evDUYdowdsBdcVp1l3p6H8BksD7sRh47E6Q8n92LyrbByzJgP4z1/7Ac
         AglJV1nMZGSPFURklHQGdvUyoED0Z8Hrcc9IirYPnSFVIDVDCRMiPGZgkgBBA5OyPWqi
         ZHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747387655; x=1747992455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdfMuiy3XMb+qdaWg+FGaZyg6nxjISiUPUAWLtCvrm8=;
        b=wYqbPZydwTtOaRyp7ypGuqH97g18rugUyr9MZbY4UVEvx4dIWQLKN+zQNw+wcDSize
         /tWrYLZqLAo5qToLqkmt77FC2zFX9JI9wKHf1UW/kx8pnD0jGr14EYIZh5Y+w8m4iUw2
         eEBvQUOzLrepr6VhNrOGIXh8ebTuMZZgRux+6C8xT8YhcbtRZOGtX/KSFcR3Ec7vOJFm
         dcj+ocfszCk/4BsJz0Fa8SKLK8uraRBUxqNw9OX3ZWxKnZs6Qeg4yiOK5DDlb3iuRT8I
         3y85xzRjXMt7bwtZ3ZyrOiCBTs2FZaLdUrEPSeY0Bob0DqHQPdYhP4q0qhVj8ARknz1Z
         4Qow==
X-Forwarded-Encrypted: i=1; AJvYcCVQWrPm2RdIsQwqFk9FZNY4nJ2KyzxY5+2ttaU/L1c1GZsKi5pCSvfXpoe33+tGMlXX1BwlbN0gLqTNEdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJ1QvLSobERQQUL+Dsf5hE7Dk+ljPlT9BjRz6RT8kdfyQWspW
	6Nd8dFGXr4AfAo0H7y2DKddPXu7cE1NkO7rC/xznOsutCXzC8IU5lL+nSSQOJGeA
X-Gm-Gg: ASbGncvVsYeDvPnQj+/ag8LhjQnUZTrqqwlGzjXt2SWHZ/ETwifA6t9S4YYuob+ncEj
	7osnpBB57YClaRZRKlqzEI+ka3OkolT8GD3DF1GCl+ngPc4U5I4DxRordYKgJKpvB3RxxOWft5/
	RGNOPW6MQ0bwKc+7O9XOlK9h3Uzkp+CGuZRy1dpF1Y4OGKRLNUsDeUeHxVaL6JUHeTuW2O9/jYI
	cNtS9uZ5oHARb++JjdEj+bu94pcq/RyGgPej9s7Mujx//TTAC+uOplg+EGYFVF0k41bWJMNfk3M
	0EVnGkaR5MMyTgaDsSor3BoIexjUVXGXjY0pF9bkdr31dMh3zNZhIEkHUUU=
X-Google-Smtp-Source: AGHT+IHoQj4+b6p05o+r0PSdapSWdiaWzqLgW7wsyD6llGJaPVTAAqZ0D69xfQVM6dlYOjrX01SaPQ==
X-Received: by 2002:aa7:8e8a:0:b0:742:b3a6:db09 with SMTP id d2e1a72fcca58-742b3a6dbdbmr50914b3a.16.1747387655473;
        Fri, 16 May 2025 02:27:35 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:896b:66ce:fdf5:6801])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a229esm1097876b3a.161.2025.05.16.02.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:27:35 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1 2/2] mmc: sdhci-uhs2: Adjust some error messages and register dump for SD UHS-II card
Date: Fri, 16 May 2025 17:27:16 +0800
Message-ID: <20250516092716.3918-3-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516092716.3918-1-victorshihgli@gmail.com>
References: <20250516092716.3918-1-victorshihgli@gmail.com>
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
index cd0e35a80542..2c28240e6003 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -898,4 +898,20 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
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

