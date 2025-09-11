Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027474BE1
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558469; cv=none; b=AGU66CuEnbOTF7PYzyL1rKSAKQFYcGz4k+x0XUA8IGy94au+Ngn7fjx19rlr3bmUgqZzMeHveq9OKXIUhpjzVt7IKXgiHfH5e2M/3d50c7Y0XCowr6jq+aC47xD8FHJMw9NnrUxoYW9m2BBsmmga0sh7Zxt1K6TEjVpfQhl9Wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558469; c=relaxed/simple;
	bh=VsYWhLysJJnmTbPsbRPKH4Te9fqitjPi8iJYc9rGN40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKyiB6tz86anIKCtTAklMC6u217hmG25FFP021hulRI55Fa2MJ9eiojeyzlwH5HsKO8ufun8HPM7F/9eoKdoPLPvbPK5Tz9PxM+0BsRP5QfK99XbdU94FRA+fBSN1LkTlBtNaY3T5KIGgqlqMwXVdTdSFJmLP56mMZBiQkdEQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSwqbJEs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSwqbJEs"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7741991159bso351483b3a.0
        for <linux-mmc@vger.kernel.org>; Wed, 10 Sep 2025 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757558467; x=1758163267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RotDBc4nduTqvm+cZpyUmQgQq6+4XUNjDl6/pxCSap0=;
        b=PSwqbJEs8IsyVx25IvEs2eQ5yGdI84ayDb6vA8xsHkmFYCC3vr3ce98EQPAj+HlOtx
         zCVyQ9/xTjpIqIAc6R/GTjXmiFctXRLd0OOmu174wvrkFSr1IS5iXJ6nbAA6FPJY/lBD
         owVnRRM9OwCwD90zFKCSkXqdHKVZIOe0LF5r8VR9g+eHK/4dtTzCrMDUvdVRPHF8Snli
         fdWn/dDOLXgLuBGzQDs6NIjD49xXhEDwaVLU/WkBcBrWXbfZY8QhjVO+xT28g2AUCEUw
         WS+iHE9+r5z274UAIMDC1PrXW2aMRlyrELcnt5sqEn5zoCcEVHsWRnoX7fRTHhGXZgpi
         9bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558467; x=1758163267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RotDBc4nduTqvm+cZpyUmQgQq6+4XUNjDl6/pxCSap0=;
        b=kOM01FgMiBze1bvtz/tAMwXQ7h6VU0mNLvKtWDqR0mJrD+bCVKw4h2yv9nue3EV0cd
         NMgNnIVWKGzrNHuDS58CwsQd8+1TgwGOojWBAeDNEKxdPGPBt+hHR7iaJTQ5NXPLV2pa
         ltKbX52v+0WPw7iTm9CRuoRAtU044cq67R8F7dqfUjWr+m2PloLvnx2/MaELDOXChmRG
         Nn4X8ROIa4bPFC04IAUL+ePYLwfv/TVcoGK2f1PB0tabv7Dc7uOt+zbZFAh7XddpOe2d
         Yh7ULMWNQotHgLZ6cANVp15Io6f3nK8qmHW0q2COAeC8OV523aSguzrRI/6yrps7N1SV
         jRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiS4Hxw4Aek7Ysc7N6fFPVuRf5Q2dNMNps/hurgP0gCOhoGEjYaJq9AQ8SP7qx+LQqtgQNXPw7eT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDj0b8QC8sBwfR0++ieVL8zSEb3ky5tWAlUwzW4xzsHxcsgg3H
	3L7MlZi0WbVyl4JeOZNdA6bZHpB/Rpocybbgv+jooBPpO8xas7my++ij
X-Gm-Gg: ASbGncst6R6wNNt0Kc1nEx2V4WBi43aUyWK5Pky1iDgDcr1MDCvgYwNwwf8bsntlsNI
	lIgG9oQY4sa/rfEE2eMHxeHE5fpdQuOiIVyz1b3gdVd/5iSEiqBzcmKGLp2+sryzSpbwJSqQ0N7
	RR6YpQs49K4dsqntdwzEmOBUUBorZmSr8+Z+TbBLuZjOMKhMFM86B0Kx/ZprfnC0B+L3WuByzGg
	Tpn73LPBYHvGmZPfdV3ImAY9eb0pHUxX7QuvI602v495W2+f+D0JRii8qJzu30MXUfLdw7KC/7K
	9mG8zgmEb/RxZeeJacfecilv3lbZcUvhxTSXmv206vk6w0mMlIsXZJNKjvUEH6CVDJKBbSwFvqm
	cc6fjoPNkhvM2G4UHlx2IhXgYuCJZdpLM0hO+WxPWh294LzHgiVQZO9EjptzlfQbflkPEp1CEEu
	xWuM0H56hdc1N4AFSkOHK1+wl5oY/9
X-Google-Smtp-Source: AGHT+IF6DEdmkzIwhlwOvXdHfSRwOtFEwFUfp7ZMeoL357UAoG42oyov+M9vvQIIxvaPMU5TR0IIAA==
X-Received: by 2002:a05:6a00:17a7:b0:772:398a:7655 with SMTP id d2e1a72fcca58-7742df033a2mr22466192b3a.23.1757558467212;
        Wed, 10 Sep 2025 19:41:07 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b17e23sm292579b3a.55.2025.09.10.19.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 19:41:06 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	SeanHY.Chen@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	victorshihgli@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function
Date: Thu, 11 Sep 2025 10:41:01 +0800
Message-ID: <6ac048c1a709e473f885c513b970fe355848484d.1757557996.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
References: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
vendor defines its own sdhci_set_clock().

Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
v3:
 * kepp "host->clock = ios->clock;" to part1.

v2:
 * remove the "if (host->ops->set_clock)" statement
 * add "host->clock = ios->clock;"

v1:
 * https://lore.kernel.org/all/20250901094046.3903-1-benchuanggli@gmail.com/
---
 drivers/mmc/host/sdhci-uhs2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 18fb6ee5b96a..c459a08d01da 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -295,7 +295,7 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
 
-	sdhci_set_clock(host, ios->clock);
+	host->ops->set_clock(host, ios->clock);
 	host->clock = ios->clock;
 }
 
-- 
2.51.0

