Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894857C735
	for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195001; cv=none; b=SS8P1uvVWPRWlVdF2h4iw542WunH4lQVcLbdJJ9DFkDs1+nBIHYmq0x1fnfNMzOJa3S8SlErE3slzejVMRtajwhW5nUq2eCPVLq8k1JPssIRU61zK9PelbNCQAReejkJim4lmVNSqNlUyEMMAlkLa9zbzRzHbGhToryQKaf4mGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195001; c=relaxed/simple;
	bh=dplioYOzQkTgB7OtXIdIJ8d7kiQ1EMlzvR3wJI4xDb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzuHQzcGlk2D4d+ukEOqkEqnNMB/zRxQKg/dJeWT6InR7i7Ny5W6aoA3hoHGyFqx38jfr6ezeOfUhIChS4KzgMobmswP8IB/vZuGVwILLnYYunhEatgq9UzfgULiwUrJruIX3rGwD4AdpQJXXaWFM+xndXKdXwNIX2AQjRKRfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVx3nFqc; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVx3nFqc"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a7d46c5bbso107088766b.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2026 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194990; x=1790799790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVRS8IDqRClJGzLh+AyZKtdvQwPlkBwHKoeRoTOl5Sw=;
        b=aVx3nFqc5RSXsBi/t/8ozLsswb7DlaVULRelW9mYvE+4Jbx1F+WnagcCQwk7PyWotJ
         H94aBTvMh9yZ6PwmsTq/mhwHwquGquOYGGZGimjSGJInruRlWbc9X3zszpqh2BWOxr7n
         itoSNkNwkUBvR2hbnjae5nEr3pmWvHWUGqNApC3n6Ad4yYT6bEY5hnCnoST8/MSr83/M
         PHj3t9ql7qe+gAfFHAewLqvR73ZQvVzO/YMwD9UhuJc66I0/zWOAFFohxDp2n1/lDNG9
         oZA+zgzGOsGDORpoNYL6XZuVup2ipPvDTuPR7eRhqUsVX/6qIA+1kn1ynNMAfdG37feM
         WU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194990; x=1790799790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVRS8IDqRClJGzLh+AyZKtdvQwPlkBwHKoeRoTOl5Sw=;
        b=Z5LtGsEXW8X6yxf4TvnX0lIRjJ1Oh5Q5+p2UU5Q0BEfzqOviHf7QAaRfApyN4pBCU7
         4yWzTWGLjh9Ws2ALeBceI7Ke6RMOx8nZ40Hj1lI+NGsn9JwjQzZ2F1W45EBkb2j1kroQ
         rooq7Fv7Vy0stP9YuWLIysHUC32NZUYBlw1z4QXpzwwjIIMA8vyV9bNfoYBTNVBDTMlg
         3Pfc6LLFJg9x9vNbZXRXmMqDakb2bbUa94OVjUTeUCgHvdXeobL6Dum96mPXmAbAeXvQ
         ZvZJRsZCafrmme8MpcpINVLQLgfYofOoaDDN8i/BUnccWzX60cB3aIRszkaJZCJO4YTK
         UAuw==
X-Forwarded-Encrypted: i=1; AKwUvBzKRT+v7b05JMcgR2852pnxHqHfMO9N28PVWJFLQLOH3JYVvly3jVb3P9p8Z5B67P7TJaX0ValQhQw=@vger.kernel.org
X-Gm-Message-State: AFuF++lzY7wk7EUuhliFANySE+CJBV5oxWCzYC6iZ7qgkM1nX6G1cFft
	OzNmdUDdmSEMgKfFoKV20xcL6K0ygWe7CqlCV10QBgbt6oVV/etxEQIl
X-Gm-Gg: AYBFou1sStwxlazFr2J+xG3/QKDv6Owy1VvO1+Xi6EIizBcVgdXrS2DoSkORZqg5uMY
	5cvz83HLy9mHToUXdN292lYtKLUPOd9EgnOp5I9fTADvGYtfiAqPpH+eYc4/hxY4MVDmpvrQad7
	OotbUV2yE8c9pYxKzK76XqZUFjm8b00hcRRtZS0vfwFwLx3IXpIKXi1c8bZPj85A1+r+/mFzDYs
	QY35Ku8lpU6sswVjesQiauf1oGBhz9h6Oj/vAjepnAunatDcgqC0Di6UVlHItDqmGV6B7OfL4yw
	XviTfFhtaURzFpzJepKN4DS6+kECX0SQR+mnIkUBh7l6nTrsXLP5skfiUv+sgYHduMO8G1OTsKk
	YtEeMh8xOLnlPO0+WG/5yji+bAXjwij3Zeg04ys/VrmBDMSwmF+JFHOSCsa2mLUItY+aUEOck/X
	A514H3CnWiXx42fV31JzrkaT43YjDa0PtZ6cqv6bbg9/pszITSRWEbC/hhFr50ryG52usJN0UWI
	53Dh4G+umB4DU2xHquGK02/3eVv5M60
X-Received: by 2002:a17:907:6c17:b0:c24:6382:2648 with SMTP id a640c23a62f3a-c2ac21f98famr25358866b.5.1790194989894;
        Wed, 23 Sep 2026 13:23:09 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c8a44sm177243566b.20.2026.09.23.13.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:23:09 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v1 08/11] dt-bindings: mmc: sun4i-a10-mmc: add Allwinner B288
Date: Wed, 23 Sep 2026 21:16:58 +0100
Message-ID: <20260923201701.43391-8-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923201701.43391-1-pmazzini@gmail.com>
References: <20260923201701.43391-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MMC and eMMC compatibles.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 9e9610bb1eda..c2ec7151dccf 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -32,10 +32,12 @@ properties:
       - items:
           - enum:
               - allwinner,sun8i-a83t-mmc
+              - allwinner,sun8i-b288-mmc
               - allwinner,suniv-f1c100s-mmc
           - const: allwinner,sun7i-a20-mmc
       - items:
           - enum:
+              - allwinner,sun8i-b288-emmc
               - allwinner,sun8i-r40-emmc
               - allwinner,sun50i-h5-emmc
               - allwinner,sun50i-h6-emmc
-- 
2.53.0

