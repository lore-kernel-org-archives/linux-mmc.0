Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AC4BF928
	for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642268; cv=none; b=sR0OXpJamtr95p2zu3lbLommbzoORhye4t6IwvflqGwIz8GAP5mAHQjfYJhFN2RvoBbHaWmNO6Su0U0MjGNDpDVK3yIhqU4seuZBznDVFfTA2IqnlxNdxWhT0ROzH6WMfKjxvGEqhrZU8YQfs2R1OTgtE0FPhjBfWhEZ8JEbdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642268; c=relaxed/simple;
	bh=OPw/566jcwpxyFjIrJuM3j15WZPpw2mE9zAI9GuCzW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BP7CFCvNENq/CjstKiboFJjB4u/Pmgb5o5XDIXirIOyj3Cx5Wd5oZrgVmtvqDswJBAc+zCN5dHteo8eOzcp+7SKquK1AC49nnJeJkOsqnuoqmybjm+AzWmaiEnF5UPMJNAY3xSjCsrFAPa2wfBSt4EUeyD5Tm7f3QuD8ft07X/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za; spf=none smtp.mailfrom=ffroot.co.za; dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b=HtkrqGg9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b="HtkrqGg9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso5059635e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffroot-co-za.20251104.gappssmtp.com; s=20251104; t=1789642243; x=1790247043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P2ttKcI/Crva55MlOorsD/GD6bVbWeI8SLWwDhSgi4k=;
        b=HtkrqGg9TaBHpkRxMf1fU5RngsHMDT/H4Yt+Qr8RHA7ysqEVV0noHE6ebQtnj0gUkm
         ckIUEsxtv41lZ43q2JmvnoPp6TaxTtIcgb/KbFWN8jbDLBXXnG8tIP8uJn6Wmc15JN9m
         sB3UqqP+0qO4tAefs6KAWyAHlMyZUuHZw+Mv1A6AGtmxuDAQ9moCI7NXeEAzYUPDGaZN
         dPyX7xgLp3xB+qRGvA3PHbuPrBQCBTeDMacSQ5IYRjOK2uu/aANjVUG98CC5SldK5R/+
         yO6Ox2cig+KwCj7QZixTi2SWjAqEmP1srlB6uXiTdxsm0LsTGj/yGg3fC8rm46q7vkYP
         jcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642243; x=1790247043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2ttKcI/Crva55MlOorsD/GD6bVbWeI8SLWwDhSgi4k=;
        b=fMxfzogMq6Xvjxb2HJy/9bCulNegupp0j0wADjcjYvfZIt7WVZci/N4STK8qLqpEBA
         3wTbe7cP5vQgeKMHrq4CNjxqWDHDfs9RQcuHPVQAYESM8/9sPIlEcXk+zeHx5o7RosLa
         F5QEuzrQ/uJFVmn0MfLw8X8HlLQcW90gCi/mhvNMdm/4VGbtfa/TfdSFvhIOOWwhaqBu
         +Q2w12jRAUuOG3bRDI7lPd0V3brbQUa8IoSM4x9rHy7yHPrvPwhQb7I5kRPY/BeCKuiV
         7nMH7DtQCWhPe4tG/UZ+hWc2nBdDl2nOjmHj1jiwvBXG3VvuUQUX6tZ1nEKqGAVTLDSR
         eKWQ==
X-Gm-Message-State: AFuF++njOixduBf2RthUsmrW0pLd2yA3G1s0VIp9oQaC4bfDbfSHDZkf
	l19BSw+5OdofgYl0YZonQMsYTpt58J8W9OYxUdeVRYSVSijDM7w46lieG6YKteeOIAvyjEn/kA/
	sj822x+c=
X-Gm-Gg: AYBFou2kisWty4PPZ8QglLJne5hTiXvSlNfa2FpFJXkdu/3rFxvqCQj+yZVaNU6GHUq
	9gbkXSUy8ruX72R+U1t2rRNt9mCls3hEx7S9JJgfL2Jndx8MDqaVHM9BpsxqVZ8mkKCczW/WPl6
	lqBOQOqPimMSBmUAfcwqnM0n3x8o1fMQGbQ0YVzkZ5Aa3ueb6ARdQKHWlSNFSeNzk2TG7VilSSZ
	9gx/kG/fkAOSXvDexvThmM7eo6fIa876LZ/PYO5nOVPcIG6Y5gR2tLHH8HCajlMsTi7oN1oeoK8
	Z3HR2hvlVmkuj6Xwgc8bu/Tn3w4blsoEYe3C01zGy7Trbq2uAPT2CYG7K6N++3KcESLEtZs1LlV
	yI42WUTFjjxYf+GPjYzwNazLesWnk5yV6QbA0QWAJaMOhnu1jOstKnOeXfxoYxJMCfzhxJ8jwby
	jsvGa9fOs/uv2XP0digWe19h/BH8WG+7/sJEnqwTYQMzqa1Rx2TQ0cfrOWEMjxxexOmNuzA6VYh
	L6q5KTpLnTZJQzAWl2wWUeAxnsOmWUtr6Ti
X-Received: by 2002:a05:600c:1986:b0:49c:fa20:cc04 with SMTP id 5b1f17b1804b1-49eb732e404mr75469295e9.27.1789642242843;
        Thu, 17 Sep 2026 03:50:42 -0700 (PDT)
Received: from dev-ag.figment.co.za ([192.145.132.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1ce79csm74632435e9.0.2026.09.17.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 03:50:42 -0700 (PDT)
From: Andrew Gaylard <ag@ffroot.co.za>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	tonyhuang.sunplus@gmail.com,
	lhjeff911@gmail.com,
	Andrew Gaylard <ag@ffroot.co.za>
Subject: [PATCH] mmc: sunplus: initialise rd_crc_dly=1 for DDR modes
Date: Thu, 17 Sep 2026 12:49:59 +0200
Message-ID: <20260917104959.662433-1-ag@ffroot.co.za>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After spmmc_controller_init() resets the controller, all timing
fields are zero.  The hs_en path initialises the write timing
delays (wr_cmd_dly, wr_dat_dly) but leaves the read side at zero.

In DDR52 mode, rd_crc_dly=0 causes the first write to fail with
CRC_TOKEN_CHECK_ERROR, triggering the auto-tuning retry loop and
causing a multi-second delay on the first cold-boot write.

Set rd_crc_dly=1 when enabling DDR mode to avoid this.

Tested on a LTPP3G2, booting via eMMC in DDR52 mode,
on linux-next-20260915.

Signed-off-by: Andrew Gaylard <ag@ffroot.co.za>
---
 drivers/mmc/host/sunplus-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index 63279760239c..e947c84eef94 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -294,6 +294,11 @@ static void spmmc_set_bus_timing(struct spmmc_host *host, unsigned int timing)
 		value = readl(host->base + SPMMC_SD_CONFIG0_REG);
 		value |= SPMMC_SD_DDR_MODE;
 		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+		/* DDR mode needs rd_crc_dly=1 */
+		value = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		value &= ~SPMMC_SD_READ_CRC_DELAY;
+		value |= FIELD_PREP(SPMMC_SD_READ_CRC_DELAY, 1);
+		writel(value, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
 	} else {
 		value = readl(host->base + SPMMC_SD_CONFIG0_REG);
 		value &= ~SPMMC_SD_DDR_MODE;
-- 
2.53.0

