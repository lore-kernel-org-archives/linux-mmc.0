Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E732EE60A
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843407; cv=none; b=XjS3ufeOcgrssusiF/fVByVJY7HBCA7+b4LuYqeP6Yshfbat95U7O6713rHVrhnzT5UW+78780zwEME6VbrgJEDat1KTb6SCVWJKBdEZpMIin4eOOKY2qvEBDqfhc0nPN+urGLWai+5ZkqeqSVfmA0MmF7Zgy/uF2lYSjJ+SBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843407; c=relaxed/simple;
	bh=YagMwxq7U7yWw9QLdcfac7nNwnvk1Yv3KEQc1uEZcGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mS6krSYV17PK6CwpLHIOYban7qvYZeJ+Ea6RrUvvmhjSElvrIzDMtTquOJ8+Ukni5XjkzhA5637NgpbLFqAPZLM5svP9biIIMvKKF8hI6B/3YSMiSeyPxlso+JMk2mMX5CIIDuDDGOE79E2TaQrGDRk/tGA0d04mxtSxyFWp4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=A3D2e6Wz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="A3D2e6Wz"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0b6532345so137702166b.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843397; x=1751448197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpVu8A0fOF6COL52SrecDnHkcknnFYzJmrqkhyu0QC8=;
        b=A3D2e6WztMmy4jEZ3O6D1dgczvWWyyjAzEZFNOu2sSsJCYqOlr2kePhIDgigvRMElY
         +lFaLBiLHVk4ZD8KnA19OGBYvrjljoHonQwlRAOQFvI+ku+NfGt5DXsDffQTdR8vOIbm
         orwyEvv+AKaLDURSy+uaok56/Xf4sNkrAVEHGZU3uGlwVsdl0wuttxMC13S8Eg8SoYzU
         Gsx6lTpDF+XGS/6gUubDowRK6rcT5BVfFNgMidaVlaQf0LnajYRXUfZ8FlEeWBfyFidy
         Tl1j+tw2BKTSzMK9C1P657kaKxYxNRXi9yHJQN8eBAOsuoa6vAgOWbQWzOG+m67LIACj
         fllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843397; x=1751448197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpVu8A0fOF6COL52SrecDnHkcknnFYzJmrqkhyu0QC8=;
        b=FTfequ0bHPB64NVN3LUyP98SXWffGSFTn8JjxSYbft8teDp00NxCwvJMI2HpDJvc7F
         NRMo9OYYrXAkmRx7MeAtDMMMQnF2uTpUEHN86s8lFsOUohTpr9krqAVVNtPVFot2dESM
         NlTTY6C/AShxaeJYGgb1+m90ggiWS2RPJX9zabp6svHS4WR9LL5OBAmxBSgfbkwP7Ffq
         /RpfJLmC0TnsG/ubx75vlLpR96ETBpf9fud2JnYzDjBFzyOOjItF/l/QkEVIwpzaz9GE
         brwVSNDIBCCIfSSyO4DG1jFbmpki/TzBkaXq0fdZ9NweYRHl+jGv9QOClFLcBza7Jl3B
         fuaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSZI7SIVD95XHK/fcmPeowNwFgkffbaYMxq3TILi2xyXwsUfeOu8sRmDL3c6hDNmk5th8LCCFH2AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/YM8HqY8FPpHc3xoxxFvODFMOitHioTqOBnBhvv2+zBh2mfL
	Qy67ipTooGErXoLhlk3KvN/DWVRiO8aH6RGaWk/rjIssKFTmGrCgEZ++5ECKpxujYFE=
X-Gm-Gg: ASbGnct4m4hIlBKj8l+JclQMPUeqOccW6/eNzH0E0Cs66PPj7EAQevOory3Rm1BzcBR
	68VP1odjyb766F0Wha7zGE/1h5vOvZUqDBXz5NSoLztSs8yhPVS8UaKt3DPnrb72+kcwZF2w+xY
	ZzCvFMu9qsZH7LFHFuj98e1el3cpc+ZRzJJ+u5RZjtliqh4yWGaeaCbS+k0iykxk4EC9oHP/GFq
	Er6nKq0t+XxDHUz6bd9ZJ9MW29pW0/NX+AYrnwFx/G5VSwu/RiVXCWr4hvvK8Zl3yzXvD4GNl9m
	piQD9WQ0UwCWF7eoUXsLvIYNqko27n+p1BYvtUG7XLypE8NSw0JKCIg/2zKjhUxuboqgeiKg22S
	vYc7lD5nyLwYDKNMWBuYnyCt0JS2OprQX
X-Google-Smtp-Source: AGHT+IGs0JOq47ozJxO/VRAvUrQrVeV04oDsRGncO0FlhvJG+pk9vEPKTSD0ngky9ofslW8b5sJSPg==
X-Received: by 2002:a17:907:9715:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-ae0c07dfb11mr197384066b.16.1750843397407;
        Wed, 25 Jun 2025 02:23:17 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:17 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:04 +0200
Subject: [PATCH 09/14] dt-bindings: dma: qcom,gpi: document the SM7635 GPI
 DMA Engine
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-9-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=855;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=YagMwxq7U7yWw9QLdcfac7nNwnvk1Yv3KEQc1uEZcGo=;
 b=tKVOirX/O5H1uxQ7HfeyAyYM5D3We6xzlJ6UXlJXIztsBOvAfenyp7TbfJ/uAqV/GmjIz7RGD
 07DUBwDoCwrCGr+c0KI+9cEHz1aYwkDjfvuOUxmsPxCvypnlcx1nV7q
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the GPI DMA Engine on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7052468b15c87430bb98fd10bc972cbe6307a866..051b90e57d5ff42f82cd803521c48498ce6af35b 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -33,6 +33,7 @@ properties:
               - qcom,sdx75-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
+              - qcom,sm7635-gpi-dma
               - qcom,sm8350-gpi-dma
               - qcom,sm8450-gpi-dma
               - qcom,sm8550-gpi-dma

-- 
2.50.0

