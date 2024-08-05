Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D3139D12;
	Mon,  5 Aug 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849489; cv=none; b=AI2mF0BVMO+k2GXrJ9f3fUvvwHNhrEbjyKGC5qEwwyXro1EA+4RQ+YDVfgmHi5zCXaa6jT79XA4hpZF7xcQNcRijBFClLH0r8nRzbCOJyT6Kl2heD9+kWnjX14M3T/LiDlLmvb4a6FnAkXUtuASCBhv9ghplLfbB5RKXW1dnz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849489; c=relaxed/simple;
	bh=lhr4ycr5iT/HvMKPlMZc/xTGMersf1RPOPJHu8DVYIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKh96By/jlJV2TCcpM5u1bVY05lzyHkmovCv+IDy3VtgrRsZM9SBLaIqJoV3KvdH9JlumfLORoc2QkUNW7DSqJ20S1m6HRBdP+DeYk7W2/HxcD/PiP2YDCSw34NZs90QzRPPQ0awSlgVBpHxW6bCCZbRiK6JZ2helmzNxHr3AHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doxbNJAC; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doxbNJAC"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1bc36bc2so2553143b6e.0;
        Mon, 05 Aug 2024 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849487; x=1723454287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfW+yJcH0UPgHr9h+kry6dKwgvMmuDMaA8IPcQFaE90=;
        b=doxbNJACTGQA88+rvsveK2bfVYqhuOseBk2a5k1PdOF6bejiUgVHCKESwY53dKgJJy
         grNZs6+FndTroQhcv6kdDWG+fPqOVqsgOS4doFVp3OoeVEzRHqRIgeKOdJ4uPjkJKiHU
         lcHe39k7bKVl32XaUurGMeOF1fMET1W5DfcbD31ZLvL+Nh/rJ6Gh7Z8l+s8PTcLt69ex
         AQDUQYj6RC1gzkjFCPslJf5qBB1BM5udL7wmW3+sKiKTiabVvpUQS637PQ4swZNRDh2p
         awjrrLnhOrJrHzV8cYDMkCRYhw9BzDNH3oTa2setwtuH/xy8ordzn4h+d7GGlX5rS9Y3
         +MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849487; x=1723454287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfW+yJcH0UPgHr9h+kry6dKwgvMmuDMaA8IPcQFaE90=;
        b=RyOTeGggPvaouy8au/EBHJm52pgdBmgqGDlMaZxrn0gfEsppUb9jEgYEuoPCwkehpj
         cHcG6qL09odOpVv2mdnag+7kWIfrGbg/BqWGcxq5w5gj3otx51kbip9KYPzIkG+cE/Et
         VIT8NgXo3tjsaUOgDv8sflHnDgtQUU07ROF/Wn2fjQXLfwF2PFAAG6e28TkaGab6LWRp
         BJokYWht+G62eaiwKvvFPbMcSLE1+BF1T9yfbtXg18CwQjGP3Y349q4P3FVC1P6fCPRJ
         QwlWgndvGJqL5BeGxvExmd7gAg91DBdEm1hJG9q2uoS5P8TiPFkqXIQU+ltmYVVjaBa2
         6wFA==
X-Forwarded-Encrypted: i=1; AJvYcCVgoyORhcHiAdHv3KXiJp7oWLxZy+XoAkvPmZTkM+SSMxUQ05YCTPwcUgRIkFhehPglW6h6zKTLDVU5yfB9T2c1AGIhlFtNXc34yt40BWt8cK4kELu96RLSX9pXZbIjEEegnKsY9zx9lOPfFObzry653nrZ/I3FQn44GIjG7XF+4Voh7w==
X-Gm-Message-State: AOJu0Yxl4bV9CFLsUnSngAKOuju9vkp5Ll1vEp6bgxkYn8SWAmn0djgG
	ma6cq0/5BLkKNL19CzpXGYQud3ZFLr3Qvzux5LzArIc50f+BcZgI
X-Google-Smtp-Source: AGHT+IFbBF3lExmEwSsTcYdXzKwjXYiy2njdzQYc05gkHhL2aT6+SgSAyFcfMhbQrS/LyC+XIkUjzg==
X-Received: by 2002:a05:6808:6091:b0:3db:2025:110 with SMTP id 5614622812f47-3db537ecc54mr4533948b6e.11.1722849487166;
        Mon, 05 Aug 2024 02:18:07 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56371007sm2520804b6e.17.2024.08.05.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:18:06 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Drew Fustini <drew@pdp7.com>
Subject: [PATCH v6 3/8] mmc: sdhci-of-dwcmshc: factor out code for th1520_init()
Date: Mon,  5 Aug 2024 17:17:59 +0800
Message-Id: <23c6a81052a6dd3660d60348731229d60a209b32.1722847198.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722847198.git.unicorn_wang@outlook.com>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Different socs have initialization operations in
the probe process, which are summarized as functions.

This patch first factor out init function for th1520.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Drew Fustini <drew@pdp7.com>
Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 51 +++++++++++++++++------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a002636d51fd..b272ec2ab232 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -830,6 +830,35 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static int th1520_init(struct device *dev,
+		       struct sdhci_host *host,
+		       struct dwcmshc_priv *dwc_priv)
+{
+	dwc_priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
+
+	if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs400-1_8v"))
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+	else
+		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
+
+	/*
+	 * start_signal_voltage_switch() will try 3.3V first
+	 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
+	 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
+	 * in sdhci_start_signal_voltage_switch().
+	 */
+	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |=  SDHCI_SIGNALING_180;
+	}
+
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
 static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1231,27 +1260,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	}
 
 	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
-		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
-
-		if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs400-1_8v"))
-			priv->flags |= FLAG_IO_FIXED_1V8;
-		else
-			priv->flags &= ~FLAG_IO_FIXED_1V8;
-
-		/*
-		 * start_signal_voltage_switch() will try 3.3V first
-		 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
-		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
-		 * in sdhci_start_signal_voltage_switch().
-		 */
-		if (priv->flags & FLAG_IO_FIXED_1V8) {
-			host->flags &= ~SDHCI_SIGNALING_330;
-			host->flags |=  SDHCI_SIGNALING_180;
-		}
-
-		sdhci_enable_v4_mode(host);
+		th1520_init(dev, host, priv);
 	}
 
 #ifdef CONFIG_ACPI
-- 
2.34.1

