Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77E1CFEA4;
	Fri,  6 Sep 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618145; cv=none; b=aMsA5a8SIdMMrRrCzCMR92JFjANDjRpahxEPtO9VKJLbCDKTxMELMsdG5ta7GoLd1fInOM3UoS7aRPdrgaXMJRLwRpBTWQ2dY5OI09jYC+NDgDPRr6nSMP74IUiYufBTgA7h6wVuTyFiK0QQ/kjMEjY0Qz9/EBhC3e3qS5ERtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618145; c=relaxed/simple;
	bh=bqrdTe+f5vq2+vljAqf6AXbmSnZqanQqIxBR+tL8iK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjYpwEp6hCQua1CPe1EZdKghMBYfkNGg9kfZpt1mzlbifdMyZvSFtnrOyfntWBxMXKR0F2PtEhP0Fp/gkNB6rdnEDxu4LpDcRMmuh8aieCS179ZhmSmpw86iUf1wups0DbYVifOFKXIR8TrPEmuB/gztnSnCkU9tAItz/ojRSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xcs3X7mK; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcs3X7mK"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3df0ad9c791so1075283b6e.1;
        Fri, 06 Sep 2024 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618143; x=1726222943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Dd+K8SoxfgI4hFihRbfQKI6+ZToZ6Jy26laC2s5IA=;
        b=Xcs3X7mKPWbD8SJriLGvyiHT2uLKDOGY89Geh80H324vtnEiXj9IbJWc0KchOvnMgN
         CU2sWcGV70ydIby6QbL5uI33fW0x8pAa2Z9r5Vs2vigOhPp7msdGdeR3Dyh7VhNm+uua
         k6FFwS2vDw4yl69shDn7DvXCJSSbx/WM1WbqNxv9UO+SJq+MrWbaxJA+2Jql/s8kDJ8w
         dd4qScBjucnWWET4B/ibPorZn9kXNvzsatjVlHmbF4cnAkGg4NNLwrvAwkF5K5bqQ5sE
         Bm/DVHvDgiivAwVgnN2rtzeVNY5V3o/dMt1OuK8xbFb9izqnawiea1BbP/FOK726UGGB
         R0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618143; x=1726222943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9Dd+K8SoxfgI4hFihRbfQKI6+ZToZ6Jy26laC2s5IA=;
        b=J+cd7bsHi7RigXXKsaNPuSkeh0TdMySVvehZqvdE5hyKDza/VfaxNvddEvQ9PMtm9g
         eNhvHGYZMhv1o3etmUMbYi6QV7HZ5phcA8IWGUKFTYI1Heq19UF98qP+z2l3kXl5U6Gw
         ach5vd4SaJ7leF1Jszb+TVnA9+hfJsmXq4TIBMWr63FX+eaWz4IWAxbEBzv59ZLjGqTx
         LMl3HvmfaQCFtkdRFd/0fsvN+XcLrz1/ybJI+HbyoVoJEU8ZUhlD9BLd7rOjr170SbzF
         oYGMQl+2WPV0IRE4qyHtTLC+rVCrtCDbJvOTYzxJ28aWj47m/y+vPk6GJFYAwF/mEJdi
         kQMg==
X-Forwarded-Encrypted: i=1; AJvYcCVxe0kzpvbHxaXEjFXaWfLzetUf3Wl6EC9ZEdG4YqBz1gdC5xwpjA9UuINulre9HSgz35aczI3cvSotGgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynH4Z2ZeXk/HpFU6Ob3xGaboCFulltev+2zAJdiOGUzlim1wPt
	USmKEGURMUxoke6qjTExWbyKMGBSA+yYDMGXgvQdOjrB2SumlSRz
X-Google-Smtp-Source: AGHT+IFILtySWWsby//Biw7GK5wIVbrWhZCl+aL88rCBISeU3P0u7jP/JkoeYEGpG9Usw5N+MTaCFQ==
X-Received: by 2002:a05:6871:400c:b0:277:dcb2:845e with SMTP id 586e51a60fabf-277dcb29f6emr20591732fac.48.1725618142914;
        Fri, 06 Sep 2024 03:22:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:22:22 -0700 (PDT)
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
Subject: [PATCH V21 19/22] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Fri,  6 Sep 2024 18:20:46 +0800
Message-Id: <20240906102049.7059-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906102049.7059-1-victorshihgli@gmail.com>
References: <20240906102049.7059-1-victorshihgli@gmail.com>
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

