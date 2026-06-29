Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130C3D6CB2
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717948; cv=none; b=qd6nVqw7S13v4vIeYnZBfmzjy0y6ZBajQ0y3Liwnn1m6I9TKbhqBwMInBAyjanMdSaCkdcMSHxHyadJ8ktS2GcgUtiipCqaqCDlM0KVYCmflBf5K8dkZL2dukzECB2DrgF3rc8iC0wzsBLoebWO9Inu0r07Iuk9CtFJ7fLYbdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717948; c=relaxed/simple;
	bh=iE9MKgjUREHQLzxDKoFspwkjqrGDnr1LZUcN5s/z3ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ3/IogECcB7w7CBUXA95mDAoD00+GrDM6bZbBzfSEDKhYOv6wj48IAhCTO+kfkbsZEsBSFpkIpH3urbjT6HxI9BGxAg+Tb0r54ReunTFxp0kkWKZn4q1Rpcg2BrIwE37zs37fXVY5ztQF+gKdaGCGbY5u6FisZWsoiwJdTRijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1oBE5pD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1oBE5pD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9b19bbaefso7384655ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782717939; x=1783322739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG2nXssE3SM50QO03yvBVPdn8YF5AsYA/cOB8cxHnaA=;
        b=M1oBE5pD6t5bxc1L1jO86iWCV/pASPk6AwptFHITsTlGI2scV8AHlgQZRcIVCQ3Z+R
         LPT2Qs4+EsGrt2sMajnfG64o77WeZ+QfbYgwbAKF832NiK/c/RYq37fFt+kJ5od5JOYl
         UPpQvrC/xjfpWrdYepRuS6J5XqeTp7dlYt4t5Pm+vZT1/k/5oBiEow786oQIr0ZrJlxU
         Tp307MyrRI1j3LBXkZ4Fv/JVd12BAQL3sgaLXlhW6JO4jVvbZLEW8UdmU/NG0qo6pcJk
         eKAEc0hE8N1c/eHRC6VW0JGUqGT465X6JNtYEnQY2LTZ5+m+R9+xyOzK2JWh0ZpluWLk
         vVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717939; x=1783322739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wG2nXssE3SM50QO03yvBVPdn8YF5AsYA/cOB8cxHnaA=;
        b=Y03kH/q7PywYmnaH3f2AQ8kXMhJPypp1cLkPyQLguEMcX1ckcLn+7gyZI0q8xZ0Mzo
         UPYXGGuP+zbNTT+/vJTze7ZX20N4yPdYfPsD/XPK3oAbyufH7nie/jfAeFqHaIy1ASeJ
         0WZXCqKPDbNPM7GrTiyYodTUoBEogKwvRoUIxQo2T7W2S5rHPFDAiOMC51GJYnuvQmoO
         14VEMv+qWnW9yRQZDzLOkB2bjZovEJ3YXy++bexOSU8gr/cCND2Rzzkgg6FewQijcfC6
         WPd91UOYRmsAnk1f/yGavVDRZ/J5cU5Yvk1QoFm/stCiTh5FMfN83hGgmZE3SHEOyJud
         hnzg==
X-Forwarded-Encrypted: i=1; AHgh+RpEX7fPd+P/5CvzSEnT+wI5xri5ICBen9BEHnorTON1piwVCeuJP0RP/DR2zrJFgIaU01KiYSELMzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhIc4WLx/roaC867Fu74Lgx5upbN45OE9q+I0j2jS7hFv36JHW
	iBrEHIw0POFYvFHmElKtUXKNUBvJNf8wdW9ML1OUCY2yi+cYoN6ZmN0B
X-Gm-Gg: AfdE7cnjsqfwI/fslNe0hlWg5QBhZTQsHLrr34DqYQ2vYPcu883gVczm3jUgMhfAysR
	aqgFP6Sz83hUMfOlsCwzuAOSoJ6b1pAvv1cSt44myMAzRcJhsB6kno0Y+udDpYCEfKeVlCKEjHr
	mLAih6kh/eGpcAl5MKJLaJfUJzdIlUBovf5owhoIg1m1J4uQhS7rbqN+5wzFo85efMcLQOe/gci
	5XyzeB8wX8SLkYwHM/pfznOoQCwrgA75Sjvo/V5HfJDeQpm4t4HC/J0dtK8ohYTRHx+fNnN5r/f
	Hp51wrmZYnMYmqir8YGi5HvrBFnXUqJ5oX7cV6ilR2bFdq8RPp15/LRUpZlOhMVFbtTAzdkoRkY
	ZVjDTzSSBZd5bfqSk+Olsjh8e75RoTa1onuEB8pi9Zu9MotYOYrd5mr5RmwsV52blcjEfygI+Ws
	I7XEPXaLf0MDU=
