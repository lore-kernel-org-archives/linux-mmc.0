Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF5E28688A;
	Fri,  6 Jun 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207705; cv=none; b=T3aey5k9fOJKXD5Cq1LlFfGISSlql3ZBhvKsWYFEMMogXvq2N70rK1uxsc5CKfHvEo3FtEP1MUj0a+ZrAH2PKOfAqcaW428DTT4GEdG2jdT8iCZBQs+r4q9DL/V51jNqRb19sIrB11QeYthZIf35iEYwYP7FnPvwocnmKpchssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207705; c=relaxed/simple;
	bh=rlyKOSjopnnYv5rZ9EMYIXC37icsOlBrqPJsm9ycYS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkWitpMWulO56+Igx9ncgGZkc5nGNDib4LYE/A6Ohz7XPHNH34USGQ+EXwcS5W9B7S/wpz/GSSSDMXsMEEpxA9X4BxNB1SwnV67A+53oWCbQf+mDgD2oqZSVKGtF4Y9zD/riYfktxDjORsihW9iBO2/1YaiPZt+k9UW1tCVZmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBt4lY79; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBt4lY79"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1204083a12.2;
        Fri, 06 Jun 2025 04:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749207702; x=1749812502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPhR9yX4mSs2h2RIwQ6dpRH1kL3oB4FnAXKq6tC6nJc=;
        b=MBt4lY79FONx0yOcHFyRldG5J9uqNQvDGiYDF2mzBq/eajtZ9ipSCEshd9dsPCvatS
         70u+DGhfj0NglY2ZY8BE4jNLweNbMg6Ri18+nMt0bzTXispxRCcNRo0UL09F3n4DczJm
         gtztog+cGZsJVO0Kbgdm2AGWF8PidtEYwerpD4Vu6RGypaHTeVxTEICPmOfC4zQrjOvz
         wIkfbNV7j+s8Wgzgk/ij1ub9ajDThQmjEOmht304KngtyRhJ5mbNFyrGoAt3d5iuzhPb
         B9cLfRdgtyCShxsXZGEHuY//XPYU5BW4rYf7yyzBL9HDt5dTc1ouLRB39RzX4DWLUvUG
         SBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749207702; x=1749812502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPhR9yX4mSs2h2RIwQ6dpRH1kL3oB4FnAXKq6tC6nJc=;
        b=NS6qs+Ck4MoPhnYkBKup6zJvsWUA8ij50VIbHZTQVZuVHO9qnV+SEnBPUpD9psU/nn
         mYEcpExXTfTZj5ZuKDJ6HXwYWwIy00ugPwHmx1GbxfyGze2iu1oLVCOAJI5Ps2cRqVfL
         mwmXsNi2J/QxOyYru2QvwSHXOudoijGfm+dFbp+xopdRSeyoNw3DQNbuEg8ZeHf9enmN
         MQ4yYBRZRQYN3hl4Pzt4IAtSmRPvxLln9IJewZFs2CG+ugNg0KLHk7j2KImqZF9CL8nS
         m5lR76bBCvAom0Wwl14Uie6GniA27cmSahaZ1TxFiPHqIA3/8LmyG/3fdvq3UN1kCb2w
         GmDw==
X-Forwarded-Encrypted: i=1; AJvYcCUmawDoPj1TKocvMDZ9Ae5pOHmTIOtyJAbEZjF63wuSMYlTbgHse8KSn2tvTclHI/qcUW5R1c8FTqKvWrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQdg9OprWqyxJ403FS6aTLFB4BCKAQzSl9fjNRuRUzzCRjyRT
	qM8ZmusSHg0QEWRbldjg1atR6ph64qD+MTF6Z87qo0C6Tuc3k3L+gGN9
X-Gm-Gg: ASbGnct7muaypLgvoi6cd27gGFgFVATVuvgnNshsTzbUQWhHgl16WkdVUxLaVVHLo9+
	K8k1U+SvDhk5t0DD4NleOcOxsY6zfi+KoaFz7J6oq6F0F7R8gj6TsMFcWyUkEHpNXfG/GYeq1xe
	PrsgJl8V4By+zNR1xvshym/29FsfAZNGQVGPcZ5vbKB6RzwlPx/PkeMVZ2VQXGznDx2QHBvsg6x
	03dfW5JSu2y1oIqjvsnt+I9bm26cugsx2dVt+vV7hXhMeLnzDrK2JFkL9ql+Rsxb9/BoMIu9GM7
	fAcJhnAfhmiM2qmYFNTzke9BpvfTCEcv9YoQOsC651SR+sHdtxye+sYBNWA=
X-Google-Smtp-Source: AGHT+IGXb/wYozRMBi61TbjaFbU/cASFsQ/CJ7ePhkkDeM21EM8iCfMvcIs9pazkFUy5Rr77tzVAPA==
X-Received: by 2002:a17:90b:3e4b:b0:311:e731:523a with SMTP id 98e67ed59e1d1-313472e628dmr4656133a91.11.1749207702384;
        Fri, 06 Jun 2025 04:01:42 -0700 (PDT)
Received: from victorshih.. ([2402:7500:477:464b:b7fc:d546:e798:4fbc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603406aa9sm10095565ad.188.2025.06.06.04.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 04:01:41 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V3 3/3] mmc: sdhci-uhs2: Adjust some error messages and register dump for SD UHS-II card
Date: Fri,  6 Jun 2025 19:01:21 +0800
Message-ID: <20250606110121.96314-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606110121.96314-1-victorshihgli@gmail.com>
References: <20250606110121.96314-1-victorshihgli@gmail.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

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
-- 
2.43.0

