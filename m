Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191888;
	b=B67imCk2mNpwjqaL3YuaCFvLLPqeSCpRnYBm66V4SZRTsp6FykRnjGm6vqYD2j7xeBFF
	 v6IvsDgijTE76SfzgfhMP3U35p8r5s+ZDlunY+/BfL0mm1D1ia8jYFNo+uplZtZwcMER+
	 0jDtWtL7XfRss/O8QczsonHl8GGT7thkL4ahq/iN6E6r+JOipjAvurofprxrLn1KzgaDN
	 pGY5Naz3Z3bZL35Tpc9OANSd5xQBtdJUTxeHphuxA84ejvZVOYcGbmMwxxkWl8CURkLTD
	 zRJMopBXFjmYLErbaKz07aOeQAVibS2ox7yWtA7Shz+AGfr38cqw9yE2fLkWE4zxudA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=A0WhCVlHTBDHeoZFEclyBLhFVHM0pG4iCtYLCGqW934=;
	b=n14Mi4Eg7enu1ChpO73g5aE/S6ZyQQe9RCuRbSLJRulCIWnRksLwf2U5NHFizh/eEZjk
	 DhmzgHhGSMqyh9uehf0f2DPR5A4Dl2eNrocEmT8rHu+7ApIgDmj6Jb+QWCbxnNnCbVg/U
	 sPXz53dLaJH6TLxFRolAZ5ZKI4Pw5+27XfEnHMPwZcRH9lobHwVHzzQP3OhUzvRwYbLwi
	 iUN/33svOepISZxqfAPBhnHN25UA6lm9rAvz0o99xlj4Zp8HTfUMJ+YQnoUMYvBjnq2eW
	 RITtcKf9zYi5fRG2+i+iijbk4xVvuVH07TNSnEnNBxwxwtklQtinDFUNTOw2kUFyAbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qddV/XTd";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FD60A2636
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E5FD60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qddV/XTd
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so7155695e9.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191886; x=1793796686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0WhCVlHTBDHeoZFEclyBLhFVHM0pG4iCtYLCGqW934=;
        b=qddV/XTdK2qf4I+nsRzvr3wxU4ipN3wSfOaPvLvujN0VGY6TuhUeop7kAQFRpwzkl9
         Yf5aKY2keNoA6WCgbAbm4FI/1bBHyXMjoaItN/pa/eKHvojIMsSOyLDw2g+kmWxvPIxH
         AUQtAHQP9GwKwi9dkQIFakQC2aXhlheQMlCVql/A7XTM0oOzmEnBuBOvofYiH+5LAgYf
         SWYsURU2tUsgKXBX5ZMyd2hjdPuMQ0caJ0JVjjLC9W/qlybIZJzv+v7PwxXmzmwrC3OR
         yj3z/HeAMNoygZG7Pb7Wo/eWefnNvUFhLtiHhdzE2DcnqyVDG89lsWMyC0OHoXSw6+Hj
         BTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191886; x=1793796686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0WhCVlHTBDHeoZFEclyBLhFVHM0pG4iCtYLCGqW934=;
        b=w9tNWVLRItXffc01aldhuqarwepUOxyykywpls6WolakM3aUQyPhlTY0E7l4Vo72rq
         M5jcplDdZmM2QEN7iMg3wR3bmncvJZDSQPyXzCwJ33N9d5d6XkGMd3j7MJ3nDzWLmsoH
         ClXHUckWQuIslF/rD66HZDuSVWa93O6BUVU0wR6QutmErmC95fe19/qDavEvtQ7f9jSb
         1nCYSFvSpNWtlVx7Wrbqq9cA2+ntxqHX0hSZsfYZDxe9NqZB8mgRkKhxsdJpPskOeI+g
         JP/Y91rTeiHPcB8x6h8hJr3ykrQec8zSsVUq9nxc5m6J1IEe/JvHS+SCcDPadrhNAINN
         psnA==
X-Gm-Message-State: AFq9FYLBoHP8b1h1kmuRoAWR0yIxePQR5QKU9qDCFh9ff9nM5DBr2GGf
	B9u50kVK/AeCpJHxg7fpXEDFdFrFtJ90ACoYTdxCcZXrJ/9OykONf7Dr
