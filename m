Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75618E36E;
	Thu, 29 Aug 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926630; cv=none; b=X2ROtoode5/rovfMOCqUlfyhuwZ+7EnfNSkI+hz+4ScmwEXw7OGgXMdAUVGZdFYNFyr7gSxTlmYQ1lZYTTn5XdwIrCyrZMcvUiHFQ4cPCITzXlMQ0K1reWOhiC0ZTh9/sbmpQg3AELkUsNSwC/IGgqgyHvlDbK9JoP7iwOG6bTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926630; c=relaxed/simple;
	bh=bqrdTe+f5vq2+vljAqf6AXbmSnZqanQqIxBR+tL8iK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1OLl2Fa2Y1vq11pgVmlErFEBf550/wSHAju0qj6PX2p1RHpzVKvp/hPGc0HFXiSaF36Q9f9tKdlGg1dKIr6qOs/stLwbl9KCvUyGHeFwjb0Ry9eFNbiL43VLWD1N9VB0ayzXXNpjAJJ5Wr+7/2+xsRmVZusEcHarv1ShHcfKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz5iRfII; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz5iRfII"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71433cba1b7so355333b3a.0;
        Thu, 29 Aug 2024 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926628; x=1725531428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Dd+K8SoxfgI4hFihRbfQKI6+ZToZ6Jy26laC2s5IA=;
        b=Qz5iRfIIfHMrhBEGUSZbdEJSH2ukAG5SlFSrnizDqbGZfenWQPutllK/dSSDlGtenm
         8N14wMMZ9hhD2UrjQJ8bWCITGmDC8fqw6RhzVMU+FucY3CF8jqPGDM3ZMY/OPzAFUHne
         j2mB6XlrDuznOSI2w622cCaxeKTn27Bbe7TGqVkhR7RKw4KIsv9vtSZU81WOT/+Xar32
         Jo5mCCet1Zp1O+Xm+Dg7/Cu7Uo4cdx1bjZXgd6QGHogVHqDn/Igk0GkQTARe2QMui6hN
         zU60mZ9L1gcBDPex8zDTVqsBomMZCoKUB1Zx6/XrjEyuwPDCP6VXdCYGtjDIF+jLRixY
         DXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926628; x=1725531428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9Dd+K8SoxfgI4hFihRbfQKI6+ZToZ6Jy26laC2s5IA=;
        b=HLu9T1IVuBlySv+9xcKMWx9jqLJFNEd/eyYNBEChRNKhznQpVE4NI3np6Ew/qqzSN7
         fGOWSjtNLjmPx+S7192Okq3BaZggjgOpGqlPjtqs7H2MiRJ5DAOpjEMRSBH0tJkREnWU
         7NJFUtFTcsPZa8qW881TOJSCZy+b/D1uHSqBOZjmVHEET6OXEJk1xJPxS0R/Nw9aC8C7
         nDHu/RJPaPgWbp9hcy7A/0HJCwIp3UC4PBTLXLOY1fNoEhM7860H90D/n9wXuN9pTFCG
         XakN7Ja8PpxnhZvIawPlrQD5jD8yzi0LMuWvHfLDDEZcwpYVOfW85zv6TRqdq2vpGUY1
         Qjpw==
X-Forwarded-Encrypted: i=1; AJvYcCUafNmgpez27FbVRWkrLta5g1NhUJnyvb+f3Mgf+1ei2nZrsSmM2owvpVs2k0vStitK64K6oV/AJRQXNQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mnKIawvCvqwdhngPH4mDiS+XbYQMdtMqbFBb4WwQdV7Lom1f
	szjWzCvDK1i0+3Ql8zU9wG7Y1q7np5nc5vvMG6ekp7Q6IEO4uzK0
X-Google-Smtp-Source: AGHT+IF5YWyN4C5AAdxZdt8fjSLKvpRnsXXBArxPMAyxYhLXbcmvWiG5OtsbmKMw9BeVWVgKy3hdEQ==
X-Received: by 2002:a05:6a20:c89c:b0:1c6:a65f:299 with SMTP id adf61e73a8af0-1cce101438dmr2387608637.21.1724926628268;
        Thu, 29 Aug 2024 03:17:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:17:08 -0700 (PDT)
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
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH V19 19/22] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Thu, 29 Aug 2024 18:15:36 +0800
Message-Id: <20240829101539.5058-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index a9ec78dbcae0..fc5ce7e66c34 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -413,6 +413,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c5e987dce927..588dd76320bb 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -723,6 +723,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

