Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB542470E88
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753208; cv=none; b=SyMJgsyHlV0D6/QE3eU8l6IKz6Xoa5qQpX1TGXV8UM2usFBscGLWFIU5X5M1p+roH52jNImNfalPGSQ/y3rNUx9Bxmnh/u2y6aWGBNNwGN+AtKtdNhFfZ9J9spT9wBEOObRrHYD0vsDkbGggd2fn1ikD85NvDF8K/tbyXwr1pQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753208; c=relaxed/simple;
	bh=PeXIOyKaz0DZ+WMcNZyDsJa5j4VZrPReK3DmaeFUCAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7+dcqMdo8Y9LqUDDqR9jDFCLiNuW7tOAWwjSTgTkzJUZ4iKrEeGey6D7RjEx2uG6E8RJIyLUvEoiazC4c5eGE1jJYFPKWHF+xL5ogbUmqiDj332k/be5ym7qjKNByIMfSv5fm9eCh4NLp2zCjpkTeLUi2jaM4021a3yRH2cVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjTG4FyE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjTG4FyE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so12143450a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753206; x=1785358006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJuQoK2RLmoQOUtCApw/BgcLgmg0HJ6NIMU5JaCgZHs=;
        b=IjTG4FyEViUcu6/n7Gt8vB6balFS00I1RFHqHtRpXutCuP8ZHRs7tgljXsJbs6TrPo
         /oaaGBLDdan6OQzRNaP25Qi4ryHKGQ+D/WYmqYpSUYt+qC7s7c9WtsMsaxkqHI1CqUK+
         /O9nT8cTF+jZTdfNKDMBBRur597RMP9GbF5P3uEqGLeFK/pCIYWIvhb+Va4bqgrQFlEr
         d68o8h2JxkXVTwLdY0kE7eKoj0aXnHfxtUn/h45jeF0V19UdYGmJjAa/RONs6/ypi6g4
         abodHo14TmUddTG6TsxhuVJfAtgEo6AbdHmECJunCrg0++MieQzStVMePoVsAwq7cLZQ
         tTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753206; x=1785358006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJuQoK2RLmoQOUtCApw/BgcLgmg0HJ6NIMU5JaCgZHs=;
        b=kdawcdYoOEBQDsOnFAPpHS6BpewkKtqtaBltPneKDA8Esu1mfoW1g5FtCIM7nPJBl7
         cBq6hqdZC47yZ77Uw9AtHVu47vqhkabB/fcMFH0HrUFjb6nMZILknTbYiwsP97iaI0SK
         28km27tU1kCxS8+XEyciLUcTtRXWiKF91rdyo6hI09CMkl7DkN0M9nOB5ucanNLenW84
         Kd9vmY8okMDW7aET2RGANyNTqMR8/XO/Nm2RCtRTPo6Xbua1hWXi6QFaIk/hX+YwggEj
         FYrzWIAtG1Dtt8/l/vDy3NcHuvt8Hspr3tz6aoTA27sY6ZIimPHqGUA5uaL9S86GFp3W
         cRog==
X-Gm-Message-State: AOJu0YwtONIO5ARQThEtOH+6d5xksDrVGJ3WNLSiS3S7TThLnDRJL7wS
	9me48jjHNjWtlkr2XJl7fHbW7v4sQJQLrVSnDGfU67CM9XZtCukxfMmK+YQcDw==
