Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483E1537CE;
	Sun,  5 Jan 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093633; cv=none; b=a9tZEUJFBf33DmyFaXb5WYxxhojODxPiTlb1ZE0ZRTfzZcFLEm297dI0jSBHJCO968Dg9OENjJnDA78ZMXYgl/6N0ko+WPfmpdbPZZxBwo9nH2iNdaJ6HPGxVSDdDexxKuDfredJri1LspLh9LKR1gQZ1goWGOt3DZ61KVSvK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093633; c=relaxed/simple;
	bh=mp5f3GluxxSGVLKmrhOfZsLf5dflolGGdTe071OeWsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMhW5+W4U5Y6XM9DoGx4LB3JZ9SAKXqxk3rUQANA3ajWZEfgF2JsgPIa9STcmjlBKJ5DS+ZzQXwjSV8rl4Dj2RrMHTdO1C3ZK34jH5uap3OYm0l6PEbGLCSyG2oHPHo0ZcTAK/uUi3j/XjgHAnrBb9mOPU4ZOFIpPQgXIRrZ9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExzVoImP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExzVoImP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436a39e4891so42026845e9.1;
        Sun, 05 Jan 2025 08:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736093630; x=1736698430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T64IvUv2v2ctLBX091YAC+zdH2GYdiIMlzETmbUeq5o=;
        b=ExzVoImPis5iJOw543M64fLhc1n2Nxxvw6pfmQD31CrE7swlwUMRYplJ6Z1q8LsHos
         e74EYeSntzFQdpMmxLJwFGWpyxLXplmJtP8ekCYVRiFDeLvkvLFrY93KV1xD/H79QNE5
         M//8QNROf1xxabB7XgrmMyLeVHLutFWbS1QCiydp3vrlAP0YuHCS+vUUUvMYpnqqpXRl
         gseJs9B93eVv+u8Q7WoGtjYZI+R9Q8GCjaPOwtRsmyHIjhAWVSSgihnfWY/vAe2kVdQb
         /3WryximM9hHYW2Lp9HJOgObpQpijm/+sE4hkF+5NblsH7K8D+UQGsYY+mBcD+Y28l2U
         ZVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736093630; x=1736698430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T64IvUv2v2ctLBX091YAC+zdH2GYdiIMlzETmbUeq5o=;
        b=S4Xj8JkCEdAtzQ3yWdTLgbzoUPlXitgYltylinEuGKTHoi92/yltWstUBfAKoDuUXm
         foqI2HRVmRkhhD0pA5S4FQfun0Kp3VgVjKAjHysRmPdapW/GzEj998LvaYVCSZD5Mtad
         fhvmMFerxtmzJYzW91U1yVPvyiJ7ZlyW63z3e9rnvJaPTA+FpyLTruDkGbKhXrHi6K0y
         NMzK142KTCNtyx7y4QJ/qb0ZvirnrrRAus15q+UtX1cihmBBFC+m7Ul3tTclfL53mgEQ
         PKKuRBnkKDxXgcr8qjBE7ANfAyfa3vCFgpha7m4qOvTRyCJjtZegiUp/pyI21ckVq42S
         rwmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZGfuParHIUcwFqfq01W/j66xByjdkqcWhUvZQMm63KxluFsquCvjagErPuiOe9GGFvZ4r9TA/Mqu/@vger.kernel.org, AJvYcCVWea0qMip1sQSVWlEm8UP1bjvxyrN1QLEl4CNb+BQAXdxEaPFtmrvsbongECX0jQx8q4NPa6r3nWdcaF0XlclItm4=@vger.kernel.org, AJvYcCX0jn6zP00C5FVaGIyTqA1YG40Sy7XwBBDR5kaKQIlxCA3ecyZWNIfIhvf9FsFmNC/GhBsMoC9TrjYsm1CZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/xpZvk5eT7OpQtSiwnO+yaG9Sqgwf1FwM9gbkt2t//UfVRVU
	pTUxG37k1qVRqtOPedvJO5BTT3doa6vhLg7eAO4cEKbuZeAH+yuL
X-Gm-Gg: ASbGncuUl3iMQiafBFOua+fwAFrmFOLGQI2EkZS57dtQrvEzJSth1Jm50NzyBUL85up
	OmuW6/ybQoPrLochzgdbs/GcHXAwqvnKhT3kQdy9ut262cxAhOoWI/YzW/TbBI1F5s+/zPs1C4j
	u2Ml1sIKELD/fJANRYiRhkWkrwNyBgFvywUjSGNPHM9xu4O6Xmfw1hAw3TTQf7jbx1jD1TcZrTZ
	TyanYTUFPZpnalgIEYHAI6WihN/wj1XgKXUNOJtDR7DThD7YZG39Mr3/VrITaXuZg4JiYE=
X-Google-Smtp-Source: AGHT+IGYEUv6t4l2l4U84ZaLAmR9bjEsT9ICGKfsb4L61QXf0dhxU7S0Y+nrRYmb/VzwneK6WaOL5A==
X-Received: by 2002:a05:600c:3b23:b0:434:a525:7257 with SMTP id 5b1f17b1804b1-43668b49a05mr413168025e9.21.1736093629968;
        Sun, 05 Jan 2025 08:13:49 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4274csm578250565e9.38.2025.01.05.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:13:49 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for exynos8895
Date: Sun,  5 Jan 2025 18:13:39 +0200
Message-ID: <20250105161344.420749-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos8895-dw-mshc-smu specific compatible to the bindings
documentation. Since Samsung, as usual, likes reusing devices from older
designs, use the samsung,exynos7-dw-mshc-smu compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index 5fe65795f..ef2d1d7c9 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -29,6 +29,7 @@ properties:
               - samsung,exynos5433-dw-mshc-smu
               - samsung,exynos7885-dw-mshc-smu
               - samsung,exynos850-dw-mshc-smu
+              - samsung,exynos8895-dw-mshc-smu
           - const: samsung,exynos7-dw-mshc-smu
 
   reg:
-- 
2.43.0

