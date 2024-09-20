Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E67DA76
	for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821492; cv=none; b=DWkYWsPV4LOe4MZWLluBS+FmY6JZVXSphjT8lG3nCci5Go+HkGYwluvLMqlTuQfDzOjxrMtp3GQCq/3zj+9iTteezMdjMwfLKuYT1T+QTBiCqUqpkjaG8ZShGKLrHubBIS5nIQJV3CYhYhmlwrFBKCAzBVqNvQUN/ogvlBxCHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821492; c=relaxed/simple;
	bh=j4Lbv6zNfqApM1V0yGgeKWlfIsHLow2v2D7sYIjkoo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzMeDe8ol7ysEJXiEg0g3INgAn6N38iJhbsXw137DXenD3tm2h7J0JGK2IVb6XDPkvxlkpmXtemYqu6YCddxHSzNyfX6M/K82y4yk+EwblZXhvgU8zCasaUchalS25WnwcNtu4cet5xEIxHKZZtNjHKFPpD1ghw00D4PWoqNo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AkMrzAu7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkMrzAu7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cba8340beso17507535e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2024 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726821489; x=1727426289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gT2RF7jns1eZm4iFgSUdoY+bcOaQqGhahQcgK59xcso=;
        b=AkMrzAu7yrWitnkC3UKoT/+1rXM/yE7DLYRKOswCD2y+FdUSbYKa57Sl7LKPfgbPqY
         /VvR2TQzcoarN7I1Tp2Pfiwig0c3lQKPiQ30+yLmhpWTWIWL5QVcDFDgCYqZdzPmenOk
         wlbM0bBOJpL0QDHcLrLTl53VwrkF93la0V/6XG8q7Ev6fxiAyUVALhm7xR1P9YBBiR73
         P8sMlYcnD0AUNb+r1Y446jKV13UzVevRgqPj3adrhHky3OiPW7wpY2MTy1q+2By9xdXO
         GLYpgVvJJGjQD4tVaD+gO7oKZfPZF514qvLwVSfsBCXxVAILnO8RKW6AKFX3+DEncqwe
         iNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726821489; x=1727426289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT2RF7jns1eZm4iFgSUdoY+bcOaQqGhahQcgK59xcso=;
        b=sm+8pGEFmr4OAc8avspShCQpqC4XnjztTAzoBPtKjgGN35VYPU4cYJ4enDtvMm5zGx
         Mt09dO96Mg9ColkIil86cA7JLphFx1GMo2BZQXtNIR+jMX/1g5FGsuXh/Q6Isfne17Qz
         YaJqf8zcPjdHpnAfxFzk/AqOfKrfd/dVkjnXQ3BFTfB3dRP1idNPLx1HtVaxpYjS8q4z
         xBEBRYuDC6QHtR8y+hnxUtzyx2vOhMwOzw5Mk+8+OzvLlTAmTZqRkvbyUg4ilL4bwS0e
         bLulADq0/CXtPCJj94l0kixjVHwQPjc+6md5U3VzM/PJT9AgI58KUQ7VtfsZXsiAtpvR
         665A==
X-Gm-Message-State: AOJu0Yyzm+hhFqjhcz25ECy3iyA+NRl7qmco6GxzbJN6SBFij2zKCMlv
	oYG7FLcwy+Z1kbprM3x/Xob4S2EjLDejHuhqL20S3+xpFsCAU2X7j7uejz8Y1n8=
X-Google-Smtp-Source: AGHT+IE5iYFX6WbTBCf8hPKKmvc2byWHvUXMxBGORLFXUMBKGWVjztPI3IQQ7+Y9YV7SsSQ/lBAm2w==
X-Received: by 2002:a05:600c:444d:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-42e74480c34mr32809545e9.17.1726821488647;
        Fri, 20 Sep 2024 01:38:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e2c1sm43099165e9.2.2024.09.20.01.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:38:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:38:03 +0200
Subject: [PATCH v2 1/3] dt-bindings: mmc: controller: allow node name to be
 named slot@*
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-1-5aa8bdfe01af@linaro.org>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=822;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=j4Lbv6zNfqApM1V0yGgeKWlfIsHLow2v2D7sYIjkoo0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7TRtOO5ZDGB2QmQUkPJ/06kTzIWKKiisCP4shXUQ
 InsXEMyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu00bQAKCRB33NvayMhJ0e2nD/
 9IWH1wZJU9XdD6gMI2xMEZU8T0xA9K+1KFRbOZVINbrRwYyTirYYoTlr3Xm8nG6AJ7LXYMa8QLahEw
 9U7ToR/R/hBkPgUyTbYdpkLxsahke9cMoCgPiiO6XKceTjn+YHkOx5RVOCt/n/Suj1sxZXenLO7tAn
 ztn7BAmhv42WPi0Z6+6gqekvb2Yro7qJLFCvScppDy3MUeYRAq6gNqfjkUuWorrPg45lMkFVcjD+RN
 PPaqGpZcSg3+r5slvgETedy5DUwt0qPG4WupRFtfBrZ0JSI2tUE5MtRSLkAWGO0aghjCFcoqrKDxdb
 goO5xpfV3aapOLYmzF+VaSGCtMoJQyETFJ5UbnjPSZZL7uKM1wkcpS7pVpG/gFs3pwxTYb4u3zKq5B
 wiQFNSLylTCparrRpM3p/ttLUJWqKrz6tv6Bvulda8v95d71BPn1O9xofO/AOR+sL2weGWs9g0HESg
 3qPSTlC5RWI9wrY/7F3tdWGcZ4K6GbrWKXxLf1pWcv63Hj82CETY+mt6ku8cNfChUSX1itt3Lz19oh
 Qeh074UwOJ+ivJ+pHI5dFrQhDFLnhRkl5OvqTSj3ec2AkW3dHDUxYYi69r2Os1zhr1LSrTOOsUfWdI
 uz5/RuAmJ4pMcld9lwSnU9WGNcBZUmwoVy0rDB6jeOkJ+zlp+ky7hp00ZLOg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In preparation of supporting the mmc-slot subnode, allow
the nodename to be either mmc@ or mmc-slot@

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 58ae298cd2fc..f797c32ea688 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -20,7 +20,9 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^mmc(@.*)?$"
+    oneOf:
+      - pattern: "^mmc(@.*)?$"
+      - pattern: "^slot(@.*)?$"
 
   "#address-cells":
     const: 1

-- 
2.34.1

