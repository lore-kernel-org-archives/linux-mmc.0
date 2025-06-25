Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47B2EE5F0
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843411; cv=none; b=jLH49yNbNFYtXOynS9L+r/DFk4VZa9Fm2I2+lpxpgYo5u+xmvrcPwKu+VImxlenRhMbcGxQVpTo+cCcwWcY69ZdY5isvRj8cL+pjLhJLt+vmI8yIjH0H5Sb5bP5C++KKSKKd7tyeYJnxsrZUYtayC8cojyCevJS2Ty2OWnLedTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843411; c=relaxed/simple;
	bh=lSbZQMNS3mZ2Qhlodk3BCi0I8+R0Xssr2JSReaIqHv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTTPbm2wYvX/EPpW/RoBGYAxl+4OqYdjIpNvcd8GhWuXAub9rNnemPJnSZAjg4BPxbnykpoaAudETAfshLOhIGaC9hZWZMSToZaeiPp4Eld9bU/t/RGLxBLiVarLG86VCu3F7kch1EqtQiMKjLZctnEe+nZi/Wbg3+b1bMB/sSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=av86R8yv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="av86R8yv"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso145691066b.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 02:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843402; x=1751448202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlprjCXzNhYiu8119hAJidFX3Tj0Nj5OLp/Tir9pgMI=;
        b=av86R8yvptx9KLSMo40dYEQvwzrpVi2kRrZRWjZll06aOluwXC4GhtmpEXJ8t7HOXe
         e7WRdcLfnfownve0Cx5nNRDtBrqHXjoitLVLGsfUoimndoT/jNzeuQKUa04WifDLHQci
         gXUjPHI0ti9vhSmsEf1ucIP/RhKEuEM86LzzteYzSSpi+KmvohRj/0ncyUA2CJIxO7hk
         +EyhA11QwI88xrt+YFKWvRxQarPKFf4olPe/dIldn2eyOZpuFmCqIYH182bMQGRuWDrR
         mXu5hyGsMy97k8aK1+cNjVMCUuSImAqxUzvkknlLYBr4v6IUjBmfioh42UvqjKzN7Tjn
         4psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843402; x=1751448202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlprjCXzNhYiu8119hAJidFX3Tj0Nj5OLp/Tir9pgMI=;
        b=AQ2+wj60lckwqGmMwssEfLYlfZZ2nTihnPpf7LksFHWsQnM3D8+a4DwhlGO8mYYT30
         IoZKkwqRR31aDfk9m+Sfi3oL8kNZoxA5tF9xwbtGioH5ka9/4HhSgEttGcrGlift5+3O
         vUMoYwCBn1imHcVOpF0JTMv7dS5HlLbVpPc/btFRBqg+kuXRrr/ArnEDIm4xK0Gf2Ca8
         n6ytgnYtjjM5oiBVDukLlqfw7epyfWduC0wq7UkIt/V0xqXdI0NQ7umPr4vPEJSA0kDB
         AeOVw4WCeoG1Y3iVI2QjuFx4diNHFqbluYOQVzPs2KFhA7qjZgLeWM5MAEBBQrf1rcG7
         hWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmiy/18jxHrn70VSPnsRo4EFUTSnu+zRHzBgLWmKN/Zk8Qo+Nr8puG/U7ldE0RpnUU1dVuZ5suQdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6gM6AlYfkA55X8CDjJbXSCdF/AmRO9rUU5rqngHcuzKEtrWQy
	t84d31j2CTGkcg88DdTqKp7E7rfZHa5Iwlix+YO2PARv+OVH8xtTVYmkdeJhjM9IuBM=
X-Gm-Gg: ASbGncv163Z3J+j1esym3EFnu6GN9IWvcuTx6ocS4yg1gR5Oeor40TRSGsQgEfbQ0+h
	uZTRkbJuEkTlKez3e8D82UWIGjE2f3Omrs0QC9NaJTfKhqFf8VO2G+tawnrZf57MRj/ne/2Tscl
	2x3fJrl5eoJ+Druo/Kccjkv7ksZO81YrdfH4EJN2LPSrZMh/3huOreZm5te3CAtaUtjJdVfZfh2
	dHcKvfQAUUeID9rk7dDrW+APVF86FWVDs3t1VjYDGRyr/odAPsIbM/YwylyFMff8jp9tqQqAGTY
	qwSNGqOgBPxRPcYPOREsnmcxZSnEmt2z+phohLxvCNRCcYgMht+oqMejujgixkdwF8JfkO1dmol
	Ueaz0vMebHnLemh8LwLCQkYJjVOc1K/QC
X-Google-Smtp-Source: AGHT+IFMjj0Y3e5vRaQHZvxh7fHnevj/9XdkbDfc1cM5LOi08SBv192uCl1KLf+bmxAA3PmbEJU5qQ==
X-Received: by 2002:a17:907:608e:b0:ad8:91e4:a92b with SMTP id a640c23a62f3a-ae0c08724d9mr179615566b.30.1750843401578;
        Wed, 25 Jun 2025 02:23:21 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:21 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:07 +0200
Subject: [PATCH 12/14] dt-bindings: arm: qcom: Add SM7635 and The Fairphone
 (Gen. 6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-12-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=996;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=lSbZQMNS3mZ2Qhlodk3BCi0I8+R0Xssr2JSReaIqHv4=;
 b=yilPxLb4+1BOE1rCFDSywXfKUexVB1szD3ZMpoPtxgrPy4d6BGvUtVW9enhV9rLTafFlsiUdc
 CU20Ge/ADStBELDiO8FCnFwU5QmqC34bwJqV2yiobXy45sPeekuAPH0
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SM7635-based The Fairphone (Gen. 6) smartphone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 56f78f0f3803fedcb6422efd6adec3bbc81c2e03..bb89f81437d4ae12ac9fa447377d6b48e3bfa581 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -93,6 +93,7 @@ description: |
         sm7150
         sm7225
         sm7325
+        sm7635
         sm8150
         sm8250
         sm8350
@@ -1056,6 +1057,11 @@ properties:
               - nothing,spacewar
           - const: qcom,sm7325
 
+      - items:
+          - enum:
+              - fairphone,fp6
+          - const: qcom,sm7635
+
       - items:
           - enum:
               - microsoft,surface-duo

-- 
2.50.0

