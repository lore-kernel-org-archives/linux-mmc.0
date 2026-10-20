Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505275;
	b=5slQob5boRQm93AC6frRakHiugZAUnrBDwQzXRqG0H9Sr9UpNat1YRD3gOG2M6HhzD0F
	 iU9MqiQXkR2b78htjtDULklezu2F4Yk5H27a2lSaAIXg9llGn6HTJm+C5Jgud9mr7O2SU
	 jp6ttV77V57z58EemvSWn6UaFR1yx+9fztb3tJamlTTBG+UGqN+UF5A2xs4pu+ygJmU3J
	 9T9uE0ybdHUX1a6NL+axUDWlWnDzOfw07geq1g/q7ZLWIO8B6f0QH2MBFjHEvoN2zieXq
	 BoYDcHpRr5wSfriHxDy8l2SsHB03QXarFe+ow71ya0OWwXkVsoattITpDjZl3r1iJmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IHU3kr6H4ebRnMajlQ45rUZRzGT3LcsJKitPjmSl92U=;
	b=Cc9A98L5gz5CafQZt6NVxKSi/UkkJmb9ByclFbplr587v9JGJ3ongZY897Yc0nTdIHhe
	 Qfiee9TtC4kycaUdFQffoQDQrTAjbbUf9L3c+ljsxpnJu/gqE7ab6TroaNXFybd2XLLSX
	 gZgX3E+jfbGXcL8Pvzh8PQL27mXqT7XH418bhQHcSphLwuHoyltJ+WKHXNSRchpyhiKjl
	 4Z8s5K4apM9iznwhwz6D3ykzlxX3JXNiSyOw8aUCXWPaarIKY6WTeWhhyns0ptHdAmYXz
	 zOSJnO8/y1+MXcGN35IWyVAW7mfwqOk1adhALemZjS+Y0HAaSkmRKd65yjhhr/iO4EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gnd0VxFh;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243E606A326
	for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2026 14:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A243E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gnd0VxFh
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd69a51d767so15907a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2026 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792505274; x=1793110074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IHU3kr6H4ebRnMajlQ45rUZRzGT3LcsJKitPjmSl92U=;
        b=gnd0VxFhaEiVHqKR6cYe64yfq4qesQy426F6HEdRyq20V4WOvYgxDm585r8Z6sRNgW
         LiSaX8+ot3gmLvWssMmo6AXkao1OCC3Eh9y/ZYSo4FmhybDYOC4M/U4zL0CMvP/h2I0U
         HS+Z5W+RrQLHWMkZu5Q8Wovm0Rq7A83b/fR5afrYJQn03DXCfTw6AQu+FjHufvcxborG
         Eqyq/G5Avo6Uq6cglysqTdsNkbwllcESDWf0druCZK175Pj48LwQN342WkWsn0hLeIkj
         X4z/CS1FoNTzf5izj/XjZZYlwk9DhVACjn0dt+uLcdVwGkM4dqfX3qmnEpcQiYoleL7g
         /FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505274; x=1793110074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHU3kr6H4ebRnMajlQ45rUZRzGT3LcsJKitPjmSl92U=;
        b=zXNxp+jA75ICTtQ6pCtTyxwpiBKma6QbH0A056+a32/YXawaR55aFj/wNbAm4R/Fkq
         tKOzDeI+aq24TqDeE5Afh4eFOvf1L2oqWWKU++CjzTYikZVTFJRLwYNNQu8BPj61bE88
         kF+1weSz9wKDfnKjxdoIgz/Eqewcc9zjesJiroJLulGGQWYQo7hhCrxmpdiRlJMJJIQX
         FfDWDj8Tan1TQOKdVZ72vsBgUxx0UxIR7R8Cb7igbK4obOa0ZhevHQVxJ9jlcIFibeAh
         S92Sj9GkvDd1BHdJBgUmUkZ/C/qKgQX5HKjL/S9lhtmRffh+ZwYenOb1ISwQNBPMovGW
         +HHQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/sztcsKrZPmDYt0vrL4joY6KcR8B4U0iw5ozGS1qTw2q58ZDBlXSx96akLwW/Xvh4sQ6MXAJjZ4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/d3icWMlJq7NTvHBYPAARtBcl38CHzdRxap1+LBfrav+h0oq+
	Z9/FHCowjXlhg/QP8O2wMNOtcUld/uyP3MZ7EdB1g5sgedseNoeNUrMW
