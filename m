Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003683;
	b=tAgk5xdayGT9hCggK6Gjx+GId53adSk8KBPVwb5AhlIh5WFfZrl54vriTRpFzn7pwCnW
	 /UHlHpum927PHPS2+zRX6/gpz1G/AZg/wsXzEvnLliFcPPOxtSWcIX+1BLxB/3nFeZdBH
	 fAXC/TTd6XxtC7P2FNx4Ptw0y8mgZO//3G0HT0kK2uDNIYbied/lnn0GeOm1NhDvwdAz5
	 wbqRW8RjTH7qA2TWa1oKz9DkBN/akmrOJKiu7+FTqt7c5NpHudDQ4c108zSlltdeO0AoN
	 Z/NT7doK5qHaZh4OE3qqtZfBQtYBxSs6/mR2aNBb89K/Y+iizXFWeIfDxhZHhFBYFSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B7dQENZy5hO1NBbTQGYEZ7DmBs04uprzORGYnKqQV5I=;
	b=iYX7W6iytkfu9dVzYYamPTeVxzOObyNgXtSaX/f8SioV+eWNe7cLyehZeGGJior7bxzL
	 pE1HfTS1IzbG1JkiHOHy5GROaBQR/lbu8A/8XquOK6IEWGfU5x/IInNABvQoO/Ry94+KB
	 s0cFpAUrbK1CCLwXA5hcO6wlK5Lpll85hc0vavkQ16sXv7wiDNxYCbMXOyYjR+O9BzD5b
	 Gq0OROSNVESknZpeJEQU1Sc62QBydWAs1FtnaSnKqF3vXspFSDUE7toVHZZHRcAKo+uG0
	 3KNeUBmSHAcc0CbI9rv8AbTSQYgc73VFkHv9BG2nnCz6XX4wXP5VE6gLWT4BG31mEuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=AhtaalZK;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A830606A31B
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 08:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A830606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=AhtaalZK
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso20499795e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1793003681; x=1793608481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B7dQENZy5hO1NBbTQGYEZ7DmBs04uprzORGYnKqQV5I=;
        b=AhtaalZK6vN7H0we5eZfJaEtME0g9vXRsj/0PMehl3von5Nk0qkJY7j6OkShNE0q12
         odEpqW2KkQsSoLU2MXSeU4fjNORSCAlOj/4zcFAomJTW4qeF2b0QTYGZ9hVJpCgtcWEB
         VGoGGA/04A4vmKbq7JDMx4sZYK4Bk7L4j0lkjtXfJkQ7CTkTws3TX29cIixciL0LTnog
         buxKQv0j2NkRB4uUKEWYN7jpAYVnOcWhjkiJTqOOMO4u1thG4RbTKQtTec4qnenlGl88
         z/8LwfTVBuO7BhkBtB+f/s4TMchGQcsiMX3SF/dYc411q7RLtY5n4wc5pdFewf0zsG8F
         UGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003681; x=1793608481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7dQENZy5hO1NBbTQGYEZ7DmBs04uprzORGYnKqQV5I=;
        b=YmST030PIOajPVGQzHB4GUqQxSspaf6HYUFhuSGOwTr8mjuM+Kk+KKyNR3MnRtqPNP
         e7UXgWYZ8qO8SesVUPnaJBnY+9fRSRkS2EDfxyEGzYwQExdPdwtxlZZnFlYIWmAMmr/4
         UEBU+8d/a3yUM3Rih6nmd0X0T6gXFzvuf/jkLLCDIrR1/8OPnuBIze1Z5CmSW7cCuqU9
         w3HsNPF2DjM3jpKyI2a4ykFRSTtA+l9fbTnkt9I0jW08rsueGwxYH+coo1BL3+YGrCqb
         TzqoJK/JwBqxNymGA+e3bc9LDZdSSLXk2HLXZ3oUOYXUcSgGiXAwJKY3VQJN3SL9U/qm
         UQNA==
