Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BA226161
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554209; cv=none; b=ZxcWh6l1qF/s81d36ifX4lHlcO3YIu8bTm8mZw/ndQBXGGJCjk2cpTliPHkR7avXQr9A9MNn4NEpSaleFJdvKnmZ/aibyl29gWH7vZ8yV8w3VvbbFt1VMGGXXxVsAd8yB2PyGe7hq/h05vq9bg7UzWbKalbv8X+ojX/+wAylze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554209; c=relaxed/simple;
	bh=wLLJmOQJ18uLKIlN2M5/WYRzh0iJEMOdjCRJqqaJhYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4tVFRdpdEQIw7ez8IK8zwujLdxBuYuOkfwuUl2J+fPKX8B5wPmV99RSqdNTMWrSNjmU+Z9ROUbDyxehmqD86YQNOuGdPy33/1fgyLlG8cIP9MYn6PKyzaXjdvIpegsUfwR6nn+5xTBCWnFz1gVIu+L/IX8N3SJhdR8OGutb8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jg7tMin0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jg7tMin0"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-552206ac67aso6449901e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 04:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554205; x=1750159005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnN9sQ1yphiBQx4a25u6KZxAXJc9uNDdDG1dBOTP22E=;
        b=jg7tMin0YEmDGDyZKwBYm9HuBxAe14hARHx4C9Djb+h2Dc6aSdvkTJL464MJKN8w7u
         6hRqytAQg3HPKOq/j20LPkSJNG0DVMIpqH4SUPyzzlg9AglUOAyWyL9AbAKwOMii/guZ
         KxStum5BVMMShgnzo7h+LOI6sYhubUXyUg2I7ZQI4nwFHXuesX40SWT/3yggnqurIfQY
         ai3miKs26pzfYpqfVGvfAvp1OZ8Iwpf65UwkF2CXrSBVT6oFcjJgCX/+IbMDHJRbVdkz
         JRLwWtxIvzLmLrRW9FfgyUmRD1kDtytSn+744CUWsP0ALMjYluo8X+v5YgqOOIt/sU9k
         F2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554205; x=1750159005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnN9sQ1yphiBQx4a25u6KZxAXJc9uNDdDG1dBOTP22E=;
        b=NeY2WF6xERPL3bwqIshuaUVk4O3EpJw8qttGCuR7B1HhD7gwm74FiXWcpHN/zyeToo
         2kkcUcL1Dw+IdLUJhhKmYmKCjcxdbpqz5j58qeFB6Rk3YdU2H8JHGQc3JWQKv5FPbim6
         rrS/H3hPS8Amo+sDWJrIJBHKdm3I3rBLng6LmdxlRIdfncJvxJo+zTMbv6/4bvCGlf64
         CMUas+XOfu9BWQQH/yBcA/mFBorvMF5FOwVsGEZZWlx7NtZdOom+4jV37WwP5rVtXA5R
         0yxVlF8v5qaJV7HculDChq2xh+ckpJ6d58vLfbBicR+Nk5shWc+pCqRbgfayzBs/ujMu
         fJXg==
X-Gm-Message-State: AOJu0Yy7BKgNSW3wIQS1ntqMeaM9lRXNHEjbrWW47FcXdrRB8URR1dAc
	qtY6w6uLR2jDJRgAqAMWCU9T2A5GXvMCehaUwZY1WHwxcgyQtCYP7IB0mAZbidryoDASKbxTCRr
	+xxVvREE=
X-Gm-Gg: ASbGncuL7Ih/ZnclRdaZZhr48z4OsG8oKkYOYtQmF/H5jcbpSxkbNQG+8xY7hZiY6kG
	hah/g5W2Z71Z6w1zSxWElr0JMtUX+6nReQmSmW2FF1Fs/vZLaDavh0BeRjW1S3tTft009Q4NM74
	Yvk+QNlpEqUzYxBWxqnFGo2nj/u7RJilczxBTmd64Q0slRQ1jiIO8aa2/2QNL0AYKL9fS0d9pgc
	kw9BsTZOEFJ/6DFGJSSPlPUUU3MJvQETsnAedpAKgmXV+NlVG0dY+g065gjFfESJy/25Z4nbO5w
	x5luJs8VegH66Ue0VU9JXd/yReN6ASR9FGVVaVRsN/7pZCCy7pcYV8T642WtV7avl/AlHRXMQrb
	vPNzMnJeDaBOJYqSBCuFOwuCsZGv29zdpI836
X-Google-Smtp-Source: AGHT+IGmpHd8lIlZVdZTjU5PAjkevrDkv0bWhCAiyYC16cFI40T3Wsvz/AvzpYrW0BRCpDYvuwv1wQ==
X-Received: by 2002:ac2:53ac:0:b0:553:20f2:2e77 with SMTP id 2adb3069b0e04-55366e33a1emr3605992e87.55.1749554205189;
        Tue, 10 Jun 2025 04:16:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367722481sm1500146e87.126.2025.06.10.04.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:16:44 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mmc: rtsx_usb_sdmmc: Print debug-messages at power-on/off errors
Date: Tue, 10 Jun 2025 13:16:24 +0200
Message-ID: <20250610111633.504366-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610111633.504366-1-ulf.hansson@linaro.org>
References: <20250610111633.504366-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should be useful to know when we fail to power-on/off a card. Let's
therefore print debug-messages when this happens.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 8c35cb85a9c0..c204cdeaee3e 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1023,10 +1023,14 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 
 	if (power_mode == MMC_POWER_OFF) {
 		err = sd_power_off(host);
+		if (err)
+			dev_dbg(sdmmc_dev(host), "power-off (err = %d)\n", err);
 		pm_runtime_put_noidle(sdmmc_dev(host));
 	} else {
 		pm_runtime_get_noresume(sdmmc_dev(host));
 		err = sd_power_on(host);
+		if (err)
+			dev_dbg(sdmmc_dev(host), "power-on (err = %d)\n", err);
 	}
 
 	host->power_mode = power_mode;
-- 
2.43.0

