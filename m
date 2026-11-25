Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630871;
	b=U588x6TjGu6R2XV6oYonfML9IZryeDbbwBqDqAncCE5JoX0eTlbROA3pw84pTL7egJMC
	 scFOG0sWWN09QHYI3YqTKoHgnrm6fHRxH6gEREgGfwOkMKD8t2FjoP6VTpKHhkvPSucbF
	 55BKY8DkB/jFsXKNRS1QWGmBZfW1JFKHpjdAoO5QDEWowOLFlmck3TTx72Q3YeIqAAtSL
	 S1lD/z3prmlhRsbx40ZuFgTlbu4iaqnY3w45uaUrVtRw3CaqkvUh0CTXodNfQpInSY7k4
	 2+3lJGU8RobFJG7ua3ulV58PabUlBEJKcBHOc/XWsaLsF8ipjs3ZEmvYyQRb4ozjjYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630871;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=fCytLPbTQSjOf7Vpu6o9kchdmZ8p74IaOwZ5U8CL04Q=;
	b=AFR2LmhPaKlIQgiU8RfbDok2D2yCfwBo9sWPRjJTMWNJJmg7jO+UzPZAQ4jzwY9MEz+j
	 OrHqF/OX93FRTcI/Lain42AejCc0zAaVlkjpc7byDv4fsB4ndkgtOwP02ozmm400ptpcX
	 owVFQ9/9pt5Ba7aTgr3SUR3w7NHiGvRBNhs6KJ2m8AAVk3w5mDDSWn3P43LC2CwQ7Ubcs
	 J0KkUVwPHFuZnYY8be5VMKWi69RW2TL9RuoKYWBuPTmWBjbFU8AbqiHib1Xpn6Y6kJuLL
	 knrK9JvQpFT9Zwocd3V3H6WcWgZ/fW8o+Br52+0LR6U4hevPJC1LXDg3QXqdxPawwPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OPD5IsaT;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67DD606A333
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 18:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67DD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OPD5IsaT
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso3198245a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630870; x=1796235670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fCytLPbTQSjOf7Vpu6o9kchdmZ8p74IaOwZ5U8CL04Q=;
        b=Fe5rJ1Cj0mtKfiJP7OhECu2DLnoiH4ohy5j3cbxWiH7x1DobdkH94ZP+2mp3+Wqkr/
         UIephjUHdiv9bE0Fu/WOMmgMUt7vjKXxmYCD6m+gcWpjZ66fE7k1MT2zH1AHzQVHmkvh
         QX4Q3qnTszZ7hLeujOiwfv0OmkLuvUsaxAde5fFyo2NWkqgow2sVw8HOBLM9IgpUV2wf
         /o5jcF9nqv9uvh2Nmzz5IuWREDVkp6Y2AR8nugCIXcIwj3t/PNzBl003X9v6spoE/XyQ
         CdqIZWySCemdiPL+YKSSyy/oaQYVaF0IJhsDDEMNj1I8o8kErJp63FXndvqi7WM69LJ6
         bbWg==
X-Gm-Message-State: APuU4Z8IRa2o4BwMnY5LVeX8+RjPvvEQXhHL2KhkGYBt0v+wv7bHKmLn
	nF8Ug9Bpq0nlN7/DVmN4Ff7k5B+KB/RpFGIh+cgoLmRmpfz6VFGA4AN80kXUYFBVKcqh2JHXryv
	PmRka7mxRDB44734+t+B7OEj+yglzyxk+0rIBGIQzOA+mE/LuMJ1pYmI4RHecdKAbTHRI9W/UGt
	01VvYia6xhwrIKjVa4L3TZOpHlFFXaoY2/fGqmy+SakoXadabjzQzVCJ60MoJDfDlnHurCqlJn8
	MRLOItdgw1G
X-Gm-Gg: AZFdTZdmybJDpElyYUlzMz0S4RhDdQh5BImiZuOj4gUtqXCNC1ejsuPVd1fe0MpEbTP
	kNx4YwRRxiEFG128R/VCl301e9B63YluioYlL/rI7iZ+2oaqBpfZm18MvM0XE4B//QTS0eM7aj1
	4zgf3W1gisHc9YydIO3Rxv+FqW17AxAyI8kBAjvW1a3hEsuJ2fw81bsc9eYSeYW2nTAMefZ7gob
	d1ogJ2cTihLaFS7hLV9XuI37bMb8BcVI7y7fo1U7bQh6fk0bQfmhaWG5k9S4QXKO+IeQ+giXGHZ
	Rdg9lxKsv73KtCkORZh5m/7cibeM9tUR15IwBPzOzJiQC7ESG0TEqKaE0Myba7XoFSO5kflqndl
	yXIOecfRlrQNehG7IPwUqvcau+ygFmX5zZFzR0A05absNFbhVnKKnchPvZox8KfQhl8xzLT1+YR
	mZH1vxSEQN0f/Yye2AOD66Yt2YUGqMnrRnlU0=
X-Received: by 2002:a17:90b:4ccb:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3b41c8dc8aemr17308039a91.22.1795630870347;
        Wed, 25 Nov 2026 10:21:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b42a5a2de9sm12404863a91.5.2026.11.25.10.21.10
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:21:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-946038e22f5so234342285a.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795630869; x=1796235669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fCytLPbTQSjOf7Vpu6o9kchdmZ8p74IaOwZ5U8CL04Q=;
        b=OPD5IsaTISg6sb+rgiXx94CpPWIX0jkkortJeADY7RArtWZQBlSWH5mkPxstplUx+J
         IgnYXTzicnWOke0YNZD3XQEEDU60u54x6/+MB/P7LRO2mOjBq4GZYDQv/8LIcRZoPsVj
         6NdTvsAXkTE1i4wBZDFpWRz/Pgcql1kF7V0hs=
X-Received: by 2002:a05:620a:6609:b0:93c:664e:e212 with SMTP id af79cd13be357-949ba9e83d2mr2856747185a.32.1795630868812;
        Wed, 25 Nov 2026 10:21:08 -0800 (PST)
X-Received: by 2002:a05:620a:6609:b0:93c:664e:e212 with SMTP id af79cd13be357-949ba9e83d2mr2856739385a.32.1795630868124;
        Wed, 25 Nov 2026 10:21:08 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1375419285a.17.2026.11.25.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:21:07 -0800 (PST)
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
Subject: [PATCH v14 5/6] mmc: core: Move and split reset functions for eMMC
Date: Wed, 25 Nov 2026 13:20:52 -0500
Message-Id: <20261125182053.3915833-6-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
References: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
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
index 93bd9b44e7d9..122ac9ba0a4b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2273,6 +2273,44 @@ static int mmc_shutdown(struct mmc_host *host)
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
@@ -2321,39 +2359,6 @@ static int mmc_runtime_resume(struct mmc_host *host)
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
@@ -2412,7 +2417,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.runtime_resume = mmc_runtime_resume,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
-	.hw_reset = _mmc_hw_reset,
+	.hw_reset = mmc_hw_reset_recovery,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
 	.handle_undervoltage = _mmc_handle_undervoltage,