X-Gm-Gg: AR+sD129MAaEedC/CEjuZLWwNGMC3NbCllt0BlveDxld09YqPWDFgaTY79SbY+hQQsY
	vXNhamf1l6zSU78xfbZ82vKzbcU0tfFFDzDk4Ef4jzz4YOi94k+sYMDGSnjnUpD3fpBD4uF2FAS
	HEDdw/06Z+XNUsEhZfYYYfajUTUPNFqZFnbFIhAn9Nztp3fpmCKxnQI8fmDsH1yfWNVZoZ9XNqj
	Z7++OBbWrD15qTCYU86PPUM4e6bIU2D4mVUdTAdNuA5LWIdmMaVGvM3fh69LKvrWjQaH+jT4iuj
	WhSWm+Wf9tW5uVGFYXC6DAZDpaBnbCQoNI/6rMVA9oH1DzCTLsi1mEPcEwsTq/J0toRtnlRmVzm
	LopFug/t+TJ1ZrsnqTFwjjQhjSIVCCkhSLxpUaTC3YmDCUrzLfsxjIkDGZ7XbtssCGAaCo7SGd+
	aBxqLZuc+FXvVtLtAQ6gOaxmHFfIReWWOZXcylmc0+GujovZ69YQl+DnNCF11Oh/Vof9JmHdOmC
	ZxpoDF3otM3s4vpoCi7aywg9A6ZVOGUZNCmcU3oqeQm0KQgG0JJzIY=
X-Received: by 2002:a17:90b:2583:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-38ec6529677mr298971a91.19.1784753206027;
        Wed, 22 Jul 2026 13:46:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e921ac370sm3840599a91.17.2026.07.22.13.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:46:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] mmc: moxart: use platform helpers for resource and IRQ
Date: Wed, 22 Jul 2026 13:46:43 -0700
Message-ID: <20260722204643.502879-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace of_address_to_resource() and the following devm_ioremap_resource()
with a single devm_platform_get_and_ioremap_resource() call in
moxart_probe(). This requests the register region and maps it once, which
is equivalent to the previous devm_ioremap_resource() behavior, and drops
the now-redundant separate resource lookup.

Similarly replace irq_of_parse_and_map() with platform_get_irq(), which
returns a negative errno on failure (including -EPROBE_DEFER) instead of
0, and tighten the error check to irq < 0.

Both substitutions are equivalent for a DT-backed platform device. The
remaining OF usage (mmc_of_parse() and the of_device_id table) is covered
by already-included headers, so linux/of_address.h and linux/of_irq.h
are dropped.

No functional change; the MMC register window is requested and mapped
exactly once, so there is no overlapping region claim.

Built for ARM (allmodconfig + CONFIG_MMC_MOXART) with LLVM=1;
drivers/mmc/host/moxart-mmc.o compiles cleanly.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 4a4d8b19b18c..28aed13549a6 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -26,8 +26,6 @@
 #include <linux/mmc/sd.h>
 #include <linux/sched.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/bitops.h>
 #include <linux/of_dma.h>
@@ -555,8 +553,7 @@ static const struct mmc_host_ops moxart_ops = {
 static int moxart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
-	struct resource res_mmc;
+	struct resource *res_mmc;
 	struct mmc_host *mmc;
 	struct moxart_host *host = NULL;
 	struct dma_slave_config cfg;
@@ -565,30 +562,24 @@ static int moxart_probe(struct platform_device *pdev)
 	int irq, ret;
 	u32 i;
 
+	reg_mmc = devm_platform_get_and_ioremap_resource(pdev, 0, &res_mmc);
+	if (IS_ERR(reg_mmc))
+		return PTR_ERR(reg_mmc);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc) {
 		dev_err(dev, "devm_mmc_alloc_host failed\n");
 		return -ENOMEM;
 	}
 
-	ret = of_address_to_resource(node, 0, &res_mmc);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "of_address_to_resource failed\n");
-
-	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0)
-		return dev_err_probe(dev, -EINVAL,
-				     "irq_of_parse_and_map failed\n");
-
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	reg_mmc = devm_ioremap_resource(dev, &res_mmc);
-	if (IS_ERR(reg_mmc))
-		return PTR_ERR(reg_mmc);
-
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		return ret;
@@ -596,7 +587,7 @@ static int moxart_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->base = reg_mmc;
-	host->reg_phys = res_mmc.start;
+	host->reg_phys = res_mmc->start;
 	host->timeout = msecs_to_jiffies(1000);
 	host->sysclk = clk_get_rate(clk);
 	host->fifo_width = readl(host->base + REG_FEATURE) << 2;
-- 
2.55.0

