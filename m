Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53513C67C
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123549; cv=none; b=kMx9ep82iAA0/NLw42JO51nib4OaXH6EsUB/uU2nhEvCTsR7VQZpkAr0frlaikD9M+XzVkmQd68dXkx1E0r50KfqnPxzkffEM6rruRcn9ZS1l2V+LVyCUOc6+pqp++kXIM1eXn8IIbMrZu13xwDwWEH/kWFi5va0M9a4LoJd3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123549; c=relaxed/simple;
	bh=GZ2r5p0dFfNcF1ZvOqiFJYmYWFEQPwiZzMJJY9diiqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X07Ci7xfHQR1O7SyHJgYABW5qcRzQeXxGX88g+GKLYXiwvgdwOFU0ig9gMTxclqFaKbSyRlND0mmdLhVSEYW4DB4EAXJhOa4XJL+OfpLxxGdNtpddFLVpI12vzCyWgzDqzTcsTITezq99PvS1QPX77SfCuU0076xDjPs6vpVI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RUMtBizF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUMtBizF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4362f61757fso20809835e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 06:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737123544; x=1737728344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrQMwi+hF2C0bCOO/tTN4XbolEHkOKYGtBgFZ4HZCnE=;
        b=RUMtBizFVYX0qVr4FBO/0JwxgbuH49a0YsV1JJd5j9CQ29Lf7Rmmk7qaTi+lF+elXQ
         h2+FrVeeNJIffu4ZwhyO5Hox1KLKtaQRmlU0H74LwrMt3H9KBoOod4P5kuLXi3PxhKVB
         Rs/flOJ8kfJnuTXkXvdXBxFc60uztwrA6eXEVSWoqJdh5c9Dma62nhHpXJ1tjA15lqj4
         UXYtfWtTwgoNmNXj24As2pjtYccfOBw5nUooFpbTHpMxcBKWygyR66Ld8+au+LyH4grm
         lG1mm8Di+Ua108XhybY+rBWap5F3oHy5szKaUoix5k4ELR+SMTPNkh3yN8k7tL9LU+df
         wdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737123544; x=1737728344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrQMwi+hF2C0bCOO/tTN4XbolEHkOKYGtBgFZ4HZCnE=;
        b=ePe3zZvuvmlBEx51yCF9ww0E2BH6B5rFd3jIYeTnn8aeAogUh4dH2K8pzmx9wkk97T
         joQsU3ifrocdD1WmPLY65/36G1670x/4242ZViWZQSFUVQnwfMheoZSdUod8jM658vsQ
         AMigUJFcnoCSw4yJhG1u4Ti1iqMgU4d7XlA95aavzgr7OwYb7fSuF1LwT1kLLZrJl7mU
         EWIbamVdg1ek8V5uREN4ubW64+FP2096ToCq/U991b9274af1LnRJ2Kdzd9y6IXBTZaD
         hrf984ocG9aUKH15TPAsEQAeEetn8vBo9FU65eTfPPTgpq2/sAL+hR6gDBaDx8CoAnzx
         uWjg==
X-Forwarded-Encrypted: i=1; AJvYcCWVrT/ngrskSRZtJTmA8RrZL7UfiUitlwPpOf+/nzSFYjEgM1D9reN9Yt/Rq5s8cda09zmObKmyels=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmyiqZklCv87kP4YpSLbTVjEmxduE9Vtmtf9Ps4BuDSSgqCHLS
	eIj2Y9Q+m+PS2k7ygFFc0A0eh4U8kznX5fI/jsiJvk892TWAzSTWFAbETYAi+Po=
X-Gm-Gg: ASbGncsKTg+b4mdyH5zXn8wWAAAgfMYQBTZzN/r28pU6FwFByT6340bsVPSS7ehMDAL
	0ATKkL6BxQmntWEvpGe7PtPCnQ/qZJolhI8bvhh0C2AYC1ZefwHQgxqyNgf1kpuvq+OPU3gRWLq
	RUz6sm0rjox+k9N2spPhAM+XNv9E9LVKNA8ZdHbtYJOBOlKUpe+awdETRk6XnlPXqAem3HSQsS3
	b/v54kWqiY0juaZbmlLk34ua8HuZM77GplSksuwYChdaqk+ZdsPsQGJ/7FGtNmxKgGHfQBjjzIZ
	yZkFdSdDl8eoxtRMC1Cm3ZuMgA4XKWTFxNep
X-Google-Smtp-Source: AGHT+IEfaWlQCEKKaatnAdlw13qgkLJVr8s+K3HBqqjRbB4QuuaaO9z/foSCuP32eVd4AGEznbyiWw==
X-Received: by 2002:a05:600c:ccc:b0:436:1bbe:f686 with SMTP id 5b1f17b1804b1-4389141c073mr23873315e9.21.1737123544308;
        Fri, 17 Jan 2025 06:19:04 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74995f6sm96764195e9.1.2025.01.17.06.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:19:03 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 17 Jan 2025 14:18:51 +0000
Subject: [PATCH v2 2/4] mmc: sdhci-msm: fix dev reference leaked through
 of_qcom_ice_get
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-qcom-ice-fix-dev-leak-v2-2-1ffa5b6884cb@linaro.org>
References: <20250117-qcom-ice-fix-dev-leak-v2-0-1ffa5b6884cb@linaro.org>
In-Reply-To: <20250117-qcom-ice-fix-dev-leak-v2-0-1ffa5b6884cb@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737123541; l=1054;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=GZ2r5p0dFfNcF1ZvOqiFJYmYWFEQPwiZzMJJY9diiqM=;
 b=45d3iiXT7ApSj86eCeo8o+vCQk8H9LTCNmewvtv437mzQ3nPnN5PwM2jJJAI++4mdsjm8dOa+
 C8c22bdPYz+B52Him4FeCPJNwliX9YaycwJvlhaqizsV5BZY8YMv59M
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The driver leaks the device reference taken with
of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().

Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4610f067faca..559ea5af27f2 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1824,7 +1824,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
 		return 0;
 
-	ice = of_qcom_ice_get(dev);
+	ice = devm_of_qcom_ice_get(dev);
 	if (ice == ERR_PTR(-EOPNOTSUPP)) {
 		dev_warn(dev, "Disabling inline encryption support\n");
 		ice = NULL;

-- 
2.48.0.rc2.279.g1de40edade-goog

