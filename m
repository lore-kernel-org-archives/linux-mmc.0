Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568C1F5827
	for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394038; cv=none; b=DLOD6Ucg397Q170gD4dvsA3Bo4pcGrftcO0DkZKFHI6syT+qg+wZLBu1yxwnT4xsvJ1W2b7KL+6KeaSFYKwhYQPVpAFjVQM3jrYjVQ+M25ixM4N4Ai5y1vQCp5mPXDVen3DSEwWhcm8mVmEvgKjJCFG5E/0nJPIZi4rw0O+SUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394038; c=relaxed/simple;
	bh=ZPOAK3xFvDZxKtMubUGBzI+X0LzZj/ehseUCLqV9308=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zx6FvW+Nc70ayADTzqmd8lteFcMIBLrsOMfr/0BFHT+O15XvEw6imfby+rV/KYyD7eemKGr7vfhB1/hTzA8ufhBoQrnl51og7coVireoKdIb0VwiW+5sw2Y8piKufaxyCUVA8MmN8JqZM0ykZtSEFpguY2DNlYvJIgvhB7Q7Q00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=TG7RkjQO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="TG7RkjQO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b45edf2303so2983032f8f.2
        for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394035; x=1752998835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJyl6Itr2J8CcBOnf8YZMhnDEgMz2YqGF17cfLG0u0w=;
        b=TG7RkjQOt1q81yyyKBTbe1QUYdoIKhdpCxzaOTjGMogHOwNKL6Egi3VqxzvthquTke
         TeaOLBI24wSWILWT7/7wJkFK0oilg/7rZY+pPtU6m+EcgQqQuFsC5+Q6Z4P0Tyn3Lt3Y
         967nN9RiFvhWO7cPiojPW60sDOF5D9SiuJ4cv/AByYCqxnC0Yvd8RVirluvsG1R9YeUS
         2bmhun+vzkTjSE2xvcQnaUuIOrqEh+ub4UVi+CfZms6IGl209PTWVITiezNPFNkTlci2
         6bXqW+7tlU+Xu5+p+TENSe+syb3cczNXZZHgm7PZa6DRQLax9ODPMF8yXRi0mwtSaqFi
         NZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394035; x=1752998835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJyl6Itr2J8CcBOnf8YZMhnDEgMz2YqGF17cfLG0u0w=;
        b=EuVfgMD5vZmwzyV45jQbtlDmyPnuglOTvd0K/yLOWqOeO0WZQhWkdlnfeXvksUjTft
         ISu7AWGUGbKA9k/+wX/axaprg+7zyG1oFv/0gOxaPa13Cf1AQtOmsY0tL/lMTD6l/arq
         YAAFmbHlHVvemqTaJmRAhR8cxhkxmJ0pJDa+ItmyzmNHwIOs6aAwPupqT7VomZneYYvY
         sXzZqCnIXqMXGOhWxs72W6iKhLb/Kjo+KA3j3ICQbkurNPqjH8ZTNe3AmpPpvYfsH4pp
         xk/GdgS2z5SmBQqTpWbK86cGPv/l0H48FxVDsK9axbjdhh/q5FIHuvWgAGuYEjR4QvJt
         M89g==
X-Forwarded-Encrypted: i=1; AJvYcCVliibNnBClkVJ7wOvJ14hgW38JK5XoMDbCUM0AxKF/p7/Mqz99dQJkr1NZHpOza9eB7Mt5O5AyNlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEcm8taYXnVlPfcU9xAGOdj1rrx3p2kHNjfYiCYVLeBWHDSeV
	jZPbTP2OCBeIJ92rgXe/2DvRWyrTLNDuM56h4b9nOzfhuCdqmW0lMrgzvcLX5LVumfA=
X-Gm-Gg: ASbGncs/z9OS/tunF/Mw+LJnOp5R4bajjZ1hUYXw3LcXAl2s8ab/OTiNThj9KDVw2zM
	CIs8tkPhdajrssjGIBwT8wckD9Kzj5LL+ELgg1SP4kD2aTh+PraAE8Rj6KQbc0419YMbUQcDa9j
	0hpXFY9oLL2N4xcEPs01XSym/7yT/kRaUZL5YZHcc5Tiw9jfHKpsA7jaU/AS9lNXlQBfolV1LxL
	hpFIPBHcDTXi7y3SVaDPf2YLqWpUHKqmRcbOqLQYKoCSpVyOt5PR5K8t8fxHlX7142SmLahH7ON
	+AeiHcYYQvZjxv3T9EQW7ZBzuaLyDKs5KD4AVQfMrqU3Uaq8qgZNf909bOKr/xVKN8PGm08ll7w
	dE9oUVmySx+UHhw5cvDy040AE0U46tR/iHP9n
X-Google-Smtp-Source: AGHT+IFDkaJX0TEdwthvnMnibkv7x2m1KVCrimnEeDmcfRvTFWioaF6EXSVrFnCJ2KS+deMt9VV08Q==
X-Received: by 2002:adf:ae4a:0:b0:3a4:f787:9b58 with SMTP id ffacd0b85a97d-3b5f18abc86mr5290060f8f.58.1752394035324;
        Sun, 13 Jul 2025 01:07:15 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:30 +0200
Subject: [PATCH v2 08/15] dt-bindings: thermal: qcom-tsens: document the
 Milos Temperature Sensor
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-8-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=844;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ZPOAK3xFvDZxKtMubUGBzI+X0LzZj/ehseUCLqV9308=;
 b=g6khw9Eoj3k7qdE6HzUK3LwUa3ARHqiUtNifgmAtPNMijChPBfhsPG+M6zDWw7Jp/LdMvpqx0
 G/ABS6yAzifCr1yjRWLDxYJ5Q3VDCx3clJN4ZacevbE60KKq1Tn9u0D
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Temperature Sensor (TSENS) on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0e653bbe9884953b58c4d8569b8d096db47fd54f..94311ebd7652d42eb6f3ae0dba792872c90b623f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -49,6 +49,7 @@ properties:
       - description: v2 of TSENS
         items:
           - enum:
+              - qcom,milos-tsens
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens

-- 
2.50.1

