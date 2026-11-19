Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110613;
	b=dAocAxP9dJVlfF/+77B9sJd71AY7iF2fZQhxBnVJGcy6lvJDu77rYBoYXpfb7lf2i154
	 /1IMEVBsD+TGtvnvS/4hE6a+xG9U81BdTV4mZqrr3PjfttM4hnLiajuAy8WiZsdO3HhMU
	 OoUb73F848WpWCJteWzZiT/bwXKauqvCMh3TfgENwDKMc/qjaLeMpJ1vvYt1JNidWH514
	 gz5MwzZJZtkz1dgqnX2IGhtfkwib/IBp504a/qOtcVMR+26cnmaS59lRcYrjqU0hiIEq4
	 e8TVwUGiwI9nPgIHa6Y7V48Q1qENbJexnPDje55G6U/AFk7fXwboAYlZwH1NL6xrECQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uMvJgUgIWQ9UB+m69mwQOPyQAv9bwycAqVzJU4J35gk=;
	b=Pz4Z2sQxrb8yzDbsGm3yvdIYUxiNsSTHuceApkoOa9z2dmOXuDjPIW+ZRD/D1i6cETd2
	 RNJO283PAf2LuL3VG1L1ZIscdB8O+6a+Z8Got2M7gD5ayW09874UhxL80l+jv8z21i2EY
	 abVGZ1fqW7SSyI1sRWX/XkKgs4b6bxp4rLpDMlPIhquE6/zFAWA6QN2SDsC44CxpfRwgn
	 HYXj76iMgE4ZYgfJkT6O451Tf/4kJhdZ/7iYv4IPmP+T7qCBWjZhOeMBnJ3/0qVH72QKC
	 Gj0Q/medmRD9RlBQ6qETZ6wF79uhn8Qkx/Be0ndxEj1akqe7x9JtkGZrFKT79+pJb8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pipCExca;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63EB60A2616
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63EB60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pipCExca
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso35273975e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110611; x=1795715411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMvJgUgIWQ9UB+m69mwQOPyQAv9bwycAqVzJU4J35gk=;
        b=pipCExcaAkgn33Jj+6XRGBrNhCc+5e9sj5XWlJo6lmJ/sjHGiZAeX5r2xVCdiCNUfI
         IIWErUWiAWY+B3j7mrp99xi/YrTIjNUJmkgtKvMfFAjEQ6Sd2c/u5fSE42jeEhPhMuKf
         T8/lzLvWPyKKXU1B0LGYaxfIjgAtb7+6pcaSd1U9NNSHH3gq+AEMHQ4/k4LhsUlyBHP4
         3ALctnth2LWKxHQHdzsj9TEau7rdpUow+TvP/1XU2wF2xnLb0txNfNYpf8LiZpbZOyI0
         zwyGZcgeIuEYEsujTM+NBjqz+fMizNvqzmEZdGcaxL3JqO3Mzt50eiIn30KmzBfM0KzR
         rNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110611; x=1795715411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMvJgUgIWQ9UB+m69mwQOPyQAv9bwycAqVzJU4J35gk=;
        b=NSpJMqBxr2HrycjZSNE0FkInpoJ+F63NCHiBPgJrKAiaPTU96Djw/uj8kwwwr4H780
         c4iIY9Rns8JuRicn+BVYr7xjFT8/FpOmp1edFygNjtOkaIu+P5kUa+mSKGorSVPFphD8
         lCshxlAazrBj1fOA9FUmL2drS6mUXqcguO3mAhGzfF1kG5br6tS9UyPlxR8PyqoS6BQI
         PoApGq9+KAseZrK6NFQSmW01Z1wXgawr+wg8AXK4wlzzKM6jV1kbysGffvzR9CMj8m9s
         wCwwmhxnNGCBlK2wTZVnp+G+O5u0p6rj8VjLp4c1RG5QBDKc34IPtEsyhwIqClfKJjQ/
         Qdmw==
X-Forwarded-Encrypted: i=1; AL+hErEM1nhY/Mwz/x31Bd1qE7iQDQkFThcexddXOF4djNM7fCqBOommQr+La94LGCzl60CD9rGJPRBRoEI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y4DEydcgRd1sXnDapx9PFuruZEaok1BjSy3lTyu3H3rLRurV2
	uU/naVsXgGsrxNuy8oyzYBBD4c8XifdYE4zsVW+6KLs0Q7jx0Jokq/0IE9ZiocTv2GDwa4HG4q1
	tvTGtkjY=
