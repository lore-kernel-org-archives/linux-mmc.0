Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65D19D8A7
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779554; cv=none; b=nOhxrUCfjHF98D+ea8YB151QpX8TEhMo/a1gE6M+/MfYgCdzjAy+T1xCLsFGuZue/6Is2jUqgYzjH2X5LYmxB+Edv8Vx86WsSvVcHpL8TiQi1F7XfKoQNHa4KAc7pxIjFq3oEtiZIjP9dy9JN7Eftg15UnCgPjugI2R3LcG/GLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779554; c=relaxed/simple;
	bh=i4ivNoJA/XYa4j8URBoVuQOwoj5jbAtHTh2CVRUNL98=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Txb7O+kTmTIYNdOiRjEJfFOC2XkHyWEo2eJaVw5C5MqdExDuWmML7pVtqqCvABk/MUiAsy4st3/GOZJ35LhUzR7Nh1Vqgu0zGu+drk1sGTv14xb3lDws3ueULriIboFnX+8fGkgcUh5adFapk+R4TM3fzennX3+NuAOuBawSIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSFNqRVz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSFNqRVz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so7402455e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755779550; x=1756384350; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YxbukuAzSacGXrM6lqlSlHSwuWfZD3gHN6r3X8UJRE=;
        b=qSFNqRVzxpYKMyE1QC6KxqSoQWvVw0pW04O36qfvu+Fv9AMM6y2I7o+EtEeroIKx5f
         xn06yIk8ngZsSvaBbsEOFW4Ni4gVFrB7W0ev7J9CMdVKuWhNM1idSkFw2Ulpqjlyvvg6
         lh9pAYC/CrukmwOamp4fbJUfPILgHsXPK9xYuVaQtXlN+09nzZcazkaPdt0e63RxHNiv
         n3XmaGswzWoV/Dzp5zLdrjFmOmHvZVRKQdI1wC/RUL2LGpPHNTAb+gYDl8vGBeEFend3
         lDu0UIiWhVOvURAxEtwdN/QgO2UOP7uuW0Ddz0M3kzHuYoFvjNfLn8KPb9+qpLk5lR2p
         jmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779550; x=1756384350;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YxbukuAzSacGXrM6lqlSlHSwuWfZD3gHN6r3X8UJRE=;
        b=LHWxmw5abg5urAwINEo8jgcc2yQo10Sj0+vh5DrmNAPNy/cvAcNSVFHLEp2gzOR1jN
         bZWI0fnd40vMZNSElBRfn9zSS+dsORIjPF0AGImQX8halwylCkYYCNcHd84aRVXB8vUx
         Qxbab3qhENZNY0yqmGiiJr7bQFsFe6b3nCtVbIk2idArLJSE1Kq1cMUku4PzvemEApHx
         aDGKrso25evypXneAMtvOsiZQCEdf0EoFHFFBuqd66x2GYnW0eZyvqYc/Pe/VZgEwR0I
         zlIGCmdEV/634bY90lHV8lGOgl1+YferVBBafVYLV/RR8rdMozmZyCiTj7g0GIDBRDhi
         WJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp1H5iQv48l7QpBMJtF3YIVDV1FFgdLhpJVajnW84292n2mmrhMUt7MssRQfRhfZTSfL2zbgCBmpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuwh1uEDYzykD+fH/+n6fa0zjD+VFgLzx/zaglMdEQqyS/ggQq
	ssYNZnxF92+nOnI//1WGt37UYaBipw20BBRvtzsXobeFq4PBTbhl9Etz3/SXVvAMnH8=
X-Gm-Gg: ASbGncs1QtqWufnTJDS09sI92qbXt+/loEpm7DoVBLzpAPuw/n0qkLHH8Nn7UemDeD1
	O+TxZQ8H14MOka9k61/EYD8Dn6qOQ3VFNNo5MNdKEQ+dxYFUSDl/gmcLQmQG8lvsLqhPGeXfoop
	8qqJ/1onzbUDpSdh7qH+Mi+nULc2YF2u1cNxnT9kc8dnU1l/yfrkkKoBguZFE4Xi+TqKLhHU3UZ
	ZLE5KVYRvqXzcRxmB4lCtFvK3KB50riwHWiQstSgpf9mBRkdYo4Ae8Mo8VcAW8RfKrFH6uYyBOy
	gsfHPpPI+5b7+c6UUvzq71I8UEicIf4SE6CeTMnAbQJIPj5LA0Ghr6tLw3KvSH8Xiy8Jq4Md3r5
	PBUlAqbqTn9tzsrXL1WguKbKAfKtUvsv0WxLdWQ==
X-Google-Smtp-Source: AGHT+IF4re4JMKqmwW7eC8Vyez+RBY3Ot24DyU7VwP7W6aNkCpKu4qpBngC8551+g/vQCfP2k/8E9w==
X-Received: by 2002:a05:600c:458d:b0:459:e200:67e0 with SMTP id 5b1f17b1804b1-45b4d7dcc58mr19978705e9.10.1755779549700;
        Thu, 21 Aug 2025 05:32:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4dc255f9sm29273285e9.21.2025.08.21.05.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:32:29 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:32:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Rex Chen <rex.chen_1@nxp.com>, Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mmc: mmc_spi: remove unnecessary check in
 mmc_spi_setup_data_message()
Message-ID: <aKcR2ea747xkw_it@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

An earlier commit changed the outer if statement from
"if (multiple || write) {" to "if (write) {" so now we know that "write"
is true and no longer need to check.  Delete the unnecessary check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 95a32ff29ee1..42936e248c55 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -566,7 +566,7 @@ mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
 	if (write) {
 		t = &host->early_status;
 		memset(t, 0, sizeof(*t));
-		t->len = write ? sizeof(scratch->status) : 1;
+		t->len = sizeof(scratch->status);
 		t->tx_buf = host->ones;
 		t->rx_buf = scratch->status;
 		t->cs_change = 1;
-- 
2.47.2

