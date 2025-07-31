Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC881E;
	Thu, 31 Jul 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954915; cv=none; b=keKrEF5Gfppa46nkT/9JUIruj8sad3qDA2ijEIUtXBz7FXscpv8vuGz7LFTkAXyf9ThJJISJ5NYK7R0yoJ/LFFnTbR+VumB4whmdvD6oW8d+R69u+Eag5BOvEiA9kQu6PYImiGe4BJClIPVSYkEAqBUkoMbkCuG9sC3nWDRFNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954915; c=relaxed/simple;
	bh=i2/nMy7FKYTyjoOb6CSTRUZssDpBCdS9RZdlFSAXfls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SaoUQqPIelGT0gr986mOdR1pM9kMYzrSRmJOMnX9aPq6R2e5egztnvTJpKTEoY5fo9R4J8anx2zjOW9nnpNvwCe2P0Ah61vS20oYO3t1HU6TeqX5MrFczYSnUaiNxFE44csUUe3ZSwvd/9m/Tv9ViJSY8uGuP1WAp3GWGDDIAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCYwW3NY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCYwW3NY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-455b00339c8so1773665e9.3;
        Thu, 31 Jul 2025 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753954912; x=1754559712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylc4ZxnLD2CbRkm680HNmR2pGWeedE4Tq4BAYLGyBVc=;
        b=VCYwW3NYAZ0/cVfSaJh8PsHFc51hr5mYu5Eylzm0aem2n0obygz8fH+OF7lUR4XjTu
         30SkYFa5p+xouMnrVg+beAOtvvTKwO2R0rEJjBOAqOJWlNDn83PcuboYz4KYX2t8ARB8
         90ztcVSU8BbMUqBn027yU16fwsUNidwmMmc1xo3XdgRtu8ZkYk24kzTx4/y9JABjmecQ
         k8mINmGnbl5AE4HUSjG/PEPjgOE3blpmNv04UgcGyJcHgc98vZwCQxPu59p8cuIBXbmo
         GYydzZuaCHZ1/rrYrPt6u0kqngOTW2u+P4KP7SxsQHexc9Z1INDkug2LAbKOxu4BLgdW
         SH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753954912; x=1754559712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylc4ZxnLD2CbRkm680HNmR2pGWeedE4Tq4BAYLGyBVc=;
        b=MkjujIR2uis19Sl8+RWoLyZ4gEEIm0ARKcTQIH59y50ef2Yf8OzaRzxwPiMOmAdahv
         DhzzcfiUO5/JMBDNovcSPQhFdvwaWe/t9qsRhl691FlCcbLMxkH+8rlH18aqUvNfdO3H
         APhknwrkmzACtIOzYj6zxaMqtXbMELy54StX6iFpQ071DC7fXwD6oJyD3bU8HTM/xZTy
         jylkQCyckOm7DIj8MeVUYijuX6j2RXNj3oYyvkObRxd9RtfFdRc4z/mDkU+TX1wsFBRX
         +0pIL265/Zsfp90YoEzroWKNwStVbZ5c5zMgt+SgCv8PZxU+pPc13EGmsi4D13fouyS+
         fCdw==
X-Forwarded-Encrypted: i=1; AJvYcCUETHwXudgQnU/Lbt2t8EaDrTNaa9Mq4aEAT1WYIOpiVo1hWvQw1lccKFl7EEoEe2c6s6MRUe4j4d14@vger.kernel.org, AJvYcCV6YCAC1nI5YJoTv9VXQxwW6i1/BK9/5paKPDNCJ02uvhaFtXigJosoVhdipXkwv9xt6xLmCrtJg5PIdnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIVuKpGZiDI846C6/ghCBjdBxYhbJaTE6OfqQldfK+8EsUbR9
	PMIe/3hws5QEsjzbzUcuBDLLiSi7HOd9oPtDw67ZIUbMaUth+AmML36V
X-Gm-Gg: ASbGncuZaCMdte218h1dFkovkuLnK8rhLB1xgpJC+3fHKl5Fu0Ksd7c/OF8f7Eh1Jqg
	+X1IAVcBZVDZqFl69IdK+hxsUM+IQbXJSRs3wExhjXzWgHz3CjqZ2xeZsFYe45Tw2MnMt4m5MHx
	33FfXpolHlMi0RM3vvIo/GlWWOGtrLcgULMckCks+DS40WloTL47GYtinJZdDx4CuGHbNqhcBcZ
	WHZVoatTzu4Z24FCcQj08eNZKIL2V0buD5y7JU07AZZ4ebF/lDxCGv9Gagw9jYtsLQ4lWXa+tiO
	G5XFnLUtmniiAX7rTNWAL1afwIDfHtKjwQlo4SJWe8RlBPmM5RA+RbARw20FumgvXaJYLTNbOF7
	OA/sNP7828sUdrRE+Icy9
X-Google-Smtp-Source: AGHT+IGje8yg8iNAPGrk4uFHpWmJ4AyuhPlf+5JK0IMwP0mZvBIu+DXEedc841mCBEGmi3Fx/5xZWg==
X-Received: by 2002:a05:600c:5185:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-45892bee39cmr54428715e9.29.1753954911810;
        Thu, 31 Jul 2025 02:41:51 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458953787a8sm58153325e9.14.2025.07.31.02.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:41:51 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mmc: davinci: Remove space before newline
Date: Thu, 31 Jul 2025 10:41:16 +0100
Message-ID: <20250731094116.2163061-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space before a newline in a dev_err message.
Remove the space.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index c691f1b60395..2a3c8058b0fb 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -588,7 +588,7 @@ static void mmc_davinci_request(struct mmc_host *mmc, struct mmc_request *req)
 		cpu_relax();
 	}
 	if (mmcst1 & MMCST1_BUSY) {
-		dev_err(mmc_dev(host->mmc), "still BUSY? bad ... \n");
+		dev_err(mmc_dev(host->mmc), "still BUSY? bad ...\n");
 		req->cmd->error = -ETIMEDOUT;
 		mmc_request_done(mmc, req);
 		return;
-- 
2.50.0

