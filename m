Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426290;
	b=bgqI031uE+eJJm+v+hB3pfMe1TFFbDEjjFVkHooK7NbKCdVRBeGgMSP+umygoF2cU3oU
	 riFP4A87mI9xmFpGaQIY9zgi3Kj5LM9KUSnULrQVXwS4bdO15bWUSLYK+V0ODnEmkF2ZF
	 UBVOX0cxPuimyHxJ9HaeViGWAFJnMPCp2cKevzmWGCGK5KXRw8GkOD2A0ZLFXz2B5GSdb
	 7OQq6pJIkeaKKf5SaSw0CWWHlz97VlBxnePU6g2pdnQ5ht6GIQSl3KDCgXcDB5QFeqzPO
	 qOcd2Fn2d0q+t6BdvpPZBYaFxRA2Vw33JVOT1GN8cCv6a1tbikmAsJXOdcoQQHTs+pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426290;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=MHzk4Y5rg8a5GL6NtRlws2skWgvMQ4aNhHaizSYchuA=;
	b=qhEwMo80Vs1Y7ACmWByo6CXo14zYjO6wvvBwOMDMowmBjteieRf/yPktUW8Bh9sZA56H
	 6WNV8onsrliuYIHxw0+pmpelyApPF0UmoRSuvMMgQyMgf+DjJOsdK2Zepc/Btfxy2NtzT
	 7vZbzAT6Sn0SzV0nn+InJsW8Qio1Gi3QaXaTvFPEx048Sa30RcXJqRFwJIwrdoUz26OCs
	 gQY9bBYWi99o2r4vEXxY7inpP/m6P8js3L4ZWkr9T1kjVoAMge6eF+0FoEpFsCnSdVdvU
	 1yd6UlOo2pML/IAXSrxCLRZhZ+Q3ofy/AQqNv88wROMOXRfpGfo4OD6H1hoiQ00mnYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RWDM1IIx;
	arc=none smtp.remote-ip=209.85.160.226
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00379606A884
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00379606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RWDM1IIx
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-5366463571cso41517311cf.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426289; x=1795031089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHzk4Y5rg8a5GL6NtRlws2skWgvMQ4aNhHaizSYchuA=;
        b=AdxpKn2/CVD6L4rZOI7mTpu1eI+S59zFArm8Lf+BmkmQ4HmqHIxwaAIvl2CxIuK4p9
         9N7wMoFKUdyFeb0/yGZwGpU+jAwrdo3TaWmJUMpf8Y/z6hB+1yK9oiIkfDd2qOpl8ltd
         U7/1KKAF/6C+HGmVpJb7cYirODMlX/F0MJB7nNL2WaOYPXiSHE3k36OF35EwrJRiPlyW
         R1ypODmMMrKV4wEWSKPkepkTbaQZR50MJ7+vLfSunen1GmfkKrZG0F6lFtUIqeH73XRn
         6pplcSB/3/oEPMu0XQxdTh/5vfSRaJqUHscXG7KmsS8iK49rrTkQws7d28iLREox2WU0
         lfIQ==
X-Gm-Message-State: APuU4Z+4KHhw/9KwFB1Atbl08jN0jsDirHJiY3qgdUwdVZEQcjoRYRkU
	CCQtOvw4dpKMP+XQq9gR9XlTaja+CBRCcxBJwxdusw2Yf+Nl0sjqp0lCeyjl1XPN0Rrzy8qV+hD
	7pxJFVvsz4FTBvSwSrdrB17tnV6hf1jI3+NrAaIwPtYAsVx3rPtsq/8C6ePYgoAp+PWLR9BRz30
	d/p50v5eIvtH8qDetP4T++f9xTw9iKe4vfQdNfNfvhY9iAeQueijjhmV9jWCwBtj6pYROAI0Hbi
	tocm5jGxKlp
X-Gm-Gg: AYBFou3SLqHtfD1q5JluLAVIjYOetMabysVroisnfdeeymkxC8brmRySaKklMUzwtb1
	9sWFMR2nK65l7dKWpokGOv2MdxSSeu/AbDZkx2R/wxnKtyevwhtvQhsz25q/C62Z2QmYrhl2QoC
	Rp+ByacvrwtkUcwRfp6HD2ITcN7yx13PzRfmgTUwpRPaeFBa0Wb2XG8C7TPLIpJdPgVIKnXoosA
	aYOIS3Gh7bq+CwxXq0znE2CR+IFkRh9apL3045n/uLD+B8LajsPuYvwI2+ofR5O2LAlegnHxyvv
	70UA09pv/uGxqmRwYsU0h8TGJAbWyHdLKr2B1SrXxKQTYq205ZxwSBiBwjDpVuveF61Orpw8Arg
	DK2cTakhh5A34bbL9JeEKe1vNV/S1oIYDxXQ38aFQ8LNsixpjt3TdwTBK1SioFxCZ9r9E1D7ImY
	4uBVNJqcjxw9p65dzxsceVc3tJ5m+XEgpm
X-Received: by 2002:a05:622a:14ca:b0:535:162c:2e83 with SMTP id d75a77b69052e-556c001629bmr54696851cf.16.1794426288822;
        Wed, 11 Nov 2026 11:44:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-555091ea054sm1132531cf.3.2026.11.11.11.44.48
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:44:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso6680007eec.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794426287; x=1795031087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MHzk4Y5rg8a5GL6NtRlws2skWgvMQ4aNhHaizSYchuA=;
        b=RWDM1IIx+KQrQKt1dV5RTshb6sNlaI1LtnQ+ospUgkmC3VeH87IUiKafvOUikNguBV
         iG5nfFWtr+BZRt3xRdAbUg4NL11qDe8ay9AgUehKcCnDpcGNCHjckDZUyTSdQwAOJdkT
         XgR9TkZbXat/bZtcm19+qn/756xP/JWAyqvXY=
X-Received: by 2002:a05:7300:f143:b0:36a:1089:9836 with SMTP id 5a478bee46e88-376855b265cmr3502331eec.15.1794426287414;
        Wed, 11 Nov 2026 11:44:47 -0800 (PST)
X-Received: by 2002:a05:7300:f143:b0:36a:1089:9836 with SMTP id 5a478bee46e88-376855b265cmr3502291eec.15.1794426286576;
        Wed, 11 Nov 2026 11:44:46 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17948013eec.11.2026.11.11.11.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:44:46 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
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
Subject: [PATCH v12 5/6] mmc: core: Move and split reset functions for eMMC
Date: Wed, 11 Nov 2026 14:44:25 -0500
Message-Id: <20261111194426.1652644-6-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
References: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
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
