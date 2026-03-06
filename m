Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D8382361
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796474; cv=none; b=X6rZylizsyqcOBP9cRR0S2Qt1PvQ/XFGzB4NQ8ElwGN5YXnOzDTI6LbFerFcrAocaQjvjbLmW/uoO2qKLG5Ta1319r8y6i3RrKjWG0CTtRLEHwDwL3TZWBoGzqUpINmCfbcu7OwwS+Q1tWjFd2B1faSPOlWkrh9iRdY2JCX/yHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796474; c=relaxed/simple;
	bh=9itS1QAWuLe0vXvae6oudDfy9qSr8VqquzUD9/4XR5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpZVKKQEqSVnFlTnOFMvrbSb1HlIk9lb8H3Z6ruGLYAyosnancy5P3xl7X8YWdTNh6bWbRGSP3kLScZ7VfvW0dIG4UELPXGGZE9Nl/lAZM7vWLTUMJTH2zvoezI3B7gHR4eTGGHRv6YE31E1LtFiLWxbuk4QhaVRGQiTqbLRMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zae6I18X; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zae6I18X"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a2f196cbaso28855301fa.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772796471; x=1773401271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyGXUYpQQ6zvxD4ZVeCoFbT7LecnKQgnIoon7pbvFWU=;
        b=zae6I18XFyGzkepqwVU/O8CoN+jVi9elAV4krWohgXHCefrs82MhxZ4GkWxq8zEJIe
         Cn1p4sd9jspq+C6Tz8WZNyidv8uEPL2KLdI9XTst5FbqHbmomU0MQwb7GdZlD0JC+2K5
         9zFKwUrpCyxWZMUcqhxd3oN2nLvA+oX9mzqVNaeKJxaS4w5BdPmUzf9rCrc9H61vw1fm
         ZfKh5zwxHE60Dtk0/5KaFR49vbxEs6Zgls0Poh4ozZhGAdunmT3YTRF8k7V6VWrsX+MM
         6nPwEUabgE8zKWmlJO84mUPgdBJIH3bBmxT1aXRJE+2WUrePaxGW1ktRxUyEuKUB3DAx
         Zfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772796471; x=1773401271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyGXUYpQQ6zvxD4ZVeCoFbT7LecnKQgnIoon7pbvFWU=;
        b=hKhR+lyPmOKVqPBqEYlV854AnUKJriI90Pwc1r0xxrICoFBWU0fvW0GZnQZdQyo4H5
         rnqtmSREwidugzcoCsiDnz/L72ANVMjdb+cil999AT13FJaQCrffu06s+9ojOV7Tg2Ol
         PrwtCtRFeaLpp9OubByxLlXagN8+Ujm17QxxpNTA/b8URe7hjy7vkKQZg+0o7zdjAUZn
         yEr/GL2EYUBXYhnKQ426VfcFt4ZYoY5ThR6lUTKJ6HyY49p5ORyKlU8I6xF9kynkwDz9
         TA3muU9ZBtGAQUUaC2nzFQ/VMQMUoGUzPN9LQsCTghx2zq8tOpWXoQdqoca3nIFzUAAz
         NBiw==
X-Forwarded-Encrypted: i=1; AJvYcCUknPynyYhBLRnsiZdeyynoYHtiyvqyETLhZvO64QA8/3V1sIDUTpmU8EIiqANNOcu5s0jycIsztPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnUkhzCVyHNWyS6sVDAFCESQxnfRrtKNtSftIf13UUdfm+KlY
	P2mv37+h1K8H7mZMG4ar3Q/U57PQvGrmAVQeAXy3eCjVeccOo2kaGwfkWMcHmVyeMEI=
X-Gm-Gg: ATEYQzwMhnVu/HgkHt6Znckex9UXLRqMMWIBmOVX5QS+DOh9hJ1oDKVq33mnSPXIIwz
	QecZI1zc9I0+WqGbBsWEu/8ayNiF8YGp7cudpWNxLbxLXBBCnu1J3h22PXu+WYJAms7BNg3JtE4
	Qq4Es733WVNJYIl1odUUo8nvfx8HdI11uASLr5fizNNyLorwkOjTJTrrawc/sCxkUfKUt//vjB7
	7kJOJx45l59HzSlnVelMvyrtYCURrPsTW6nbMMutr1Vr++qIJdp/Ie3KOcwOiyb2XKrj4fOPXoa
	QwlEs/j2983TME/4WKVAcnMcnUh8hguetiN9X+FSJJ+f/4bDDX6IYYH257eQ3Daz1VjV2XXUANz
	HYSWc79YOclOm2yiGKx67Dko2ff/DrNQet2zguxXJFYmjjUZW627/g0OjI2RNscjoFkd4Oq+0nE
	wrtY9cIqFFrNvy6i3OyMizsNag4F/EinOFDLk8cVo7zoCl7oq5woHYryfMU8/w0kufPObQug9k
X-Received: by 2002:a05:651c:1c7:b0:383:16e7:9c3 with SMTP id 38308e7fff4ca-38a40b5db59mr6384291fa.3.1772796471064;
        Fri, 06 Mar 2026 03:27:51 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a41f9907fsm1891311fa.4.2026.03.06.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:27:50 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org,
	Ping Gao <ping.gao@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: mmc: samsung,exynos-dw-mshc: Make both clocks required
Date: Fri,  6 Mar 2026 12:27:42 +0100
Message-ID: <20260306112742.64235-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current binding allows one or two clocks to be specified, which is
wrong, as both clocks are needed. This is also confirmed by looking at the
exiting upstream DTS files. Let's update the binding to fix this.

Cc: Ping Gao <ping.gao@samsung.com>
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index 27c4060f2f91..3e560dde714e 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -42,6 +42,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     maxItems: 2
     description:
       Handle to "biu" and "ciu" clocks for the
-- 
2.43.0

