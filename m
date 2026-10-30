Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383883;
	b=uG98LJwcGeXesp9RSKzSdwPl4jD0lJdl1bia6Cbc15Kbjj9+cSY2dtoxKTheLHvX86dR
	 vayQbOI0h/B1vKaIGHg+J9iAdHPBfVtDUib1dpmRa/cX5wQU/BKo3RCVLjmNH3i0pPfOT
	 LXc7E33NlebBweubb2cU7lFHktFVpL+1HDAcg4eSJ+nuXwT1Nzur5YUUUPX3Pao/BrK96
	 I5ve0GTJNtEyULeN4ZzTmMNO3dCIEERsQdk8Wc3XEWmDft0eFpLOwgM9tsR/W/QuglQZt
	 eBSy0lJF4E5KGU/ezVstTYgvnFpLNDKypdixI4Tibqkee66a4vXN6JH1GTgZl3zuYXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383883;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=9UEip65nRVFiwXi/RQ81IOIqu2Aa5gJjnBH6d1LLNVo=;
	b=y4kDhcnuHcilE5FMemLMHuztvzn6i9Z2JC5tsv3kNGWLgMFWcTh7pA9yYpsJuvNaJMLp
	 kYcd/x7NfmUwT/hXtB0JujKJDEkSBIwLA8ETPigYEO3UASbPRGuIEqDRdykoZvXhliycR
	 mqhbOIxPuUCmPFLmD/Ob6KMcb2uxj3xXBc3b4jnrwMfxPXBM6GpA8ZSWch3PG/eZfQqji
	 EAlHvy10Y7GWceR0BF0SFo+v59gjlGRCr1nEcaPb2u5/SsIr0YJ2MIUAZokshAwl9I4/z
	 sJoxDpLRu5lKcCqkAkBJ0af7UBs3fRIH2a+IYBCi+i0Ravd5O5zSkOq9vgkCjz8/8TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ca3RKvGW;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50A60A2612
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 18:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C50A60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ca3RKvGW
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso422255a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383883; x=1793988683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UEip65nRVFiwXi/RQ81IOIqu2Aa5gJjnBH6d1LLNVo=;
        b=jbODeLKg9hmFbSQjL69v7jwCznjt/TdrzAthr6JemuLc75kOKsvqi/xsCJla2OKYwg
         aBq3xX7eRiTT/HyKyAHbAshKLsGnfkzwmddYfMiWAnspMW4SXHnhNcP1KRidslcohlSd
         JioEXxNDEYYX3UBKmW4/DUIf22m+r/4n8gX9DlXkPrUbemmzJdxMStST+k4bv6appcfR
         J9YTQ3X7EPF1Y1/eSfsDhSEw8LT/lIaPM2g7mIBEBodDhGK3Anh73DF9ZXoU5ab9zGK4
         FFSNp3rCrE9FricyB/NburVQYY0POvLtEz670IZigckHWsSS2cprkryU7oT410v2s08c
         3h0g==
X-Gm-Message-State: AFq9FYJ5xD9D0ZdOmT/dU4gAhLH5cFyzsEf3dIv2LNAUzYnIf8s0CyNh
	gPV2bjvBhy0Cz37jY2GdFOunoltJHMJyq/0QuyWUdpS/ftglsIFT0zBmcjCxb/lPu9Hu0E7AFzo
	si416aSGt1WZkZ1gcybvGtyveR22jybZujExWjoiQsSKlQDs4/D9qSqOFvsrKIf7WN13ol+Hc8E
	onekYmZ8sRr9eL4kN5gm3GHGB2oO5orwxC0GePX/mzQ/Gyx2H1I0LwnuWV4/2uWG1pcsqnwAeiZ
	Bh8/v5qO3M8
X-Gm-Gg: AYBFou2DQpNJU0+rJ03HOx9HiWg+Dg38jEPkL9YGXq21Qdz6NS1BJpYkxLiJQ4LJaPM
	Q41DJljhUBjBOc6GKFqy0p0q71x7LWKn3UTonGAamgAc+/w8VsyaKJZ04J00jbPUjfjlGh9yfO3
	hKYfb/RWOZWLSHcBS7JUaD322k1rKTfabdG2tFL+EBg06oouasKBJfRFkhhcXjRm8g0LKrrcBmc
	zLzddk8NtD9KKVWmZv4RYxGCSPHo7amAtm/zk5W8QBxOdVsC/gxsbpKSNliFcOwUb/GiHUiWbk7
	nrbf8XfQr9EKeClI+rHBV68yCQmyMXcZxFoT5SmlxglNPwazDiGZY/Ts8a9vRLdi7Fym4lB/ns0
	bKCQMOEWrHLBuGdmEgMVwZUdgmwBASymHOOnih3++DilGsFtRP0lO+PDV3SGdUVcWTdVec9v1zm
	+ynbKqVk4X/SmPnaekfpU4aOmFBAgWnzAY
