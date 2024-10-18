Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCA20371E;
	Fri, 18 Oct 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248883; cv=none; b=O943AeW0BLkDmZiFwT6693m8I7A8fjVLH2zTg4+t5uANGp8z+S+WJ0o4zJrV+cL5mzs31gJ6tkF2XuJVX3JY7eP06ke09o9+cuoYGQM3pFSj1ev+1FSvSvkkh3ZghWZ3CUahTiiZL5rMgdKBTBMxC8+16AM2t1x/xx8oavuKXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248883; c=relaxed/simple;
	bh=v4MM9bGqXsTwGu4en4i1RloVtI86bYOecflv6HHdnis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCVPTGkTb0+nnxNl+yrur77yzL/me1eyPZfduusMH/i024LK+2AgozieoWVEiUabl/sYF4oNr1O1HlLD7MZEYFlibKdVLnVQiDORA1oLU7B9X5cS1fej+q/OpiGwE6yWQpYThDI/Dr+92YRm6hQj1wXHDgG65n0W356lLvUT8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8DE3BpF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8DE3BpF"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca1b6a80aso17761365ad.2;
        Fri, 18 Oct 2024 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248881; x=1729853681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pefaTk8qKKbtSAgriHJ425KtY2+eFqYfJpkB9h3wzgM=;
        b=P8DE3BpFV+CXo89ysAfU+p2K9aWpNQK+i9xmIUeHkDsNiBHvuU/SOobGcKEMWp1jEj
         zYL6Zo6j6goUYC/5Fe+vOecNuCVDpUaCkRNqXfHGc3puKNVuktC/uBIqWGadFxreWFyi
         eqjX7NjSKbzIpQsL3KhFoY6/vZLUbQJimGhILmQ3McSLnkklEOqFIFmThAdO5rh/iGKx
         B3OQu911usAWYdTYVwSlBomZZNlJO1ZsEoTjSTOMOjZdc6WH35XmxkNSb4QTCK3mLr0r
         zUxZhgXAyuMvgAQLwX7hR0u3b7B4uCOmLOPV3GD1dTRExZNBoAq48JvI3fkpS/0wCMM0
         AjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248881; x=1729853681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pefaTk8qKKbtSAgriHJ425KtY2+eFqYfJpkB9h3wzgM=;
        b=SHYnbams3v8TA3SVU46Q0oRsaiK0HvFuRiD1tjQxF74rwERF9X/ZVklwIhkAWpl1u/
         W/vR/ZM5EgwghaPWYsum3zg6iQxyMtTEellMCvDDfIwWaZQQU7Cs4PBMLLoqS/GrmHWF
         md2N5KI+TmYN19hIchgwfSJNMprt3RqJMk8Mml4/bcSZI2flPMPAErEHGifXqcOwFRy1
         D3rmumNDZ37mLNtjNN3+xjptso/cebxqZK3oYMXShjmNltqRZnkruDbzGaCzyW+0POUY
         /GpAFIyYQCEkqv/jbooOZA1TXknX8wFhHxGkHwQWbUUxuLpf/RxMpvSZrNdKlN0oDaya
         UHnw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3IhwvJTPQ2QLRC49PX6BaTInQnJtmaWLewpBt0laOweohiAEcwKyXBE5EyTDS1MAdS6XwVZ+7XEb6kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwViiGTM+jzKdXEKvFqgCDWDArKSvlhnLgRErZyZwCPjEZH+MDo
	FwyF1Ra/utf+2ge1n4uEdARZ1kozNk8PyT4Bgcx8Oky2zSosfff9
X-Google-Smtp-Source: AGHT+IFukLFvY6uQ1WJOZS66U/6VdVB1klGJ4tHMml5jWOCqbh3LIRPfiDswVCt7lDEjRuujg2GpcQ==
X-Received: by 2002:a17:903:192:b0:20b:9c8c:e9f3 with SMTP id d9443c01a7336-20e5a7663c2mr18394105ad.14.1729248881202;
        Fri, 18 Oct 2024 03:54:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47a:11ee:3789:3bcf:d64f:bc9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fa20esm10237455ad.234.2024.10.18.03.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:54:40 -0700 (PDT)
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
Subject: [PATCH V23 13/16] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Fri, 18 Oct 2024 18:53:30 +0800
Message-Id: <20241018105333.4569-14-victorshihgli@gmail.com>
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
index d99ea05098cb..c488c6d56015 100644
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
index c636808139d5..cd0e35a80542 100644
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

