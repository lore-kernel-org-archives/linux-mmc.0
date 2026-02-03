Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C61519AC
	for <linux-mmc@vger.kernel.org>; Tue,  3 Feb 2026 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081818; cv=none; b=QMiO0gzVv6RAt5S9KazAvHtLF4I4eO2R1UxDS33HpZKMmbARKKR5Q9ZXl5HlGMsV6FyfXaw1+VNK5r2ZpK+kE1kjiRc72XOBGn4Znxue+Mn70z9sft2wbwcy5e3fhoNzph2KXTPWvFQI4LxJwv15huMh+mH6xcymLgivRMegzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081818; c=relaxed/simple;
	bh=bV92YUEk0Kbdtkf8yzyT5tItqUNNVYgGk5GRcEgwsa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jp25A4CrPmQUOFuMe9i3sdIAzUcIGUIrPZg+Q7ZrD8tZhb1Pim8uVND6NUArApc3Kk87Uc8rnU8V8OOC04z2FEpooJmbnSRqAC4Avoov0Sv/AWBxv4/4ZOmzPP64XQUhbyfPzA13/7ET2GX1B55mToj0ReHQYNKjzaZSTTCeVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW/rjB31; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW/rjB31"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-124a1b4dd40so2364244c88.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Feb 2026 17:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770081816; x=1770686616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiPCt+o8rhd3MPjYrARh+lPIFZjBaiPX2nn/xL1HQLw=;
        b=NW/rjB31JjpifpR6SKA063nGGC7gxf0BNRng+BAniJhTslZ8EkeFfNOjBxsgxVwoli
         XoqRqVj9l03TES6peawl0+izwePpKdZXBnH5B387s1nKdRWzE4aekOFAWx4UYtcBbOJH
         +H2caDUcXxGDCFelYO2/lLoexzX4rrs35xnd/a5iT0PzXc9sCcErYFJ8RMMHUqHzuRut
         C2JeslYsD6Qwy0roE3MU27ucerJlPpXCbRQu958g7bMorAI0LiaxaR/jGvD32dsqoKYE
         rT2BLPMKGt/zzhW+PbXI+QXvhwCg7Sht0qhhP0t4pDig1nYg+PCOnojMJrYbLq50qnqI
         bAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770081816; x=1770686616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiPCt+o8rhd3MPjYrARh+lPIFZjBaiPX2nn/xL1HQLw=;
        b=ZltiR93wMFMCs1imRHrXTt1y6I1Y05Z+c9U+pRdMIhe4j/ZAmdhhDxBBK9QFP4zzSH
         6qCUACBmpPxj6Ve9qI3s0DUFLHmnYGzmTXWNlzcBe1M85x3XIe/EvmKRlhmrC5wgTJxj
         nTsbDZBqUe9TJutsDvkBSbl2jreCYpgWGd/SVWjI99x9APuRJC9/vS6GnCrYOFtMrZiX
         mmlc0HAjIRDTWzpenIa3rUQclZ+1Bq2yJawTHcjLG87fUjuRKoEgT94e6JumkKfY0bnq
         CTilc0UlHOecs0AzZblelXIpqEyN3tUv9we0nP/VrkvI43fxhb07RHqS72ecXPujM9p9
         1pyw==
X-Gm-Message-State: AOJu0YySatqnzIGGdvRx9SXYLc7CYBJRSmjUHL+eY7vFH+VCXWOyWWYl
	FtAQixMacoO9TM0SK+isTTrH1LGtgWmWuWOhdacb/OIzIrBr2iGUsQ/d0ARtabLz
