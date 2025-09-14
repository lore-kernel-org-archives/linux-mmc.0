Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F525F99B
	for <linux-mmc@vger.kernel.org>; Sun, 14 Sep 2025 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855938; cv=none; b=sSwWp0HXQX70Hn6diwhvCPFo/ViEvNhbukUlsK4zviYeab/lMUYW7MQdl/aZ2N5fVXdIw/sKKjWOF0pZXjwxVuXaQ0ZxGNQSugrYlPSklgKFupUYhfr3EiB0rRlWxDx1LUql9xN9fLkEV33hVJairZQKFnc9+k18+vwJj1eKR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855938; c=relaxed/simple;
	bh=ilMxvWH2dg61Z6fyXi47Z0rAj/IgKekCXgAzquw3YXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6KssGAhqLPQNZAEIgbqK3cEwkMIOLhTY+Ynhp4WFUx8a/3ql1YWvXVEhoEKbhdImBdVpUTHO4nDuK7lBJSIM96MsPf2A3u6fj4azJ/IJoob/+W9XrZOYh85fNxQ5DdtVjHAAve54azZZF7pZHXAYPym9R4C3jZufGMMzMzXltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVf3Cw++; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVf3Cw++"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dde353b47so20251785e9.3
        for <linux-mmc@vger.kernel.org>; Sun, 14 Sep 2025 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757855934; x=1758460734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpcddqPrYhRHRnLKWFJl0UXLOkAIbo7ClNO40SWmR1I=;
        b=hVf3Cw++enjGQUC9WJ50stlt7rX4H35ZsfgQGzaiUVbxhOB32YAQdl4Dnpp1zqnTlp
         sa6KTtBAG0/zLJE4UWOPP0ziV027L105cojgMak1t8JT2gXaBI4PoSyL/uSaGfBCt9LZ
         voGxVCPcQjO75VppmQRCU0FPOYpQJxZtnGKcaUHg/nRQqRM6PfO3PHjOEk5cU4zboo7c
         G+hxISv31JYJxUeDImvElLbSO9SpA1boKwB7a3Mol8ML4izkmwdrZgbJ/6Uqow7ECg66
         nVv1jbKVTM6kDA5B4ZiUIpaPFjb8JUeD6kitjAU80jBEMrIL3xZIE0Jqb47Qt7/j+Md4
         Qh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855934; x=1758460734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpcddqPrYhRHRnLKWFJl0UXLOkAIbo7ClNO40SWmR1I=;
        b=wokBeGhVuQbq6TF5WWJ8sQB/4NdGL5fokObZEh0iSK6Ayreb7EYKeJgEkfQtqPT2hI
         kMPG1aNic/x0Chm5Kl6lfpUi3XU/MHhhTaDO98EXBGdN0rHYym+YVLhFa/BZNO9KZlP7
         dk7SRTnFU0+rR+pzJHLrukdEHuc+iDGe6tYiSwlZ2q4oyrKXPXFq/U79Akxqu6+o/TcI
         0keyAOYAcYS0xjURXqsUvST8szPkzoX+VkJxL0W/nrWic79G4VLiXc5yGIi3MxGmkOMs
         Kf47/lcxhx+FyU5taDSymflafJmCnWIcQbovTV1AWLQAksnUl+mdh9Fsf2xz9Mrfxxl8
         1Ggg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJgkV6sgAhQu04NCKQ7h0JugRVeNfKkvRSzFGKzMhBLk9UmBDcd83odoemxtakp7LTJwZBK3rCP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9jlZZEVaeL6sV2zDt7N4Nysk0/wnm+x7myZFsLaqYE05hx0w
	NZz+4j2GxduAXPe73XonZ3jl4LuopG0xVl1Z1F1Wj3kgdIn7/suCe1vZ
X-Gm-Gg: ASbGncuCWmzKS/oBExVDbfzKOJMmFS8fW5iKQDY3og4YQTHBN7VcKrW4D/JIJ/HEwTI
	52hpCLKYX5FEJlFQuRtHmRR6SUbJFdd1cQOkVQm5zwhOf5nEE38ks+MYhG+Yc6hsIn3Lcj0aWkJ
	mHqTFl/ZmgwFtOKv6T+PmDRZMX/Yx1ivdVuKa0FDAPrSrhrnl3+2jAtdGKU1PgVbgazXYzpPaGO
	jyTFe20fUz2QUdqp5NWXO2fKwmFckhKZx1L6O5+0BA7/2pdR+uHmai9BWWyr05g0nmUV+v8sQWn
	JCDxbeNBM9X4sewlTxy2z57WZ2e+qofuT1FX+ZtMs+6zbbv4+frtFx4uDdVImRC92ifuQdUP3MU
	frdGG3i9gzXqdJ5R7P0FvR00ad6EghOgwSZoF2Vm2AEwUMfoRrtyEIIHrjxpw7QM38KaH907nhg
	==
X-Google-Smtp-Source: AGHT+IGAQ9494spxVybXeZcysph17sK0XNJ3EcpSw8C5tvKdn4tAgtOfyRpsT2ldfbY8hA09fnwBpg==
X-Received: by 2002:a05:600c:1c0b:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-45f212f9888mr83535235e9.18.1757855933631;
        Sun, 14 Sep 2025 06:18:53 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d62besm133359875e9.21.2025.09.14.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:18:53 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for exynos8890
Date: Sun, 14 Sep 2025 16:18:48 +0300
Message-ID: <20250914131848.2622817-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos8890-dw-mshc-smu specific compatible to the bindings
documentation. Since Samsung, as usual, likes reusing devices from older
designs, use the samsung,exynos7-dw-mshc-smu compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index e8bd49d46..27c4060f2 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -31,6 +31,7 @@ properties:
               - samsung,exynos5433-dw-mshc-smu
               - samsung,exynos7885-dw-mshc-smu
               - samsung,exynos850-dw-mshc-smu
+              - samsung,exynos8890-dw-mshc-smu
               - samsung,exynos8895-dw-mshc-smu
           - const: samsung,exynos7-dw-mshc-smu
 
-- 
2.43.0

