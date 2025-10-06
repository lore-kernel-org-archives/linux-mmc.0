Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42C1A9F80
	for <linux-mmc@vger.kernel.org>; Mon,  6 Oct 2025 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759714639; cv=none; b=mIYGjFsXJLemiPgB4EemHxn+b0bjdfAOrdKRchcqL54P6nEvGt6VJBlLJBVagd4+pGnhBMDCU2jEgI1xbaemsArQ+bRO2KRRbTb7M8vR+lKX2fjxE0jZufLQZ4uzg6TzJGyKVik+4QhyqLLsuWtzRDN8O2/dMyqlCVqQYHfU+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759714639; c=relaxed/simple;
	bh=8vb78HgLflfOFaCJ1SzwxhWOvrnKvFy9/Pw3SIfHYhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3OoUbq/Lk8i2Wr750ZcpOGXFdc8qLOJ2RACYqOixsgTikl/QdLTgos4lmNyu6pbHxNQ/5mFNVlvy63GGV+jKzsjaob9rwCOnKIxDIVgktkcmrz0gyD7j8ujmjCZ4mO+DamqOoDW65dg3/EyF1maE0MH04FFXGlKy/6Dz2tFUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brrk+DBC; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brrk+DBC"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7b24b58c742so323406a34.0
        for <linux-mmc@vger.kernel.org>; Sun, 05 Oct 2025 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759714637; x=1760319437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qqs5Ij+9qF2GYjJfsvIYV0c8RAhcOS3264WorTC2CQ=;
        b=brrk+DBCZ6QNiQVbmKjmYMqOLb90Klz38XAIjDN5EmD8VWLuvo5e2/lOphvjvecrXS
         R62ewoLo+xYt/VUXdvr87bMBPVkRSvXsA952zQtYLU14GpE22SthUTT/P/i0L8QhkI60
         JMtZ+sA1r7w8t3qH0A9+Qq5X6LgsaW6gDYBQp+XkpSu59j7GWWyrTNb515fRDIGzxYPS
         rkFYhz+7gGPhkgeAeeB6tofu7H/3tyenVm/qmJzpq1D8uig4GKrxQub2N4d5oHToeCD8
         9hbEthDKSwJNaqcVTaKowEZUuobHn+1EwUm/YZByHyqS75oJjS8IQ1OcBInwO7Blbrdv
         8i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759714637; x=1760319437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qqs5Ij+9qF2GYjJfsvIYV0c8RAhcOS3264WorTC2CQ=;
        b=G1KlXhRwluYEM9wlAu6B6OkljLty0DyhpuIZU3M5UBR8zBBUctF87jLxUKsSCWB3i+
         BPuzRBuqXVnADzP5B9KH0pZoKvOo1TDzSIokjE4c4IW2iE93ZurTuYmRCuk+PLdXEQ3J
         CX6nd2+w/bKpo/HzzzYKrH82m8WO6RrS6TDE46U1chIWYiL2UEDG84FBzMWVwH4dDagx
         y6WD4SXn4/Dgq8m7mTOotODMojBaMTDgHqRC12pUF1a6J8foLNQHllCKxb3WLvxzPNSR
         +damwnKdw0Do66p4K9uMCXiZUXveDj/E8bdmPJWEjc94Qa1VWqPXVC5XOfy8lyMHpzdS
         FPkg==
X-Gm-Message-State: AOJu0YxmTy/KcE6oR6Ft6hQhuCgC2tpGLuxY74BCcuRQSOafijt5oCNA
	Y4RqeWQ9W6SYTQ3wkRURKH+FU9CDngN/nNMX+ld9rhszzrXFNvfZxBl4
X-Gm-Gg: ASbGncv9eiHjpNuAnPgVLqcDXK5O83GkAt+Ir2u116t9Rx/ebnHTE9bDoF72MijAnAV
	6uJ2LN6nqzCDFz9cNEKzarCJeXdPQAri4iTm95Dx9nfVft9yQ0Gl4l/GEj759MwUfJ3iJaZ/yeM
	8C+bjQlKIz0aHkcFH5yu3q/6QwEvMV9eHK6czMNeDvoi7bRGI/PRC+a9v8ojAKfaiFMfCKdJvdQ
	MoCADa+gA/a/+38sKaVtIRAr6L8reSK2+oQ//IsPOafiQ37E4xSNSLGTRjYFyNLJS83KZahxocd
	nJ67o5JYrEKCQy4NXG/Hf9C9MJuoerXRv1J+hyByVJ59zcm70nIW/64slb8k+pGMCcf1tommoXV
	MmSsgvWyHBly9raRucC/NnYAZVszjOfEqpbbtKBN3YlU694OULurfSOHxHrom6RltIruDRgr/rW
	MpPYpLdzCP6gmj+J77QA==
X-Google-Smtp-Source: AGHT+IHAYM1xwlbULXHzAzvUYaszsHniF48mSz6Ui/2I7/3BZwTGS4Gyl2/hVMl7ZhiOuJTT1MOHTw==
X-Received: by 2002:a05:6830:7105:b0:7ad:31c:56cf with SMTP id 46e09a7af769-7bf772ddb3amr3505956a34.4.1759714637454;
        Sun, 05 Oct 2025 18:37:17 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcfb69sm3462870a34.13.2025.10.05.18.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 18:37:16 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Garofalo <officialTechflashYT@gmail.com>
Subject: [PATCH 2/2] mmc: sdhci-of-hlwd: disable bounce buffer usage
Date: Sun,  5 Oct 2025 18:37:00 -0700
Message-ID: <20251006013700.2272166-3-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
References: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the SDHCI controller in the Nintendo Wii's "Hollywood" chipset, using
bounce buffers causes the internal Broadcom 4318 Wi-Fi to fail on most
data transfers.  Disabling bounce buffer usage allows reliable
transmission again.

Signed-off-by: Michael Garofalo <officialTechflashYT@gmail.com>
---
 drivers/mmc/host/sdhci-of-hlwd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 5bb845d13599..59736ae85c14 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -63,6 +63,7 @@ static const struct sdhci_ops sdhci_hlwd_ops = {
 static const struct sdhci_pltfm_data sdhci_hlwd_pdata = {
 	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR |
 		  SDHCI_QUIRK_32BIT_DMA_SIZE,
+	.quirks2 = SDHCI_QUIRK2_NO_BOUNCE_BUFFER,
 	.ops = &sdhci_hlwd_ops,
 };
 
-- 
2.51.0

