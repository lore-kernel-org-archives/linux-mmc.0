Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35642E0B58
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842917; cv=none; b=LOfHDoub+aDkAciFLDNVOTtqGFxMjLW/PhO7IO1SCKm3uX3i3+xu2U3hj1HpWAxVpWWHG/q66h6wgBwKJn2W20ePky2DdftLkmaaMWdoZI+ZZ06TWO0/Z/BG5Laq78PMA0+s5gD8O6+cEJ3Z5XFOkzIZMgWHJIccSeFuTRz43AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842917; c=relaxed/simple;
	bh=D+RG4BiNmosB4POjfo5LyZOum/XJgmmiebmEbEc+9XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=no0k1D8xVVYPYWrmyHTU4Uual0MstY7t4JZZBH3EdUje8hFQOS+G7zqln4YEtjqApOSxu7GfQtb6Rz6IOu4la+HLjpJy9kvCABWaSy4wzKlmKyNMTk297YCNT3GvkdyuBTgUKzXgNxMEpeDqRWXt07h/fYf4UbM/nMFEhkSsO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jtYhG92/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtYhG92/"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57e36125e8aso5766621e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759842914; x=1760447714; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUbAoZOe38I1qyvuq3YPis6MKfGdcvZ/5XhukSJlpQ4=;
        b=jtYhG92/STiFn3WW2RZSkO44l3Z7+1NP6av0sUM1yAY2l5ihrqUlNVYbIsAw9kDXVP
         6RKVzMWNhGCZUDNPrS8fglDY7t7W9YAH25jc3XWEvDYKHrN5xl8o1/N6qPEqI9wD8eUf
         7SRlwkdiVxuYbd6++TCYOykeOX5llqm5QefdSh6HwGaNrNuY7+uxRhValZxtY7HZHIOJ
         OnumG7WBRutuqbr4fylSC1iOpFwdZTNLvx80UcCOwa44BYeGOLihy0/RvyDtqtOkTSS9
         CtGde1HSV+tLqqDG2tGf3lopcKEZQBcaz14dov9r+GTRLpOlfiuj2z3qGbT/aQ5DJuZz
         k1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759842914; x=1760447714;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUbAoZOe38I1qyvuq3YPis6MKfGdcvZ/5XhukSJlpQ4=;
        b=j6TtmQnVt4RxfceJpuxh5aE0N+X96WTjc4kVuVsgf7J3q8dcH8J6TH0U8vwxMMQ314
         I5fIEcm53Ai9oSFlJPzHv3MlqB/5wudtyN2dgXSDqP/SDXhHSh/oPTa1/2Y0OQTsMX+8
         9WWq8n3hCaSHJj2inakqx1Oj5qeD+W+W7zhnCLrsucsp/HpW5t1RD+Ht+xhkKX0Jol8t
         WBeItCJ3O8DKiVcd45CnfRRJ+FpZIHaQ4Io+jVtAeBoALqQrth1vbJSGEbGFa8DXHez9
         oLdaMkjmfhPIwytl4yMcEMwnCc25dDNl5n2RSRdAk0pZlNylf66h8TtjBXOgUzRAkbdb
         iRpA==
X-Gm-Message-State: AOJu0YzydWOclO0OYSiQqhhDFrYohBV3Bdd7/tnMnsi4sCN2RRzPb02b
	H4BXE9wHrLKp8QmLYkh19Xh74mZo3CNWxCI7nqclOIuY2cghwjCMnD7kX1E4rrT580w5nsBy/Qy
	hM4zT
X-Gm-Gg: ASbGncuBtmA23hcyTck8Crzo0LodZsOajmHxoed/AUNCdW0xxB17y4x1pChKic7Y3qb
	q7iROZQa4hNepWhNd/d7LSLZVeJIKNfdU/eqlqdYKYKrhcHt/4CFvPluwlaSFHWKxds8AKaCDOQ
	EcDovJ8UjmIBEQjKdpTWk2glOaZFhgdLz1TMQwJhuhUnco1YiYhlHokmQG5YUIkjYyKWxK0xb7C
	bIpD16+aNj1vhGmPBKrYH8LgOG6d31ZhnMkCSGd7ILMe3joMI9Z4YSolxyEh5Ej6dEt27XfjzvS
	x+lJELBJ1WNkf5HtE/4pQRrewoLOBPqcYdrZOxcOliXDaNmjNj/fuTCAR4RKnrfxPFv9AdvA6qL
	QyvfXGeO59Ep6IO3d4ajIJQ++kEIEJJlyEG1VMcBZpbMBWPm3Ca2TUVel1NssjQ==
X-Google-Smtp-Source: AGHT+IFRoxaQc91a4B+h8FBeLlnS7vEr4OlnwDY4Hm5RxPgJYcQA/8Qq0ahvJnUd5oMpNbBS7Evoyw==
X-Received: by 2002:a05:6512:1195:b0:57e:a78d:fe33 with SMTP id 2adb3069b0e04-58cb9d1aca1mr5868647e87.17.1759842913864;
        Tue, 07 Oct 2025 06:15:13 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011b120bsm6070604e87.129.2025.10.07.06.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:15:13 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 07 Oct 2025 15:15:13 +0200
Subject: [PATCH] mmc: sdhci: Stop advertising the driver in dmesg
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGAS5WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNz3dzcZN28fN3ElLLUohJdizRTMxOzZBOTlBQzJaCegqLUtMwKsHn
 RsbW1ANFVDiJfAAAA
X-Change-ID: 20251007-mmc-no-advert-8f5646c44dd6
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

As much as we have grown used to seeing this message on
every kernel boot, it does not add any technical value.

Demote the init banner to pr_debug() like other similar
messages in the driver and drop the copyright message
altogether.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af71fa5a70eb579fd812227b9347f83..001802a3aa202c4d8f185ff4924838579ee44c4f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4999,9 +4999,8 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
 
 static int __init sdhci_drv_init(void)
 {
-	pr_info(DRIVER_NAME
-		": Secure Digital Host Controller Interface driver\n");
-	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
+	pr_debug(DRIVER_NAME
+		 ": Secure Digital Host Controller Interface driver\n");
 
 	return 0;
 }

---
base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
change-id: 20251007-mmc-no-advert-8f5646c44dd6

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

