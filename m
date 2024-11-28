Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BC19E99A
	for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807010; cv=none; b=NFusxPamk2Z/EXrDKadD1XX7PSdo9Dn0ZBokJXM//b2nyyKDPlxKFZhPWMTgQpXj2Fcu+yo4tvFkmKFsn6mawPl3Plyvcbue+t/JtY5cvE3d8aoEtK78JgSSDzEw3XEtWYaNwgmsfEEH5Adt0CaMGqKDC5AIJ43T83QaK7vmDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807010; c=relaxed/simple;
	bh=bPKXnWow3ydwEe/IecPN0lHWVn4gH4zGjIg/TjrNdgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFuM/puKdP98nEiyAIvZhA8/Z79iKHRSdBWEhPLAc70sOsgnH+nBpMuWXzkvdCPdvReSD7zL5+4Cn4aaFomQktgF2t0te74QbBeQiBnT+bD4tRjtObmTALM/CpClTIG5UOhTTPlZmgNyYMdo2mUeacpacfeKn08Lmon5+cysH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypNbi/da; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypNbi/da"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382433611d0so845307f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 07:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732807007; x=1733411807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aomBrOkJJqCFmjpN0sU1576SH9xMwR2JgmGtI6ewTOM=;
        b=ypNbi/daRQOl8YJVtt1wPcB6VsucM1NTV270R9o5E+m9+zje58nI6tYjePh6y8qa7V
         7ZvXslJ9hZAukrfBWjVLAJmdDchJwnEr+OlxQ8M4VHRXS6PrgvB0ZsTbtRRSspzwb8zP
         68sHFGruhmfHd4AbxgSFyEUTeUxoKy5gD4kglmvUKnAQwDrzXshznWl9zktDMe37u6T1
         hQSRsz5rAt9qwDwwtIBtAzCowVJL0km2gUxmwUOZYQFsG0JMZ0OHEe6nYtUTFa+MBEeH
         Sr1zhZET0XwrUXurgH+d+jA3YWXrSdQamLgxIoNodSZL6uN7pNMvo6r/zdf91uQFvDzY
         1OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807007; x=1733411807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aomBrOkJJqCFmjpN0sU1576SH9xMwR2JgmGtI6ewTOM=;
        b=po2qUAbc3CyoEvMVLfTuwQjy7vsfn/bSz682N7Djs6umjKVbxtP/C2JS5av34pjucR
         O5d0yx0a9oGeIdbPvnxUoy1cZnK5lxhtGhucHwzjePWVa0JJ+kZuxqNwzHF7Kmf9K5Fz
         g3cRjF6EeLYpp2Ade6XshF+EaNE5RWP3+B+XT1wOfHKWhhKhqcjGM0D/CdwGq2RWwGq1
         JG/pEnQBipHArsLi8kbvyBWCNphVr5qRfWwQs786A+nVjdLP2txVNGXGTD+3zXQAI7xS
         CAzeN7pFosKKwb/mlJF8EoThL3opw65CQkf5eOycNpOn+Lv76E8G1O7BC5lqB7WruNu6
         5Hww==
X-Gm-Message-State: AOJu0YzH/fo609AqhxkgmiNZNE2cX5TnakuKSOKTN7v1gMrOv7O2cdmQ
	wTFIehbsmzQ3CuWeAYYDEF/aCFwAUrqbl6RoR2wSYRu0i4aQuGuPALiF7gnt/iA=
X-Gm-Gg: ASbGnctpwzPYqgfniEv6sNzr9HJ9i01Q4fE9qZvh5TGhe9ZtXBcWT9sJbwiNwfb84Ct
	AvintAApwEJrnz9rNpIvQVdYnq6RWnrlLjmMXoZ28+vJajr/e0g1RgRHBsNNJH+0Fqugjl1jsQT
	U9A4X8LaxbrVNj03VjuGac5J12V27pDoQKp0NhAIxoGncbiy3Kh/GV3U3J48jWSJlqRE7jVknN6
	VTQ90DcS4tByF8rIA7yv/pz18+fL6UvWfudaWPu+HVE0t+61nNF6HOYVRHYljmRYcckwSg=
X-Google-Smtp-Source: AGHT+IF7qgUNEDq9uAPoX7zFnn8oEdvAgf35U5UKLpooE3ExKagukoVva5liFqR9fUXeHbx01NFzAw==
X-Received: by 2002:a05:6000:156f:b0:382:495c:dee5 with SMTP id ffacd0b85a97d-385c6ed9398mr6786903f8f.37.1732807007345;
        Thu, 28 Nov 2024 07:16:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4fe1sm55867025e9.38.2024.11.28.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:16:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 16:16:41 +0100
Subject: [PATCH v4 1/5] dt-bindings: mmc: controller: clarify the
 address-cells description
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-1-11d9f9200a59@linaro.org>
References: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
In-Reply-To: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bPKXnWow3ydwEe/IecPN0lHWVn4gH4zGjIg/TjrNdgU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSIlbr6WRJYLRcaNMGR1ncbaIe+itmYl/XMH5M90Z
 joIxdeKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0iJWwAKCRB33NvayMhJ0feZEA
 C9LEvNiEfDbR3jqabZ4gFHy7ZUW5EbzWJ0W26BSURiQQ48SZHz7YI+BAzYI4t8Ye1WSEZzdb3YpouL
 JhELBxJ1zoatxGPGqUxZWHIIRKyCJXgqFpjXC0tnDNesryqz8UyNaPODROlGOzKDKpywGED2Hpg0Kz
 rGpSyPcPyIoq9sylyeBDBzScquM8WbvPq7bM5/YrfwTAw9fUOra17+VP0zlpzdqdbUVvvsVKd/Syhi
 d4oH3lS049viIYLcKsLuZDF7UeuSFuCl8gnvWbsIU67zuqv3QvAILVR2MbP/7e4TokZkRSjZ8IXj5Z
 KHPNpa5BTis3Z0x+AoGjxaypO5mrtfPtyuMV4wyqTQn93xcFuNfV0b7Ub+qwKumJHFsxvLsRc4WxRA
 6aLtOVnqY/TUdk4eYQfEkDaU91Nk7YaoBXlDESUIwxjVL0i9DgL3/7m1ILk6kxCz2Zg3XS7BbzGa5y
 8hR3nPrgySefND8BTe18tcLV0NBHqO0fZWwwB19uxyhc+666aMWlWDGG6BrmefXzRLrg+bXoHKJOk6
 TrZa1t6qa6SUGuosce+rl/yEKumvdIAT33DV0miPxOKxK/e/aNYBSP5VroHnw/jdWJbMrTfVrqy7aQ
 8b6YTQxECEAJdUi49Psc/p95vh08kV7R+decpmDNi+7nq3N5UzFCLo/x8rEw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The term "slot ID" has nothing to do with the SDIO function number
which is specified in the reg property of the subnodes, rephrase
the description to be more accurate.

Fixes: f9b7989859dd ("dt-bindings: mmc: Add YAML schemas for the generic MMC options")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 58ae298cd2fcf4e03b5b10a4be718c7b77552a7f..23884b8184a9df2da3bda5f86916f2e0a5d502bf 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -25,7 +25,7 @@ properties:
   "#address-cells":
     const: 1
     description: |
-      The cell is the slot ID if a function subnode is used.
+      The cell is the SDIO function number if a function subnode is used.
 
   "#size-cells":
     const: 0

-- 
2.34.1

