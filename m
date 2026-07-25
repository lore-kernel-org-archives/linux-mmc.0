Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A42882DE
	for <linux-mmc@vger.kernel.org>; Sat, 25 Jul 2026 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785005504; cv=none; b=SEl0NQpPyD/CwpbIwY6sEbsIXMSS0LLrm3i7WKEMXI8pf4cBnSf40C2OPXcrU84CNYWjvGBxRy6mQux7Q/CNzc1daVWoJX8r6f7ZGJ6qVHMs05pLqVXxbkAC0KRJFtHCpearlD4wlWW261ymFnzUSXVzsc4edFuLz+0iDVmwq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785005504; c=relaxed/simple;
	bh=zXmjRYsNskrjIXx7qyH5rsMW2os+RcAo3nnc7FL477c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UYBYv04dvIYanbpqWm2tzJgqM0Sr5jj0ge6Rg08lyPTNjZoeiLyEo+5dxc5NoICnC0TrsZTjTNl/PuuMaIf/s54iljvmmeVxEDw35dS8cvy2G/x1ShzvS+204RNsXAYmgsM04YO1v0fYp5H46MgSgIEBIUR+rCvxVlR4eLue67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxcaFRsV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxcaFRsV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cedda2ce6fso12664655ad.1
        for <linux-mmc@vger.kernel.org>; Sat, 25 Jul 2026 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785005502; x=1785610302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3n25c2qu5nQId8pRmFQPbeaPos2SANAOL544ubHzaWs=;
        b=mxcaFRsVQ/4lnm76eCTbNIZQ3F2K2EvNXLAjSH2gjLPulQPOiz963bl+0tBRgz0bXG
         t3o2/sZC/xrCzYJz58MNWZlaEJqswjyNu3X6mVGqaFVTGhLcOJMdJIqndf/WXeL2qiat
         KWDx/+ws2iuUt8354q29JycaYV4/g+MeQs46jv9EYXEuiUwd94hCN3RbhGP2TtFVGG/0
         sXUYWYeCMrFTlRGDu3LsIaTggonHArADSCxJAuzDWJRmGWQl4gxmWppVQ/RP+kh37+05
         RHWz2EN1QxBPfI2FK6PaojahDSNSiGk7/1Ze1v5eyg4XhsnR+D+SBmtS3KvprGaxizU0
         9D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785005502; x=1785610302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3n25c2qu5nQId8pRmFQPbeaPos2SANAOL544ubHzaWs=;
        b=mYku4+EtGPyH7KiRdLm2n6Ierk5mO0yhmVtuDzXbCl7RP5Bb9/Q5u99lTxPWWAz2DT
         EFwvhRZYR9ruh5DWauod8wJAaEqrjSH0SN36UOkAyO/IIPqRK9XJ3z/2Bi16TdBsxS/X
         Fh0/MMzyS+XKEPS+u/Q+CWRrPGBkyKRf78x35kZHnj8lyDIdz+SCwxaCMqTZRP4RE8qe
         oYyAr9yHdzNr7PWTWXTD9pxIoruYpAaTOMkFsr2hbBbEGsruOfxirxaeOg9pDk8IM0LC
         1y9SPicJ3W7GGcpslt3F+7Nep+b0XHIQcpKv/M6jG0ExraNQK7pmuL0JnrBAum/QdH8x
         5L+Q==
X-Gm-Message-State: AOJu0YxKQLQvoBS6UbbwKRw0hXgs33O6edWRWT/qRpmHRhF3hYGTwCRK
	ZkdIgsXDIH7nYL0/c4tGZrgaomX6nFqRemsGxJimdr43T6Nc6wGGBTh7
X-Gm-Gg: AR+sD12+CP0kNCzLvucH8uDtygPo9pOXVhszwMn3uf0RuaSbVyyTOQVutGoUkUplOVP
	1msfnKhub5W96ZKPoEhKR7Zxc4A0lbcNEY8ESjDftinpMtkJVqFHJWZSZbNYKS2UtAHyUnzeWU+
	+1NRcuTJywFMZWkolI8v/MePHRqyy/etTVOYIYQcQUYnDs01om/LLCsqehhY2LG7p4baH6VIRLA
	csAVPUp00b3ZBJT3XgXLDckhhMsiBdCDb9b9JfqpyGijrdJFv1nleXscfQL8Ws3damqLMCAaVhk
	4AtSEaOYXapxt8ig6Q6kJINcF44YLJdhFlz71Cr0ff+1LYuvrMF3k9WOBRKNwX5a/imbsOL9t1+
	9WQ18EodMVx88Wq18ZrgJSR4o1Yb3+bPOlpIw7QEGtcWKaguv25Q1EgL2z8UPTHHb0rnPZbDGv4
	5U/K569Ki501N5a1ocdg==
X-Received: by 2002:a17:903:37ce:b0:2ca:1bd2:d57b with SMTP id d9443c01a7336-2cfde55acfemr25735425ad.0.1785005502403;
        Sat, 25 Jul 2026 11:51:42 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.51.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549cacsm13281089eec.16.2026.07.25.11.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 11:51:42 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH] mmc: core: add MMC_QUIRK_BROKEN_WRITE_ZEROES for ESMT eMMC
Date: Sun, 26 Jul 2026 00:21:29 +0530
Message-Id: <20260725185129.43397-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ESMT eMMC (SM0000) supports normal TRIM discard, but fails when TRIM
is used to offload WRITE_ZEROES operations.

Add a new card quirk, MMC_QUIRK_BROKEN_WRITE_ZEROES, to prevent setting
max_write_zeroes_sectors during queue setup when this quirk is present.
Apply this fixup to ESMT eMMC devices (CID_MANFID_ESM_MMC 0xEC,
CID 'SM0000').

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/mmc/core/card.h   | 1 +
 drivers/mmc/core/queue.c  | 3 ++-
 drivers/mmc/core/quirks.h | 6 ++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index a7c364d0030..144a8f5e7d2 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -94,6 +94,7 @@ struct mmc_fixup {
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
 #define CID_MANFID_KINGSTON_SD	0x9F
+#define CID_MANFID_ESMT_MMC	0xEC
 #define CID_MANFID_NUMONYX	0xFE
 
 #define END_FIXUP { NULL }
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 5d187e063da..3ee640056a5 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -191,7 +191,8 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
 			lim->max_secure_erase_sectors = max_discard;
 	}
 
-	if (mmc_card_can_trim(card) && card->erased_byte == 0)
+	if (mmc_card_can_trim(card) && card->erased_byte == 0 &&
+	    !(card->quirks & MMC_QUIRK_BROKEN_WRITE_ZEROS))
 		lim->max_write_zeroes_sectors = max_discard;
 
 	/* granularity must not be greater than max. discard */
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index ae3ece89d0a..91758fd7fc2 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -91,6 +91,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
 
+	/* SM0000 supports normal TRIM discard but fails when TRIM is
+	 * used to offload WRITE_ZEROES, so we disable it.
+	 */
+	MMC_FIXUP("SM0000", CID_MANFID_ESMT_MMC, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_WRITE_ZEROES),
+
 	/*
 	 * Some SD cards lockup while using CMD23 multiblock transfers.
 	 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9dc4750296a..938a4296b55 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -331,6 +331,7 @@ struct mmc_card {
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
 #define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
 #define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME	(1<<20) /* Secure erase/trim time is fixed regardless of size */
+#define MMC_QUIRK_BROKEN_WRITE_ZEROES	(1<<21)	/* Broken write zeroes via trim */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.34.1

