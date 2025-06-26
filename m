Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30161DE2DC;
	Thu, 26 Jun 2025 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937102; cv=none; b=QqH/jaIyu/hbDai4Egg241/wmtATfLMec8BGX/+Ma0+Zxiwsf1/PtHnF0xSRzRkyLNppnAKPEDLAwjIgln9JrpvFTtdB9O5rHPYi/VVyHZXYVIWwsE+gZUwA4DG5aUbIqn+64h/LeX7LCLj5e9oS9eo5g9tEX6X8H0jnT3aMIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937102; c=relaxed/simple;
	bh=03PKuUYJrD5nD1QhUdEl4KtAYJCxxfiX2hC+aEDW42A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oLMwlFyZVJEBx7OYGIMNpC1ywAtrfIoFtkTBa8GIPF15oOcsRZKs6wenpGPwtOrg/HRdGf4aQSJMw9p8h6baXG6Rot2nGbWSng+jHPIzv4EOUkxQqhvK6/rk5RNDPVdYFdCy+uDWjmpeCcew94Z6I4OLPyH/wHUQII5VF3mOksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx4RUyDI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx4RUyDI"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso720867a12.2;
        Thu, 26 Jun 2025 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750937100; x=1751541900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFQX6uUBpxDtt/1/azFfPLLQ4QGA0qnKL2eurBf3pvU=;
        b=Rx4RUyDIBFF3oqUbxmRFwUoXR/5Y0WPHOPtT/VYlw5lE10h+WudihjUn/RJ7tQEwS2
         FcOiDc3hy5JAGRTiCZ+c19M53UYH/UpzbbF76LjCfkQaKt0IO0Lm8IQ2Ibtqdy2Nf2IL
         FnjiwhYcRAQ0Jc2ryHGKEv854zl+I0kinXGt1paPaktPjgSKCGY00lUvGm4sjD/JxDLq
         vLHKUZH758vfdLxMlyw91qSR59jRh4+eSkv3Kw8bNIQAIqpdTKlqLR035+1Qz4qpK5sn
         +jodRzt8a8mLLbC40XndcJf4eESuXkdCDI2tacsMqbcoSwAZQi6M2aqM5Z3d+Xh4BciY
         /ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750937100; x=1751541900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFQX6uUBpxDtt/1/azFfPLLQ4QGA0qnKL2eurBf3pvU=;
        b=MDab4xG7L/1qfBoNuZ/rp1RAmADTbMJ2SbRiS8Ftc3DKdr3mAC3sQKyRgDeQR6Ko92
         yaV8df/reAalPmQfUtGvC4tPRuvXByONbsdsGS6TIsbZMQ3Dgc5QxyqmGkrR0WSdCWjT
         CNC4eNpg6t7RFgaSbtFs8Ev0SvLxOcfojmuCreT/N6MgKN/pVq62sAjJPKDoO19bI/so
         e78f5Tz/rCJtCaiGhYxXJGGANd5Z+QbP81mB3saRPAXbZgRT7gXto+7FCflgDdUdV5KO
         /jdp6qz9EuWvuGf20cSsylgex3eWv4SQcVrDW3nqOB0OxfmrNctkb+ncPtcrJvci2wAa
         gdCA==
X-Forwarded-Encrypted: i=1; AJvYcCWAwHroRqxm1ByMJUaNAvpgJeF3KSv9FnOl8hHtFlabLfToQ3pFJl3ACVqb6cfmxca4iW/3+XLAZa9T@vger.kernel.org, AJvYcCXQTV1/LPMECMAgCbTGL3Dyt1oF3PlnzvP/igaAKrBo2tI001ebmKrz8WsDKRFepzOoOSr5ElSOLsbMHlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoScdZ2ymjgXgJQ069tIY0TyDsHQ7fOj1+HYBFd85MqjoKBXX
	qmDkoEWR4zqGOMH7L0ljHO7QXf3cKFikSIij8S3SeGOcleTzg0T04YgP
X-Gm-Gg: ASbGncvDP2FStu1VdphIEZcZRcXuDtc1wddleOXwngc+YBoLr7Q/8LGFL0T0afr/MWf
	DkMODCDqKh6kD0Pi8JnIbR+aQMZb3LNWSjMKlJeq5PZ5K9AydgHPRY+dcoXu0FXs/1sXUyuYD+I
	6q6oQzHd62Bli6JIE1/PBqN+JUNVmmZlGEMbKdRf1JShWiFNNk0mlIa7F3ia4/9Jo6QZXFZWtP+
	6LsFCoGNAAted8TJD6LFEmQRFGWpUgIXH0CiBJpdXBcFGH4GAUN/RWONno/xSGGysBvEEry8kPR
	KWlDH7itAcIFw2o2a+20ds73NPM/vTchMZeid8+JCgIQYdQSE+zAkujfDubevbJAFKmqdEZdCAM
	qogDDtg==
X-Google-Smtp-Source: AGHT+IF6awlLuxZUGb2m0NQDcbLt5zcurz78BLypov2q2wtij+W6y4vevOdr5iSqelRvzpW4kO0jIw==
X-Received: by 2002:a17:90b:37c5:b0:315:f140:91a8 with SMTP id 98e67ed59e1d1-315f2687f07mr11483087a91.16.1750937100008;
        Thu, 26 Jun 2025 04:25:00 -0700 (PDT)
Received: from localhost.localdomain ([187.17.229.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53c2951sm3915122a91.26.2025.06.26.04.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 04:24:59 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edson.drosdeck@gmail.com
Subject: [PATCH] mmc: sdhci: Quirk for broken command queuing on Intel GLK-based Positivo models
Date: Thu, 26 Jun 2025 08:24:42 -0300
Message-Id: <20250626112442.9791-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable command queuing on Intel GLK-based Positivo models.

Without this quirk, CQE (Command Queuing Engine) causes instability
or I/O errors during operation. Disabling it ensures stable
operation on affected devices.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 13a84b9309e0..e3877a1c72a9 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -913,7 +913,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
 {
 	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
 	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
-		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
+		dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
+		dmi_match(DMI_SYS_VENDOR, "Positivo Tecnologia SA"));
 }
 
 static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
-- 
2.39.5

