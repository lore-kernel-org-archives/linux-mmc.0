Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72322225410
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479261; cv=none; b=UZyUlMtSr2vXfESlveZdBQYJ6hc6B0D4HfYtoRrc71St3jC887vn+LPgI/Az5ct4bCDtgxWhoG2XEPSNQGQuTXEISAhvUVoWVUThquyjOqyBBoKW9iHIdmrp5D7/0+UR3+61iWLRjDRNyZit4mVv9o/S7xo7nqQVS8ZJA9hc+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479261; c=relaxed/simple;
	bh=tJcpx7kVoOVh62Qzq7CsqXZyteSS2xTmfx3MklEEb5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbcxnb7N4bJwSxpNZdEy+kLnkuom9g8F1cGzhwbw3B//NW0h1hMNcyO8AhUGkd5J0bq3bHU2OVRHUauCBBlRwQY7ryM1DTgs7Un5alr/PuA5KUzNIMsC8ylvOq4mrnPeGsz9wJCW818gDTXWvEOY5J7OdPG0wKwC3FegdLXcaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovGwlYVK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovGwlYVK"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-548430564d9so861775e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479257; x=1743084057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cpurPguaZZPLjWUcw85lV4P2hxnhe8DmTCMrQ+sP8E=;
        b=ovGwlYVK5p5MCyM7n0n+8jzkYo3MDkQnvXTmQoBhq/Fjh5q1C8rjW8+ORWSc16MwdC
         bfG2H8MJeRj1WXehec8O2cCg/yKJGsAJG6c2aSvvVjDVuAuWKHkNW7bKFLr9cHUW0cXS
         OFIplJZpUJGcrZxpKZNOArUOjXFd8NcXyA4RNcOAfcjx8NcRArND8/CBRZlhB1k95wck
         vEdwWTfLJR+uvJDNLiE6CdoXE4l9g9eBPfyoAzQh3ixQMw+V/7yzpV/DFJYm0fpcpumN
         VvgkXx0rWCMtS6OCHQNWYM/7W048E8KX3lh+NXGxFqOEo6zAlH1+MZ/FuRNcD7rRE4IC
         x7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479257; x=1743084057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cpurPguaZZPLjWUcw85lV4P2hxnhe8DmTCMrQ+sP8E=;
        b=S2L7un5g3o4wgr3uXEKCPDn6XTzBB3qujvtxoJQwXl4Ipk3dQ1U31GtNqO7hE0TciH
         bUQWhJZChyoHUi2bgME+7yKi9XLUnY2Xmb2FY3xR+GHZHgABwMpGVVJnUBs1omYnxqKE
         IOCBIlkVPf2vcupABBfI03UBCCkW9W8Y5VL4N6ogXJZn07cB4c2g1Jw3N5hCVDOT3NNg
         8EHYSgW8JDHksxjHaZU3dQRMKmh0GJh26z9JbDg1z3p8dx/oExIEc8IAMyfgiWtTdx3o
         f2LOUFkAHegAFSC4tXck+CO2FI+P0oLB4h1Yq/oAbcxTZQQ7Yl/8Lg1EnyiBLMfHYkBY
         wY3A==
X-Gm-Message-State: AOJu0YyMGkKtLIlt8MBIwk32qI/6nPffDsFRMDcKq7pMSKWu/Ib9hLI7
	Zdh0bKTkCPKUoXlap0I3crvwKA4ZuubxHvvyhDQ2d5SjILWDlYR14mrQycN6Kq8JDBfrJ7LiBj5
	V
X-Gm-Gg: ASbGncuwlVDjia4Y7g1K1zwUCuJ9Ik2bkt5vYagZb5KDqZnUYD6+5WV3qzfZmg9M16V
	qwyFPCuLqQADMEasAuznSGTNilpotzgpVe+JTMC+Bf48xKqhahyNB4mfDSxhmZUseu3JuEUIIgW
	MP3h49RqywjnU3ZfAmr5t0/4H9JSf68fkgmU7h0N/PgXcPpEswHfamCrJocYdEyWGPb5xeqlgjZ
	fcpa4vzjaqZyB2MIkn09j+euTHHxLTcmnqUDpxN13u1sG2ySa0ivS7eqYj0/ntLigj+v/AdMPmk
	yj+cuit8b31d8MJTx0KqEi26Gvq9DXfjd2Uu6O073b3JmDP46iZJrXHgL7lvuviQNAAF6oM8KAu
	//Vd+3lF0bijcFUIdjgoa+PKuyXiFCA==
X-Google-Smtp-Source: AGHT+IFI1fZrjfRWED8P3YwlNenPg/UaJprkHPw65/8Gv1KQD06yFcLy7lNo8+Ww7atrOreTQU9wBQ==
X-Received: by 2002:a05:6512:400c:b0:549:9078:dd46 with SMTP id 2adb3069b0e04-54acb21a517mr2932004e87.43.1742479256977;
        Thu, 20 Mar 2025 07:00:56 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mmc: core: Add support for graceful host removal for SD
Date: Thu, 20 Mar 2025 15:00:36 +0100
Message-ID: <20250320140040.162416-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140040.162416-1-ulf.hansson@linaro.org>
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An mmc host driver may allow to unbind from its corresponding host device.
If an SD card is attached to the host, the mmc core will just try to cut
the power for it, without obeying to the SD spec that potentially may
damage the card.

Let's fix this problem by implementing a graceful power-down of the card at
host removal.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 8eba697d3d86..cb4254a43f85 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1596,15 +1596,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	return err;
 }
 
-/*
- * Host is being removed. Free up the current card.
- */
-static void mmc_sd_remove(struct mmc_host *host)
-{
-	mmc_remove_card(host->card);
-	host->card = NULL;
-}
-
 /*
  * Card detection - card is alive.
  */
@@ -1630,7 +1621,8 @@ static void mmc_sd_detect(struct mmc_host *host)
 	mmc_put_card(host->card, NULL);
 
 	if (err) {
-		mmc_sd_remove(host);
+		mmc_remove_card(host->card);
+		host->card = NULL;
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
@@ -1730,6 +1722,19 @@ static int _mmc_sd_suspend(struct mmc_host *host)
 	return err;
 }
 
+/*
+ * Host is being removed. Free up the current card and do a graceful power-off.
+ */
+static void mmc_sd_remove(struct mmc_host *host)
+{
+	get_device(&host->card->dev);
+	mmc_remove_card(host->card);
+
+	_mmc_sd_suspend(host);
+
+	put_device(&host->card->dev);
+	host->card = NULL;
+}
 /*
  * Callback for suspend
  */
-- 
2.43.0

