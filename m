Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76F3FADE2
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469865; cv=none; b=DWlvSR09bpTfsC5f1PJp8oTLDzQYyEFA3MSYW3jNxhKO2eESLnD8Y21eXMlZbbGnfGsg0xrTrHYOYSvtoNPqOzkSNO8UqE8PrUykJYUMQwGuFTlfJ7EVFl42wkjnp2UcqNwDWQFU9CPLM8xVcq04TFnSNp3OkILMAw6pgAZZPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469865; c=relaxed/simple;
	bh=XviPFEdL+531yfoxPUGX/RIxGqB870L3MwG4Nt43Qf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJlgmIOTCS62NgmPcEigSMHo9UI5CpnkwecGDyBJoszobwp4A5F6ql0BB+b6HWkLdt0J6eAuBSFMygzWL57BCz5wI2BKZ/AS2J+3uBfc4uLWYnN9kE6fHpKKroDZKIKJQWQKFb6z3blOLph+o2yc55/cfmuAIL2p4C1xqhzBKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRXDMqFa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRXDMqFa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49041e84237so2480145e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469860; x=1781074660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXIHUWLCh3o2xpCNm6vz++jYpXPey1+/k/Oe4Vv3YwI=;
        b=lRXDMqFaZf2DdHSRoWzVkVE4LD1qe0y7GhyWVaYOd5f4IAGzrWFInKWLxsikBtiB8I
         WuQVB1maHWQiZkH/aC9mURMxkv1oY8G2LSDAm0jh39A+jRS4o2/FGl0AwNIMOGxWf4sc
         YKyK+zLnOkYF/qqvalGGyat55yysRXbDRGRpFW3uuS4qPoB2PBnpnD0AYJJ4ssWonaWF
         d5n4KbX4TUNQbzO+wREk3qsRvO7UQL1dn1UQUwP8CRoyGnmT+z1o8ZG2/hV4pDw6QAZ+
         v5V7JcDZi8p8uAwDD3tDfGwUU4IaCTvJrbaK3BqBP7qGjIxnOj71aWGNPpS8kVEHUqcX
         qHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469860; x=1781074660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXIHUWLCh3o2xpCNm6vz++jYpXPey1+/k/Oe4Vv3YwI=;
        b=sy/soe1dhJd0iDooPpdAlQ/nKs7m5sRd7M6dxN8kC6P9R6od0krJes7YyqMGdtlwxG
         64QYaOHwU9IeQ2S0Cvqtb3Yswj0IWV2kEARGKv+bJrA+Yy6W06tC3bFQRFcU5x34RtoC
         DLzSGqTetLRc4zMVNQRLKSVdCEGfXsXLtUvT7aK5JNMGM1HaPrW/SZALCEBTvENfhzYr
         atlIzCX7YwR3VSPpKg7SBdrYKolCrqi13+vhwBMu4aTvaGf5+9lkVTcJyhfejle0plBl
         SOycrl6gdq4rY4IsExpNHiIvEhcLVFDppIKPAJQphxn5fPNqLP33VcjAbcmrnWMhKsG5
         da/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9kS7hLByWaChqCEjSiMFhBegHfurmmUup9CRXeo8rzU2AtL873bZNnaKW/YPtD3Kx2wapTndR9nu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdvFwWjP+f25qO+FzI4aNm9j7bNbT6TxHEpAyYHkr68+6LrcS
	9SPQ7sT7Brl4fPr2gMMFtQ9nPK+aAypK3D/SI6IjZ/ThMS+PZF9+IaPx
X-Gm-Gg: Acq92OHLTIaoM/QQ9GNLaEQ329lBJowsSRa/73Y2UJedCUqwhFZbEU+c2Po+znKKjCn
	isG5ZosPlVdlNLO+8lKnE4FHM6cWVLHoZfNxW473In4vazbMobdO/rV/XhAOcfbh0pKff0uQEUw
	L76MqLCXq2KldESj4zkMqOokz+T1jWLx6njKu6odqOsMU6cYEGUshW7F/cSt3pqYOVgViIzJcln
	A5dUC/PkfaGwu1+cZbYRMcTj50pwwWhTq8BHnqi8sFyHzNajFPpD3jBOzHoZer7UZqYJnwvUYI6
	kEfBLA/UddtXLfOMzI+j4LcZxq+eAx9HgIKEeUToxf2j1Q/TxqmKNY7L9xrcdtqTrUJ5oH/Aj/y
	l7Em5t+aLPYAEVDWddYI+R4jXCI9ADB/rrGaHt6iEJ2m2WBBPFT7EAyirImTDDftteWIY2ay6AB
	KA0W/BADUFOD+odajPMbcLZj+c2YXzR5uAs69z975htR8m3PjXpIoo2UQttno79OuVUbQdtg==
X-Received: by 2002:a05:600c:8b0f:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490b6163925mr24119345e9.16.1780469860612;
        Tue, 02 Jun 2026 23:57:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v17 04/17] mmc: renesas_sdhi: Fix whitespace alignment in struct renesas_sdhi_of_data
Date: Wed,  3 Jun 2026 07:57:04 +0100
Message-ID: <20260603065731.93243-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Remove extra spaces in the renesas_sdhi_of_data struct definition,
replacing the tab/space mix used to align tmio_ocr_mask with a single
space, consistent with kernel coding style.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index afc36a407c2c..09bf9b24a8c3 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -25,7 +25,7 @@ struct renesas_sdhi_scc {
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
-	u32	      tmio_ocr_mask;
+	u32 tmio_ocr_mask;
 	unsigned long capabilities;
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
-- 
2.43.0

