Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D016206966
	for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207889; cv=none; b=XcdkM154Op385rEM285DMraSVz9/vLynOIDqAv+7/HWlbfaRkJOqIDyi1zFQPuAwvcAiXwQK49U+ZTeCvPShNFuGwDJtpFBSCIxJiiH9GTkl2Ufao48JYW076wd7PwuEpNl4da0ci7RCkZ5AzGdzjjPZBgWIMQRrNoTdIpfdnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207889; c=relaxed/simple;
	bh=9Si5uHtdp0Lt+1Q+Ut2zNTQ7sHvOgpyLbpOxdbMF8Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaCMgn7c3nRHXU9R+/UUt7VuhD9GI/QTmAu8/r5VeKeCzXcoBZunzOu4EEoK/ChlP4AJKpAhsNGBWDFoBxFzNp9vwvO+eTda2PYN0SZ/ZhrEhazL1Ob921VoiYEFzOndjbDUdv3gQqgkwCtIvYVDP++fZ/zwCSjwju502NaY+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fz2X46MP; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fz2X46MP"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso50396281fa.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2024 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730207885; x=1730812685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBgydnSYe7wOoT14t60TRfzkasKBAAiMFxpZtek6s10=;
        b=fz2X46MPAd2tAhqX6vceerhg/iQEovKIBvAKOgMqyBRQB1qHulN0nS1NQHr933Wd+s
         z7a/wIVktYX+1Q3qHDTZ9tghpuuMfUSdSLbx7RalBJ5kQZ4GUxtyfSXPBaxh1JqcPGu2
         HnWOb9yGz6W5UQ7y6VwoUdmuZpC4wWuU9S/xciMrEgR/pKurg5hMwyS+1Sri2EavplVC
         G5zAKmfDulp8XtCdC4/HFch1vmLYVtTw5OMtHYbDsfdlIZFrMe5R6RmAf+R3SaZU38R2
         tohe2AX6URVVfYDTvyua9u7yozQwOjFXq6OKRrBaluwHsi7NafrG3hXNYo2SKV6kBm82
         lYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207885; x=1730812685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBgydnSYe7wOoT14t60TRfzkasKBAAiMFxpZtek6s10=;
        b=pXlWBkXJUh5WAhJWP6qpGuiwZ3RJvFGjbBcI9iOMMCcQyeEIowDCmNe2q7WoE342Iq
         sNmtW0uoh6vLppr8qoD8y2GtkBT5fG2YXaJrp4LskgYb7l9Z7rE8L4E9V5jwLwTqT991
         DFOw3EpdW9tl04vtDyGJq2XS4OwmzGYQyFVvX87zVZIOAiNE7bhHm1+RuNB4SBilr7Q4
         vq2JPOJKzKfK/eWfhBb5da8P/HNztJmnobZJkcG9InkWkzLQeZvjYQQLFzbojeDQXCCg
         Q/Px/muVjP+DWb+EDOgvVqV/NVb7528gnrSu7FkKNVBcFzQpdldJlw40d3V1mwChyaIj
         biFA==
X-Gm-Message-State: AOJu0Yz2NnFJOUS8AMD3I7olARId1WTE7LBvsjw0n+qkvAQP7wIF1L9l
	sSsAdeeFTTpbN/MkCADfSHeZa0DsgWBsrePVTH+ByejbUP3dMPyKhdc/h84QIvnJj+bor2q8FDf
	3
X-Google-Smtp-Source: AGHT+IGDNrXtE4X1RXnTXnmnfBYVxYvy6Ye9s6ZWmMdqElCZB2ctE5tDPdQaGPHu6SfCJoDCLn32DA==
X-Received: by 2002:a05:651c:2209:b0:2fb:6328:b633 with SMTP id 38308e7fff4ca-2fcbdf612eamr50249911fa.4.1730207885108;
        Tue, 29 Oct 2024 06:18:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1b5asm14898401fa.85.2024.10.29.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:18:03 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Victor Shih <victorshihgli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mmc: core: Fix error paths for UHS-II card init and re-init
Date: Tue, 29 Oct 2024 14:17:49 +0100
Message-ID: <20241029131752.226764-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029131752.226764-1-ulf.hansson@linaro.org>
References: <20241029131752.226764-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path didn't manage the removal of the allocated mmc_card
correctly. Let's fix this to avoid potential memory leaks.

