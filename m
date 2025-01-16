Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869922B8A2
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038971; cv=none; b=DqGM6P/1QE2OCj793Vjkcc+fnCKdkHkstcM9Gj1i0wBCz5xo/onMvaiuNSISQoL8tSG1LTFpmsuiJafz7uF1tOSDtuT1uG7hXh9rQje1DMzQWDomf3oxsCodYyPYwKd9kmTH1h7+PikNWyZjUQuQjYhBFlw+/6ZW9A6b4jl7uDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038971; c=relaxed/simple;
	bh=yQnJYX0uPLjPaWJCg5DBrwaaox/zrNkiPK9/oReRrBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bAiSC1KSsIFPRx5ZX3os88HAxn5cV5SUikizbP5LOmGgeevzamwhkaHBoy7yV1td/2aJwa2SUc3IySfBmKT8rvm6pgqMwYX8iRoqBsxnpnsPs/2c8ES13LYMyKITlzU1JJPXauHu7EMqSdSw8CQnsUB6tyhiCvkxfMtHz5rgrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l2e090i0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2e090i0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43623f0c574so6603655e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737038967; x=1737643767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQqtN2LlHzbsYqCaGCM4YS8VgGj6g0tDMtNz77m0JDs=;
        b=l2e090i0Q8lcEfoEJsWtJ99BHhcbAEsb55xutF1JLErna75gulQL3KLZKfyrms7Mxw
         fR/DY1GEeSTmhcyJnlEqIWAvRyUhDLs2cKkqSUDI3hemWKNT+oYSuIbHO4YFihycpBZ3
         ulB/Dmw9iA4XV65snB9l8q3jAXkcrHgwCRFB7LhKNJGkXMuym7Sj+i8NwRYl1qGDnhz6
         NZA9sCEkf1DS8Y1Mzug0Ij410SYnAx90Yql8W0UlZnfN4BaxMgAl6DkJNXpjFZDn0n/7
         GU6NBLnKxBTMLctNwHWMamjSH+GjjYjiMrV3ECy//vU34uqgIFlgI+W1BaHOKQweXeiB
         mRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038967; x=1737643767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQqtN2LlHzbsYqCaGCM4YS8VgGj6g0tDMtNz77m0JDs=;
        b=g5XIl7i7X1P6u26px75mPvFQggE6prAbfvPsnI2KqOGSin/KT94UNqEeiPkKhInUWx
         HiH/dUTZjr2qURGus4IdKzdy/gPOKVOTQRHbMDYsKdkB9T0+GedWD8hmhsfm/WfUcTes
         dUpGUQZQLW+53kk5FAiI2wRS9UBbKxZojZsJ/fgIIceisDv2UbPHOK2CvSPYNZaEHb90
         sb22Tp2GZomGrJStGAFRBCV3c1ShIU7Ycnqq0RfQMokr9axHYCYhqPXZi34KMmPzRNPG
         9UCNC89A8Rag9jUaUHqpSMFkB500bcx5gwEhvMDDCNhRlZK8PN+4lt2eP+38Z0oAFdWE
         lISw==
X-Forwarded-Encrypted: i=1; AJvYcCUEJFToYRagSmOiF0TjQONOZd7xN9Pn3jL6aJleThSTrjfc/x7awkCDmIx71quJ2ark6ctIg1K57do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbiKjHfTQ4aL9xWaafq035F344vOcNRfomQSvMuKlhOWZtw3e
	vde1VTw6f5cOBF+RRYI0ja5lMgbZ7YCph3iZONR1TKkRB3dcgcx5IhKhJYSPWj8=
X-Gm-Gg: ASbGncupBan03IHLP4EDo8SlbUQaefbiC+JxsDYt2U4z+zF7RUhVpSk7R1u3SAZN+hh
	BKuA7LJfhlcAG2sNN5+uZi5pnf6MP1bYYn9hlcSRvwJrWxKQ2LUPXv3O0FodIzcBjthiKXJoikz
	e0JwNQFZMyIPyhIUButL+9I5vNGTtSjkyFc9ri11DqDLtan3Pmd0QNKcXVaQnNVnWlbR1BbN7JL
	S9AAcoC1SHT2uiC4R6NFDfpvK5zDPM+eGPDOL5DqbVLAIc4Pcb638r3KNvkY58OHC5eA/V52vg8
	qeqcU3V4lZtGjoqsvlBGhj12agOx/gYbLosZ
X-Google-Smtp-Source: AGHT+IHRJ4zrdb1ZRXErSV709NTqBsRUMyS0Kfg5tPapw4Kqm0cLHb/MJRkLo19NNccX4K+54bKn3Q==
X-Received: by 2002:a05:600c:3c82:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-436e2696082mr301334975e9.9.1737038967196;
        Thu, 16 Jan 2025 06:49:27 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm70310f8f.10.2025.01.16.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:49:26 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 16 Jan 2025 14:49:05 +0000
Subject: [PATCH 1/4] soc: qcom: ice: introduce devm_of_qcom_ice_get
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-qcom-ice-fix-dev-leak-v1-1-84d937683790@linaro.org>
References: <20250116-qcom-ice-fix-dev-leak-v1-0-84d937683790@linaro.org>
In-Reply-To: <20250116-qcom-ice-fix-dev-leak-v1-0-84d937683790@linaro.org>
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
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737038965; l=2250;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=yQnJYX0uPLjPaWJCg5DBrwaaox/zrNkiPK9/oReRrBQ=;
 b=dvOHW0gq57zT7su0+EvrZUYQUdDDd52T/OiLXmz9qbseW7TNEx8fJuXgbrcX10BK9uz7fBYdf
 xSVXGVPO2zLA8oEk6fKZbw1aWt2g8ht6yA1GYf/x52/vAjCy7Zwwvs+
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Callers of of_qcom_ice_get() leak the device reference taken by
of_find_device_by_node(). Introduce devm variant for of_qcom_ice_get()
to spare consumers of an extra call to put the dev reference.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/qcom/ice.c | 34 ++++++++++++++++++++++++++++++++++
 include/soc/qcom/ice.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 393d2d1d275f..9cdf0acba6d1 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -11,6 +11,7 @@
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -324,6 +325,39 @@ struct qcom_ice *of_qcom_ice_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_qcom_ice_get);
 
+static void qcom_ice_put(const struct qcom_ice *ice)
+{
+	struct platform_device *pdev = to_platform_device(ice->dev);
+
+	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
+		platform_device_put(pdev);
+}
+
+static void devm_of_qcom_ice_put(struct device *dev, void *res)
+{
+	qcom_ice_put(*(struct qcom_ice **)res);
+}
+
+struct qcom_ice *devm_of_qcom_ice_get(struct device *dev)
+{
+	struct qcom_ice *ice, **dr;
+
+	dr = devres_alloc(devm_of_qcom_ice_put, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	ice = of_qcom_ice_get(dev);
+	if (!IS_ERR_OR_NULL(ice)) {
+		*dr = ice;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return ice;
+}
+EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
+
 static int qcom_ice_probe(struct platform_device *pdev)
 {
 	struct qcom_ice *engine;
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 5870a94599a2..d5f6a228df65 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -34,4 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 			 int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
+struct qcom_ice *devm_of_qcom_ice_get(struct device *dev);
+
 #endif /* __QCOM_ICE_H__ */

-- 
2.48.0.rc2.279.g1de40edade-goog

