Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AA3E6DE8
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860338; cv=none; b=jmBuuOCopt5y05D8yNJbj7iIKGqlwQj3gujfn4yKGfQGp4B/HpExNvsZ39KkRIBp4U1iAnatsMoogOXpRN1EQJwBbK461nq1Fd7e/2ToUjlBNCg9WCKCEUHvfMnXybBq2ddNCWRxOyJH2GCQloTQFJH0g18K1gYdkvtd1DDsJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860338; c=relaxed/simple;
	bh=j0S4KRpjuwt3nsK0sce2EQ3T5QreZX+v22OUsOnmgx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=au6mOV8TzGmQtzBSg7fphAu6yMm3L0Nc8SgKgEEOhfZVmTzVj584oXheMsLEiaG2OWuOIdUvc/jNzRCY6JUTYLdl93pYdZ/QdjyXfSHk10KS7uJVwLrhsH9yPERRWIw3TaJl/Im4nnCOlEEjrZxCQujhgwAqtrqQF5pT65OXgWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/O8Ut3s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/O8Ut3s"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6f9e2f681so47383105ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788860337; x=1789465137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8Uf1/He7wGtBx838McXz59D2uWjpQpPbZa4QJXiQso=;
        b=c/O8Ut3stdG2XtedLzqH4R7IQopB3Oketos65r7MPd60bHSTo8SPxVVVUzJOz6V1qf
         WotQy8Hn7F2r/DXjrI7v21MN4DF25pVk5G+ds2OqYlQXqH4RIL2xeZnvrHgl41JDZwig
         s5i9t2J+s9sA1IHJ7SbKC41BD1QgQ3Ca9Xoj/ki7m8chBYOLlFrDwSeOXb58wwV3hwHX
         J0wSNYA0rP4zu+EkLq6wT14XjiMMjfv652gjKg5WXbdRj2EA3Rx/GjBLuMDJK25TBOgG
         dcGrB1hqEX0F1H4pqarArRSwWzMTmKlCpZlaic+htCm0RawR8iL7HjI0hAOumRHFs6Gm
         JYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788860337; x=1789465137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r8Uf1/He7wGtBx838McXz59D2uWjpQpPbZa4QJXiQso=;
        b=lQSgZqjbF1M277es6GJAGuocrJ91AXgUhjpZqFIHZmV9DLS/cPxZHLCREP6RwNmjKn
         yBCMdcOwtxMon8yBMWi3LF2hvfIwfFk/VjbK/6WD7t3bowkwShzAhLZ+YPyTNlPCL5MO
         flqL2cVjkxh50vPV954RqNW4s5k1WqE7HIAAho20w9vGG3Ys+ZroVBKMdKoaGf7fMS+X
         2cwmyNKiwcg8P+SZFZse4WS+RpYGBQgoWnToa51HGBfVf4ackRJ//Zh5mxTafrOg33zK
         4DxvHMe8uUdWVG7c2RI8XRIzsY9a8FXauK7qzY5xE8IX7VfWMQLaPGoXv4/NmaG0ZCvP
         NMnw==
X-Forwarded-Encrypted: i=1; AKwUvBzhVz8gl9jw6p2Q09mIiVKxWBghdJR8BjgmHw4uTd1oTfMlOGCwX1EPbXt6cPYYOQWpWGZ98sZNTFw=@vger.kernel.org
X-Gm-Message-State: AFuF++ncsU6CVb4ES/z7tIDjKH0gxclA0QoP3jZZ/u2dGKD49UmEQQdG
	XrxuS7nlSN8p3U6i04BY8BWeJUkg0zmUWtD+xbj4jF9ctTtSzX/W9BGE
X-Gm-Gg: AYBFou11HlAkn27oXEe8YRWiu+DQHR35SWzlHtnZC5T11+HgExyz+Ww2uXrctiwNJre
	tRcD70Kur0qKMH3kMztl9OD3Dk5mpe2+5A+Y9xGkacQ/6HhL9IHTb/UYCrsukNc3/3yA7oKlR1h
	WEx7fZTp2ZVUIKzBEKNMnja9SbRpnU/nmwPagA2ol0mgju/RiMYWcOY8rAz0i6CSo6ZvA2R5C15
	hEh0yqt2bC40iKfwkl+NpeebxLBKx5USIIzXaMZZh4ll0+NXo68tnQa4qpeJe/iboNua4Ek4LFq
	8Dd1FiNHh2IN0XIRnSUSoRWbA9O75iiJ2EUXeq4ZJ6BIrIZ5S+qj8oeer5pK0UvKJt/Oi83zfSU
	iE1UVShoe9mi0UtNDwTyfLJsjBuqXd5kS06qwm91eYnbVc81H/qqGVjYebqwBcZfQE+In2TitOX
	d4/J9bB3e7FKWG3Y/ZaoOYTHytK9RhZOblkEznF4dFyzChB1gvdL4LZJ78rnQeWiL8vDmX9D0oM
	Uv9CLvDIAc2YmpI5ndFDeg9IsCQ98geZMHbTlE8ZNqmknM8bj12qNTloUYLLUb6pxjKr0x9wWxx
	LA==
X-Received: by 2002:a17:902:f690:b0:2d8:d4ce:7e3d with SMTP id d9443c01a7336-2db126326f4mr367331345ad.18.1788860336815;
        Tue, 08 Sep 2026 02:38:56 -0700 (PDT)
Received: from nxpwireless-Inspiron-14-Plus-7440.tw-tpe02.nxp.com (114-25-99-144.dynamic-ip.hinet.net. [114.25.99.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497d9f9sm54848085ad.32.2026.09.08.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:38:56 -0700 (PDT)
From: Jeff Chen <chunfan.chen@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	francesco@dolcini.it,
	linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH wireless-next 1/4] mmc: sdio: add NXP IW610 device ID
Date: Tue,  8 Sep 2026 17:37:55 +0800
Message-Id: <20260908093758.596444-2-chunfan.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908093758.596444-1-chunfan.chen@gmail.com>
References: <20260908093758.596444-1-chunfan.chen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Chen <jeff.chen_1@nxp.com>

Add SDIO device ID (0x0215) for NXP IW610 to sdio_ids.h. It is used
by the nxpwifi driver to probe the IW610 chip over SDIO.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 include/linux/mmc/sdio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index afae93f6f245..5eff5e348eb0 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -123,6 +123,7 @@
 #define SDIO_VENDOR_ID_NXP			0x0471
 #define SDIO_DEVICE_ID_NXP_IW61X_BASE		0x0204
 #define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+#define SDIO_DEVICE_ID_NXP_IW610		0x0215
 
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
-- 
2.34.1