X-Received: by 2002:a17:902:ecc6:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2c9e9db83fbmr27121295ad.7.1782717939428;
        Mon, 29 Jun 2026 00:25:39 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b2be2sm87568205ad.47.2026.06.29.00.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:25:39 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/2] mmc: litex_mmc: Set width from linux request
Date: Mon, 29 Jun 2026 15:25:07 +0800
Message-ID: <20260629072510.1451480-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629072510.1451480-1-inochiama@gmail.com>
References: <20260629072510.1451480-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the litex_mmc driver force the 4 bits bus width.
This means that the gateware with 1 bit bus width is not fit.
However, litesdcard does support setting bus width, which
make the 1 bit bus width gateware possible to be used.

Add logic for setting bus width in the set_ios() function.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/mmc/host/litex_mmc.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index 3655542ca998..affdff8621bf 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -29,6 +29,7 @@
 #define LITEX_PHY_CLOCKERDIV  0x04
 #define LITEX_PHY_INITIALIZE  0x08
 #define LITEX_PHY_WRITESTATUS 0x0C
+#define LITEX_PHY_SETTINGS    0x18
 #define LITEX_CORE_CMDARG     0x00
 #define LITEX_CORE_CMDCMD     0x04
 #define LITEX_CORE_CMDSND     0x08
@@ -72,6 +73,10 @@
 #define SD_INIT_DELAY_US  1000
 #define SD_INIT_CLK_HZ    400000
 
+#define SD_PHY_SPEED_1X 0
+#define SD_PHY_SPEED_4X 1
+#define SD_PHY_SPEED_8X 2
+
 #define SDIRQ_CARD_DETECT    1
 #define SDIRQ_SD_TO_MEM_DONE 2
 #define SDIRQ_MEM_TO_SD_DONE 4
@@ -96,6 +101,8 @@ struct litex_mmc_host {
 	unsigned int ref_clk;
 	unsigned int sd_clk;
 
+	u8 width;
+
 	u32 resp[4];
 	u16 rca;
 
@@ -451,6 +458,24 @@ static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq)
 static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct litex_mmc_host *host = mmc_priv(mmc);
+	unsigned int bus_width = SD_PHY_SPEED_1X;
+
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_1:
+		bus_width = SD_PHY_SPEED_1X;
+		break;
+	case MMC_BUS_WIDTH_4:
+		bus_width = SD_PHY_SPEED_4X;
+		break;
+	case MMC_BUS_WIDTH_8:
+		bus_width = SD_PHY_SPEED_8X;
+		break;
+	}
+
+	if (host->width != ios->bus_width) {
+		litex_write8(host->sdphy + LITEX_PHY_SETTINGS, bus_width);
+		host->width = ios->bus_width;
+	}
 
 	/*
 	 * The SD specification requires at least 74 idle clocks before CMD0.
@@ -463,13 +488,6 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		return;
 	}
 
-	/*
-	 * NOTE: Ignore any ios->bus_width updates; they occur right after
-	 * the mmc core sends its own acmd6 bus-width change notification,
-	 * which is redundant since we snoop on the command flow and inject
-	 * an early acmd6 before the first data transfer command is sent!
-	 */
-
 	/* Update sd_clk */
 	if (ios->clock != host->sd_clk)
 		litex_mmc_setclk(host, ios->clock);
@@ -555,6 +573,7 @@ static int litex_mmc_probe(struct platform_device *pdev)
 	 */
 	host->is_bus_width_set = false;
 	host->app_cmd = false;
+	host->width = MMC_BUS_WIDTH_1;
 
 	/* LiteSDCard can support 64-bit DMA addressing */
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
@@ -587,6 +606,9 @@ static int litex_mmc_probe(struct platform_device *pdev)
 	litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
 	litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
 
+	/* Ensure the litex is at bus width x1 */
+	litex_write8(host->sdphy + LITEX_PHY_SETTINGS, SD_PHY_SPEED_1X);
+
 	init_completion(&host->cmd_done);
 	ret = litex_mmc_irq_init(pdev, host);
 	if (ret)
-- 
2.54.0

