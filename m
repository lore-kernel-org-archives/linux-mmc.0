Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D7296D39;
	Fri, 23 May 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011650; cv=none; b=PtIVZPkyPVCYnvc9qY0JhCh/+CtZ6yXvZOfSHOOlMtZ0ofp1tuJN5v7+nhXlt5zbr76vQYHXejpa8xCcYDLMwLTP4/HKXS2XjyD+b4CVFypCXIR2nM7Tfbj9M6csTvfKFhLsS7tydg4vvvV8VCom4GgjSKIExAao1mcJZBNDEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011650; c=relaxed/simple;
	bh=ci51TN0zWIkUuCtREvFuALW7XcksRaibdd6IoD9Sm2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cO9d2UFkuQpkyzbkf39TPr87VAKrLWXSng/MjC61UtuqFBmSU3wAHtFDFpsLamSwSX4lzBttiZGK30iGFEP6NodA3gf/VKf+Py1Wq2PVuZYdhd8+VcmIEjXgn5/mCHd4EiJJRk4Da4/3hLTUR87t+LOVuI15eoWA5H+1q2lzn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 77F9B343270;
	Fri, 23 May 2025 14:47:23 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Fri, 23 May 2025 22:46:32 +0800
Subject: [PATCH 2/2] mmc: sdhci-of-k1: disable HW busy detection
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-21-k1-sdhci-v1-2-9f293116a7e7@gentoo.org>
References: <20250523-21-k1-sdhci-v1-0-9f293116a7e7@gentoo.org>
In-Reply-To: <20250523-21-k1-sdhci-v1-0-9f293116a7e7@gentoo.org>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=ci51TN0zWIkUuCtREvFuALW7XcksRaibdd6IoD9Sm2g=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoMIpyusZ8D6qbB+Gs/i5nVYuZsa0KAy+jE6sr9
 4Jzp4cyFhWJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaDCKcl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277agdD/9arIG33iPsRPT10E
 r3siK0Jzx331n/x1wWBEQpcPdFVnkYdMUh5FMmG0XN4zXPFjii2T82PJDM4F8i/thQ2dex9mPrV
 puQPBg0tEVJs4UABj4N4KSuA9bmCEH76BB44+XSMvBrWejUmQfP+DN5wrDWihXJL0RPL+z7ziT5
 XGGj2FIrCPoWnLvrF1WwD4EUbJtxgrROXKB3qW8AFUMYHSwjOzvec795itMAI1XrlFXT35HSsEm
 U64F4k2OpbL3qnfgSdkhs/qakKo8WImxyLNwuE9TkRaAo73DSOhiZ8ZYUh4y/aY+ci0uORQSvSd
 xWTYf0CsymAI/eDKAWMTdTjeXCkBxgbfteujZbpcbAa7l9PJd5cC4RFQUixKfC5YgQCY0r4aktD
 n4uV1ZTqiQEbaACGgrqaNK5EoP+MxvbbEN8PwZ1yccSsljkMpDs5xzN7f3kBZE/bAAvz/W6fb/x
 afcWfLOu+o/2Lo+vk/qqAmCIOnkpSx0ACcm9apH/G9Xfzc0fvQ9m8U+0r8d4zl7iXZj+nLSxdWY
 vBZRfdDEGtvwC+C0ByqWKPEMHr7HV2EiTPwS7Tdvdki6Je1SZNaD2DjPHDcUJd716dbOjtt5LaY
 xNup/HkQEje5HbDRzK2fojE9p80l9ao32RWPw1RGPxrU/zf0xaiOPe3bGin4BDA6YZSg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

It doesn't make sense to enable HW busy detection in pre_select_hs400(),
while disable it later in post_select_hs400(). And the reason behind this
isn't clear. Therefore, let's disable it for now.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 1e1e012cdff9143a7dffa4e00bd9baac2a2dff2d..89f37f147a8a12cc80978d637cd31b9ecc0e9eac 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -178,7 +178,6 @@ static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
 	struct sdhci_host *host = mmc_priv(mmc);
 
 	spacemit_sdhci_setbits(host, SDHC_MMC_HS400, SPACEMIT_SDHC_MMC_CTRL_REG);
-	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
 	return 0;
 }
@@ -188,7 +187,6 @@ static void spacemit_sdhci_post_select_hs400(struct mmc_host *mmc)
 	struct sdhci_host *host = mmc_priv(mmc);
 
 	spacemit_sdhci_phy_dll_init(host);
-	host->mmc->caps &= ~MMC_CAP_WAIT_WHILE_BUSY;
 }
 
 static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)

-- 
2.49.0

