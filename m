Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C9286D75
	for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2025 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620463; cv=none; b=MaUTVE4xFWfV/ftnteezecnTf9ElT3Nr55uIZyEJVNzaXJ0VAGxGErHP1K2x+pQifVWnwQZmbrnpaQ3Rxyd+QOedgqgEAEO6z6VLcfysmtpCxCvWxRu3OR+4tt75omtd9vqZGvwvC1ApQZayuRNoWFc2j9bFa7EM8aCgQM0pQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620463; c=relaxed/simple;
	bh=M6ZlHU6FLX2CA9QPMHjn/+MEhADmPo6CNAXX8jHSGfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T2aNE+AstLPfVCEPAjfSKkfH9CYZK84tGRqJCOG41giCIVoD/N6+rP3tJ6e708ncQmnmZW7cslodznOuCuVMNHtfBuXh1RxLvhbADbKQsrCNqWKjA/sKo0RipEpFg78DX1mANW0HhsKO8yAYV/HlwziARjJEYhwTTjogTRfvDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hSxU2Ubu; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSxU2Ubu"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73e5e3c6a37so569900a34.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2025 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620460; x=1753225260; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjmjRwrY70wx2CHWgUgdB7zU+MT5vMpT8bTQPJScVgc=;
        b=hSxU2Ubu52wQfGMq/dXtCFEhU2rK+OssajI/TEODBmZYw1q5ezDslKFkrsaXzH30Mh
         mGmFsQOxKlZ/B4u5RNJgSk0Sp5IqZ65MyojZqWXssuGMzfXJx7ksx+k3JHLw8Duy63XO
         4+UoKOr2jIAhWQApbRE0SIRkanK7bSs4m3tad9ISd/K5cUmY8/43hwZQwy7Vx49I/Uvm
         /DKN32a+XNl+xsT/ueUcu8Uq89UYGkJGtLwoDRXJJ7EiJoWxCZEcjZg9UOpXlfFskMAZ
         XZS93TB7WgbOyWHidqz9rnVys44AIq254J+WIY4MjDmTT/JNAjGFsXR7YsjDGUzk42rT
         cNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620460; x=1753225260;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjmjRwrY70wx2CHWgUgdB7zU+MT5vMpT8bTQPJScVgc=;
        b=AHs/08R00NBr4jTlLy+YU0N1dyj4ZxkSl3yHiYxPW+CbBWM4+Qdc3Ke28lbecg5dDr
         CwUDY57HfLCLuKG0fNstshcPvLtn7Ai/w88MqTjfG3ePWwPXgWIHPtLMsnIwErnWiQzQ
         JBlJC4OD2jR0dB/P34ZWAQLSl8pQJ6oSNbPefTQ1u/W5Ee7Kfc+HZwXWRI6WBkXI2Wke
         PaiSlxuJHdtM5miGhF2JgIVsiV3bA3w3zYoC98LseNKlkOYq7fKoQK/ho5t7wYDN24FY
         nsTOpHII1ytIkNyebngs+LtHeSVxx1WYaAKkw46ZIsAajHlrrETRfzo/VVjfGdDg+1kz
         UKKA==
X-Forwarded-Encrypted: i=1; AJvYcCXAhY3SItx+us8oZz1L+i6KQedqPr/WRtOrZyY4pnvu1swbmihrcFlnXd0CftK1QGpEIHnniV6TG10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpKQ9/LE8lXkpr02K3oDXypGIjZAWNlIOCl4kPET7T5rtaiAc
	VWAuFK+jONwVUIDKv+wTtnlka3+syntjYJccBZF8o6pSWvQmZ4mvul7GBLmtQPAL1Co=
X-Gm-Gg: ASbGnctVUSiEWUjLFHw2VH5W4aaAM/pHLd2OpWTzlPEjCn8gbbECK74qkXukXOlQoUz
	W3fuiT7C2w39thtcb3dxCpsDIWswgLyumNrl12r2h+u/dNI4+9+w7FOsXTF+1fyRQI4Fk/H65E6
	R/ozRQvg3dt6J2quXzpRyFFPekU66jg3VY9Wjgzf1XOg15cu/m0Ks4waIWPvsOGVZlFlvaCbn+/
	eeL3Hfk/1x/BQYIELgrtyHaJZQx3lLJ+3qrntLdNzySpTCBezhiK6osh11pxyaUPugigx+QIaFq
	Y+Rlr5w+uvLxIU5I1rqQUaGspYFVDDDAHcgK6nNzBr6PiFLTHVWA9iuVD3Xs8t4Pe9RFGgjIrK8
	RGl1GQsKhK1u8poKcsADUDzyevsci
X-Google-Smtp-Source: AGHT+IFzTAUh/H2WsdNWY9R0rFIJq9Rr261iK4dEmF89rYSxkR/WcE1QAJcgUum3s7/cBaN7xF2qow==
X-Received: by 2002:a05:6830:720e:b0:73c:e30d:c273 with SMTP id 46e09a7af769-73e65f2d943mr315168a34.0.1752620460253;
        Tue, 15 Jul 2025 16:01:00 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e54ff7384sm1012741a34.35.2025.07.15.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:00:59 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:00:58 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] mmc: loongson2: Fix error code in
 loongson2_mmc_resource_request()
Message-ID: <847bf395-6d62-49c9-a39d-8e82c5b17bf7@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a cut and paste bug so we accidentally return the wrong
variable.  It should be "ret" instead of PTR_ERR(host->clk).

Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/loongson2-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index ba6bb8fd5535..63d01d2cd978 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -887,7 +887,7 @@ static int loongson2_mmc_resource_request(struct platform_device *pdev,
 	if (host->clk) {
 		ret = devm_clk_rate_exclusive_get(dev, host->clk);
 		if (ret)
-			return PTR_ERR(host->clk);
+			return ret;
 
 		host->current_clk = clk_get_rate(host->clk);
 	} else {
-- 
2.47.2

