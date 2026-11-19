Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110619;
	b=2/2+siKtuQH+1w2AZ5YOpGzvVxOi7GhQrMy868CKCHnlYX/wtDAmj8VzdcPE8WiC2hwZ
	 vEkgumdSzRW+MD9YlMBSh9zWxIJq8DSraYtReiatMD5Z5oMSR4sgNV0omxK9swd9HxHwy
	 umvyDrbwlH5A82rXm/uNCRykBhojdV+Aj0gACg+bC8g6FYbeZ0F2JAMZC1EPvc9CK6BA+
	 S4rA4wauoN8lyCvV/Ebzl5eAToSq4HopuWzAW4f5TPMVD6kNvmIPS5DAqx+BnwI0i70kP
	 FBTGH+yi4bhR4MHIjeKih6cKUKWrFFFE8KeXwShM5WH8PTlpSWaRcoYmfeiVVBWK+tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q7g0KHNL5drVX1lZb8pGjmAF0NrBsrB1gG2lDqfKoWg=;
	b=RxttIXQ1nZWVirub4g4tQWmIMWYGhNciyUe6To7XFupA9nKILenNUFIMe+mdDY+2MEsA
	 9JvV3vWlwOyPoQM6+Q6KanQSsRsjQ7Ywm7l+60OckVXC/jiyqqrmLSJN02AEhs2IwKZmZ
	 9fd3Yksg7AuiuWtHYGwW1n9I/VxC09j/xkI6QF0mUnE4e0SVkeUVaJq9nGklWqEIS1BOC
	 944+rVNi4jk2scevN2ACzoqDzKQJ/Wu2EwzRhLtjgQ+NHFZ4ikx1xLGfbhUuFBxJ3AyS7
	 U+zi72fPMlVNs0nEnNnfRuANpGchESJqpyNOC9TVRVLjyW1wk1RRj/cuwxs8sh7KUvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n8OX20cE;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013360A5BC3
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3013360A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n8OX20cE
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb606491faso14982465e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110616; x=1795715416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7g0KHNL5drVX1lZb8pGjmAF0NrBsrB1gG2lDqfKoWg=;
        b=n8OX20cEK3rax+Ru4Z9EgjrB3T4PAKO/53cZnU3yUjRICzEumHI2YCgRq8WNLgRpgn
         OBHkOALaNHdPMil/CNWAGiKiOqLJzmAMh7ZLFtTDEkCKr4fTbnk2bFe+qlXX8Pyz/2+b
         n8IwyJ9QPHfScy+fZ6/4g/8G3Jc4L+bQcFYrMWcFzZ+a4hTyJ9aK+UDSsKfFgxwxBqtZ
         H6w37pNrqwAnN5wDR8kZBRVz0NJbbVETUmjr6wxwH2mNq3r2m2fLiDnEB306wyBEa9ke
         zTEVPvI7K/nreNvBST4wY2esXHwEwn9Xszabzl/pcUNtIHTdrM++u1rwURLk/NH+36mR
         Ynpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110616; x=1795715416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7g0KHNL5drVX1lZb8pGjmAF0NrBsrB1gG2lDqfKoWg=;
        b=agtpp0juIdoa6NEuitYOcbG2z84NAIvbYNoW+TYDFllkUlKeAqlBCcQgQc9R0WDtTu
         IZdo/lQcQVfZ4tKnUyjQcEnkPyjAJzWQp6an758LhDAjRjd7TEhAR9IzszH8mm0PHrIx
         s4PV6SO91f8vdFztG/W7n3iuNPEhgzyCalVgYJgZ3DYzGYuCT2oSoKchLmgiDQXEEofh
         R5Ls9jPqCcMqAxXO9VZlFFCbFQK5VQvqAbo4K5MKJ2JJzdwTPmPu4ntYFJVjWRwg+s/N
         96j5HvslWOrz3vjlzQ9E7vcLNvwKTBg+I++wM8GVJR+t/QSq2lb1MCLAWBLvybv53Qu5
         9jUA==
X-Forwarded-Encrypted: i=1; AL+hErF5COBLvbIt2PDaEevGOClhLx3L5hHiPDRDmvY0u2lZLuZl6KrBbiAtxNwEAT0SmdnwpA2Yw1r80X8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8D0N2Lu6SZoN30a1KSWGFm1asLu8Ru0mIKyluc0um7PBiagGs
	oQM6b4U/HVp5OYB+/kinxfLHSX0gW6ClTXAPqSQl3hKXQnP0PV8p8OZBwSXmL8BiK1s=
X-Gm-Gg: AYBFou2JvEQzFFECM7FLMo0QvfpsM3rXiQsE3pAsNt4o3KkHV3BqbaR0+LCFE5gK6p5
	zdC2AETAdxLtQ7oO2AyZGBbjDz2z6KWeXEw6EaP/BOEk22UheFTtCvuEWsLtr5pDfXCrB2N54Q1
	HB4nx7kyM9+LXrdXVq3Fn+KScdGdkT8rMhbbsUzBUYGWRVjjuU8L5uEyKKnOkmWXNKQAEc7r7K1
	KxKgWWMoa1SupX9p1/+ako3fleQSkrm5KIKDoY1dpWYAhOkkYbfUjfGDl7WUVno03wgl0cAZPil
	KZsI4cbYXD3XABx/bt8iqdnr60Sd8QI/CqR92Kyw0NFL+mfMhpqsmZTVgv+xPBhWYoggTExUkRq
	GV0OfCCNOVuXQvd4xEBbvhtUOlysMYflY/gHtdYbFFjQKhG9UQiXCFkozMN2TOTGaZSdAMej6qx
	jcSNzLbYc6eImxw6QaULHZy9iH0jvgb8tKS0fznbfEiTMp3Af3br/J+NtQMCK6fDUjK+jS78S46
	4X0EzjuB2UvbAVLRQQVZbZm9Nc487l9PU2jzsA0gkIiuthTxW/2Of5Tn90i4oQvksc5uvK49OWs
	MopL5v9B/vPZbphvfcPK6gwcg0wSTTqHcAIRtoQCAwymQsypO1LQnPK+X5CJVCVMb4b+w/7QbO1
	sO+SwD52ZhAd9y0ClRN0sunbLdXxfAmU/umUDASaGnUlEkVD5Dq54UbhYg3zHStsrVZKRAGxIAe
	z1xQ==
X-Received: by 2002:a05:600c:8210:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4bb887e25e8mr7534355e9.2.1795110616543;
        Thu, 19 Nov 2026 09:50:16 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm66709165e9.0.2026.11.19.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:16 -0800 (PST)
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
Subject: [PATCH wireless-next 10/10] MAINTAINERS: add myself for the cw1200 driver
Date: Thu, 19 Nov 2026 18:50:02 +0100
Message-ID: <20261119175002.458988-11-arthur@aheymans.xyz>
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

The driver has been orphaned. I am adding XR819 support to it and can
look after fixes, so take it over as Odd Fixes.

Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7b5f6beba4..3ee6e717bfc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7209,8 +7209,9 @@ S:	Maintained
 F:	Documentation/process/cve.rst
 
 CW1200 WLAN driver
-S:	Orphan
+M:	Arthur Heymans <arthur@aheymans.xyz>
 L:	linux-wireless@vger.kernel.org
+S:	Odd Fixes
 F:	Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml
 F:	drivers/net/wireless/st/
 F:	include/linux/platform_data/net-cw1200.h
-- 
2.56.0

