Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545000;
	b=Q+cX4crgRRLndiGxk9cfdljJRU16vbf6csEsywAbcsP9ybq9iMhLYHw5r+mz0jBdojvR
	 dE0vd9ZvSuNCf6xHa5vllIYgEJEvFWdBBFRAnyZ0ouYOt86GJX6Dz+5KhDe5nEL8pyxHg
	 SuQbT4UaVXLvqnV6nhNIqkdtHlWq6A48MT/jwKDvIQc9wAFfwmK6tusIudZOQpxxvI9+b
	 kvV2wZfpk2GJBjrDA5T6SZvwEUsKVXqH6JaXIXm/W++09iPk04XdsmQcf4bRCelIJzhzq
	 hz3yge2iJjWJSVuokYn+c3sau4lKtY+6T3+VHiCeS9eva9QvS3HVNupxH9zbj5O4NXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7j6NQ+GDtGAfwdRkFCQTMRmSY7z5XVEstvt7hBMwONU=;
	b=Alr3ksg0UcsZYa1oHnGNPumC9PfAFYGzebh/4P06KzVsfoUl9QkoZ+5nRoe+zxD5NMrf
	 Oa64xlnUvXK51Rqp5NdfeBdd81izkEJYdoofefL3PkdwxMqxOCsXMSWcaGHLiFu+inalp
	 Ci1Evp924qGsDlq+iCzjn0HPh/KefdhKp4FbotWH16ZREoAM/A7rUNFsG5mMNFsApbtuj
	 KASpoNoJ6LKwSivI8bEDwCQOnZsnItVXp5BIg6EY18IrkPWTt9fsQkPfiOQX11gQK3fq1
	 3y1UY0c+swyH48vY9VxEKGiy5K+goxin8Z5d4lZ6shDfDCU/RH0G87HiCvEXJ/f3tAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mezn6k+x;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592E606A32D
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 18:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A592E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mezn6k+x
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-540537f959fso5207630b6e.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795544998; x=1796149798; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7j6NQ+GDtGAfwdRkFCQTMRmSY7z5XVEstvt7hBMwONU=;
        b=mezn6k+xCF+zoCAKeIiUkqMUHcOIl/J/XjYDnf14QlZy/EQCBdTgR1/HVIP6xJe9VW
         aYCT1mZz4qUgeFosoGUvcK2O6ZZPNrBeNQdmef8Pw4zIPa/HmYYVsSwaTqhDRmUzKA09
         scTeqGErq6kTqFhxlI2I2gy1F9VC75TRUQW+NDBvlOGWXiFcKWfFHsuwKF9cId+YgFVK
         HCnyqPHHeDEAC2dXgyuhmjoEelTl4V7i6JCE5wcRyofzpV7PBSKY0PVWPoCNSxwLYnAd
         6aCzQZiTFcAw+MSKZWMH32juhUNZ+hD9dspx8EK96vdBmu2mf05TQYdkmYCcn0Lsroai
         FTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544998; x=1796149798;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7j6NQ+GDtGAfwdRkFCQTMRmSY7z5XVEstvt7hBMwONU=;
        b=OPMOHmyYnyGDFvTKoBwsRn71QulfKdigu/bdPwCwJxLqgepvl8APA/4ZRNUVWNTrLS
         mwJvS9Ws4CW0i7mNPoYea+jo40qUuyGN1q5XcrwdvIqul2QH8hIlmJKMWjIXq44mpqfw
         O3bWJ/R4pkGd/YmvxyGgfUA2/NHgzHbiL2GOlzzM+QCw19L+2dL+UFLi8Y1QjqV98SoZ
         +daq8iBjxkU7q1rJioRv2Bi1hykpLYWH4a3RFeU+ttcCwpCNDeKksHc+hLr68KdvIcV1
         q4cfEKBDRaOJQTJfaR/Digz5+ChX/163GYsQGyyiiPLmOTBo5afYe8QseU5Un3nih6a1
         hOhw==
X-Forwarded-Encrypted: i=1; AL+hErFIBTJp9FMAOI4yoeq8WxOT99V5nDLmJbxPBjv2mUesMlu3QLkcn4WP1dwHH6Fi/JUFc2lizR1if38=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uO5iqakuTqPz75vzpfDbcQDEi2k5jt4vrQIzvsXmJ30r8AiNQ
	Mpx+ruqoLwOxtTb4/+pLdBkkoGpjiQnNMeWL9L7FTs2gmWh68hueVC+JeTsoku0QEIOh1Y43c4r
	baf0UO3ekCAJERQ==
X-Received: from oabvk9.prod.google.com ([2002:a05:6871:e49:b0:4a9:9e93:8ee0])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:f03:b0:50c:bc6f:fba8 with SMTP id 5614622812f47-57a0c7c3651mr17024101b6e.65.1795544998225;
 Tue, 24 Nov 2026 10:29:58 -0800 (PST)
Date: Tue, 24 Nov 2026 10:29:13 -0800
In-Reply-To: <20261124182911.3886897-5-wusamuel@google.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124182911.3886897-5-wusamuel@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124182911.3886897-7-wusamuel@google.com>
Subject: [PATCH 2/3] mmc: dw_mmc: restore IOS on runtime resume whenever card
 power is on
From: Samuel Wu <wusamuel@google.com>
To: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Ben Dooks <ben-linux@fluff.org>, 
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dw_mci_runtime_resume() resets the controller, so the I/O settings must
be restored. It does this only when MMC_PM_KEEP_POWER is set. That flag
is set for a system suspend and is cleared at the end of resume, so a
runtime resume at any other time does not restore the I/O settings.

Restore the I/O settings whenever the card is powered, similar to
sdhci_runtime_resume_host().

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2f60bf8adeb5..9e920275868b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3487,7 +3487,7 @@ int dw_mci_runtime_resume(struct device *dev)
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 
-	if (host->mmc->pm_flags & MMC_PM_KEEP_POWER)
+	if (host->mmc->ios.power_mode == MMC_POWER_ON)
 		dw_mci_set_ios(host->mmc, &host->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
-- 
2.56.1.831.g720f3f5937-goog

