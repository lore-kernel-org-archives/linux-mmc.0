Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544996;
	b=sZc6k00lw6YaZaFDSL2qzZPuCBQAVXzr7/bElc65gMyv1Iws2YzQLKUAtgcaufGQGv09
	 holxVx5xF4XYavJ10alsCXijqJe7z+XkyZ8RMG6Lsccr0Z4FUDWkF06v305PairpPdgsb
	 7S23lkCayr27QXMTdYR7S+2W8bk0ob1Y9Yikg/8odmqZV3AThw/iC0decdKi0Dnff0EOt
	 phR17RmkKDJSSD1bgAfQXWSlKHupCyLTPI0Ufb0WTGZ3dP5Bd6FX9Rs6uXEWfXgDHhLwQ
	 GI6HlXC+bO4wVuldsiDs4594oJCySd/xjUvbZriQ1u+X6zs+Gm6lUdDwB5Ti3iA+IEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ciGcDUdqZ2SyKahhKhdiVa8n3tyewBQyhVUHy8NVEpE=;
	b=0+eJXS/stRXREdEcQ13rye5TzePg5QzvH0A78jdLogVwV2kJjIk3ecXwcsUHK7bxkjYe
	 jFddm/zZZTKWATfhX4UeUQM4Yylthq8jldanCSSgvL+FE42LLMClvvElD79kyLzNzt7Tr
	 BCYaeGHQxGcjTCQdkOc6EX8v32w41X7ZVXYZRSZPqSV617bhK6k7EXJrjfBY1/wtLHdH0
	 RWbFtySuSkfchIwqHhNmcp1V/bHwbJ7z8M5geHPlEt5UUAkWcwwu/I4Bnl4qQ3FGCHQ+g
	 0TUI5rj7B46Or/pT6sTTJBVbSJOQsbG0JiR0JblaL110yRQsCqXdGE+tGwhLNErBtNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OOJRn9vp;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91F606A32C
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 18:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E91F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OOJRn9vp
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so3087244c88.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 10:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795544995; x=1796149795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ciGcDUdqZ2SyKahhKhdiVa8n3tyewBQyhVUHy8NVEpE=;
        b=OOJRn9vpNBxqwRLNJuAyMJTL/DC2nUJRPW1MTboWIjyDMOwjZZFCgoT2A77THMjXAq
         sM0L+pSSCd+ppBDKiFGaKajX+26WneJxq7mhNUrE2HNQOsmFcvIefdk4pF0+T1ykKB/I
         NZA3bfLd1bO9MQ+0Ct7BWy51taMoeWTtBE/QCpUleh7Dng93KTlQgOhU+/Gs0Jz6Z1xH
         dghYsCc8Svh4q4J7X/6K4Z82xuWR8jV1Ek7nmvp486IqC9Z0UrHNrgS7U4AlZopAi3w9
         obVWYZSuBfA4b2WCzY8YAJzXb2DP0VJSjZGy/r5b1nHhW2kcSF8J6JE5xiSWLlvqPhXE
         7MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544995; x=1796149795;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ciGcDUdqZ2SyKahhKhdiVa8n3tyewBQyhVUHy8NVEpE=;
        b=UoU6rbxmVhtH1ZcnJSMNtX4wIZRJoEcYntoFwY657zL7YvMM8JpdV76e8/jH6r8Z4j
         E6RHncXtDc2jYEfOyv9bRicSuFEZoGIauZTVmG4tSlAUmcv2Ym7fo9hMVguv05MkKNS6
         XkSZUYY/vGQt+XPSLIl3IhakJRM4dPPQYghI9/vfnGFDHjDPfN1clLp+KifoVXowWLwY
         uFsox4wiz+E0n98NjMS28o5J+QwIcbTiCeXhMtENjrkgK2nFOMi5WYYN47O2z9kbKEu7
         n8S0nAdbJF9BsGctVkOgmNm6Km+ILnzOeyfE9IC0RRwJej2KonNJ+/chbKDAVKtQkYRg
         3+Xg==
X-Forwarded-Encrypted: i=1; AL+hErHukJFuQatUmSocETdqnWukWsZyXwamsvtOHWRax29eyzb6EiWX4BPv2OVz0bLfuzPwFiPjJyVVGY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pZTXER4r0svNgB9/b8QFez4W8menR3xIkYUy4rFzSdrYA+1tP
	qzNRBywDaYzqB6CBMLPLKojvQAh4sY677i1KnvX72AUcW+gwR2jDNxYmMHvpMfYA5QGZ/EG6bhS
	KtOMNIXvFA0h35w==
X-Received: from dli21-n2.prod.google.com ([2002:a05:7022:295:20b0:1a7:c918:186f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:698b:b0:168:3243:c91a with SMTP id a92af1059eb24-1b556865248mr20748508c88.13.1795544995049;
 Tue, 24 Nov 2026 10:29:55 -0800 (PST)
Date: Tue, 24 Nov 2026 10:29:12 -0800
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
Message-ID: <20261124182911.3886897-6-wusamuel@google.com>
Subject: [PATCH 1/3] mmc: sdhci-s3c: runtime-resume host before system suspend
From: Samuel Wu <wusamuel@google.com>
To: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Ben Dooks <ben-linux@fluff.org>, 
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sdhci_s3c_suspend() calls sdhci_suspend_host() directly without ensuring
the controller is runtime-resumed. If the host is already
runtime-suspended, SDHCI registers are accessed with clocks off.

Call pm_runtime_resume() prior to accessing host registers.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/mmc/host/sdhci-s3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index ca6120adb21e..379961c62917 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -685,6 +685,8 @@ static int sdhci_s3c_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
+	pm_runtime_resume(dev);
+
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-- 
2.56.1.831.g720f3f5937-goog

