Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37816346AFA
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969790; cv=none; b=u/YGoOaizmWU5KyAZf3jJxmGwfMr4DS8Zh+dscRVUS5skjLUOfHgOzvlwElXeAjjlCql4r9iw27p6TkTv3AcyuRJjH5MgBADWaq1hOT/IDVyWcUAyaLFyvcMYeY1U+NfFCer/TFrMBXlZgJ93EN9BNW+u9sta07TSwaXJ5PD5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969790; c=relaxed/simple;
	bh=nVg8/dPMXpd837fVnH+nSt0ymYJC3P/GUTRjjIQmYt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9Q9o20HKSnUGYcaUDk/VsY0fa+1v8zR+9GMOAasEXega24MrQDsWV78Rr2QJJpCGCaMQdO1OEvTmKsTNRCJOK9DZjvP5CvUX+R+5pJGKqnwyJNWEqI4fTktCdkS8daPRjLD8NWdOJOAg0htw/mPPQ6ARIBOQ5AX0j7xYrttwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oQzQ6cNJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oQzQ6cNJ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-649784c8967so7580002a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 03:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765969785; x=1766574585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2SwmfjF77+ak5KfsorzokdI/DV+t+DAcXlk3P8v6RY=;
        b=oQzQ6cNJ1SSixAVxQ0zuOHOKeR+QiTCMfvlUtxNQs7eYV3gjFFxxNxj327I3V9iAdc
         mWAOu1xfqKiUxJRncTsz6NbwvKxXHfMoSmwAJOT0vkrK1ewneUmsrPp7Q72n2eLYKJ0L
         46aALrm0d1i3RGOulqFdrZ/MpRKetN6bOqtOMgyESxtxzERlTJegwYaaTAz9aEAESm+m
         PJ86L/zyuAB3G3ZRabrN9oN883VGgxZJ6fs+ukA3icPn+aqHuK7MROwfm5IXvNn9o9Cq
         Bti7mAth70NntrqiTAuxqSPRjVoQOj2VpJYILkdNbbKkjyxcuXkvIY3qEv/skU5Lt7dK
         ektg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969785; x=1766574585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2SwmfjF77+ak5KfsorzokdI/DV+t+DAcXlk3P8v6RY=;
        b=QjGTeQPvCfJ0W5l1dXj6pW37rkSb+ufHIFM2CJNUSHVHHKIraTXfTbJkC3+HtzHlMs
         ySqEttuKh1MXOgsmZpKuGkHrn0mCe1qx0QNPVRldlpiOtNYjX+zZX8+BD3fGEUmzpTqw
         CYXD/Btqsd8fPB3BAVcu11suT5cx6TMIGfbuvf+7jrPAn7AidDDcU2HtaqbeYR8rQ7HQ
         Ta+AchxCBEykYVCwMFAYKpOc9suKmqedQb85t2tRglAfm0ff/2YIi47WQpXOpPW3uU3e
         BWQbFXT1/i2FU+oItgTSwjy+lqoC4NIktY6gNLyiVMkWgMLHwiZG/z8ZrEbmMPtTFmaT
         Ib5Q==
X-Gm-Message-State: AOJu0Yy6X0KrjjoXxdBIvtHqDRxgXixYhmlmXU79kSQ+yHWyUW7mKtXO
	3SJBswtohy8DkAsA07tTnGKxnmPO+sJ1sECTkdHoGLUeK/azwWBPF3xp9JmK1/FvP0Q=