X-Gm-Gg: AYBFou2STg+picSbdvBJMqBIWqyf75+SPknjAuh1K/YzQJgZ4yTg0GtNPDS28/yHYD+
	P9c/LIoAEmY9PZPjVR1p7/nytZCJiypgVgQU0jzVPhCYewt3Fas5ysNW9f8TAz2DDQBM3zzkLzd
	2TxUcVuonZshLZtyk2AKiB5/70Xzr44q7D16sbTOASiEdnQiwXrEqkWfkbCISFs4unj/5vH4TBf
	1WNO3b4Z8gcEyHbkS2CF/EvVu+LG3EvDPKFtPb5S9QO75tMJiJJr+14VFaInhq/AhjQgDj2yW3x
	FZcp6tmsjeBTE2L5Ee90Xa000PuEK7x3U6Pu8GJSzZSL5++tIKlpyrIUn7003mifAlCZTB4vmnJ
	l9wc11dKjdPhgmcRpf62TPqfx/aeGE3kwW7Cv4ztVopb7oNVmvxWciWjJTGK+Oeh8pSnKtq4/5k
	MoqiS1rZk8L/8iYeU7Au9vD63dQHIod8G1wiQ7QHeTwfXAWlfHbWFksz6Utr3rmNcB1dkx26vvF
	8dRnWZRJ+a9JVRYnfvvG988N4oC8ixApdaET+d1yyGfyRR7vIhfkTtxaPfx7QPTaykLFCtm1EOL
	lz3K24z+Guk/P4AlqPlBzb2LdUf1j8y3Z096WOfY1YnESv1OZY3ItJJAptxHcU3hwANqIon18CD
	YyEF34Ornt4OR179loBKggV3FkY8g8OLzYLat2/jsXD6NsIsR8ynPVZq/Yq+seIsLPKHb4CRYhb
	CthEM=
X-Received: by 2002:a05:600c:5306:b0:4bb:6ac0:6dc1 with SMTP id 5b1f17b1804b1-4bb887c994cmr8080595e9.2.1795110610855;
        Thu, 19 Nov 2026 09:50:10 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm53032625e9.15.2026.11.19.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:10 -0800 (PST)
From: Arthur Heymans <arthur@aheymans.xyz>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	Solomon Peachy <pizza@shaftnet.org>,
	linux-kernel@vger.kernel.org,
	Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH wireless-next 03/10] wifi: cw1200: bounce SDIO transfers that use stack buffers
Date: Thu, 19 Nov 2026 18:49:55 +0100
Message-ID: <20261119175002.458988-4-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119175002.458988-1-arthur@aheymans.xyz>
References: <20261119175002.458988-1-arthur@aheymans.xyz>
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

Register accesses pass stack words to sdio_memcpy_fromio() and
sdio_memcpy_toio(). Use a heap buffer for stack and non-linear
addresses; keep the direct path for ordinary packet buffers.

Prepared with OpenAI Codex.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/net/wireless/st/cw1200/cw1200_sdio.c | 35 ++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_sdio.c b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
index 2b6afe221268..1894359ee9b4 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
@@ -10,6 +10,9 @@
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/sched/task_stack.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/card.h>
@@ -61,14 +64,42 @@ static int cw1200_sdio_memcpy_fromio(struct hwbus_priv *self,
 				     unsigned int addr,
 				     void *dst, int count)
 {
-	return sdio_memcpy_fromio(self->func, dst, addr, count);
+	void *bounce;
+	int ret;
+
+	if (virt_addr_valid(dst) && !object_is_on_stack(dst))
+		return sdio_memcpy_fromio(self->func, dst, addr, count);
+
+	bounce = kmalloc(count, GFP_KERNEL);
+	if (!bounce)
+		return -ENOMEM;
+
+	ret = sdio_memcpy_fromio(self->func, bounce, addr, count);
+	if (!ret)
+		memcpy(dst, bounce, count);
+	kfree(bounce);
+
+	return ret;
 }
 
 static int cw1200_sdio_memcpy_toio(struct hwbus_priv *self,
 				   unsigned int addr,
 				   const void *src, int count)
 {
-	return sdio_memcpy_toio(self->func, addr, (void *)src, count);
+	void *bounce;
+	int ret;
+
+	if (virt_addr_valid(src) && !object_is_on_stack(src))
+		return sdio_memcpy_toio(self->func, addr, (void *)src, count);
+
+	bounce = kmemdup(src, count, GFP_KERNEL);
+	if (!bounce)
+		return -ENOMEM;
+
+	ret = sdio_memcpy_toio(self->func, addr, bounce, count);
+	kfree(bounce);
+
+	return ret;
 }
 
 static void cw1200_sdio_lock(struct hwbus_priv *self)
-- 
2.56.0

