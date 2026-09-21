Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77833511229
	for <linux-mmc@vger.kernel.org>; Mon, 21 Sep 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018021; cv=none; b=W3AZykqhzWqPndeWd3rMM4iN/PeWvo2f+AZvhWo8mCjK90hN8DISqeq32RAl3Xso6XhQqOyYO3flfFxZubmrJnqVkDYiHTUfnB6PB1MFqDhQPTDNj/SrFTY+fSBpBkAvoifPWHqXLbPFakiWMNUegvB/5N8Z+oy5nTypM5aHmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018021; c=relaxed/simple;
	bh=BQed6cSp6vzZ+hQ7oZzppKqdBjTyFHm3lTjQIjKB3r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9x3MCrFXW9593y34v//kDvKgAg1iPIXjhhw2jwGFJrCjPBNLhRSQvY4FJmPtpqYTDvBaPC2xirodCCZFudRZnfVziNkxpXHYhcnHFK2Zv+4+lZ80qbMjKeoVv8H6GFKl7bCRpEgKErEBTwF8AWsR6WOc4T1OOPsHSNEV9Pd1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brivo.com; spf=pass smtp.mailfrom=brivo.com; dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com header.b=Kgsg4t1Z; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com header.b="Kgsg4t1Z"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91071ba92a8so18882216d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Sep 2026 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790018019; x=1790622819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgouXHW55aIbAEz+yxgGnRtHE3IVMg92WaPFZm2OsIo=;
        b=Kgsg4t1Zdkldb8+wEiTC0LBrIoUsPeYpYmPcEJBuB+C62al6TsPDqHrqTR/zABHqGl
         Vegs3zkbxCmuhnwN+HQmnD3k9G2Rrmnxgli9jWX/m35wbcC11eVyGIVHWp2h4ToI8QtZ
         5vwwaH1ioQPhozngNOsPB+i+wsNdlgVd5DJKD0vqVMEZCUnZENAUCmovoisCbIQLY0jP
         ZM4cTLuco2l+1s1iRIQWgGmdD4poIwXv++T5UcCrkrPx4Z1uggeMNhOZ0Kz2g9DT1HWu
         0ybE3sRPDvX/0+g74l2YhpxoRPMO42QX+kiv32fvFICQksKsWNwUY+MAgjHWqmVbJITV
         Qz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018019; x=1790622819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgouXHW55aIbAEz+yxgGnRtHE3IVMg92WaPFZm2OsIo=;
        b=MMiuxNcALc1C8lYZAbfp3LaR6XxnRzDQSEl+F4WU4zTNnrES9NuLnkWjH3A8DwTRr2
         VsGJ07VCClTbjM82xAHBQfzoLNhqyRBJdJqlmnHJF7ss6JxM9kZSgNrUMzq5fee/Hjxn
         WPqvMzgGAXKKsh9H3jtHU3hwC8c9HUig2CE1PRy/abeEXXveSp2X8/EfR/xwWzzA64Bd
         utzvxZY6gYlRys96Zn86q6T9mu+uikA06db4YFt4Vu9c8ROnIUuFOZkZhbDpTAXPWboP
         k6rNlyXeg54qzYBr+8aWDP7pZOrmp+h9BlUWWXpeC2oO19hRCXWzjOaytfXaQToMyUIU
         8QJg==
X-Forwarded-Encrypted: i=1; AKwUvBxRmWGZ/2xIXTdMyc9l6bP/Ab7Xk57Dvpm0FhG36BI9IIBjn+IuhrSAuxRvo+5uDC+rSIuV8atYRL4=@vger.kernel.org
X-Gm-Message-State: AFuF++kOWlL2LEESow6q7tu+1BwriyS7VscKzeFc+/pwzu16bo3Dcmv9
	yhQD73E2nxp8Qkk3AN1zuYCPvhkEZvI6oN9AhXeRUBk4575diiEINm2Yg6HXFWy+fNhmz7eUPNM
	1WmPpMdhfxJUV5FCGuSqzUDznD+pe2d9rWEp44UtfXGcY9bPDlsShABs=
X-Gm-Gg: AYBFou0qIXobWp9xHwQDLueiv8MiAI0xJrb/oqToDTdIDQQ7Oo+TbIK1ZRAIwifqDRd
	jaiPTbrHyJf/Ge3Y1xKsLwwi3jadspA97vKee4FUc5Gkhyw0Kg+sKsT/LzN878mtJ8p1jkGGWQv
	2Aqty8S2QWPEjkHJkMB2pVcmMEY4mq8A3K6qe8HcHooA786K8QeKqseslgrkgsDSjdqbzYv6vio
	kMVA6N9Zycre3yWB739aGJnjkfRLxVaLS3SzOg1GMR9Gv4+LdMUkvmpNHAputKaHLqbiyPua7PE
	OGDeczz1mi/r5tpck28ERv8rwgfWVCDzev5g9YNdh/9Bl9MojQBgb8o+TRlpPr5Gg6YG3pvxC1Q
	qzkZEnWgZ6IoyM2Vcq1ToZqANHHJta4RfYxWzVkRk2kxYu8MO4R59AJ+Cz3y+hOJyryX464Z5+u
	uyb9XVy5QQdNnLFi28MeUUxM1F91bt4gc1RSHQczXC8z5PVilC5hhha3XVa4CofQ1KS6ZDkX3Vk
	A==
X-Received: by 2002:a05:6214:19cc:b0:912:12cf:f6b7 with SMTP id 6a1803df08f44-913fc8a23f8mr21513036d6.7.1790018019138;
        Mon, 21 Sep 2026 12:13:39 -0700 (PDT)
Received: from strozzi ([66.193.28.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a61570sm75443526d6.23.2026.09.21.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:13:38 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	Sean Anderson <sanderson@brivo.com>
Subject: [PATCH] mmc: meson-gx: Convert host->lock to raw spinlock
Date: Mon, 21 Sep 2026 15:13:08 -0400
Message-ID: <20260921191326.2146363-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary handler for IRQF_ONESHOT interrupts is always run without
threading, even on PREEMPT_RT. Therefore, we must use a raw spinlock,
which will never sleep (even on PREEMPT_RT).

Fixes: 066ecde6d826 ("mmc: meson-gx: add SDIO interrupt support")
Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/mmc/host/meson-gx-mmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3f..d5365c0404cb9 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -176,7 +176,7 @@ struct meson_host {
 
 	bool needs_pre_post_req;
 
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
@@ -953,10 +953,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	cmd = host->cmd;
 
 	if (status & IRQ_SDIO) {
-		spin_lock(&host->lock);
+		raw_spin_lock(&host->lock);
 		__meson_mmc_enable_sdio_irq(host->mmc, 0);
 		sdio_signal_irq(host->mmc);
-		spin_unlock(&host->lock);
+		raw_spin_unlock(&host->lock);
 		status &= ~IRQ_SDIO;
 		if (!status)
 			return IRQ_HANDLED;
@@ -1112,9 +1112,9 @@ static void meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct meson_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	raw_spin_lock_irqsave(&host->lock, flags);
 	__meson_mmc_enable_sdio_irq(mmc, enable);
-	spin_unlock_irqrestore(&host->lock, flags);
+	raw_spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
@@ -1225,7 +1225,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_init_clk;
 
-	spin_lock_init(&host->lock);
+	raw_spin_lock_init(&host->lock);
 
 	if (host->dram_access_quirk) {
 		/* Limit segments to 1 due to low available sram memory */
---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
branch: meson_mmc_raw

-- 
2.53.0

