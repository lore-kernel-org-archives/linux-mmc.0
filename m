Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383881;
	b=0jgzSwWlu1FWg+AR2WBhqCG14X/UrfWwM/VBWVH4vEk7Cm5+RuIl6sXYa9OKxQLUGY5I
	 xZyFTolqvqGhjye1MdEErLqF0YPCOt/hR8btHjKJos5w0iOHJp6oG12mjg24NS7ilJDQj
	 Pqm+Z+NTp8iwD4E/5MDVOikLWTydY4l/bTLDKN4NHY2EvcLjahQ7F1ZY/rhinEO0zPp7Y
	 KnPg0OXO0hEv6ffvMJbYYSeMHD1sfRkRf3FeU0Bt/n8VaboQ3MdKtr2K1zGjMJqyb20cl
	 VzR3K9EtwffEf8wfyMB0TxULsTSnpvMx8ztk6KNCEalWln9EoAWJOk125Rl03FufmLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383881;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=0+uaoRo5l36iC7XTBrb03pfY3TZLNhetIMMz75SoQNo=;
	b=vzB2VrKgCLU6nFrp1OyXRpEUi18l/nCTFzZvzGt8fcYXyL6TP3PSXiSWnNkhzAgTO+IT
	 sbJDk0Pxu81lDzsonPsKwEDherxLMi9b3nZySj2pyxzSnCK2Lx28DIT3GJQXDRwtaNxAh
	 77M/OSGoRJyb7SDV+78MkoYR2Q4USQILWTqrcnP+RvivCUEYKI2JvcDWXBr2FEZlQjukX
	 +mcg6kNCKuwHKJroZmLG/gRpjDEBcLrNwoRpFlZ+Z2AXIWvfOyicrnXMpp089gvlgYwbN
	 B/OpoPc/c2/e0lCjdaNtVcaXIW8bQvijak6juX66hVCi1sXqOCvdzTG92Ih3vetBXBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Lj5YJ6v5;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B2606A324
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 18:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16B2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Lj5YJ6v5
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso488447a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383880; x=1793988680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+uaoRo5l36iC7XTBrb03pfY3TZLNhetIMMz75SoQNo=;
        b=ftnz5A+X7tYLFOxJJru2fBkkm1vzq6sCqCQja1MMp0Gh+Y4e0E2N6FfxdW5HWihSM6
         OzJ/A2nzeE64F9iTU4hsmOFH3Pt+cU7EqWygyZDdi2yIdRfPvM29dxQJwBGOIdOK2Tt1
         bxdNSr0WIPbP2l5ZepxlDZXmzG/Jj4OuWOKA5gwfDa++S1efbfc5Sq5w8YbA5Lso61iU
         i8vBzmXmaYSaeib8HCoXIkbbQjPqtXILQvPFheG784zs+ItpJx7FvNJ0K+cWVL4X7VkD
         phVQ7cJUXuaHu8oTK/k1uczuVjhAGwtlXry4ldFPEkBCqTPUeC6wi2Wzfxfai/G5lQ/C
         3MzA==
X-Gm-Message-State: AFq9FYIchrruDUChaWkOw3sGlhV5hQeUqRTK6JugsKHAet/MLfYf/OKi
	+93GRimh1D+h9MO15HKABonfPxc3X6AaykUoQHtETBSCH6aQ4M4U7wmIsI3WI+CGeoPL9FAItif
	r6Ft2tAaHDtoo/2aTOcGEdVWqIIu/c0xVcjLRP9ZhLUdkKdpNsjbj4btq45maNXfvSsGr145uGa
	k9vOX8UlvMYs50CY0ru/qI8O1qFi/0BH5eqosZTqZx4GUQqZk6O88iVvyHYm8GBu6JlUX4q5nkV
	ucowbl3tyhq
X-Gm-Gg: AYBFou3kwfyFKCZkD8nwXZh03CS/h5Mxv19+ozFeJofhUTsyAP0XgLKhDRKgPDkpzS8
	FXZ25iivRAwGr/5LVa+hpKslClMlspkaG+6BxZxSKeOEOHdMkoVH0U1hEgbNtzqEAcoyyJLnF2x
	Y0GpLFNGwOQB/FtjicOfmiE9RONbMC7LAOkWrdM2wYT5dhQy8QZIXQwTxo/4UhHrwVmTIocTDmq
	fjUFumh+AAKRtEjc9vJnZlmn8GfiNlywFpws2+inv4m6VnEX5afUdyu58XGWf/5AYOTY0gODdLO
	YGKsMBuNJIEZ1PBPblDtv/Ny7ir9sItTqjMtL+kll1lLzzEgEDcuefkIP9rwGXcLp1w2pbhs8/K
	cnEQiceX/OwI4LAS5yo+i1zrdCJmGkI2cDSVm9acqG9G5TPh3jdiCYDlgQJAC1NLF4VlYjzxn9x
	yiFZERvEWCx9ydFxyARcbkj4IYdUVD1pBG
