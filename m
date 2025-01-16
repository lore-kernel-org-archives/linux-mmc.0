Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833122C9E0
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038973; cv=none; b=cuthqqRJc/9Ot3o7oPpmMCfBbFOg4Mi5NW21BKBsCUwfw8ZzW03dVfMF/H5GkZiKR5iTxII6FGYROREVEdWrZAAxxoBrPx5n8XE795JLUEDqM6COyJICd1pv31tJpE95/FovEAs91oSZARPdOWdJHQTn8wBlcXkjFOaW18bXt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038973; c=relaxed/simple;
	bh=SLPk0X7feJzjbp6iNB5msnLoDstFDxW+7yuOzADYOIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpvY443RxiiBQSCJZowggW1W1C3QLw2F+/oj6hprqbNMy8zwuJxfQDbxl8fNRpL4aDhGJIXoNrukaQytrg2ZeCN/4S6zw2NE5QHNJEveyiaT6pcf6x5p5LLs5iY/kpVZ7ODTq/S5MUKnvP0HBSNIxd1aquwdy5eGxjO4XQmcbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+paxNDI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+paxNDI"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3863c36a731so885214f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 06:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737038969; x=1737643769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7cRMSVWB1iA1Z/E9hbzESrNuj3mM1/u3MbHi16H2W4=;
        b=k+paxNDIjOxDJgPjAQG1KtidazknNY471iVzSHZQNe6EgPboggEra9/7VcAlUw7/o8
         fY5tDLXNNxoIfYERctcld0qybKoLCBy5gfdMaWR2LpefZTo6J+Z9ytcHocx+O3VDxInC
         3mqZxcLEemohTrWZBpxHrbvB8ONTmm4gUXB5vvzEr7WQXl6ESFPiuc/U2XhUZRLI/9bS
         IPm3I83AR8ub4NYD2Z8WBUJN+aoZToBv0cvpiiNvGzhH3d6zPrEGQGFtaZt30uHSYO/9
         q706kNsf99ulZQCS0aOYibKgTuvitR7LNS8OblVZLa3PkQLGDhGcu78k/OzPWbIrgbeH
         u6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038969; x=1737643769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7cRMSVWB1iA1Z/E9hbzESrNuj3mM1/u3MbHi16H2W4=;
        b=DBfEL387OrysqwyU/Th0iST2T/U+GvZ1xhCbYyvmUsE+59MmXFlEzqCrVSf5DSD4fB
         uJ+ot28dF207ySh+ewQWKjD1suEm+d4BWsAYq+06gnKehNv3y14n1JbhrrmWTzteclCk
         sUhugYaS5LvuIA3OE6a06GLzF5TvBqaCiDSvb0+ND1ip4CXFCt6niD/LqzFq4VTxxkWh
         U5X2rBvcHyYtcjRAWI8EdqcL47XaTT1slKeVNF16nMv586z+LTpJXdQDKF/PTp2jrXif
         zZbSaITohko47N4oInaF8c+73iuTDCYGk16TzC8p8AJDvx7G3Gpj8g7Md5bx9FfZBl8g
         AXQg==
X-Forwarded-Encrypted: i=1; AJvYcCUFFDi5AvMAWogFVh1WiIoe956516C3kuLrw06QhzFImeBzK0DEPW2W6zZbKffEQfpjMwRQbbDdRoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6J6pKOXIfHyar315+b/b/yA9rVsTCWOCN5g3ZQy2Ul/04Ri5g
	LV943iTj70gNUuS9qVIrB3q0sEQrKk7Ottdn7HyOReCf/9V6U8CVwUoGGadUNUE=
X-Gm-Gg: ASbGnctmam4ykyMhmNaa1/zweoML4yAre0WaZQVsP8AtzPSfwXYGKuMaBkSRIy0KFoL
	bgh+TXMPEOJgAS73Y0yaa7+iKfLGIZ3bRXY32RPvroVqM+EwHsLiCzE6t7Ag+Aj/8EU1csP3ZxC
	lHabR6OGahb+O23UtZ6nnyr8DUrmrYBjwbJf7prn4InNwySCpaDMvevFbUV5MEDw9gE+TyDdIsd
	j8dNwjOdSA8mz7x2+CoyLKugC2AlVkck+vZ5AivT0pFci7LxlV6DGoZDQ/i6Y1PVewWWFJ/7w2B
	O7uB6WoDp3dn3UrNZIJ7tk5uzPggiITEXqMT
X-Google-Smtp-Source: AGHT+IGuLmvbYhQXQ99Ngdjm7P7XXhs6Xz5bChZGEdZB5e+12utWg4WoIKuw3R2n6RN9NlrJ92GEfA==
X-Received: by 2002:adf:a3c7:0:b0:38a:88d0:18d6 with SMTP id ffacd0b85a97d-38a88d018dcmr19384870f8f.42.1737038969571;
        Thu, 16 Jan 2025 06:49:29 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm70310f8f.10.2025.01.16.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:49:29 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 16 Jan 2025 14:49:08 +0000
Subject: [PATCH 4/4] soc: qcom: ice: make of_qcom_ice_get() static
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-qcom-ice-fix-dev-leak-v1-4-84d937683790@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737038965; l=1554;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=SLPk0X7feJzjbp6iNB5msnLoDstFDxW+7yuOzADYOIY=;
 b=G8iEARZbH9wv6CQbJi1hOS5u+HYxxskB3G6McP5l6dHKR3FG9vTnp5n4BD0jqXTdLl4BSdAzC
 4JF38mDEPEmDQ7SXoKyDlewZGuD6XTgwZIpVqagkG1RWcJfa0FQRTzo
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

There's no consumer calling it left, make the method static.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/qcom/ice.c | 3 +--
 include/soc/qcom/ice.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 9cdf0acba6d1..1a2f77cc7175 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -262,7 +262,7 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
  * Return: ICE pointer on success, NULL if there is no ICE data provided by the
  * consumer or ERR_PTR() on error.
  */
-struct qcom_ice *of_qcom_ice_get(struct device *dev)
+static struct qcom_ice *of_qcom_ice_get(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct qcom_ice *ice;
@@ -323,7 +323,6 @@ struct qcom_ice *of_qcom_ice_get(struct device *dev)
 
 	return ice;
 }
-EXPORT_SYMBOL_GPL(of_qcom_ice_get);
 
 static void qcom_ice_put(const struct qcom_ice *ice)
 {
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index d5f6a228df65..fdf1b5c21eb9 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -33,7 +33,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 			 const u8 crypto_key[], u8 data_unit_size,
 			 int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
-struct qcom_ice *of_qcom_ice_get(struct device *dev);
 struct qcom_ice *devm_of_qcom_ice_get(struct device *dev);
 
 #endif /* __QCOM_ICE_H__ */

-- 
2.48.0.rc2.279.g1de40edade-goog

