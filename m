Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493A1FA177
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039693; cv=none; b=K9q4AAh8XpS/cJci5yE7KfiBp80qsKrTYIElx9Pdx7TKCHYg8MNTrk/4mp1xMWHBUxggFN9gnTApZuA9sQ+Nlq45k0uL7sF5gTFH+prFcXqSC8/RYlwKpZetJ6LbEmEj4RRms59Sbwk2R49zNrOAR5GLAnDnh5qRITTQnK2bM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039693; c=relaxed/simple;
	bh=KZB+pX8+Z+t02Vyu3JiH1fIAeOGA3SvV4prne66BLo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4N1brFTRFPBIfUys9j1xEIeAvF0bB/tlor/DdJN4P7Gi3rEHs3tV/GEVLsMKTw6GQ+5qFCVAoI9l/eohbmojQ8licqLcYhri3qjSY3+s0XFR8D+ydQYHjzoO6ahzsy/Sq5inLEgBI0HW9S9pQ+7yxoDxgTL1mQosfvj2KCGEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HdAI2e7m; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdAI2e7m"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so41053921fa.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744039690; x=1744644490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa0NqKrTJ654Zn0Q1P84Jb3f7w9bMHpFgeDh4gI/15Y=;
        b=HdAI2e7mDs1MEGlnG9DCsAZAN6uv0tgrwh0PSd6SBdIzNZ+h/bI9WrQsuMfu3fQL18
         U7OfNz7jdvi2bdtbxaVOGmT9QldDz8Rt6Fjd8tM87Nymhv+D6pcLrEym3BD8GcFzZaRD
         MPTrWww2ybXBfNJwwU98KOIF52xHJVylIbymjn2QH2fy1QOM+qoVb+O/k9WKpu+yHcZG
         GMdg6tZcfwB0xAdmVWnq6WRhgqZncDirSyizjfrNlAmVN9GWvR8NsrnTdSL7FyXef4u6
         hUW9tAOjwyaXzfLsy4JHkD2UWzenYg+tXhGiYPgu+Mx8gwf3qaabaiJ0EmlTcvg4XGR+
         9nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039690; x=1744644490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qa0NqKrTJ654Zn0Q1P84Jb3f7w9bMHpFgeDh4gI/15Y=;
        b=ZyDwUx1FNLOhwmgJSMFK6Xcm4emMs7NhOtOCryXiUUAHSF8nh7ZHp2aE4xPpF2IefF
         znpOBdZNYmbGzgV8zgixTyMWRqYrT8dZkNkbdh8R3OHTU7gON9D/BSa0dLanNTSDeo3x
         l2mEh88bI7m9J73zE45bOULFV6/gtXDyuOj3QU+AdsO7qmpPUaYblZ2gMFJ3BUoweTWE
         iOmnV8WTZHGfJtp5NEp9j7BUvhh1DaQou1C6smbXV8y+dXrcm8EAi2Z7/zX0EWQK6jAu
         8tZtu4xuFKhB7dcMNdJHhwHQMOZJgAqbm+msoyy4dJcH70EO2yB0Q50ztYzZaN3yNfhO
         I0Dw==
X-Gm-Message-State: AOJu0YzakNE6qRGkmDuag1lVotdcWPYYU8GY/jwlAMEYuKw6xy8L7s35
	USTVx+pgpoygsPlFzrBKdk6FP/KvWlbgIy+o88dPN87owRIY5FJx3sorWEho7ui6N9t2JyHELdx
	T
X-Gm-Gg: ASbGncu/igQvjxGvcYQJMGH00rBYnS+HIM/5GBxCvMX+5ZGMPzb8qp/Q05m5otejcJb
	FiNmMFI+WuH2ADg+VGdeEotpuLL6KLTL051XueRzoHepeiXl3HkQdyDmFm4I5nuoe8yFDwLYO1u
	jHA4SKRXMbllBgMyMJMxFImg2g44O59F0L4DEybXwNTdpE+c4IJjS3n/PwjQIGGMJ0/oZnppl+i
	/jpdJNx2NfHK9vxydZ20taA+wqG8Op8PDmt6Vll5UDyRZrVk8uI7asTw3qEaC/fD0vG1s2zgAs9
	RtKHqfdbtbfJzPlOjqrUjG0mX9DprpJfD1d9e3pBtStbEOnPQGHGPfPtlrHCcS1csl8iU4pFmum
	rU6JS7T8eWMZgJxNDRL1W31mdvhu0Gg==
X-Google-Smtp-Source: AGHT+IFeOmjZZCVinZE9PYC+J15PmJZZVU9CLynwj9bgWoY1cdAzycB5GWB7cxZRv+fyPdkRgXGDbg==
X-Received: by 2002:a05:651c:3130:b0:30b:cef8:de87 with SMTP id 38308e7fff4ca-30f0a0ec55dmr40033581fa.4.1744039689698;
        Mon, 07 Apr 2025 08:28:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314c62bsm16158691fa.61.2025.04.07.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:28:09 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Avri Altman <Avri.Altman@sandisk.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mmc: core: Add support for graceful host removal for eMMC
Date: Mon,  7 Apr 2025 17:27:54 +0200
Message-ID: <20250407152759.25160-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407152759.25160-1-ulf.hansson@linaro.org>
References: <20250407152759.25160-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An mmc host driver may allow to unbind from its corresponding host device.
If an eMMC card is attached to the host, the mmc core will just try to cut
the power for it, without obeying to the eMMC spec.

Potentially this may damage the card and it may also prevent us from
successfully doing a re-initialization of it, which would typically happen
if/when we try to re-bind the mmc host driver.

To fix these problems, let's implement a graceful power-down of the card at
host removal.

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/mmc/core/mmc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c41cee7ef267..48656dadf93b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -36,6 +36,7 @@
 enum mmc_poweroff_type {
 	MMC_POWEROFF_SUSPEND,
 	MMC_POWEROFF_SHUTDOWN,
+	MMC_POWEROFF_UNBIND,
 };
 
 static const unsigned int tran_exp[] = {
@@ -2054,15 +2055,6 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 	return err;
 }
 
-/*
- * Host is being removed. Free up the current card.
- */
-static void mmc_remove(struct mmc_host *host)
-{
-	mmc_remove_card(host->card);
-	host->card = NULL;
-}
-
 /*
  * Card detection - card is alive.
  */
@@ -2088,7 +2080,8 @@ static void mmc_detect(struct mmc_host *host)
 	mmc_put_card(host->card, NULL);
 
 	if (err) {
-		mmc_remove(host);
+		mmc_remove_card(host->card);
+		host->card = NULL;
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
@@ -2160,6 +2153,20 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 	return err;
 }
 
+/*
+ * Host is being removed. Free up the current card and do a graceful power-off.
+ */
+static void mmc_remove(struct mmc_host *host)
+{
+	get_device(&host->card->dev);
+	mmc_remove_card(host->card);
+
+	_mmc_suspend(host, MMC_POWEROFF_UNBIND);
+
+	put_device(&host->card->dev);
+	host->card = NULL;
+}
+
 /*
  * Suspend callback
  */
-- 
2.43.0

