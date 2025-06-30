Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE1248F44;
	Mon, 30 Jun 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276154; cv=none; b=EMj+zG4c8ifwcPsobPhHQ65GAawyeNlAs7rltDK9tfUqrVgpgcWPcwgIQCWga4cSFDppM0bLPjUZ23wg22aYQsOFowlbDAOb1ggMaIu9cLOMzFQ/vj1i2t7YVYtLbbl/48XNPfnz+LLbQfHxWqC2+07ejKk0ZEqtVi3os72G4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276154; c=relaxed/simple;
	bh=z29HrFDi9s65t9GNCGzh74kdd7wcDIierOJOKdAPlLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAo74iLkE16vn0TqNzPLGiZELY82IvTeRuaS6DOKo1jxNun+Xh55NkCZRtKKwZZtEakVOkeqiF2+EaY1M+aK5Pg2a1fzKJ2qSKrUofaXXRvb4n8Gvw0NNN+1DMkDlUkToOBxDsxjlPo6C7wPTNt7hLjyUo9fqX6I9DkwtZIXn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsYx3mjU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsYx3mjU"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4e62619afso464245f8f.1;
        Mon, 30 Jun 2025 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751276150; x=1751880950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1A5u/XezbCzc0vXccv/POOZnvtspnWkWrOLPiV9LNk=;
        b=gsYx3mjUSXnSoJBZTLI/ou4abMltHTOOBAppbHxNo9HyNLIKcJuB/M+zr/R1YToFat
         m6AneMUwojfAI5BQTYCcMULbqegeCIyDZztmKHq3QvKprDajV3C0On2XZZ8uM2lUfNC4
         MnI6UwpZcvbY4W5dJH4lyi2SinUyCNtGSTB1xwF9TcMrXjsHGoA4AY/e3G2ifDCx3Opa
         Ybx6K1/5OGGPU7HRzfKONi7mvObqBV/7lUaiuyql5l7e3Q6i5kBZ7fZbsZZa7KJ8Rsbi
         cjQctlOhKyaTQvFOr/rtnBIxPyVAUvcLqN4K8DWAwZdknB534XtETk0KqrAGzhK2HoXS
         Q66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751276150; x=1751880950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1A5u/XezbCzc0vXccv/POOZnvtspnWkWrOLPiV9LNk=;
        b=hpVyIb2KRCrs3Vtyg06Xh8gnmhlPCfOwC17KL7ApdFTqaGN5MUswfDzwIcG+VcNb8y
         f9OSo05bggykTpKQ1axLupGPpucfr3UxvAppNKGcD+b0mgspjT6Fc/gWUfXXMUB5xjnA
         QY5uRfud/OD7cUwPIozNMOXj64lY65BTabP2QWdFI/2Ge0DfmC92Rs7ACzCz5J6iF/E0
         gI4M1JTr4bPo3Pj9w9Bg9pTwUYpz+3Bo+SmvLKEEp0+MLI1UOMT1RUy7dH3NhMAfihrE
         BHu9kBIhs6ez6H5V0nSwTTQA+qnZbN5UgDahrVCysZIoWiSBbXDPf50RJroEGKruQHkW
         UoLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn+bAlhBR561F1LCS9Um+zL1CcJmi6wXUyCRTNMz+WTmoMkIsyPxgLwt0uyOj2iHeNgxBUK8RuUMVW@vger.kernel.org, AJvYcCXArlL3GN+GK09eaIUmhTFVz+NVR7m0wFdgFOK0lxzSFOfP2ykFdInAZzGzBxEldFBy2EzScHRPwyNm/ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrfgQEi2YO564UQqQE6K+n37TcVUlFgsnEAnHzXFWQukx8lNz
	iwGgumXfwcvbWKuhQQ6ZYOxFTUxm0JolnO/DOm4bbdMAJ5/ux4Jdi+nH
X-Gm-Gg: ASbGnctau/JBqOZAtPuOJttaDJeS1NplTFQAJeNiaL/ZqwAMTWZjULsk9MgAT0Bo6KG
	ia7ogqdDekU3EVfarjsib7bXshWndVsJFiCFeloLM2aGWLy6NpmBAMYKy5JKYL3tmK37beGHgMY
	cJj63I17e/q/rzCKccc6LG+WcsHP+GGGVmYzaxtCfXttckoGRGYeRNW5G/+rd+58yzfCaOT/uek
	seTZZceFwxicSbWKYPnDXa8bEoQlYhq4meSFFeg9F6gAu0As9gTAqITFrPgCOdoFo73eMlguNP4
	jEabBvY6IVM+A4yaszwZjYBNDiGwgBk+WT+8uyJIkiVjMNL/RmCerKhAPSzMss134xe4TIxPPhl
	W5P5s1yEWr7pZSqhHIi4lSOl8cA==
X-Google-Smtp-Source: AGHT+IENoQHFcKucvcnuAdWdAyrPNttNlfViNN8c8eBHYW6QCFoessLifIGmNu5Aps8j4D3BqFxOXw==
X-Received: by 2002:a5d:64cb:0:b0:3a6:d680:f282 with SMTP id ffacd0b85a97d-3aaf43b95cfmr2363583f8f.7.1751276150193;
        Mon, 30 Jun 2025 02:35:50 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:234c:3c9a:efe4:2b60])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c7ec69dsm9774684f8f.6.2025.06.30.02.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:35:49 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Yumeng Fang <fang.yumeng@zte.com.cn>,
	Eric Anholt <eric@anholt.net>,
	linux-mmc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: bcm2835: Fix dma_unmap_sg() nents value
Date: Mon, 30 Jun 2025 11:35:07 +0200
Message-ID: <20250630093510.82871-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 2f5da678351f ("mmc: bcm2835: Properly handle dmaengine_prep_slave_sg")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/mmc/host/bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index def054ddd256..4fced9b36c80 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -503,7 +503,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!desc) {
-		dma_unmap_sg(dma_chan->device->dev, data->sg, sg_len, dir_data);
+		dma_unmap_sg(dma_chan->device->dev, data->sg, data->sg_len,
+			     dir_data);
 		return;
 	}
 
-- 
2.43.0

