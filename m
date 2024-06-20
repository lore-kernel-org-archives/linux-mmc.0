Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6611AD3E1;
	Thu, 20 Jun 2024 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880368; cv=none; b=pOR4s7dYj9PRmNX65p+rYRmr5pIxMKLyeOobDAswCDyjwoURLDTwpbOrZ3fhkyOqxz55TmQMldP8PXMtIcf6FLSqHyt+ansV2tiECWN8H6yiHcgwe5yXJSEkKbK/vm7EqKeSOBvtmyeuYgWHT17esS50pk7jS+CUy3oaejIlKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880368; c=relaxed/simple;
	bh=YmGdoU2kM9kz8RldpB42Zg4qiub5aLQNjtB3AIIm3IE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeO3F5xKXvKrIdcLJxK40mRn72eG8Qvcz2Y9bY+WcAIKzXndMeumoFOnReG/nhrex76Pj/ArY5n09hpmk0VTmLmHQvdQwSJiHcG8t/PULqya7TdLU+xWwIdXLhhheKcXlGjxMFng9QuVrIrRiWL6U0Y/MzUgEzbD5lJ4rILRAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8RGqgEI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8RGqgEI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f70c457823so5488505ad.3;
        Thu, 20 Jun 2024 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880367; x=1719485167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGs9rWGWnBXf0JakyBjz5eW1VzwyIY0EbVIiS0VC/qM=;
        b=j8RGqgEIHNT8YYM0+Pj3ik5I4eTIsAyKKMGBUQnlEAH634gnCsQ4FLWV1MQG4cwLLc
         C/JgWPUhymsoSK5O+qDSfCDB5vcGDCnjP2i6EjIMIe4H7Kar6b9qnolsDnT71gRVfgbK
         +vlQcA08W1vR2xKi6b/kDaPZmY53uQloatrmwgWmUknf9o/XPk9QhcEcyAxjgZB/X7FV
         0Cq1aeqOeG1k0dY77/8WwvN0mkZC9/z0h+UCN6BUJAFgCmfkImc72/ecVg78GSzvwF5L
         fVKu+VgasdACtESEtskHWsrEJkVBlFD4GDVuOvkg2tNsiFtqs0da8qHlpFnxF5N0vJt4
         rjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880367; x=1719485167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGs9rWGWnBXf0JakyBjz5eW1VzwyIY0EbVIiS0VC/qM=;
        b=YCw+6gFSgW6i7gmni0AiYppZWnfyiL7oSZyZAIx7q5p6/YAttIjQ0Jzj0aD2CuR1JJ
         UMk2j32tG1hUagR9xPH7N+6icnosKPpxqvw2JC+77apoSPf+IsLukf155TMysE0MnWUX
         j9Q9/FF7IDoLlU9qvAgVE41Ig26aUplnPjPqIzEHhc+WR9mZEbEMbAj4AjrjgwAn7MY/
         HG2TlLO3sePfzEsKxvOxmYecDptl98Xrsok6F3GZIQK6w9PZQrAk0DDUzQBh4qn+zQ1t
         3mf1GtjFMk/zq7II/jkRXu51AKT3EqO1rNXVnVRua6hZeTrkBKFUFVEmPAqCyGvrKXXA
         I/4w==
X-Forwarded-Encrypted: i=1; AJvYcCUCqB7ju4/DBxaUjNELOC3C+yhwkrQZQiBuYP7MWl+zfMGMlbpG9gbcjETIrWrmcAcsMYKtbxoAs68t/OK1ZPzgxxULUwCSA1jOG65o
X-Gm-Message-State: AOJu0YwwEnJf/7zCovkyogfp1oYDPxVuKCELJlHv2us72kr8Bigl88Kb
	vnXS1YVW1jjuc6qoTJVORA36Htv0tOj8EYYofW5RSRJBfmXlVD8C
X-Google-Smtp-Source: AGHT+IE7eQWMftzr/iHNgUtacrTeB2mKl/7MykViQTbGJuURCnhaZxHnhpsop5OeoPZLEaFjJqWDJg==
X-Received: by 2002:a17:902:e745:b0:1f7:1303:f79c with SMTP id d9443c01a7336-1f9aa3ed7b0mr55575805ad.2.1718880366964;
        Thu, 20 Jun 2024 03:46:06 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:46:06 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V17 19/22] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Thu, 20 Jun 2024 18:44:41 +0800
Message-Id: <20240620104444.5862-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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
index c6732187b70c..5c88b7ef60e2 100644
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
index 5d600f41ac50..5ac5234fecf0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -725,6 +725,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

