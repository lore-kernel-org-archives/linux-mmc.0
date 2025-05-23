Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA7230269;
	Fri, 23 May 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998132; cv=none; b=BtFLUzD6yhmYeBM7Sou7vi/XJGLGw/GoFgjXvoE2+MbBLlYisWRa4m/UZzmXUjF4jgi9LaO+cBoyS5+0m6P9J8ptWONcZCISaItlZrIaN0pYln1GpJ2iwunF68YM7RLO0oRiiHInaNi29aVrrN5Sh4CjXg7YCadTu3GhnHxL4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998132; c=relaxed/simple;
	bh=wWlg/xxi0rcYKKYjAjYz0/gQCRTPCc1STKy73K8LuyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8cq5G27Wxecy+ePjQl5M97nK9igu4UNI0MmSB3HLl4fSCI7dyAS2l5217f1F5FMOi/1han5Lknymr15Zn1O93BhWrSuDUFQQZjpWn+Yr0YDXOzyhwaKzIfELjUKR2gcZnyy3LVJKUuxB0vsQLL5r0zH3O4wCv/8pz3WJ5HdzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw+yvpnf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw+yvpnf"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c5f3456fso4594831b3a.0;
        Fri, 23 May 2025 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747998130; x=1748602930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJgvMWFPSvDkN3i2S2OGW933zKfxq/CvOajiIJhLSOw=;
        b=Tw+yvpnfnb0rH5GU888YU1++/IENRoDC6Qn2Pz5xClqtneYs4Lzuy2G+xP9hlp2DdZ
         ybJQscEopMbH3cLjAvFilxpw1H8eytk2vxenDXPVFnBUfwtIiaBi6lgJfTxkfjabnBlc
         aYjopMOxVcLyNNaddGBU3EXVSGzgBlc9VT8BqbtUO8V5xsBsYMPeNovkSTgCaubsnpqv
         8OevKqsaad8AoCDMBY/CliYNkEn4RVMFNexdAvZakgFTA9EwgcjzDZzbk+uT+2QCfUfQ
         i9G+wshotJcovvPYuJvbTY3MvmF3hQsu9Q2uV+DI0MTdbSKTMbSK9f44h1zTDOv1FWYI
         1pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747998130; x=1748602930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJgvMWFPSvDkN3i2S2OGW933zKfxq/CvOajiIJhLSOw=;
        b=H+2AyThfokH+6v3qDvaQ5c/7z9WcspcdmeBGJN3pcY4hQO5gfyUM0JjtoiNB5uOPBu
         mCBy0dbFctO0sYMacmDtqnUvbEBaBy4YYDkXKB0PKRDoj0cIOojEWkTMnGeB4PEMP8aD
         20xwB3jTd1VN+GZLj1wYVtHWm6kPknPlF74CEMqqm+79LBVOOgguRi2IYQawHlyCJfIX
         8JxZ0z3CqbafHvnU7ai0wBmqAbIjObkEvr3x7d1BkZvlPogphvhv9pwr71zm8XOMyy8H
         PyHGlhBorSXvYbQsCYh5f5tjCphJ8rVBErfH73BkmGbJIxq5Tei14OXns1S9F7CdxmDi
         KcQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKfNyz6/5ODjfFaAKoszTeAfGoefUn5GbEZnu/AamtpOxAB7XFtdeL9S9/pbFLwb8lNBQVu0l1Woz1T98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XWPUsXZX6ea3nWIT5fHiX55lyRV8mW4ySXlwRRUf+2SGqTyR
	pEl5WEcII8JtNMhhvqLpbxIdm0Fh+cyUpjkL501dPk65IFm36Qb8U/kN
X-Gm-Gg: ASbGncuRpBdiFY9t2ByN2P9YA5i7XLDPc819+N8f3MPbJYJBIQFKbk52K74B4zSGN/e
	6qleQXbvxZ8Y8T6xpB7nwSonKj/VXfmIijrbmcPMbhosMqMCBMuHpL2W/+r5Ju2nqDi13JMs6u/
	ISB/pJUmC0Q6Jez6y6xS/Yq05kX8rWrwPE1Vveu4q0ninlX8zju2HBwjYbPkAJ21GVBdDekHzH8
	jth0TmDlCPXlu1NfzqtPKvLTbghWOUN+fGxxo3Bhzi9r5yLcPqRpEscm2sfLXVb85lGv/N7blMv
	lfKcFDiiEDbN9BeACSNae19DchivNBQnZcV1zS3wQ2BcHQwWhXAmL0xRrLk=
X-Google-Smtp-Source: AGHT+IGixeryYotarTWIVPVJwxDxHUo5GCtX3qrhF0iki3SvLoI1Bq4NpuP/gqfaAex8YdhZDsEC2A==
X-Received: by 2002:a05:6a21:9105:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-2187a0f2cd7mr3059365637.20.1747998129466;
        Fri, 23 May 2025 04:02:09 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:c299:a1bd:2b60:56b8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6dc3csm12541617a12.24.2025.05.23.04.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:02:09 -0700 (PDT)
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
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH RESEND V2 2/2] mmc: sdhci-uhs2: Adjust some error messages and register dump for SD UHS-II card
Date: Fri, 23 May 2025 19:01:55 +0800
Message-ID: <20250523110155.10451-3-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523110155.10451-1-victorshihgli@gmail.com>
References: <20250523110155.10451-1-victorshihgli@gmail.com>
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

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 20 ++++++++++----------
 drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index c53b64d50c0d..0efeb9d0c376 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -99,8 +99,8 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
 	/* hw clears the bit when it's done */
 	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
 				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
-		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
-			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
+		pr_debug("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
+			 mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
 		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
 		return;
 	}
@@ -335,8 +335,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
 	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
 			      100, UHS2_INTERFACE_DETECT_TIMEOUT_100MS, true,
 			      host, SDHCI_PRESENT_STATE)) {
-		pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
-		sdhci_dumpregs(host);
+		pr_debug("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dbg_dumpregs(host, "UHS2 interface detect timeout in 100ms");
 		return -EIO;
 	}
 
@@ -345,8 +345,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
 
 	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
 			      100, UHS2_LANE_SYNC_TIMEOUT_150MS, true, host, SDHCI_PRESENT_STATE)) {
-		pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
-		sdhci_dumpregs(host);
+		pr_debug("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
+		sdhci_dbg_dumpregs(host, "UHS2 Lane sync fail in 150ms");
 		return -EIO;
 	}
 
@@ -417,12 +417,12 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 		host->ops->uhs2_pre_detect_init(host);
 
 	if (sdhci_uhs2_interface_detect(host)) {
-		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
+		pr_debug("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
 	}
 
 	if (sdhci_uhs2_init(host)) {
-		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
+		pr_debug("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
 		return -EIO;
 	}
 
@@ -504,8 +504,8 @@ static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
 	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
 			      100, UHS2_CHECK_DORMANT_TIMEOUT_100MS, true, host,
 			      SDHCI_PRESENT_STATE)) {
-		pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
-		sdhci_dumpregs(host);
+		pr_debug("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dbg_dumpregs(host, "UHS2 IN_DORMANT fail in 100ms");
 		return -EIO;
 	}
 	return 0;
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