X-Forwarded-Encrypted: i=1; AKwUvBzpLhzlnVFW7Ude1Xbd0C9UQ25a8Lg7cXgtL77JV8tvH/FBTR+9FCM8sY7OgCn7J9Q7EQOjZEtsSkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSvjGPO6wEx0b6XdUEzcpt5O+1fLpqhCcfy/Yhm0vu+y7DragX
	l+a9d842GjsfSYntfQCNEhMsoNoIc+oG4NWVF30DmL9x9MuUTGs72IDkOKr37zkxdsU=
X-Gm-Gg: AYBFou2hagnr9kvRUPltOgpZrpvT6hNnXFkK9EqaEgYW2vVKOsvsCVSZbgdyQqPMTu+
	6IxYxFdnJaOXb2ePq1tlhwwPpp5/hCvuxtUiSBcna6IBmxPWZQ+mmej6BXKsTIadXzzcrtnQ4gp
	t8MrJkiZ9n4ETorZQ/SN2rKY0xSexU7724CmFEfJ6sELwoHUc2KmhJGXwz1FctmCu6Qet2m5KyK
	dTo2p5fLDDSs5tl5f39k+HymJMi3UUlvcH4l4QMj/ZNmQR5+Dz+42xaMrkt6RYd83FUtkmeRnqm
	AO98TEocLgZqQn9S6eFndzrveWdy8OY6lluIyrPzNq3vfFTA/xh4qT2YaHPwcI6FyFdcEEie9iw
	FtUeCO5wA8Nw8LT/oYIUMHCfm8uxltPzqote7i6gRbyHhr5ma+xG+xZF0XHynYBeShaSt/PpL32
	1wVbb/brp6i9GttNE+c0E1br7y2m+K78oEwGNhAGcVB0Jzr+G3WgMy1rUgekNk+PgpPyKVDkxM4
	d/+0c3Hf9sDxazj1iFoRhS0KkqW6FITPGHY6jFdE62bppaEL3XDiOKPWBxMQQL9zAlAX0G/0eNJ
	wkOkW4bmCBdPug==
X-Received: by 2002:a05:600c:3115:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4a35ac9f6a7mr113540625e9.21.1793003680191;
        Mon, 26 Oct 2026 01:34:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a08643dsm143259045e9.4.2026.10.26.01.34.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 01:34:39 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matt Fleming <matt@console-pimps.org>,
	linux-mmc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH] mmc: jz4740: Remove the host before resetting the controller
Date: Mon, 26 Oct 2026 09:33:23 +0100
Message-ID: <20261026083323.12301-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

jz4740_mmc_remove() masks every interrupt and resets the controller
before mmc_remove_host(), which removes the card and lets the card's
driver send its last commands. Those commands then run on a controller
that was just reset, and can wait out the driver's 5 s request timeout.

With an SDIO card that cost 5 s on every unbind: on a HiBy R1 (Ingenic
X1600, a BCM43430A1 driven by brcmfmac), the CMD52 that
sdio_release_irq() sends from brcmfmac's remove waited 5.1 s. The
command had finished (END_CMD_RES set in MSC_STAT), but MSC_IMASK read
0xffffffff although the request had unmasked END_CMD_RES. MSC_STAT can
still show IS_RESETTING after jz4740_mmc_reset() returns, so the reset
most likely completed after that write and undid it.

Remove the host first, then quiesce the controller, as other host
drivers do. On the R1, unbinding the Wi-Fi's MSC now takes 0.65 s.

Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.")
Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 drivers/mmc/host/jz4740_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 6a3c26b7c82d..923cf1450de5 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1151,12 +1151,13 @@ static void jz4740_mmc_remove(struct platform_device *pdev)
 {
 	struct jz4740_mmc_host *host = platform_get_drvdata(pdev);
 
+	/* The card's driver may still send commands as it goes */
+	mmc_remove_host(host->mmc);
+
 	timer_delete_sync(&host->timeout_timer);
 	jz4740_mmc_set_irq_enabled(host, 0xff, false);
 	jz4740_mmc_reset(host);
 
-	mmc_remove_host(host->mmc);
-
 	free_irq(host->irq, host);
 
 	if (host->use_dma)

base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
-- 
2.39.5

