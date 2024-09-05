Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1B1993B2;
	Thu,  5 Sep 2024 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531690; cv=none; b=eLwVqRUR/X4WXZZdivQuhKO8AI62zDFDPh0/3hzhldw4xy3SY+iKD+qf8SGVQoMeLR6OjqLtlxe1qZEQEkwQdp80y/J0xinypwecrieL+b0DrJUm8hrd8q1aHGEJC3XjLgf5ro816ZUMycSB3HmQ49MbdVZUb1J6fWB5DYsAGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531690; c=relaxed/simple;
	bh=bqrdTe+f5vq2+vljAqf6AXbmSnZqanQqIxBR+tL8iK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WL3jQb2DW1UlsfDHDq0QIRrAE/aEXpqOxJECaH1lGhhobtWDsYz11FxDWfs1yD5+42CeiL9VE14j3fJ5ZSVyXyTlBfI/srx1iiSeXM7okJf6FpgXWJzI7tpmK+UeYEH1HVkN8++NzKKGBJsh6d1iyV40OmXdCXd73hqWvzutbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4Y0HfcW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4Y0HfcW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2054feabfc3so6135855ad.1;
        Thu, 05 Sep 2024 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531688; x=1726136488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Dd+K8SoxfgI4hFihRbfQKI6+ZToZ6Jy26laC2s5IA=;
        b=j4Y0HfcWzEHjYNdI5TYtPyGTJX1oYGTCD0Mf6rpCbJGenpEq7e7ENL9MLWtw57/5tV
         OE+/C1uVFwOKT8LR+B2Pr2Eist6cyXiHf+IoJSE8MJQn10QVrr2YTraIXUN86cNPsRoq
         LarG5XN+x6uhWOEIVFc3o7QZbLqrJqE5PMrMVOZu4+F6Aio3kfYTFKQ5aEafwEAAjqCx
         VZhqzX43kylRXDuxEgqh0mhh6DoR9k9feF4UwkyuYmmgTz4NkBx9OCEpDZm3QEJsqbDF
         ilFQOsPsLNoOJMpOsoyrN7/63SZdRrcHsQ5d+GjNqHS4a9TvHYScMLgseUzQGuIBl7HQ
         9Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531688; x=1726136488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9Dd+K8SoxfgI4hFihRbfQKI6+ZToZ6Jy26laC2s5IA=;
        b=qkTnMM1e55Vudp9zk9sRRB98/tI9wJGQZWF3fRRWpqc5WgGFe4p08KRVSig+veQ9kY
         yGMHRE7rZmeHRWc7ac78JCu/7Gm/D+NrBlebOVtKuvfbQgySWmzg/nBy0YPJfUMVx/Mr
         FAGpZWi0i4ELpVX7NFtXyL1oQv9nuV5AS2h5X2qogWvgEVLRBcALdElvFPIEOxoomCKU
         LCLMCf+mHjo05ZTwSo86Z9uIWDSS44EsfgIZchaRN2SjOLGkl8N9ajZezP8jyN/Lqyvf
         pMkWlk7M6715PhokQZXlfqbZtlBlLfWGOVu4eKVPaXrleg+Uw8m0eI8WUzF6eyMxdYaf
         WjIw==
X-Forwarded-Encrypted: i=1; AJvYcCXJXTc4o0hkNgp+n12YbRrTthvKS2xQvCX141My2Lm0jmYq4F1Z5Rdk579in1tHhM37m+NO4IUrPZrwJoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySfl/EAVo/KKFCz4xYBGQ5HER+YNGKcS9dfcLqomIj6Kz5Wo2w
	OkW5E0ifqixSxhxe9I4gtKkASIfSKSzODfGh0qK1j6bUkjumxKiP
X-Google-Smtp-Source: AGHT+IGn5HvwksjJlaBerhtqxS0mTIMfzoJ17a4YwHBrjhljBsjIRYsrtNtkUL8T8iE3mg0i21MESw==
X-Received: by 2002:a17:903:2451:b0:205:4a1d:ba37 with SMTP id d9443c01a7336-2054a1dbbe4mr205381325ad.38.1725531688250;
        Thu, 05 Sep 2024 03:21:28 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:21:28 -0700 (PDT)
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
Subject: [PATCH V20 19/22] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Thu,  5 Sep 2024 18:19:57 +0800
Message-Id: <20240905102000.5020-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905102000.5020-1-victorshihgli@gmail.com>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
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

