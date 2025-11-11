Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B26212FB9
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845726; cv=none; b=aYOrHKf6lzlU8vfhqj3HBAsvoikEmfuuiTBmumHWuDl1zLljtpk9AAjqKlHz0hBq0hPK9UPv0YL06nUZMFeIkQBmTGc9hDMeMQqlw3tuG4lsOH8aHP5xUKXxWuBPWeLVH3bBdAP0henR1emctyx/F+QZXcmsUzsYHofBf9M9G78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845726; c=relaxed/simple;
	bh=Zf9WEFXfE6bq+Hc2EstDsmaBak2mnzhvUiacR4bC4/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFkFjVSDbSVj7Yk1YFo2FWVBRce/kFbDKFKB07J6oXQPfQ2obLHP0xgPemCHuxFBDxTyge8/ZZvzFp8qvHjKGOzd9MUT3IOmw8tUrnkszEr0/u9T52ucbqHRSOHa54QZXiHU1doUD97jPm74zPdRBCITwpik1dsnFQLP5ourAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIJ4uGrG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIJ4uGrG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aad4823079so3517568b3a.0
        for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 23:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762845724; x=1763450524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z3L1kNsgL26Ld1VFBvRuQTF0eVIZpSLBAGlIIman4Q=;
        b=lIJ4uGrGfFSz+tm04eVOHv04YheMMgQiJ6Scf/6sM1qMD1q+IRAX11JMmDJMe7069q
         iKhcct61hZPT4L5YmlxR2KWQk3YLRWaBaaOAGueLwQ8WFhoU6O6AqPOXcGn17aA0S9vK
         8XvdNW8q5A9qifoxsoOMGpExMaQGVFfHDRw2Ayrw7d3r4esAf0epCwKhRSOvnb2a/Uhd
         ca9Gd8Ypga6FL4M0FviitGaYQYe5T/RbHMDzxMsdAw3h9YVzEm8FUFnJ6ymVIFWuvsZU
         OHyzicaSxzMn3bnvf76l8T/FTuXBIqoT1nSzD9Kw6Chz9fVGfIWtpbRr76W4K3XjnBpc
         6BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762845724; x=1763450524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z3L1kNsgL26Ld1VFBvRuQTF0eVIZpSLBAGlIIman4Q=;
        b=fpyEIqqbMd0chna9SyZtzSi38+7hnF4AnpmSD5BiTG6oanKhKMjogF0PD6T1SIkJP+
         21zao5NaXIyRe5BB02yuOW/V84+cnyGAOmSJEfA1ykqMA7WEeJHA5YhCcWBpmoxzm+up
         g1EVa3TSEKOSeNNxokm/UvX/yBL69y2N5oVHWIoiysHqr7F2kDFdt0GM/wJSP3XvDIty
         3h3mXfdpakBcSV79M/+C14iMmkRa9MQcfw98A3QsNSB6M3r92+Vvp50TVkkg1k/JFcof
         erYUE4JmlxBk0OuLQiMZCvA1kNpKQpRhXnf7iiPYd1bXSJmHbfylakJGaWJBEHC2wbNE
         fZlg==
X-Forwarded-Encrypted: i=1; AJvYcCV0lnn0CqmOamGkaEbQJ0T8pM/Gw27eDzWAZfhzLJiPohgUx+X7BscMi8WDu8TwU2j12VnMN+btOd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq88MnR/a+u5it6Mnw0gkNKnARVNuq1Bvv4jngS/YOXknN5iWV
	4OukE8RQDGQqSmJK3DZMlr3RqqG/YmV1u9N3QyvbxuhiKUciNljm2fio
X-Gm-Gg: ASbGncsYGPtMioLf96LZTdi+Iqfy4i80nmYM8GrY176hORAU1yYW18t4AbusX8C01Bi
	jHi3Ok1YGXmn0PaB380nr9mLP+QhylwsctxnhCW5WA4hdQSz1T5onUlufyZOvM6gf4rLtqL1kMF
	fO7DY24zqcIP5Ix4+tBhOfP2rznkzrr5KpRL1yJxDjmajIIAgkPdBbVxO3AOSXGP1ePnb3RMW55
	dphoapvPPhZqM2Fu/gxyKgmK9tDVGoDeGgbeEGzvRfT22yGS75VIxvfTijQLeZS6CCBCyKR2s4T
	MbRhcnUdfXiNg4JlSwk7iWzpMcp49X+IJTMTqom3zZFmF2D9q6OWboMzf9MfEZlDMpGO3ap4kIw
	fgdAFzMvT8K8EywS9fD0f4a8Od8A4AsRLBgw/cRXNFFOYsNueSE4XUmVPNvi3rbqQVhEpEkeLD6
	F6u9jTH++l
X-Google-Smtp-Source: AGHT+IGpsEiuiMerwOIwaAE+LQq6f13VAWzZ3g9VwGRVGMuJ4FNKoN7VNGnAwDPV3OPkWgBhWnKfHQ==
X-Received: by 2002:a05:6a20:2450:b0:342:5ba7:dfa1 with SMTP id adf61e73a8af0-353a3859cecmr14895533637.42.1762845723981;
        Mon, 10 Nov 2025 23:22:03 -0800 (PST)
Received: from rockpi-5b ([45.112.0.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe33a75sm15466106a12.24.2025.11.10.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:22:03 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org (open list:SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI...),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] mmc: sdhci-of-dwcmshc: Enable enhanced strobe for eMMC in HS400 for Rockchip
Date: Tue, 11 Nov 2025 12:51:57 +0530
Message-ID: <20251111072158.6686-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per RK3588 TRM Part 2 section EMMC_EMMC_CTRL, Add code to enable
enhanced strobe mode, set the card type to eMMC in HS400 during clock
configuration. This bit instructs Host to sample the CMD line using data
strobe for HS400 mode.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eebd453899566..3edde4532b13c 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -77,6 +77,10 @@
 #define CV18XX_RETRY_TUNING_MAX			50
 
 /* Rockchip specific Registers */
+#define DWCMSHC_EMMC_CTRL		0x52c
+#define  EMMC_CTRL_CARD_IS_EMMC		BIT(0)
+#define  EMMC_CTRL_ENH_STROBE_ENABLE	BIT(8)
+
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
 #define DWCMSHC_EMMC_DLL_RXCLK		0x804
 #define DWCMSHC_EMMC_DLL_TXCLK		0x808
@@ -660,6 +664,14 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 			DLL_CMDOUT_TAPNUM_90_DEGREES |
 			DLL_CMDOUT_TAPNUM_FROM_SW;
 		sdhci_writel(host, extra, DECMSHC_EMMC_DLL_CMDOUT);
+
+		extra = sdhci_readl(host, DWCMSHC_EMMC_CTRL);
+		if (extra & EMMC_CTRL_CARD_IS_EMMC) {
+			extra |= EMMC_CTRL_ENH_STROBE_ENABLE;
+			sdhci_writel(host, extra, DWCMSHC_EMMC_CTRL);
+		} else {
+			dev_info(mmc_dev(host->mmc), "strobe mode not enabled!\n");
+		}
 	}
 
 	extra = DWCMSHC_EMMC_DLL_DLYENA |

base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
-- 
2.50.1