X-Gm-Gg: AYBFou15DySQLZ8bPP2uRphOwFs2ih6meZ2c94ncfHqf20Ew2mAmghUeL6LVX4dHybZ
	K1Y3iqlION8Olt1dn3hInuNQalUC33bxBvQFflSxZgGXgrf7kLwToKeHoHDMUhQniu1Ds8OmNbo
	AEgdTIooh6Guv2sbz3ObGRyt1mJq1l6Fa6t3ugaBk8caoaESnefT6ZAl4VRALPdstBrlhCBMVfx
	9FPNXpadbYnJKV3bqx+qvZ2HF2CheYQHcvGgDqEE7S+tD+wjrUKVo5Q7IqMF8A2pa67UH7JkZ/5
	c+v6ySBxqNL34Lps4fd9p55tSwGH8CPeptqjvqsU4NlfDGXh/BmNd1qrfmv3q991b50KoFogeMo
	jOFR3+Frv9385TTWtORDCfvgoPy18Gi9xWB6O8zdlqPvnU8aJJSLNm2ZuBiTV/z2/Jw9ZoBwwff
	HK6pGjKJmgCFkDe0P72Y9RhECBXF0OyiArkbCMS6QFcJ4EtNYpsLfzSCGTs9h8hJo+YrUpO6D1F
	tQScwhDjaXfhyvFuQ==
X-Received: by 2002:a17:902:e84f:b0:2e9:4175:306b with SMTP id d9443c01a7336-2e9a6832e3cmr148561805ad.1.1792505273849;
        Tue, 20 Oct 2026 07:07:53 -0700 (PDT)
Received: from LSSP.an0.nb ([2001:da8:7001:22:4372:4888:28d9:3e09])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea145b7805sm13430075ad.8.2026.10.20.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:07:53 -0700 (PDT)
From: Guanxin Li <bruceli20040604@gmail.com>
To: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guanxin Li <bruceli20040604@gmail.com>
Subject: [PATCH] mmc: atmel-mci: fix PDC bounce buffer use-after-free
Date: Tue, 20 Oct 2026 22:07:43 +0800
Message-ID: <20261020140743.2765011-1-bruceli20040604@gmail.com>
X-Mailer: git-send-email 2.43.0
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

atmci_remove() currently frees the coherent PDC buffer immediately
after pm_runtime_get_sync(), before the controller and its interrupt
handler have been quiesced.

A pending RXBUFF or TXBUFE interrupt can enter atmci_interrupt() after
the buffer has been freed. For a completed receive transfer,
atmci_pdc_complete() accesses host->buffer while copying received data
to the request scatterlist. When data remains, the interrupt handler
can instead call atmci_pdc_set_both_buf(), which may program
host->buf_phys_addr back into the PDC and make the PDC access a freed
coherent allocation.

The buffer must also remain valid while atmci_cleanup_slot() calls
mmc_remove_host(), since an in-flight request may complete during host
removal and take the same interrupt paths.

Move dma_free_coherent() after the controller is disabled, the timer
and IRQ handler are synchronized, and bh_work is canceled. Keep the
remaining teardown order unchanged so that in-flight requests can
finish before the buffer is released.

Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>
---
 drivers/mmc/host/atmel-mci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 8f4df250a77a..7f1a5864da96 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2592,9 +2592,6 @@ static void atmci_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
-	if (host->buffer)
-		dma_free_coherent(dev, host->buf_size, host->buffer, host->buf_phys_addr);
-
 	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 		if (host->slot[i])
 			atmci_cleanup_slot(host->slot[i], i);
@@ -2612,6 +2609,9 @@ static void atmci_remove(struct platform_device *pdev)
 
 	cancel_work_sync(&host->bh_work);
 
+	if (host->buffer)
+		dma_free_coherent(dev, host->buf_size, host->buffer, host->buf_phys_addr);
+
 	clk_disable_unprepare(host->mck);
 
 	pm_runtime_disable(dev);
-- 
2.43.0