X-Gm-Gg: AYBFou0MiTY+Itk3FUFhF+cxGcXj9vbqkmibNkphee4e/HvNoQUFwNFiPitS4o3tbzR
	XGjlNp//ahcz1ftcGuros9qGLZXR5I7k6RGM6sRGFjK5Ssc5uQYfcyTszrOUBUJpmFr51OdKcD2
	Eu2PZVldqv7p/KboU/5b9Jt1+uGKZOLqetUbiwx870HhyIcbQR5VU4BkJLxg0r1n4tlynZuBMeV
	9ZR60MA1q0aXBba0pMVBXYQ4/Ogfe1q0ECISYAU35o8Xdx1idj5G615FJX4lPx5HddE19YhVrRM
	xWOP5sijgzaaX8xeE+M6jJi9LLV0X2KBiI5ODFc9+zMm5vKn5bU6HNVXKg8Q9qbaH0jCpQXSOdK
	jUOoLrsq3BpN9eyNzWgOQsqwuQuh+I1MPn8qTqv0R1yHsHyajB3wxOSolRtykK4M99yY5Cldlf2
	x4Ah8RiKmEdZG3bbHjGPgIEDYwnzFq1jUbtoGre9ncBUl8z2yARX3X6lVPCd6oD+JEB2qbM1429
	vL5HCBV4jCsUkFhR5yxyKNMCG/6Oi8STuA9Fq2CXc3kmzJS+Irs9kt7DwdwZs1SYfpufvfnwQ4l
	I9NR6Y96YxYSZ23vwjmO0sNdF5qhelfrsdAo78xOCq5s6v24KNauTOH2Bg6pczq7Kgs=
X-Received: by 2002:a05:600c:4754:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4a966c41e6cmr44785315e9.22.1793191885760;
        Wed, 28 Oct 2026 05:51:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6bf5:6c0a:cf99:c9f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm29275016f8f.10.2026.10.28.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:51:25 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 28 Oct 2026 12:51:22 +0000
Subject: [PATCH v25 05/11] mmc: renesas_sdhi: Add SDHI_SD_CLK_CTL_DIV1
 macro for 1/1 option
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-rzg3l_sdhi-v25-5-57f16691c2ed@bp.renesas.com>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793191879; l=1939;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=9RhLI0TxhP/BG9bZ8qAvVR+kroaEpg4uYm47POogTgc=;
 b=bAXkYzWXua8bUQGEteyij3DZYjtKacYh1Q67iPuZtWKoG75gYgMUt/1qBjXCnhK09UvBtY2Ru
 YRn+W+rsQbBB3dANNs6hNkWY56Xkbm3+Y8xpH8Xnmvw83OSSUbHDyQJ
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace the magic number 0xff, used for selecting the SD clock 1/1
divider option, with a new SDHI_SD_CLK_CTL_DIV1 macro. This improves
readability and self-documents the purpose of the value at each use
site (setting/clearing the divider bits and comparing against
CLK_CTL_DIV_MASK).

No functional change.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24->v25:
 * No change
v24:
 * New patch
---
 drivers/mmc/host/renesas_sdhi.h      | 1 +
 drivers/mmc/host/renesas_sdhi_core.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index b54802c0807c..b759376103d7 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -24,6 +24,7 @@ struct renesas_sdhi_scc {
 #define SDHI_FLAG_NEED_CLKH_FALLBACK	BIT(0)
 #define SDHI_CLK_MASK_DEFAULT		0x80000080ULL
 #define SDHI_MAX_DIVIDER_DEFAULT	512
+#define SDHI_SD_CLK_CTL_DIV1		0xff
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 74834e72f038..500ecc357095 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -227,13 +227,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	/* 1/1 clock is option */
 	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1)) {
 		if (!(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
-			clk |= 0xff;
+			clk |= SDHI_SD_CLK_CTL_DIV1;
 		else
-			clk &= ~0xff;
+			clk &= ~SDHI_SD_CLK_CTL_DIV1;
 	}
 
 	clock = clk & CLK_CTL_DIV_MASK;
-	if (clock != CLK_CTL_DIV_MASK)
+	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);

-- 
2.43.0