X-Received: by 2002:a17:90b:28c7:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ae897ee62amr2635422a91.25.1793383880344;
        Fri, 30 Oct 2026 11:11:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae841ee0ddsm2357422a91.0.2026.10.30.11.11.20
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:11:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso1585073c88.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793383879; x=1793988679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+uaoRo5l36iC7XTBrb03pfY3TZLNhetIMMz75SoQNo=;
        b=Lj5YJ6v5jl9irQB/CVxMAEs4E75x08Vkbg/50xpvYKukWvA73aWmC31gyrddXHC3TZ
         P+TPJk0Wuzqe9DAaD0OrMSK/Wq0q9fbDeN92SfIx5QN6ZBz0KCIzkFSVIAfAWCFWUTwc
         EG2sgsqGXXtDOzK9KXgz5alXelShvq6zTAI94=
X-Received: by 2002:a05:7022:38b:b0:1aa:47e7:97e3 with SMTP id a92af1059eb24-1ac5c45fd1dmr4838131c88.15.1793383878515;
        Fri, 30 Oct 2026 11:11:18 -0700 (PDT)
X-Received: by 2002:a05:7022:38b:b0:1aa:47e7:97e3 with SMTP id a92af1059eb24-1ac5c45fd1dmr4838041c88.15.1793383877613;
        Fri, 30 Oct 2026 11:11:17 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm9974062c88.11.2026.10.30.11.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:11:17 -0700 (PDT)
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
Subject: [PATCH v11 5/6] mmc: core: Move and split reset functions for eMMC
Date: Fri, 30 Oct 2026 14:10:32 -0400
Message-Id: <20261030181034.3811225-6-kamal.dasu@broadcom.com>
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

To prepare for a subsequent change and to simplify review, let's move the
function for resetting the eMMC card a few lines up in the file.

While at it, split the cache flush out of _mmc_hw_reset() into a new
mmc_hw_reset_recovery() function and use that for the ->hw_reset() bus
operation. This keeps the flush for recovery, where it was intended, but
allows the card to be reset without it, by calling _mmc_hw_reset()
directly. That is needed when resetting the card at system resume, as the
cache has already been flushed at suspend and the flush would only fail
with a timeout, after the card has been accessed by firmware.

There are no functional changes.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Co-developed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/mmc.c | 73 ++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c936272bcd81..026003ba507d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2271,6 +2271,44 @@ static int mmc_shutdown(struct mmc_host *host)
 	return err;
 }
 
+static bool mmc_card_can_reset(struct mmc_card *card)
+{
+	u8 rst_n_function;
+
+	rst_n_function = card->ext_csd.rst_n_function;
+	return ((rst_n_function & EXT_CSD_RST_N_EN_MASK) == EXT_CSD_RST_N_ENABLED);
+}
+
+static int _mmc_hw_reset(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+
+	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->card_hw_reset &&
+	    mmc_card_can_reset(card)) {
+		/* If the card accept RST_n signal, send it. */
+		mmc_set_clock(host, host->f_init);
+		host->ops->card_hw_reset(host);
+		/* Set initial state and call mmc_set_ios */
+		mmc_set_initial_state(host);
+	} else {
+		/* Do a brute force power cycle */
+		mmc_power_cycle(host, card->ocr);
+		mmc_pwrseq_reset(host);
+	}
+	return mmc_init_card(host, card->ocr, card);
+}
+
+static int mmc_hw_reset_recovery(struct mmc_host *host)
+{
+	/*
+	 * In the case of recovery, we can't expect flushing the cache to work
+	 * always, but we have a go and ignore errors.
+	 */
+	_mmc_flush_cache(host);
+
+	return _mmc_hw_reset(host);
+}
+
 /*
  * Callback for resume.
  */
@@ -2319,39 +2357,6 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
-static bool mmc_card_can_reset(struct mmc_card *card)
-{
-	u8 rst_n_function;
-
-	rst_n_function = card->ext_csd.rst_n_function;
-	return ((rst_n_function & EXT_CSD_RST_N_EN_MASK) == EXT_CSD_RST_N_ENABLED);
-}
-
-static int _mmc_hw_reset(struct mmc_host *host)
-{
-	struct mmc_card *card = host->card;
-
-	/*
-	 * In the case of recovery, we can't expect flushing the cache to work
-	 * always, but we have a go and ignore errors.
-	 */
-	_mmc_flush_cache(host);
-
-	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->card_hw_reset &&
-	     mmc_card_can_reset(card)) {
-		/* If the card accept RST_n signal, send it. */
-		mmc_set_clock(host, host->f_init);
-		host->ops->card_hw_reset(host);
-		/* Set initial state and call mmc_set_ios */
-		mmc_set_initial_state(host);
-	} else {
-		/* Do a brute force power cycle */
-		mmc_power_cycle(host, card->ocr);
-		mmc_pwrseq_reset(host);
-	}
-	return mmc_init_card(host, card->ocr, card);
-}
-
 /**
  * _mmc_handle_undervoltage - Handle an undervoltage event for MMC/eMMC devices
  * @host: MMC host structure
@@ -2410,7 +2415,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.runtime_resume = mmc_runtime_resume,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
-	.hw_reset = _mmc_hw_reset,
+	.hw_reset = mmc_hw_reset_recovery,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
 	.handle_undervoltage = _mmc_handle_undervoltage,
-- 
2.34.1

