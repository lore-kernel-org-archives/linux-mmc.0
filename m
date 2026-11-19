Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110614;
	b=TPlDC3aZp7iV1dY2LaLBcNl9OzoDGiZ7vC7OA5wWBkqhq2YH3axO3VjiTT5rsRjpGUFf
	 uBmx/fjJ8oGNxZqYKn64WSDlIZ0kamE0e0E6E4OSjBAYFPZzjuJvlQwMAAE/loCVp5Zhi
	 kDzrUXceYB+tBzQ9+tj0QWPY6Ta9X0wE4XIcYxk9E0jfL8QeKUcFbeR9ScgaJ8J8WcXhW
	 vUWsib9JAIdO+p5acmhIfo/qLUHi11tj7RNT0wt99UP65iC5kawOU6FhhcEUzZI3Dmpe0
	 tM0hAdTTLMVF6gW6WdDCuoRLA3E1+BK6c+26NdTOqIGvN+A7Y2gFSxFPyXTnBeMXF9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CvEm5T+elZmAIVJRuKb7mSJIVKxbHtl2NRkj0Gb2l8U=;
	b=TL4IpDBbR98nlc2LsDESMdXG1Gm2BKqe88DmyzKofewE0sVkgTyiWMiS2fBaVz7Futb8
	 fFFaLnjo69FnPCN3CJPxXau/250bcNULn84rSFzVH9X5yMHStXucwt2YBopzWQaMYnjRf
	 jSX/SE9+A/bDXbavR1FGKjNGkokBtdirgxu9Nh1kC2153BkLzkGugrZx4HQNyrotOCcxx
	 MKOX4y4bSRKy6xN2m6umS4dI6yqVdN7IE0Idk2jm2MOPUG2q5V7sCU8tBQ1cGS72rqstz
	 eFGxG1KS6UhqKpey8mYlFntHGmXHHvnHPbQ/O9ANIIQXxksNYh3Bf07YXs+BN87YrWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gMr5ru9l;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AF606A332
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 430AF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gMr5ru9l
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b467581b98so31009135e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110612; x=1795715412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CvEm5T+elZmAIVJRuKb7mSJIVKxbHtl2NRkj0Gb2l8U=;
        b=gMr5ru9lLh5siTDux9OeJMjctF8puIy6nYysyT9y+2aXt30gBNSeo2LqIHd4LgYy3W
         W0xYnInGeBUJFzMeXImmASrU0JOYIksebNC3t6YcmeH97eq3P36pDRT+5JJ+FyfsG7Dw
         3QUUkbjuahCxGBtzHeZi1Dz688ZBghQ8eXw51SPAOjg32nIfMgEN6B4+iZArnmGVWKDZ
         KMGYy00pfZsrXSuLERVR40hV3dFbwvDuSKmHfWIhL8dWSP8VOKuQoHzoTXAVcOa3rF58
         KPgS6QBL5VPg2PT2fEw6KWl8hnNJ708LdPoON05k/vfQaV4nDvl++XI2oRl/Y5bqHDwF
         T+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110612; x=1795715412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CvEm5T+elZmAIVJRuKb7mSJIVKxbHtl2NRkj0Gb2l8U=;
        b=UmbJVQVteVwEkjx72H2kFMbchQRlA25dc4u5zbhiW9YtQJE3XSXlncxiM4wHHgBFuB
         tpwa4t6SepNyCyD8pZQxhx821mE7q8diDiCG2EoPXmIDVgsAQdoDSX2gRlqip3Pyr3Rr
         p9YbzhGGObEIDrxsjJCJnCe9xNmjor0asEE+agIo9j3n/ddwqlr9SMHYZWGdH9Fic9I2
         fQ9V5M3R+4PcxW8JZIPjJhD8fzh9ivMM1Wu85Z/2N09B/QO3ZCEJWIwbCmsSue2xwQot
         rHmTOhx45wxi/S68DIxO3fSpbF64SkVrjEKEgty9Kva4Ak9ShafAx96JwmkyggNzUOgu
         xLOA==
X-Forwarded-Encrypted: i=1; AL+hErFP7R7M38TQk5aACvW6QldzO2t9k7Rv/cFkMCdhVQwTPV08frC5wMfjKsHPbwPNGa18tzB++aZiyn8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z/nOMF/GZxafvFhGOv4dKHBJC/1lx/mSwzw6K97vC4XAk2AMD
	xv/K/z9ROVPcYJfgNtNL0yViLwSWfMqJ0WceVWPEKpyjToRA7uVnNm0n67AQjpJiD1w=
