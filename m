Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5D11CAB;
	Sun, 11 Aug 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723411401; cv=none; b=TXyizmmqVOJWoZMdHe7SY4fWlAoXour52VHlj9ngeijKljFgTt0h3qjutm1n1g2TKjwV5TJSnRa/ErNuR/yvhAzroHOE3XtzQphqfC3cV2BbyV6UFWWr97mfbyBOPIJXlz5vTRD/rdPaGZWZKRuZJ5T4tkGJWPW2//+Lt9VQrDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723411401; c=relaxed/simple;
	bh=6/tog7AijmFSbbOb9Kja2sdd1448VG0rlEkqmCpSCDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsWTckkYJsMxTCa4X3Y1kIGQEQasRKfQiLfQ9SRU0AcXMhvANuREfxV7taXHg+LA+D3cZnamJKWjPwNz/ELpeTKgkI4suwpO6bPjflnuDjF48hbLErKZ8jOBAAzTWbHf7vepY6tKIN3pIo1T1Pu1Ape8RglyjIHaDtJFFcG2+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjZAefh0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjZAefh0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso27444145e9.0;
        Sun, 11 Aug 2024 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723411398; x=1724016198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dmUwrUSfBQFzrajL1iOaEwCXFsL0O8je4zmGdZPIH2c=;
        b=PjZAefh0bUroSgu5lqRiKADtaSQugX7bIgA58snsSkA/RU7MLKQQCmt4UrYhL08NNr
         Q3JBjsj9uAUeVZFVMquTaeYONMzBYXMM0UDTkSU35s//k9DJdJ1fuo6v2v5qJRV556FG
         Sm2VaER9nCNzBAltGyAIp4bKYBXsEEGoTBLMlB2FHaXYX2mfby4xD0tiCCToVqeJcWgg
         EIjBGG1z1CV2U1TcDuAEL8mJ8ne+pvymq2693OwPSu6dOkJ458pqOZTVqkwHPBvumiDF
         8tZvSRYodGjm4z0gRRg9PMR+P84FU/R3PWJUKMBsD0mS7F07Z9xpy7O06QXDnV6eHArk
         uKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723411398; x=1724016198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmUwrUSfBQFzrajL1iOaEwCXFsL0O8je4zmGdZPIH2c=;
        b=RZUxVtApK2SS3shTI3vSmHbBMzCYEZNnUV45jV04q5+K9sF5sDxWDF8osG8WWuV/YB
         8gRy99rkO7nv4bM1lD15J98KU5HHxSgQWq6RU3BeYVp5S7NAAemAksZoJT/TM3f8P90e
         bs2M7YLVfMJLk89SjISodpfS0UZUdO5Gs2m8hqGSHlvQ/ZChPLT7mgeRqkA1idcLNJL+
         0cpGQWB2UBvBEqXsU9seqV/D0DclgxFWKCurqP+Vehci/FL66KeCtmQIhkYI9yBDewK6
         8Txzu0X0F6FiCONo8RbMWMX3jurQFwx1bJ769y4o0WQUVLdG5ZU+z4uC0M3sze60kkhs
         Q5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa9l9zL3abQW0s+ouIRg6ER5BHpq5gR14tOm7rs0pgwLQoRT3A0A5ppmpDclXgsz8Dowc2zlKEw9jk3ZzswQKDWHjphYVwFXfJ2u7rF+L9PO8wMY63GHAz/NVtbcbN7EEJAUdfm+At
X-Gm-Message-State: AOJu0YxW8LsljZyeZFmIG1GMgMh+uGpBUO04yXOf1jcxS1oJiLCxayk2
	ZTFmYrF9AfDC1ATO3aNGKqOUNXVAazrAubkEAKUFw0+1JJk/R0cY
X-Google-Smtp-Source: AGHT+IGW0Kze6LJc/d+J5WO+J39Y2BxDIECNkFysAwtV+9+tJFsfxjXFDm9zsFDDcvbd/gcxwbZqHA==
X-Received: by 2002:a05:600c:4591:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-429c3a28c24mr52406255e9.22.1723411397653;
        Sun, 11 Aug 2024 14:23:17 -0700 (PDT)
Received: from Lappy.lan ([193.223.71.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74aa5dsm163846605e9.26.2024.08.11.14.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 14:23:17 -0700 (PDT)
Sender: Ben Whitten <benwhitten@gmail.com>
From: Ben Whitten <ben.whitten@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Will Newton <will.newton@imgtec.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Abhilash Kesavan <a.kesavan@samsung.com>,
	Chris Ball <cjb@laptop.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	Ben Whitten <ben.whitten@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: allow biu and ciu clocks to defer
Date: Sun, 11 Aug 2024 22:22:11 +0100
Message-ID: <20240811212212.123255-1-ben.whitten@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a race condition if the clock provider comes up after mmc is probed,
this causes mmc to fail without retrying.
When given the DEFER error from the clk source, pass it on up the chain.

Fixes: f90a0612f0e1 ("mmc: dw_mmc: lookup for optional biu and ciu clocks")

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2333ef4893ee..e9f6e4e62290 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3299,6 +3299,10 @@ int dw_mci_probe(struct dw_mci *host)
 	host->biu_clk = devm_clk_get(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
 		dev_dbg(host->dev, "biu clock not available\n");
+		ret = PTR_ERR(host->biu_clk);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
 	} else {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret) {
@@ -3310,6 +3314,10 @@ int dw_mci_probe(struct dw_mci *host)
 	host->ciu_clk = devm_clk_get(host->dev, "ciu");
 	if (IS_ERR(host->ciu_clk)) {
 		dev_dbg(host->dev, "ciu clock not available\n");
+		ret = PTR_ERR(host->ciu_clk);
+		if (ret == -EPROBE_DEFER)
+			goto err_clk_biu;
+
 		host->bus_hz = host->pdata->bus_hz;
 	} else {
 		ret = clk_prepare_enable(host->ciu_clk);

base-commit: 5189dafa4cf950e675f02ee04b577dfbbad0d9b1
-- 
2.43.0

