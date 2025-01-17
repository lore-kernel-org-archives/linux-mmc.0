Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686B14386D
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123550; cv=none; b=Y8L5LX1uj303SJ56uOd8w+BhC/IYTaYKvCFxFwmNlk6MHaC0viVvEBxa6E+3iXdKEJsBkLJTDihjqT51a7Nj4j/MpmlH/4ZBMtObrVVSARpeWqmdnQHtRT0YCsP3n1CadaS2x2OxLR5No9SPhNBXR6UwfBuUrRlhGOA7efd8oH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123550; c=relaxed/simple;
	bh=rkN16KFyfCGbANv1URyC5pgmPDjOKr7gcHvrAmLZiGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUfOCT48ZNuqg5mBY1IiiKmDJ+EZ4oMHUaLmV1jC1HI9qFeKL4diCHtc101A98kq/EH2OicKZo90+1oEGh4O141OOQF+0bdwcpO1tM7E3TWxihtjmsdGDJH6cuFM34DqzgxJU7waRM/RjZoeJ9laHl+MA3z99zcmihhnLPTZPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFLZapW2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFLZapW2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43635796b48so13816815e9.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2025 06:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737123546; x=1737728346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iw3hbPMx3DDHttAVH5KXQAb7aC6TLapsYr3FJPMUjSk=;
        b=RFLZapW2iKxxI8T3dcu5OKvgO6KtaG5AFr2Y+YZdn+ocSk+15Efbz7fjDPCQauc/Of
         5MqGBrnQdmdpO/oyYETWL4wb3lcTg1qkbriLA/qjqAM+xF3w476xErqlA/GMrEEk9pcc
         pRuLppqbLvw3kDNiVQ/+Fx+dxMu/uq5tuMlMWCj3ek68UzP1bRzR0wzWG7XNRp0xqocd
         WmCfCOxjtcKqpB+2UpVUPBuCzejZbjsUjK556UQ8BrBLiRTRCpuj0VVk2b/Jc5CeiH8z
         2U9+PqEa5p7kpPDyHiWSMLJzlA+vKfKkHqmgcxtCbUQs8J80AEQyijVB6GKLnrS9+hWj
         dD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737123546; x=1737728346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw3hbPMx3DDHttAVH5KXQAb7aC6TLapsYr3FJPMUjSk=;
        b=CKKq47Z/vRBPNf+JDdAXqUWMNXwVtIIdyantdL8K6UN09g7UCVS6nR0IlZsxsZUeYn
         HAF21GZThiwBv7V5QD65tFagniuw2PCGMC4Lm12tVhK2a5aYQILD/1yk6NoUlh3/5Vqj
         l6OTx84tt+cnAEiGRuJNSrWFDlEWyWKkXPr0xbtE3fbx/RsFzn5Jla1n3CbUlpDzGyZL
         6gQoTkPM1NXEUig9xgUcrms7c1C09JKctco1Q1EksbiB7G4xU5LXIdCvZuUo0B+qqypx
         c46O/knFfc3SAEU/ajhr0Y2u9zHxSoD6spDzcnXJrsalp2Pbej8rO6nKRNsxPd7hFEWy
         y+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkVYz2Z60+bBwD8TDfhHIWOoL+nCZLIPe0rap/3xlZ48s8RFrNgovOWLZDREF6uwlDpSGJeDCSQhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mkDSvPRJT3Qb1FlGcAiIw+dOR8FsJSTQMN0qTQ2UPMsjUFl0
	4nLJ3Xa/AHLuSsFNTJ2wy3TOBW+pCI0HiXN7vJFNjgY+j4PzZ3N3cFstaLWCOr0=
X-Gm-Gg: ASbGncu4pCZZkfm9SOjFPLwqPg6/ss5MpyYVtIFAkGvuw60t/YHqjBMmGxqRhp3I/gL
	jUtBbLnCLq05HkJZd/siRIFAMbPAhVlC8iwbMl1sNkP2f8lFU9SCsZ+qQAL5MCu8QFGt/LFP/oK
	pXewdEdpLUZYixi36elmS+Dr6wx4seZFb8fDBfbX2hMThFGfKRJaTxQDqXBx7Cn6ZdM6ux8q23l
	CoLxsceJCzl5iNMGelMhStZReQ8U3h+2mUL7j3iG7METOVv9/0GwoxTIV3jSyiGintPvnLOiL6e
	+9nzw9BH7geFrsCVzlLlbGBBOkDs5L3awDUH
X-Google-Smtp-Source: AGHT+IETblMrx8KIRmwK9VCr83hmCG0f17UdDxWZUvSUIiOhoWXqGDdx+je3BMGMgRQiM12epULhgw==
X-Received: by 2002:a05:600c:698c:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-438918d3bdcmr26937075e9.7.1737123545938;
        Fri, 17 Jan 2025 06:19:05 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74995f6sm96764195e9.1.2025.01.17.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:19:05 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 17 Jan 2025 14:18:53 +0000
Subject: [PATCH v2 4/4] soc: qcom: ice: make of_qcom_ice_get() static
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-qcom-ice-fix-dev-leak-v2-4-1ffa5b6884cb@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737123541; l=1621;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=rkN16KFyfCGbANv1URyC5pgmPDjOKr7gcHvrAmLZiGk=;
 b=GkVvea3pMVMpJEOFkCogbzhGJLadWWc2COyDHp4IFtQvqwN8HlMWhUl0amrJXjGiMy0W2cgM3
 AqCC1xa+8FLC3UvoQfVuAwJIX32Ugg/vLxSxUTTBxQ4yk/FSRFpuR10
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

There's no consumer calling it left, make the method static.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/ice.c | 3 +--
 include/soc/qcom/ice.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 79e04bff3e33..2310afa77b76 100644
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