X-Gm-Gg: AYBFou0ML+B0N8sN6U4DdPYw7RyyoKijN8iT5xpZnfjo4BoNXz936qs5VHZIyvmALZw
	Vq9Nb0yAPfFTILwpL7DMqdc8YgHFGilDxYKeBWYhuO8L5RTC0tYPsbOjtGJU9KehM9G+sBNSLU8
	Kw8eX0PgfP1I9D15zRkqeXL9CTIwOZSKNmfbqlhSWYdVg5Nw/9M1SdLe6coHK91m/vTFKTyFHoo
	/viYB6jo+WcbN9LHxda5uPyYFrdpNGOo8hPpwKkncr8p5FTh9xiw/s+1PsSoLlVMa5s+Gl7PmHl
	JibQ4pk+zOWGRiCVzZHZnpCKUwWNeyd9g7UYvON/zuRI60BqMbYg5/mt4BnoOqXD3Rmrx1faQCa
	psJN8tolE00qBeDG0/2WxlANT1YWpMpgMmYfe+lYNmo3A7MAisfAwE3ss0TfydTkzlsoW058H5/
	GO3muYQED65UhgNT1RdgWNT3sf2UZfCnhnL+arln9l7ThJkJpA0XhtnPpfAGG/ed7VYzbYEQeON
	9jpgI95H5ZftYPunMEA1qWb/PX9DkMn60WGUuWbDgOWc3KoDWysYqwfSu6JHd4XezhNrC9mYK7S
	Jlx06gkMvMDkYQRA03uATczehgsyzhnKH2p7wayXIFFZH8OMnCt2LaM3ZgmkhEjxkmd/mV1ajPq
	7WA8R8Umais8MzYOfmj7jiKIrTFgFIAEelOCLT9N00ytkp831NI47aI3u2B5l0iOsBrAxV9yTEz
	yJbg==
X-Received: by 2002:a05:600c:820d:b0:4bb:7b4d:6396 with SMTP id 5b1f17b1804b1-4bb887e21c6mr6739265e9.3.1795110611578;
        Thu, 19 Nov 2026 09:50:11 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e06c73sm90733095e9.2.2026.11.19.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:11 -0800 (PST)
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
Subject: [PATCH wireless-next 04/10] wifi: cw1200: unwind GPIO interrupt setup on error
Date: Thu, 19 Nov 2026 18:49:56 +0100
Message-ID: <20261119175002.458988-5-arthur@aheymans.xyz>
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

If requesting the GPIO interrupt fails, the wake reference and the
card interrupt enables remain set. Drop the wake reference and restore
the original CCCR interrupt-enable byte on the error paths.

Prepared with OpenAI Codex.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/net/wireless/st/cw1200/cw1200_sdio.c | 38 ++++++++++----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_sdio.c b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
index 1894359ee9b4..dda201e69735 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
@@ -143,37 +143,35 @@ static irqreturn_t cw1200_gpio_irq(int irq, void *dev_id)
 static int cw1200_request_irq(struct hwbus_priv *self)
 {
 	int ret;
-	u8 cccr;
+	int err;
+	u8 ien;
 
-	cccr = sdio_f0_readb(self->func, SDIO_CCCR_IENx, &ret);
-	if (WARN_ON(ret))
-		goto err;
-
-	/* Master interrupt enable ... */
-	cccr |= BIT(0);
-
-	/* ... for our function */
-	cccr |= BIT(self->func->num);
+	ien = sdio_f0_readb(self->func, SDIO_CCCR_IENx, &ret);
+	if (ret)
+		return ret;
 
-	sdio_f0_writeb(self->func, cccr, SDIO_CCCR_IENx, &ret);
-	if (WARN_ON(ret))
-		goto err;
+	sdio_f0_writeb(self->func, ien | BIT(0) | BIT(self->func->num),
+		       SDIO_CCCR_IENx, &ret);
+	if (ret)
+		return ret;
 
 	ret = enable_irq_wake(self->pdata->irq);
-	if (WARN_ON(ret))
-		goto err;
+	if (ret)
+		goto restore_ien;
 
 	/* Request the IRQ */
 	ret =  request_threaded_irq(self->pdata->irq, cw1200_gpio_hardirq,
 				    cw1200_gpio_irq,
 				    IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 				    "cw1200_wlan_irq", self);
-	if (WARN_ON(ret))
-		goto err;
-
-	return 0;
+	if (!ret)
+		return 0;
 
-err:
+	disable_irq_wake(self->pdata->irq);
+restore_ien:
+	sdio_f0_writeb(self->func, ien, SDIO_CCCR_IENx, &err);
+	if (err)
+		dev_warn(&self->func->dev, "cannot restore interrupt enables: %d\n", err);
 	return ret;
 }
 
-- 
2.56.0