X-Gm-Gg: AZuq6aIvogbiatfBXxoKVaKprcn/7HJc9BK893nPmtmgKzCUZCGxj8yKWq3JDW0LTpd
	m9Asi8HphQWhMSJd/wS+XkqDi3B+ohafgKR2ABiSqoqMhP6CsbXnZQJbuyEbphrGRK6gNiYY2dR
	EzItceklJ9YRnGqkV3i2so4prEh6umVBD+TkTN90QuZEWsBIAY9+WkkTxsUKOszm+joFqDH/GBY
	c4EhcXnpdMS8NKCqtxMH4QNGtZlKekDtscQR6wC4ZPMK/8BVW8an7WTkkP6K1dnPU4ukrUIX+O1
	Z0GQKcIwb2tiky/DGSEvEKl8Wy/VbhRCWWWii3rndw1G+Tej93CA7q28+wl46fU4SBqxjEV4VYF
	Xa1kcJ0AOOVK6kQq5ZH9/KSg7kEbZXaPQilN2vJ4+vQhgtr3l4P59KO6yqCfUBGW11GaPVYmgLt
	JU+YM3DoZ6kLxRucGcZHehnX1gO3iFsTsQt6OGwzzhOuigb+X3tf3pnY7wJ874i7dGGeTT0Xf9V
	li8WVY379aEHSNQRVK6bMVQ5B0jXo6aBg/eXcyYGPzWwv461rj1KH4seFGPbQVaPXh8OGRet8Bx
	HeJy
X-Received: by 2002:a05:7022:2206:b0:123:2c98:f6ac with SMTP id a92af1059eb24-125c0f88a8emr7360784c88.12.1770081816375;
        Mon, 02 Feb 2026 17:23:36 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d8ba78sm18218039c88.8.2026.02.02.17.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 17:23:36 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] mmc: remove unnecessary module_init/exit functions
Date: Mon,  2 Feb 2026 17:23:21 -0800
Message-ID: <20260203012322.20827-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three MMC drivers have unnecessary module_init and module_exit
functions that are empty or just print a message. Drivers that do not
have module_init or module_exit functions can still be unloaded
successfully. Remove them.

---
Changes from v1:
Rebase on latest mmc next branch
Improve commit message

Acked-by: Adrian Hunter <adrian.hunter@intel.com> (v1)
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

 drivers/mmc/host/dw_mmc.c      | 13 -------------
 drivers/mmc/host/sdhci-pltfm.c | 13 -------------
 drivers/mmc/host/sdhci-uhs2.c  | 13 +------------
 3 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b2ac61f3a8f7..2006ffe7eac7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3523,19 +3523,6 @@ int dw_mci_runtime_resume(struct device *dev)
 }
 EXPORT_SYMBOL(dw_mci_runtime_resume);
 
-static int __init dw_mci_init(void)
-{
-	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
-	return 0;
-}
-
-static void __exit dw_mci_exit(void)
-{
-}
-
-module_init(dw_mci_init);
-module_exit(dw_mci_exit);
-
 MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
 MODULE_AUTHOR("NXP Semiconductor VietNam");
 MODULE_AUTHOR("Imagination Technologies Ltd");
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 7f6ac636f040..d4fb60c1ef69 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -215,19 +215,6 @@ const struct dev_pm_ops sdhci_pltfm_pmops = {
 };
 EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
 
-static int __init sdhci_pltfm_drv_init(void)
-{
-	pr_info("sdhci-pltfm: SDHCI platform and OF driver helper\n");
-
-	return 0;
-}
-module_init(sdhci_pltfm_drv_init);
-
-static void __exit sdhci_pltfm_drv_exit(void)
-{
-}
-module_exit(sdhci_pltfm_drv_exit);
-
 MODULE_DESCRIPTION("SDHCI platform and OF driver helper");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index c459a08d01da..41e49c6cc751 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1126,7 +1126,7 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
 
 /*****************************************************************************\
  *                                                                           *
- * Driver init/exit                                                          *
+ * Driver init                                                               *
  *                                                                           *
 \*****************************************************************************/
 
@@ -1138,17 +1138,6 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 	return 0;
 }
 
-static int __init sdhci_uhs2_mod_init(void)
-{
-	return 0;
-}
-module_init(sdhci_uhs2_mod_init);
-
-static void __exit sdhci_uhs2_mod_exit(void)
-{
-}
-module_exit(sdhci_uhs2_mod_exit);
-
 /*****************************************************************************\
  *
  * Device allocation/registration                                            *
-- 
2.43.0

