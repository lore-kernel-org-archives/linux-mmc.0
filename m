Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2833F8B7
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157325; cv=none; b=NOO9OaTqfDUsDVz79OCIjiwf3G4s0P1SytDwnWhi/OHi7rYIQ++Tpi/TOgPS2g/CNIgtIqymIZ0BJKuVn/abQDl2pvZPtjtydd/gLsOcpczOUvO6iZp1bNYgSAsp4hgBcNkJ+dO9GiQF/5zeaF/JPuKm2xBZzxv9lnWLrIzOAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157325; c=relaxed/simple;
	bh=BhBy+S0HeAqMqVD0vfTgVyzMzn6TzF9an+zKeggyjho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvYqkfgpr9cQM3/VJPXGyGQtNbweUgxoeUHmDxGyxsjkxDgwnCQp5DShe+9t+3bR2FF8aSvyBMV/8Ug8Zn0Tz3ZtobeX93UG1SHUOw5CoAgW7zg7DOwXC65FsT3p6blWX7o7uVxSAbkZG/f/pL/8D+hkpCclFIN3NzTFARsO/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0tVdjdD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0tVdjdD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so90598315e9.2
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157320; x=1780762120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPP3Gc7DbsXSkC2W1JsK595/iLwnbQR3mPGG4AseLmY=;
        b=M0tVdjdD0SgY3nodBIAp6NbzPbyDUF8nSXqpOsHV0JfOoMSyhey4r0XkQfBhEWVq4L
         hJwZ7LNP2EWudyRx4uz9y3ba9udM5fNJ7IC79vgKbms5ynqqwirG+Rpn3C4ZcRxN8bz+
         xU7rErewuM2lykH/MiWyFF+Exa+cZtVuPtVRNB44Q9K88oG3fn4uzVrpOrUC1aJJVEDU
         VXRjZ19+23+QLqDPo6cI9dfgYvf60O5LR/8IoE71CtO0OAB2nbcrwoSxTMdtJjmCAOoD
         bJCyPsY+rccSAOLi+9s441FCz0k+koGhQ/LQlF5PtlY1k7sw0w834MGX/5aguIysu5T9
         e/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157320; x=1780762120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EPP3Gc7DbsXSkC2W1JsK595/iLwnbQR3mPGG4AseLmY=;
        b=XDC3IRHUBS8ZCPOmZ0/roGqhT2J9FJ5wTViNy22iZKLLrBKt2BQOcY3iuHJaivoBiN
         FOmdEF0W09Q9ON05VSaQ08Yf4fwmYbDmthLbQEpnk4BQTLB0kCFKEM/Cy49CL16Y4wOz
         7PVsM8mIncc75jcidWyVslbVSDiRbf7K1Cu3r1Vvp6o5RVAD37Im/tAJbJLiJttXoBKB
         8V/Jkx3gmWVImZgNJqbq05MRkf+niEYT7BWAnQIhVeBbp+wmpSf4UM5VC/DofkcEiBFQ
         CuSO1eTcaNWiqWliXMf2MUpiw1P6TMv9pjE5B4op2duSa2nSOCIvOyvjdKiH7iFmLFoo
         DJhw==
X-Forwarded-Encrypted: i=1; AFNElJ+y+MCb16J7i7/6Wo+j0tD903OzepVrDxvOjFmKbMfCf7PA4SeVzdkPud9GQzmK7RCZf9W+eB4cgGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIl5XvgAtfOxBW7mbLZ8zRE/n8dX4eQOQyDf6rSLLzHWz5ZvN9
	F5RuLe68hTcbaz0NAzonPCLfgICHgQQGInZytc8ltq0fVly7jOPi10Sd
X-Gm-Gg: Acq92OFdqDOeyNYMMHuCHfDv/6CKCDPmscqv08OwrzRvtiVMvqcGIPI+pDCXMYLb86L
	VgSa/dt87o9O2p/+RBtc5jfgyhGBRZDDYQB1qX4OrY9aWYyTVgvyutpEd9OEmw1dmJB2uof8mEv
	ypRxNDn0923jbgdP9wSZ0u6qVl5tRNRe6268VQXNDKMIqzCpw745kUUFs9TJJFFQMuLcItRFljb
	wDmM0k1/+PvB94Wohr8wt0H/DlA9uMZEENIQaZePfiA6X56hi9dAOZUKvKzjcnhkHqptTCNMVqi
	oXWuX6BdnGUbZu06sRn9Vvpwnq4Nrr1M6E74XkYGj7LM7rKmpRxkPCPfMCROg5eRA7kWGxZXYXB
	8FDA2SXQ2wM26UntIOTLyvMStFv9bFmncRYPjhMDwEx87uAg5HCsuUYn3jxlVipuPZ7iQkx94TX
	ZmFrz1ZHn66hJh6LMiBwIdZt0IWSYB8iX+KHdNLHLj24wNPhznOKNARclVQU4=
X-Received: by 2002:a05:600c:1989:b0:490:5655:8d3f with SMTP id 5b1f17b1804b1-490a297d462mr81500585e9.28.1780157319627;
        Sat, 30 May 2026 09:08:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:39 -0700 (PDT)
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
Subject: [PATCH 12/17] mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
Date: Sat, 30 May 2026 17:08:06 +0100
Message-ID: <20260530160823.130907-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The SD_STATUS register, specifically the IOVS (I/O Voltage Switch) bit, is
not automatically restored after a suspend/resume cycle, causing the
regulator to report an incorrect voltage on resume.

Fix this by caching the CTL_SD_STATUS register value in the renesas_sdhi
private struct at suspend time and writing it back during resume. The
save/restore is only performed when a regulator device (rdev) is present,
as the IOVS bit is only relevant in that context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h      | 1 +
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 6c024e7f69e1..10f634349da9 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -117,6 +117,7 @@ struct renesas_sdhi {
 	struct regulator_dev *rdev;
 
 	unsigned int divider;
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ee1b1f70c9e3..974acdf110d3 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1379,6 +1379,9 @@ int renesas_sdhi_suspend(struct device *dev)
 	};
 	int ret;
 
+	if (priv->rdev)
+		priv->cache_sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
@@ -1410,6 +1413,9 @@ int renesas_sdhi_resume(struct device *dev)
 	if (ret)
 		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 
+	if (priv->rdev)
+		sd_ctrl_write32(host, CTL_SD_STATUS, priv->cache_sd_status);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
-- 
2.43.0