While at it, move the assignment of host->card to slightly later in the
init process and drop also a somewhat silly dev_warn() when CMD8 fails.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd_uhs2.c | 55 +++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index f0d631b4bbd7..618b46c37857 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -827,24 +827,28 @@ static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *oldcard)
 
 	err = sd_uhs2_config_read(host, card);
 	if (err)
-		return err;
+		goto err;
 
 	err = sd_uhs2_config_write(host, card);
 	if (err)
-		return err;
+		goto err;
 
-	host->card = card;
 	/* If change speed to Range B, need to GO_DORMANT_STATE */
 	if (host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
 	    host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
 		err = sd_uhs2_go_dormant_state(host, node_id);
 		if (err)
-			return err;
+			goto err;
 	}
 
 	host->uhs2_sd_tran = true;
-
+	host->card = card;
 	return 0;
+
+err:
+	if (!oldcard)
+		mmc_remove_card(card);
+	return err;
 }
 
 /*
@@ -855,7 +859,7 @@ static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *oldcard)
  * survives a soft reset through the GO_DORMANT_STATE command.
  */
 static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card,
-			       struct mmc_card *oldcard)
+			       bool reinit)
 {
 	int err;
 	u32 cid[4];
@@ -873,17 +877,15 @@ static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card,
 
 	/* Send CMD8 to communicate SD interface operation condition */
 	err = mmc_send_if_cond(host, host->ocr_avail);
-	if (err) {
-		dev_warn(mmc_dev(host), "CMD8 error\n");
-		goto err;
-	}
+	if (err)
+		return err;
 
 	/*
 	 * Probe SD card working voltage.
 	 */
 	err = mmc_send_app_op_cond(host, 0, &ocr);
 	if (err)
-		goto err;
+		return err;
 
 	card->ocr = ocr;
 
@@ -907,20 +909,18 @@ static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card,
 
 	err = mmc_send_app_op_cond(host, ocr, &rocr);
 	if (err)
-		goto err;
+		return err;
 
 	err = mmc_send_cid(host, cid);
 	if (err)
-		goto err;
+		return err;
 
-	if (oldcard) {
-		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
+	if (reinit) {
+		if (memcmp(cid, card->raw_cid, sizeof(cid)) != 0) {
 			pr_debug("%s: Perhaps the card was replaced\n",
 				 mmc_hostname(host));
 			return -ENOENT;
 		}
-
-		card = oldcard;
 	} else {
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
 		mmc_decode_cid(card);
@@ -931,29 +931,29 @@ static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card,
 	 */
 	err = mmc_send_relative_addr(host, &card->rca);
 	if (err)
-		goto err;
+		return err;
 
 	err = mmc_sd_get_csd(card, false);
 	if (err)
-		goto err;
+		return err;
 
 	/*
 	 * Select card, as all following commands rely on that.
 	 */
 	err = mmc_select_card(card);
 	if (err)
-		goto err;
+		return err;
 
 	/*
 	 * Fetch SCR from card.
 	 */
 	err = mmc_app_send_scr(card);
 	if (err)
-		goto err;
+		return err;
 
 	err = mmc_decode_scr(card);
 	if (err)
-		goto err;
+		return err;
 
 	/*
 	 * Switch to high power consumption mode.
@@ -989,9 +989,6 @@ static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card,
 
 	kfree(status);
 	return 0;
-
-err:
-	return err;
 }
 
 static int sd_uhs2_reinit(struct mmc_host *host)
@@ -1011,7 +1008,7 @@ static int sd_uhs2_reinit(struct mmc_host *host)
 	if (err)
 		return err;
 
-	return sd_uhs2_legacy_init(host, card, card);
+	return sd_uhs2_legacy_init(host, card, true);
 }
 
 static void sd_uhs2_remove(struct mmc_host *host)
@@ -1172,9 +1169,9 @@ static int sd_uhs2_attach(struct mmc_host *host)
 	if (err)
 		goto err;
 
-	err = sd_uhs2_legacy_init(host, host->card, NULL);
+	err = sd_uhs2_legacy_init(host, host->card, false);
 	if (err)
-		goto err;
+		goto remove_card;
 
 	mmc_attach_bus(host, &sd_uhs2_ops);
 
@@ -1185,13 +1182,11 @@ static int sd_uhs2_attach(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
-
 	return 0;
 
 remove_card:
 	sd_uhs2_remove(host);
 	mmc_claim_host(host);
-
 err:
 	mmc_detach_bus(host);
 	sd_uhs2_power_off(host);
-- 
2.43.0

