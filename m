Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1B30FC3C
	for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469729; cv=none; b=H9NvmJrF9AC+W+87xq6kxMYXsy/8GhDOFpm6JQ/VBe5NSDO0mwI1NPxc9A7iXiZdGsA88QOGMuqzFsCc50vwKFsr8JC5sXPQHb+02nZi7/cW4WbmpcOKjgSIl721ih2GN32I7WFTwAh9fDJEM8Pv/MK4FcuUnmwT6VE1nXI37as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469729; c=relaxed/simple;
	bh=9MHv9U+sIP0p9WbV7pGkyb6FAUYdsK4jABeRipv6wcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=butVnKrXSiKf+VzPYe0ESXcLZSjyxE4Etxjmjg41L2bi0T/WERyOkn7z7K5O9ufm6sSwO3848opuxHEeE/t6+jUchpe9ZJJjN1/NUEe+q/wc/tzI+xv+9ru4Bfsd7dMG95as6IAj5kBSG6BiP7rFcHSTC9+fNWJNfONDkmCsUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COqC7Cju; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COqC7Cju"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so284493a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765469727; x=1766074527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGzmMUNNAOJwEedQ/rguOQmtJ7RZS/q2FSqGY6vneBc=;
        b=COqC7CjukVkf+m2i2tpunrqLfzxYYxKM5ugJQDfX2noDCioGeLDLet+uYz9mXFkf8M
         qW9K68EC15fi9X46WMgNNQys5H4Znxa8dgmIwODbRCF1/9GnPE45hR41+fVp44+/RpQ7
         jtVktWIxMWRRAdL372lNaSeQktEyqc3PBZa2zrDGlJA2U8RWYdXg4JMBLj0yxSGS1/67
         6RfIbIEvlu1CrJZ3dcTLtPpV6rU3eeTse9eWSAqij8MwdH+9IXM9uwSYN9lS9pPWdCm/
         GcBEXKWB06hZUt8EAvW1u28g5v7h6POJ4vsey6ZjNT+XiSw1a5WD7OefVrVi6wBWDyZO
         Qb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765469727; x=1766074527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGzmMUNNAOJwEedQ/rguOQmtJ7RZS/q2FSqGY6vneBc=;
        b=QN65h0Ad8j4k3mHReeWlO2QtKOyR7MCEkLdrmog8J3M8G8ggltmDN4pEv234z8g7Hg
         YeiAD8ej0P/r9yP+7+0SSJTepdfsZfcNsnsADPUq48J+MLRj9jd+pgLQ5BiGpEhNCpjc
         4YxcNyYKV0VphsO+YWJPZjb/IslbDqdKGXPzmjhZw9cr536wyB1LsD9/V1pU3HE372js
         uMjjVypCREJA6B/ZBEEgDjoJlHq+AsLhMM2jERh5GHPV6mToKhSK04N3vGSQOdUyv8zL
         jSRQFFOEdHhq1Aun5pSn4sp9P7nVsyPOuG3PF1n1jQnfWgpVdp2h5/Ys4HRX98Yymx2C
         Fb5w==
X-Gm-Message-State: AOJu0YyQWvZRpWmqZnMSIJd99DK3N6qXZ5pTzT68MBritspkVyfL97aR
	RzByt3mQMTZA3Y/8mawbXN2ZpBCN4Og8lJqazmVwDLDBe/lYccCaaAs1
X-Gm-Gg: AY/fxX7NHC2cS5jow5dior7GfmvzbqoSmPdvliY9UzhH2+D3CI4jcN6yXoBu00w049E
	+o7lcmVoOpLsv2RC5R9w4WH6Qp2nsQxPVd4WtpAWKaA5LHWliHQCacqf8/IHbOviHnj5Wxqj/9U
	yQIdh3GS0DQjdOMarpkSq4oSnTVstO9KjYTlFTL4Cx6nUA2iniG0nUan3iR/YVPCC4vcW3pERIj
	UrXVgi3npa/0UT3otREuQjswOjUSM+4+4rWhHoPhGiOkceqDpx+OaE9g5dSG3NBQhnU4KOJKgoF
	inJt0zZZy2CV35W08NtVYiOkqepgVfHrQ/Nf5b7Ib6cjvns1khGczwzu6uHYaKNtcAL4QojSdMH
	wsSlrPlIHfvTnQiYAkDS2BFJRToYu2z5vtP8PQnhJpOgeTxzN08z6Rv+P/FH10esPs1oIIC4baK
	d6kwB/mcmYU7czRMda8L+AcK2b+tc4Aub5VGIJ3QRbKXnT0/u/X8IbTAVdEAvX2G6O5GksGIrxV
	g==
X-Google-Smtp-Source: AGHT+IFQsCDlcvlCMimDFjXBthrDJntLJez/5kfiB+AqUFY15dTXUsOpWGzg5GS8BJRyVlbv8+e0jA==
X-Received: by 2002:a17:90b:4b8f:b0:34a:aa7b:1af8 with SMTP id 98e67ed59e1d1-34aaa7b1cd5mr660661a91.32.1765469726837;
        Thu, 11 Dec 2025 08:15:26 -0800 (PST)
Received: from oslab.. (n058152119183.netvigator.com. [58.152.119.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c25a86fa3sm2791188a12.5.2025.12.11.08.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 08:15:26 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: jh80.chung@samsung.com,
	shawn.lin@rock-chips.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] mmc: dw_mmc: Add a defensive check to prevent potential null-pointer dereferences in dw_mci_runtime_resume()
Date: Fri, 12 Dec 2025 00:13:13 +0800
Message-ID: <20251211161313.3994317-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this function, the variable host->slot is checked and then dereferenced
in several places which indicates it can be NULL, for example:

  if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);

However, in the following cases, host->slot is dereferenced without a
preceding NULL check, which introduces a risk of null-pointer dereference:

  dw_mci_setup_bus(host->slot, true);

  if (sdio_irq_claimed(host->slot->mmc))
    __dw_mci_enable_sdio_irq(host->slot, 1);

  dw_mci_enable_cd(host);

To prevent such issues, add a defensive check to ensure host->slot is not
NULL before dereferencing it.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9e74b675e92d..e74dea0a32d4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3670,15 +3670,18 @@ int dw_mci_runtime_resume(struct device *dev)
 	if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
 		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
 
-	/* Force setup bus to guarantee available clock output */
-	dw_mci_setup_bus(host->slot, true);
 
-	/* Re-enable SDIO interrupts. */
-	if (sdio_irq_claimed(host->slot->mmc))
-		__dw_mci_enable_sdio_irq(host->slot, 1);
+	if (host->slot) {
+		/* Force setup bus to guarantee available clock output */
+		dw_mci_setup_bus(host->slot, true);
 
-	/* Now that slots are all setup, we can enable card detect */
-	dw_mci_enable_cd(host);
+		/* Re-enable SDIO interrupts. */
+		if (sdio_irq_claimed(host->slot->mmc))
+			__dw_mci_enable_sdio_irq(host->slot, 1);
+
+		/* Now that slots are all setup, we can enable card detect */
+		dw_mci_enable_cd(host);
+	}
 
 	return 0;
 
-- 
2.43.0

