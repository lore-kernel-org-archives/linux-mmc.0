Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC013A879
	for <linux-mmc@vger.kernel.org>; Sun, 14 Jul 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720972663; cv=none; b=Pw8bz+PqgFUO5o/lh0zF1KrKFOtMWc70MMzzh8Iq7rSKzdtjJCl3/3jFrm38kV3dOKKIzqj9vzYc3RXXvdmKXPI72L9kbEop6+f2/G+qWpOLsnLqOeEnC7IIMaHUzskBUBSV0JSIKvO43qOhHSf894zz46aMeDC9LIxfwUUTA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720972663; c=relaxed/simple;
	bh=q/R4Npm+7Yxu7qPIoV8lmKcaoSGtU6a7Ch9HCBpDAKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gGK7RkQO5VSCF1WbXwfIx8BngdiRb3edd1F7ZUvGO/KGYnjdqB8HbChhUr8bMIAAva4p0PVfi9C3MfsksUA/1BjmbQV2ipl68afBYeGvfR0DrB0VbiTAYiZ8hmgQFrbuXYkRdowW4iD/YqqGz9lO5V/arjHnUQGBSnJGOeA4Wz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=B91v7p9M; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="B91v7p9M"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c9715cc5c0so471140a91.0
        for <linux-mmc@vger.kernel.org>; Sun, 14 Jul 2024 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1720972661; x=1721577461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEifdP9zkqLWnpE/85v9q3k5f1zL/8w9Hois4rH/O4c=;
        b=B91v7p9Mfr12BZoR40kKyqHDe4heESFWHlyjXJXgDcKCLB4DKlT1aTUu0N1rF3tVVf
         Y0oT4kQmDqn+0tTx8Zl6laxw9JlpYOVO8wWB2F2EFnpvaRppa/dC/8cksxQajzrrO3z6
         TgV6Q2HHFA92aUW1lms1g58f6t9R2LLOM1nUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720972661; x=1721577461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEifdP9zkqLWnpE/85v9q3k5f1zL/8w9Hois4rH/O4c=;
        b=tTybBruXUMPI7AcbvN7zaiIapVb/jU0s6yFPYGCSAFyLlU/e9CT4IlMAOutDYGL/UN
         IBIs7e0Dc4h0YzrsCokRnL7XvhPMuprJzOPcHEymLUpC7VTuHhTWLxn0K/9++I89m5vq
         cjwo76gf/rtme2p6nFndfKnjdEbul3h2JdVsAPZu1VMGJqb3fAVuz03LZK+uHr5lH9A0
         e+N0Y07yr9gIEo8074mmJNqZFdx8NvPC+JgDQO06o04Ck1wnI5cDU7FDfDRLv5Us1OKy
         15FI3TfSLnfr4/CuLC4KuyXm2/pWXqo/H9i5n6W1nPOxNvGdKJlgcghPrvgAPStCFf/v
         wdbg==
X-Gm-Message-State: AOJu0YyyTfWhH8WIvxc8dzFDlUEGP+QfqeFfxkMpUheIC7iiDpjNeCmG
	k78CuK7pj4Q8Vw5Evzx+/FYKICKPNVinwwEvBh1T70JnwozrhDTM/jGlY8pGXBs=
X-Google-Smtp-Source: AGHT+IF3M6mHi36gpG9PmGgIYWXeNisyK7bKgdsFdp1due/hcU2FRUjQ2ZnLCqT5pA4MBBRkXTrm4w==
X-Received: by 2002:a17:903:244c:b0:1f9:b35f:65dc with SMTP id d9443c01a7336-1fbdcc44387mr106328685ad.6.1720972661188;
        Sun, 14 Jul 2024 08:57:41 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.120.71.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc271e2sm25211715ad.168.2024.07.14.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 08:57:40 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] mmc: sdhci-pxav2: Remove unnecessary null pointer check
Date: Sun, 14 Jul 2024 08:55:11 -0700
Message-Id: <20240714155510.48880-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to check for a null mrq->cmd in pxav1_request_done.
mmc_request_done already assumes it's not null, and it's always called
in this path by every SDHCI driver. This was caught by Smatch.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/9ddaef2a-05bb-4fe7-98c5-da40a0813027@stanley.mountain/
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index b75cbea88b40..7b957f6d5588 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -126,7 +126,7 @@ static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
 	struct sdhci_pxav2_host *pxav2_host;
 
 	/* If this is an SDIO command, perform errata workaround for silicon bug */
-	if (mrq->cmd && !mrq->cmd->error &&
+	if (!mrq->cmd->error &&
 	    (mrq->cmd->opcode == SD_IO_RW_DIRECT ||
 	     mrq->cmd->opcode == SD_IO_RW_EXTENDED)) {
 		/* Reset data port */
-- 
2.34.1