X-Received: by 2002:a17:90b:4a46:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3ae8953617fmr2806085a91.3.1793383882724;
        Fri, 30 Oct 2026 11:11:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e6ec859sm4659277a91.2.2026.10.30.11.11.22
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:11:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-193b5eb133eso1134683c88.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793383881; x=1793988681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UEip65nRVFiwXi/RQ81IOIqu2Aa5gJjnBH6d1LLNVo=;
        b=Ca3RKvGWNSQaAhXGySCioh/4xqWVLydiPfMIvdmXEru8B4+KYXhPTIPCBAFVLkZmts
         CJoMiCWWmqQF/YeDqLhBpZjIGN1nPOvLFpKh5f8LTEgSI6qGMNPuwiyKVaW7yadkj1y7
         721wAwOvnhCf7zcAaJhZNO8whJcznSgjAOMos=
X-Received: by 2002:a05:7022:208a:b0:143:26cf:8615 with SMTP id a92af1059eb24-1ac5dc65c45mr3734304c88.25.1793383880825;
        Fri, 30 Oct 2026 11:11:20 -0700 (PDT)
X-Received: by 2002:a05:7022:208a:b0:143:26cf:8615 with SMTP id a92af1059eb24-1ac5dc65c45mr3734232c88.25.1793383880060;
        Fri, 30 Oct 2026 11:11:20 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm9974062c88.11.2026.10.30.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:11:19 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v11 6/6] mmc: core: Add support for resetting an eMMC at system resume
Date: Fri, 30 Oct 2026 14:10:33 -0400
Message-Id: <20261030181034.3811225-7-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
References: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>

The DT property reset-card-at-resume specifies that we need to make a reset
of an eMMC card at system resume, assuming it also has stayed powered on
during system suspend.

To implement support for this, let's start by parsing for the new DT
property and set the new bit MMC_CAP2_RESET_AT_RESUME if it's found. Based
on the property, we must also set MMC_PM_KEEP_POWER in the pm_flags for the
host, to keep the eMMC powered on during system suspend.

Finally, to manage the actual reset during system resume, let's extend
mmc_resume() to support the needed behaviour.

The property only makes sense together with keep-power-in-suspend, as the
card would otherwise be powered off and system suspend is refused. Warn
about that while parsing the DT properties, to flag the misconfiguration
upfront. While at it, claim the host around the reset in mmc_resume(), as
it sends commands to the card.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Co-developed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/host.c  | 13 +++++++++++++
 drivers/mmc/core/mmc.c   |  8 ++++++++
 include/linux/mmc/host.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8e9e61839198..8b38ff45d20f 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -48,6 +48,14 @@ static int mmc_host_class_prepare(struct device *dev)
 	if (host->bus_ops->pre_suspend)
 		return host->bus_ops->pre_suspend(host);
 
+	/*
+	 * If it's required to make a reset of the card at system resume, this
+	 * indirectly also means that we must keep the card powered on during
+	 * system suspend.
+	 */
+	if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
+		return mmc_set_host_pm_flags(host, MMC_PM_KEEP_POWER);
+
 	return 0;
 }
 
@@ -375,6 +383,11 @@ int mmc_of_parse(struct mmc_host *host)
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (device_property_read_bool(dev, "wakeup-source"))
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (device_property_read_bool(dev, "reset-card-at-resume")) {
+		host->caps2 |= MMC_CAP2_RESET_AT_RESUME;
+		if (!(host->pm_caps & MMC_PM_KEEP_POWER))
+			dev_warn(dev, "reset-card-at-resume without keep-power-in-suspend, system suspend will fail\n");
+	}
 	if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
 		host->caps |= MMC_CAP_3_3V_DDR;
 	if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 026003ba507d..a9e3cf7ae039 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2320,6 +2320,14 @@ static int mmc_resume(struct mmc_host *host)
 	}
 
 	pm_runtime_enable(&host->card->dev);
+
+	if (mmc_card_keep_power(host) &&
+	    host->caps2 & MMC_CAP2_RESET_AT_RESUME) {
+		mmc_claim_host(host);
+		_mmc_hw_reset(host);
+		mmc_release_host(host);
+	}
+
 	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 	return 0;
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 032c018650e0..3c0ea74e3e35 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -430,6 +430,7 @@ struct mmc_host {
 	u32			caps2;		/* More host capabilities */
 
 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
+#define MMC_CAP2_RESET_AT_RESUME BIT(1)	/* Reset the card at system resume */
 #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
 #define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND (1 << 3) /* Can do full power cycle in suspend */
 #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
-- 
2.34.1

