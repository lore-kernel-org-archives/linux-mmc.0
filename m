Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46CA22B8B4
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038972; cv=none; b=hfsmkS4Sl6ShKEL0LcP3THioCBYKTT3hpDJwjZ5zNpLbAkO6EFAHVoMPT4EcBiCUTY9xf13i5QVtQbciEBY4YCVAdTgwE55DuUH0zB55+tqSA8BDPXCUnhhBQIfScgQMv2qS9eP2nZSkTPaYVRX5gfp9ZLBzXg3PehgdroFP94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038972; c=relaxed/simple;
	bh=Wje1BciONDqQrKQyhp/R22j+9s7pjT1C1mQYS4XxTmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8RNtS0yrmrKY2W2iot3MJsBst1QBGmAIdBSLGxaty0PXFw2lUqCGKQAFtx6fH/WIQ1iNoLJw+ok03rCrxRg7btb5Tr7ZyHPG9JbC8m8uD2sMGXpEHg2Tsw82jox3eUYZ1A1lVQkiVj6G/Zk1U+qBhUJx99E8pnE7Lrk2kp6Nss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cj4BxhIO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cj4BxhIO"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d161947so572481f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737038968; x=1737643768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbb6Ezfzp9O8O/V6bl6D5LDxeK+r+UlRD6ckNgY/1gU=;
        b=cj4BxhIOazRcHCNPKjsyeoxRxz3FuQ4Ok7sBqmWmD1tVSWnG27HKkfrR/NoN8ftx2I
         VEsUNWMd6b8voWUmiayk67a6BwE6ZAuE7BLfM+cLRX5WUTiB2o5I6CKQIv1MhopaLRoC
         MbFd3V/x5dGnX6EqIcbFKwDV9pKahE+HZAyFHgsWmGDJO/esypA1uxFBJcqvJyKK0fyS
         o510CMK33n9WCSv6mOZBx7P5/vALGzjjUF1l1nHVARra/93O7A3uAQYoUxDNpiHmI+jP
         y4uE6Jb54xEwxChGoUvFhn4IbFLt1eWx5J5my2duEQmmgdzOuX6I1nV9VjwtwTeLFoOQ
         2p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038968; x=1737643768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbb6Ezfzp9O8O/V6bl6D5LDxeK+r+UlRD6ckNgY/1gU=;
        b=AvS2JIKXrPVA1tzmbShgWgfdXMFqNgfCImMKjVBm8r2VARHzE+Ryew+eS7Zu9l8+8z
         kXifuUfHXbsh4t5st9WCg7warYupo0mBF/+RdqeYNZ4INw1KPwiWnPBC12TIn+R4P20u
         qOeWV0kjQDGXC69GQkKLrlFLgntI6NFDwIKXD8gVKna6km+N/GBnTeTq5tx0RC5DaALU
         5qTptI0eX4xx42eqRw2fCu4E+lU3N5gAOmVWpR9WkKPf8jPx8nUNSEFFQHztTWLo+VZf
         3zfksSHIi7yTqRgSXrFCrcWCthEpf/Zq43Jmg8nRlq8hJOiOxsuif/SGfTrS7utkTnw9
         rvgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuGOdYIozcU1AWKTk9QrE/YpNvkFkmsvWhb400tUWDnJIqJZFldFBZZxL38LjmVk4didp8AeijpwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUb4gD2dVED9ILR04QegEwnx2gaSzYO3F58MC8vZSh3YmsjfES
	ZcnYK4ltzlrRcUSliz/+20+AK6qBuJXefPuievMovC1H2e5sYC70WI+fEfgfjfg=
X-Gm-Gg: ASbGnctRAyfzNwC8oSvadcb2srbVoh1uXte9csWMY6VHGU0DqSclWurXEC/+tu0qbnv
	0n3JUTeC32tJMgepamC/FDo3xbUxeR7pwig/R/8X7rjj0Q6aWOXODVSjdNdI+8Loa5vCbQlM7S2
	a2TtrdbC6Pyc5eJKGasSThAegA8Dhbw031Gs4tZKhW0dLCes87ZOVgsTJ10QI7+FnmfZsFNDS0G
	C/4fZE+w07zu5jmMZqm5cJPUp47AsBSersCGz9dJB1leY3bcU+i/idIBN9zm15E4ppE34KO6oNp
	xplda948XCy5KHOnCSvRdMtStiWRSBYODXbC
X-Google-Smtp-Source: AGHT+IH9TQuJ8S6VwCv/DsUwUueSrMwmdIaON0G+tCnVqhp1ubDleE7CO0HW5JVWQ93mm1BDZ5rH1g==
X-Received: by 2002:a05:6000:18a4:b0:38a:a043:eacc with SMTP id ffacd0b85a97d-38aa043ee63mr16034591f8f.1.1737038967915;
        Thu, 16 Jan 2025 06:49:27 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm70310f8f.10.2025.01.16.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:49:27 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 16 Jan 2025 14:49:06 +0000
Subject: [PATCH 2/4] mmc: sdhci-msm: fix dev reference leaked through
 of_qcom_ice_get
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-qcom-ice-fix-dev-leak-v1-2-84d937683790@linaro.org>
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
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737038965; l=939;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Wje1BciONDqQrKQyhp/R22j+9s7pjT1C1mQYS4XxTmo=;
 b=aMMD3l+fSYmaasELHSb630GvEIX81VeJMVo3eY8nHViIArWh5G7STBR9Qc3WZpAaFDvitRjk8
 m9LNmbtOIdmDxHTkSnPmHvYOH/JFRZpvuMIE8UrP0vRAQpXFltqIOPi
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The driver leaks the device reference taken with
of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().

Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
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

