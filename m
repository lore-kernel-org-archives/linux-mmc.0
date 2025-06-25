Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC162E11D8
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843404; cv=none; b=bsAM3voJkQnDHpIU7RANL4I2L3KjtV1416DHa6ze+mLXsI4CKPgPDOo6Su37mBP8OiyVHPkBGg91pRXsDCMr4d01nR/+9v8pQVXLxy7HdGDb74ewQVvx+lqhYrwQXL1eVKfw2l/hpUcZVscfnX/URZAI1JObTKJYQtiEI8KpC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843404; c=relaxed/simple;
	bh=QF6zOzPisaNRx6UkDEnfUjzHboUeRh3pRf3riJuZ07g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYz1HU1oU9YNzOoCTDE/vJjjgidr9Rqb8GJfaaefE96SaZrs4nlbmW1tsFKiC7Fq1vBUNlpVaMhoI15zpy58KSui3egmaz5825CxTOZtKXSDiqoRVu1wf61fBsQ8eGoYYg9AiewEuR1koV3pCEkhMhzX+Gf/mXtPxHWoYzD92ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=QVvl/9li; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="QVvl/9li"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad883afdf0cso258089966b.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843396; x=1751448196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKX5DuiO7AzJ1dwZVvAVxWI3Xdt99v9P0wOhJICwjbk=;
        b=QVvl/9libTo5/a2GI0EJQbZpa2KCIvFYnDJqJU6G8gbDGzXg7f4Pdk+YkaMaHcXCAn
         Dj6l/mHZdMaMwic5f+ybWQS2qaOi0xLsKoZunJFNua7C6PREekpvnoFbLy4uoQ1x1yGm
         vbJB0WvFKXecgNYS8IsQCyPuT0CCWS3mkHs967Y30nfdiMFsV+w4gNkDCFSVZ7o9AddO
         mflARtdkg34SE8aNqu//ITfDRKJ7JZWibDXNFyvltw3yDDFDOljWHnauWLlPngd6v8QW
         BHPkErTQBFL4WrwnTjZ9D62AO3DvDR4pblHMwO1qiTzqL20mHx/yPrDKynfYErrzz5f0
         hvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843396; x=1751448196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKX5DuiO7AzJ1dwZVvAVxWI3Xdt99v9P0wOhJICwjbk=;
        b=cna1SgI68kkRGSFOzHgD0v/cGV4GV07JqMlqqr9yPjdDSNVUkOgTn8sKInxsUzpzA3
         9JRuZB4q37Eey3m1xegug20Eh/+iiy+DUBnX0ud5OpJ0WpaX1mniqrYiE8EYJ2mKcyMW
         9Q1Ez5BDvM8RHwbwnKXIXVywW1Ft08/0e7LcBnfzbeRSiTxABlc5EUOlGPq45i+MD+sg
         JJTZ4pprjWbKASPjpgb6tSC60qpef6+bmlYe9u9niWC4/AJUQl856CfWkyb9dPWxtFth
         mFuLLxlX4uSHQZmWRMuReDWJX/ebzDOq256FQwaR84Da/9NWbk3coxRthexQjQ0IP4BH
         OD4w==
X-Forwarded-Encrypted: i=1; AJvYcCU3aD4uyVimH8U55psk/MV8Kf/ZruK6olaS67vrM3IlT750RsAPLSGsbxVdjWdsL2f8eG9e8HZFpGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+8wmYRzjgLP3gB8A7YojOsvElns+YQKR6uiRc5ihxv8bhVGn
	umkR5O2rudL9wdhVK9G+wih8IXPJANLVm76GOZhgNOjPJVKl2K46BaRcDPbz28Epnow=
X-Gm-Gg: ASbGnctkEuRPGAWhe4GNcrRBhvlgEoDRGSg0l0O6LBLoTR/66bf0f9/8m9VsrvPpX86
	gLRrR8eaicI8Y4tPehC31+ifdo1LI56PjJkeyWoldLRMNhNZy9Jd1/2ilbvnvNOlm6h4SDX6IYL
	mrqt73N0m35uv7ddBXUmhgNN7YuvjQ+ekyre+F5QaL+5fxUCvmI5KQgRukYyDvLc8O1vmvXMxsG
	/0thmLtRh8DZIEEGanEOXdfZBrAoZDnAe4DA6Vpvh2ZXeR8UW2zjWg/sjJOzDOxk1xvcqqRY4y7
	lx4eHIs809JKRWwgeowjd4bwejtwtI9+oQQayS2kliF9jZuAbFtyX102lNE3o1rZWj/zzZ9gjRD
	uOAG9xQdvKrGbtsYOEXh6LweFRD3bBuGiO/Q5yoqMzLs=
X-Google-Smtp-Source: AGHT+IGiDFBoDucTPjUqqaMImeHSSI/9lZCbdCTgquH7Z0S3KEgQQwP7r3gJyT916kpPzaeBdGItbw==
X-Received: by 2002:a17:907:9808:b0:ae0:bf55:5c48 with SMTP id a640c23a62f3a-ae0bf55634bmr217592466b.7.1750843396185;
        Wed, 25 Jun 2025 02:23:16 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:03 +0200
Subject: [PATCH 08/14] dt-bindings: thermal: qcom-tsens: document the
 SM7635 Temperature Sensor
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-8-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=884;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=QF6zOzPisaNRx6UkDEnfUjzHboUeRh3pRf3riJuZ07g=;
 b=u4p3k6p/2j42YHb4XwcyOL+Rq/CqQjib4+cSu01z968A3xXWkhEPGtNDUd9b2G12MuzVho+Uv
 4c01+k5CLJPAHJpvg+Bz4qlPQ4Hme44CNKKgFxwQ8y5DARbiLPoZmDF
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Temperature Sensor (TSENS) on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0e653bbe9884953b58c4d8569b8d096db47fd54f..76b3d4ab5a793a9bd675e52a348ca2d62077cf58 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -65,6 +65,7 @@ properties:
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens
               - qcom,sm6375-tsens
+              - qcom,sm7635-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens

-- 
2.50.0

