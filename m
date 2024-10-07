Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9E18BC10
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301559; cv=none; b=N00+jljaygTJjh/6l6e4hazy39jqHtl4/qO0l16hVFRhP1EtmgOZh+DJGXJuo8JEjxBPNCM0kxHnMiZkjfPudPsKmtJT7H0QeMA3b9Ig2Dc1ugBlmS9pevV+CWYgjTwIF2LiGPYom/5Ybxql5ICL/Su0EBEwf+ksBMvTRlp6dXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301559; c=relaxed/simple;
	bh=jESfmue0np+sznfxFUnf226R9lUQNlDJcp5q8IXgN54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LA/YawRiNUIbJiZZoJ7A8CkptJVHvr+dFKWK8UA5XNqqMX6sJZ61jZQfljImQHd+/at9cyuEZvDK92I1aq43BnbaPsKiE8S5PRo23O6JtzDngvdjG9A9P6zpz+29rhJiHQ3I4F/ZtHShctO5TmrUAqouvsv+87gaSEJyyn2U3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3HRROZGG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3HRROZGG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cfff59d04so3420251f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728301555; x=1728906355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnfRZrs5rd9jTocE6z1mGyd4iAKiwxMzAQadUPnEw/M=;
        b=3HRROZGGyl9oqHtYebGZ1OK7hDlsCYz+YCJWiMD3KAoxaBFdRpA4IxCvnCJmxIjPwN
         UGWXtufAHVj4u6hGSlN4agpgX2QC1SfXN1B0gR3b6Z6Cj6RMUr2Hbe8mVEZM10A5DMZX
         7JOqQG2NPaRRFpFHX0Xnqs2H0FS2QwDE2OV2PpEBD1vJOG3OacEXZ+cKP8QaDZs3okvm
         y1aouZqH42EDdBzstF4aPIKeKQqxHnKbjpufJfVPK1z6JAZjkrG+RIhgaWvPGBFHKY61
         8dj/tyR+baalJ60XwjyyoCsFT9f9OKlHGuQcdlbrXLZWpSZ71KDcVkHsfrnH0I8mRxaP
         GLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301555; x=1728906355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnfRZrs5rd9jTocE6z1mGyd4iAKiwxMzAQadUPnEw/M=;
        b=XYM239Rl9bNq9GSyrzMl4HH6R/FhY/bN1XyjLFKdFsTDNSA2Ymxnu+pioIrPSKCNet
         QDCmIY1bIcPxbyc3QkkBL9KGEa2+TtcMC6SPXcIGI0T+SnsVoaiKGDb2siVxrjVZBfP1
         3rnN7YnrivKN5w1m5HDyxb5z9rBkXK0jTZaTgRQ1u37zo8Ja8heuVW420mosQPbziBpw
         adoFFNcMtrQD/6EujrSwPmz85r7Llgd8+rVmSkEs3wAnpipuGf+zLx9RAW7h1reILXp1
         OjaMGc1CEpVt+YU9wx1wuCjHpbL9DuV3uDQz53Qlyv4VJcFBwYLBbcOp5OS665P9c/SA
         Y3bg==
X-Gm-Message-State: AOJu0Yw2+F9+tsN6h6nm3dWpN9fsvKXn6+gdPqvW2Gi2gGiNZcM01xg/
	Gl3kCLX85xlvSFVqYGIdsE4XK6zuTvb58wtUeoyUOe8fsL899cqJMEZFPx6MkgI=
X-Google-Smtp-Source: AGHT+IHv2HDJzBlWcJX+EM1VUKdDajOjn74SvjnVr6X2+w9ayFZJ8r4VM0n4+22m48JJDuduijUscg==
X-Received: by 2002:adf:ce05:0:b0:374:c1d7:4ef9 with SMTP id ffacd0b85a97d-37d0f70c86cmr5784457f8f.26.1728301555040;
        Mon, 07 Oct 2024 04:45:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d169734a8sm5562454f8f.101.2024.10.07.04.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:45:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] mmc: mmc_spi: fix snprintf() output buffer size
Date: Mon,  7 Oct 2024 13:45:49 +0200
Message-ID: <20241007114549.51213-1-brgl@bgdev.pl>
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

Increase the size of the target buffer.

Fixes: 15a0580ced08 ("mmc_spi host driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 8fee7052f2ef..fa1d1a1b3142 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -222,7 +222,7 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 	u8 	leftover = 0;
 	unsigned short rotator;
 	int 	i;
-	char	tag[32];
+	char	tag[43];
 
 	snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
 		cmd->opcode, maptype(cmd));
-- 
2.43.0

