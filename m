Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA94C62B
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403307; cv=none; b=XnHnLox98h4CNgJs+rDlJHMc13GqDSBXCfjsb935FMFtW3Mnx5hlFKw4EK0bNSlYo9tUJf76HHudlGyxt1+VO2k3TFRKo4DneBL1ZP6gPMC2PokisDy6ETzL9ZLs+uUZ3nI+QiWa6DgkiIfKahwTKS0hEOjUB+6mYZCiXmhxQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403307; c=relaxed/simple;
	bh=6pU47CiYN3EVOmy5b96h41Z0vXSiMpnhxRrzNk/tQ+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BT1eoqx+Fjg5A2FgkXaNtON+W5cBpn/qBFUos+tp6/HVXAJ/ngwaKGLhWtG6SytZ0DwKmDsgwZWacGgUoY7BQLw9NJXiOgNZx43ZYs6KQL09paPMCrC4xSt69a3SLH7VUl/sAEIzesWvElhEcaFfjIxmMIYkPU/dq0WhWQsHZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dXeDqQxn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dXeDqQxn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso59776355e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728403304; x=1729008104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3s9oSg9hyHcMfQiy/pbWage+koXe/JdbFI9wGPznvgw=;
        b=dXeDqQxn2QebsC6wTlQuw3xOGIkGn23CwlrnRGA6puAk7ZUPbzHRZSIYQ/OlFFsvw5
         9Eoi2W01jmRGYd/pYygUaX7JlhfIPv8RYADYGw4SZt8FiOEMICzwJpOhyd5nrn0yJaTo
         5mP0suw2lvpY1ASCKFfi/nPHQZiL0bT1nmfo4ksQtazGJZ/05r+SAM+kspWgmt/+4ENX
         8GQoHIzzwbcrW0J1AKEhAWw4LlHNqNDn3zSaniAJNfBXjve7ZZax/+VySqZl1GF3ABN1
         +0b5iiQk+A0KfqOrJMj4JHwplrWdwr4UyJ2U/scNPOPR2pJDYRT9LdC3vmoYLvWiOVhi
         /BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403304; x=1729008104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s9oSg9hyHcMfQiy/pbWage+koXe/JdbFI9wGPznvgw=;
        b=FrsEvz7BoYWP9M0HI8R1sH41W6NbOeocYpKvSKi4CSNVOxfG7WkpF5LLRZOZ+NCXCz
         hSJxB1M6rDO5pNF9mPIkrCuSdfR8VRIa3xsM5yayGpEG5TfXZBrhKJcibdCh6GfRy9rU
         EI1HPFq/tJ9UID1ZpRTPa8ozHkVtsP0p2l/aKBvE/+a416R86DrERDoTo0pLONInUf2L
         8yn/0vUzG8sC3DgSzemqEqLgjykGaLvf9uHnlaXCNfkl+Mk4B7f9iiG3XLHciQA5TAyL
         cV30GbeImlOD4rmBYQlsY/GJ56knUbmO/Okw93wK6JoV6S/1DBaZSInvnV53KDaDmDmT
         y2bQ==
X-Gm-Message-State: AOJu0YwKePORtP5EfWYmyML/Hwnsiw62bIEUngQso5OKpfPwaTx/GvXL
	avXUOQ/JCcTXYM6yn+3zBEL6X7yLxlQkFvhNzQNUbCSzfub1W/y3cSAIFjVYc94=
X-Google-Smtp-Source: AGHT+IG6aCaOYevj0NkS1PQr8iOt3XMxnjEGZOxnPI+9ILlWXqvGiIUJFoA2Fzjb647XEx/VNkPmEQ==
X-Received: by 2002:a5d:6b91:0:b0:378:a935:482 with SMTP id ffacd0b85a97d-37d0eaf7adbmr9041255f8f.58.1728403303931;
        Tue, 08 Oct 2024 09:01:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:738a:20da:f541:94ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4d8sm8389125f8f.36.2024.10.08.09.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:01:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] mmc: mmc_spi: drop buggy snprintf()
Date: Tue,  8 Oct 2024 18:01:34 +0200
Message-ID: <20241008160134.69934-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GCC 13 complains about the truncated output of snprintf():

drivers/mmc/host/mmc_spi.c: In function ‘mmc_spi_response_get’:
drivers/mmc/host/mmc_spi.c:227:64: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
      |                                                                ^
drivers/mmc/host/mmc_spi.c:227:9: note: ‘snprintf’ output between 26 and 43 bytes into a destination of size 32
  227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  228 |                 cmd->opcode, maptype(cmd));

Drop it and fold the string it generates into the only place where it's
emitted - the dev_dbg() call at the end of the function.

Fixes: 15a0580ced08 ("mmc_spi host driver")
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
- instead of fixing the buffer size, just drop the snprintf() call
  altogether

 drivers/mmc/host/mmc_spi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 8fee7052f2ef..47443fb5eb33 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -222,10 +222,6 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 	u8 	leftover = 0;
 	unsigned short rotator;
 	int 	i;
-	char	tag[32];
-
-	snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
-		cmd->opcode, maptype(cmd));
 
 	/* Except for data block reads, the whole response will already
 	 * be stored in the scratch buffer.  It's somewhere after the
@@ -378,8 +374,9 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 	}
 
 	if (value < 0)
-		dev_dbg(&host->spi->dev, "%s: resp %04x %08x\n",
-			tag, cmd->resp[0], cmd->resp[1]);
+		dev_dbg(&host->spi->dev,
+			"  ... CMD%d response SPI_%s: resp %04x %08x\n",
+			cmd->opcode, maptype(cmd), cmd->resp[0], cmd->resp[1]);
 
 	/* disable chipselect on errors and some success cases */
 	if (value >= 0 && cs_on)
-- 
2.43.0

