Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949DF6DCF5
	for <linux-mmc@vger.kernel.org>; Tue, 21 May 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280512; cv=none; b=fgWkG5buvwqgBIKRbV7jPHcXp6IEHLiZWElzEMyEhou2ge+SNsE2Pnbc3Xy5eo/BLhiX2iKzOswt4dIlFQK6Hqj0wRjpDsr30IgQWTyqbBVfjNaHmZXO5UTaMn5LEkbW2FB8xLRzFxvfZPZIH4OYfPiu01M0HgPuVo6F09U57TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280512; c=relaxed/simple;
	bh=9k25ZsPTf+WrTiK8qVLkskl+r232la4YhtO+5MWY/Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGBY3ZAEFJLV+cjubz+G3FzoGKAviU+YH0/i5MWeEtnws7OpawyNXe2WJO01+ffYGKkLm3ce1kdEh2W8ZzgXR+n03dxjpUJoDgn682F9oZOMq9EwE8HyXYKlr1/q8IbyX2snWr+UnSkx2D8J7ADZwytDq08IFIBl39kB39+wI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pw0ZRPHA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pw0ZRPHA"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a0013d551so455590566b.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 May 2024 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716280509; x=1716885309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=Pw0ZRPHAzzYC6/ONfa/PFJAWG0VTChASjdFU7viYyzKJFfXJ7ZZILcW3K6/Fn9Duy7
         v9Lz8RjRhe9B4t2P1PNnScM/xgTszJnxy4QRqiujEcc8rJcA6wyW/rb7TXOhDmNVhHCS
         CjEhYD23i+9G64QHuCNZFzXE4vOxC0s6iyYxjgWFnDciOTq/lkGMPFBbrCHUaCuWOzo3
         w+n9MQltA00m38xLboWecFJzaIH7OFSdKl9lrxk6IxBVwJ1qhLc7bWXmNGfU+aImaYn7
         OaXUY6yT8GEZfys2Rld6QIUEPBUDpIz1q4j4tzrCu2uehlUerS8FAqeNbdozRuX3+D02
         voJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280509; x=1716885309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=pgOXX2fPVYzntuXHHsNSBNQQMkd45/Ef+Hw4v+iJpfIlzMHs6oKT8PNGgl5jQxX84+
         al9Hpwrpd9nJmTw/8sxjq2IeIGhZjd7E807dxNa/dHfC7AydZJf5Q787o7ygXA7OosZK
         qfO8i/hYO+wzKyJUN542z8+wW8qev2fQ/5jRWrVrZryuqqBkf43Nnf3Kr0tzQFQ16bZs
         IA6xSK6RG4qc7arc60QT14k3eB9J3IHNGm21pSeKSGUB9TpFqbpwadDjzKjgtA0r2b4Z
         BvAQyIrt7xvlklzYw+tohojZmsPMOrQtiKa+ur7bE6HTaf8zZSse2Eiwo5OUDosv6K66
         H+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV1mOLUPgUt4lKQw/ejlaW/Vx8yKbOlvqIm0511YDpzIZ0SxaAgDOPbaa/fLioJdfy2tsUCVZpcRRYapYPm806GaZwQ7Zs/+cUV
X-Gm-Message-State: AOJu0YzKsbhxfM0Pk5dASkKdcgLNJ6WZmlRhWKdmDBDF3R4O3FMKG3cy
	UOI0BpiZMa/tzbobw5Shkfe6aKqA1JwpaIkbMZK0I5oM2BPqrNNUjItMEp+UYs0=
X-Google-Smtp-Source: AGHT+IFdOJDaXxwt3G/XzqPJASfDE2cQLEMIY3fQlL8rVbF4b17JPtcvYhCbyKk+sH7uacDvaHu6OQ==
X-Received: by 2002:a50:d518:0:b0:575:2ccc:13c1 with SMTP id 4fb4d7f45d1cf-5752ccc14damr6751138a12.9.1716280508952;
        Tue, 21 May 2024 01:35:08 -0700 (PDT)
Received: from localhost (host-87-18-209-253.retail.telecomitalia.it. [87.18.209.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c63bsm1577804466b.51.2024.05.21.01.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:35:08 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Marc Zyngier <maz@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
Date: Tue, 21 May 2024 10:35:13 +0200
Message-ID: <b852cf1fc20db8fb7fd81900b6df0498f1086008.1716277695.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716277695.git.andrea.porta@suse.com>
References: <cover.1716277695.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
acknowledge its new chipset.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 162a39dab218..e4ff71f006b8 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -23,6 +23,12 @@ properties:
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
+      - description: BCM2712 based Boards
+        items:
+          - enum:
+              - raspberrypi,5-model-b
+          - const: brcm,bcm2712
+
       - description: BCM2835 based Boards
         items:
           - enum:
-- 
2.35.3