X-Gm-Gg: AY/fxX4D0xBlGYjohfSAGdJDVCzVnmlHR45ErSw0i0Rxh1+vwYq78urhUTf4bUWnZfy
	iKAjzwaN93mZNaXVPLdSko26BUNyCal/AxR6ivQIlnSFDZTzb+VMvu4CGx3S1FIiy6j4Rppnzl1
	A6kfK65wY13XtWDNBrPvl1ZGcy15Lk24UrRgWY+3MbzE4Q3wu5yvvU/MefnRuFCCXsDtYxoHNWS
	fTdAGHb41d60ZmOSk+m5V4m66A565MtMvZyAwTR+oEFgNwuzkb+mFb2+2pTiueNPP5dn7YC7BMc
	h4yy41/UpQA28Y5vwig+rDoFV0SfbEUhF0W0PwMZ+OB2FUAWw8gvg0nLUYp4OVeSFMkI0W5Mi7M
	vUJim9tI/meCAl7p3oLyXW71bbEMgO9Z4rr8Yz4hUV6dfmXtwcUCN2IeK1gtdIF+Cljo2e0NF9x
	qS0i85wFIgto8pFzMG
X-Google-Smtp-Source: AGHT+IFplUWO89lh2aiL5iam7o05siy3yB+bol9YYYWazAW0/qp1x2HCivhkkPaRZ9Jt16WUujSU5w==
X-Received: by 2002:a17:907:3f88:b0:b73:870f:fa37 with SMTP id a640c23a62f3a-b7d2376d4abmr1839041166b.17.1765969785523;
        Wed, 17 Dec 2025 03:09:45 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64b3f4ea67esm2187104a12.7.2025.12.17.03.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:09:45 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] wifi: rsi: sdio: Migrate to use sdio specific shutdown function
Date: Wed, 17 Dec 2025 12:09:25 +0100
Message-ID:  <53a46d554faed2f28ac0c0e981ae12badf020cab.1765968841.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765968841.git.ukleinek@kernel.org>
References: <cover.1765968841.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=nVg8/dPMXpd837fVnH+nSt0ymYJC3P/GUTRjjIQmYt4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQo9p2+yijRwC6XFA9QuHYJCtpCFALJmLX5G9w /koL3Kvs9qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUKPaQAKCRCPgPtYfRL+ ThenB/9LkYKkq3huDqcvTI5BmhmEVUvbrvh56Hn+9R8lMBNooYjjmlGSqUVH9MicnLk1HUj/pun iq1NhUx18isDq9UrUdoMs0lDPJYBoneQlAp6Yrk6tf0bgAJ+q6GwvZgbwsCcM2e9L+Tl3unSfvx 6qnbfs6OOI3YJkJ8YYCralNhNIDSXVqXcMmgxmwNaQla+SCC/BfybpkDszHfuUkfCEioI0LYyUk 7p7I15Udpx2NBk1IVUQ215tRcW/ef38DHV5NWV7hCob+CtmUN8MtWRKLyL6GmRlNKGlc6/I4OYy 6BSKzrkSnsaIPLSoDfp6+I5yPTRtEapHphn1RVVpN7/w5Rmx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in rsi_driver.drv to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index c2b2d09b616f..a1376847ac85 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1442,9 +1442,8 @@ static int rsi_thaw(struct device *dev)
 	return 0;
 }
 
-static void rsi_shutdown(struct device *dev)
+static void rsi_shutdown(struct sdio_func *pfunction)
 {
-	struct sdio_func *pfunction = dev_to_sdio_func(dev);
 	struct rsi_hw *adapter = sdio_get_drvdata(pfunction);
 	struct rsi_91x_sdiodev *sdev = adapter->rsi_dev;
 	struct ieee80211_hw *hw = adapter->hw;
@@ -1509,10 +1508,10 @@ static struct sdio_driver rsi_driver = {
 	.name       = "RSI-SDIO WLAN",
 	.probe      = rsi_probe,
 	.remove     = rsi_disconnect,
+	.shutdown   = pm_ptr(rsi_shutdown),
 	.id_table   = rsi_dev_table,
 	.drv = {
 		.pm = pm_ptr(&rsi_pm_ops),
-		.shutdown = pm_ptr(rsi_shutdown),
 	}
 };
 module_sdio_driver(rsi_driver);
-- 
2.47.3

