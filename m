Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624912F7454;
	Tue, 26 Aug 2025 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195169; cv=none; b=cN+aeQFMNiilwv+sN/IQiOF/9+Ch5JRQvOhQHolXxLmY/3Mb5uzjUJ63CmNPhYi+CSR2V9hKWNbhs8Hqq2uRhDIoG4jwrx4k5NM04pc8Rxhc6U0Nj4m2EBPGEsgXH+v/xEekKfIoJaRq4l8kCuAlUvGnP4Ry8E+L9j2UM5+MIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195169; c=relaxed/simple;
	bh=X1MaLN7tKERzOb2cHVgs5tYuoY8axr1qOLRbSLCneA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frg19FOiTjvJrSgBbYUOqFCfZSJppzFlhVgwNHzNKO7zE2qnQh6dUkLYNdKiSMQnEUOtEqDtaL5yXp7XhWr/i1Wsxkgqx1/GT7JdDqtI9Ok1XQbtZ+ju4Zqh2vXuS0IyRFETDVsX3LzMy09kc0NQDbV9MOgg1XG/L3Dr/m9W7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at2GirUH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at2GirUH"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c90c22cce6so163826f8f.0;
        Tue, 26 Aug 2025 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756195166; x=1756799966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jRENcxkuUAz/UlpXmIPqOpr3BKnP2Y+ajqaaP+h5obk=;
        b=at2GirUHL0z+4ap/mChlNRwJYarGvSSwqsDvSebgOXlZkZp8QbLU0FaPcxL9v0YBFc
         l3wb75AO1d7y0ZCZvKsJEzvmXcYWlc2ZEGKqvIBmzWF7wlqynJ3FmCcw5R8Csjard93S
         0obQtf1HFI3U0tqz3DHi3cflmjEOkp/N1/+92goXHMuAez3pk74zYoKSlok3Yk4yCV3V
         csQZIxfDnUv2Z/fkOvuknPcy1ZSx/yzWoWX/td9+jOP7Ev/9SlhBYe+98QV16bnsVoTn
         YTwvi+BoIYZR3OSDBsAKimcxOFHG5B/TMuxAn+aHkea2JTRPXWTPd3HnqySKRsJ5LEPI
         OxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756195166; x=1756799966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRENcxkuUAz/UlpXmIPqOpr3BKnP2Y+ajqaaP+h5obk=;
        b=u9MaYk7E9Y5SEwlXT472a+pwW3ji0NCxrNeNpjZCu9OgmwwsX/QrHPgMBWCgT3QU30
         Jo87ZvGzB6PgVzCtibdmV8HfIQolLJTEIFomutNcsPNjZPxYKqFdtaWRheTN1mfAbVs2
         8V47h0wrY056YaoBxqRgZWcthz3nItlnc9um2Kld80AxwhlRenJhecrSFaT6i/x4JjTN
         uX3YLLk6/RpCHyYaU+IofblN0HWfXOdin1GZSF0lWhoN2M/qh5Z1y4I/oS4czujfQOw4
         CS2yMIrjRkDtoL+W84ZZr3DbfQZs4BbG35LGbMzWGLatEUpczydm3SNWJcpUVfgpxTXI
         JbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG+dG2aD62ypoPC9JUgOEwmtrtCH6sWZTYuZ2bXbjhfXA785XvgR46nFptxzwUtwrbKLcNnBjxzVov@vger.kernel.org, AJvYcCX898GDxeFWt/VTqOvj8X4n9ek4sk/VCS2TUHstXwZE5oOEDX+JQCAw8o2eDKpxJCE7cRpDmOoMxKoPbVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1IfHeVxkS9Cf+i+3wZe6dQZVYBdQshlRswY0APzYeRepEOl4F
	lWMSuv+j1jTIVEefGWFnuaK2xDKLXG0Wh+k0AT6P2dixKZ1g106WjWKr
X-Gm-Gg: ASbGnctZOr4xB+T/f+Z/XINFMZDGBrFFQfdtS0vKwoyDFPYFs4CpObFLTCFuA/rtKXL
	24eAhNCoFtNUluVpyFxIhRoBxk0KDzz1A49cQpU+MpTgFWNdeTydU1OckZeWUR442hp93DXTkRA
	ruRrNuaRXMi4xE8M8LTy452O+UM1n2taExiaz7WGqMlyjU//aASZfo2iGa2baKLJLwXzqGeaa6r
	mtMAQiFAiQbB/lzFLtubk2weliFNhPPJ3/fVsgYAhUzKcYgUmw78y2TU4uItZFkHYwhJxpHbkDb
	5IEUnDS8Kv/rqgqYWIZhppR1wDvwk2iShHHYq7z2oHdtJkRQ6akXt7HjOCZyCDMd8kMo1AlqkIu
	5pcYq+HRY2MOOQT0n5+cuHg0JQOH7Tgwe2vOlizImVBj2AXbZJxUUnS24WDrlow==
X-Google-Smtp-Source: AGHT+IGVKwxYo8EGjrD3YMGXfXdaZtoL2GTtpXVx26oogTwNzlCvl7VTsjBH7TcC0Z3pUSZ67d+beg==
X-Received: by 2002:a05:600c:820c:b0:459:dfa8:b866 with SMTP id 5b1f17b1804b1-45b5179b595mr67744635e9.2.1756195165530;
        Tue, 26 Aug 2025 00:59:25 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:48a7:f637:e707:7f2a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b5753ac36sm144810195e9.6.2025.08.26.00.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:59:25 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Pierre Ossman <drzeus@drzeus.cx>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mvsdio: Fix dma_unmap_sg() nents value
Date: Tue, 26 Aug 2025 09:58:08 +0200
Message-ID: <20250826075812.82305-2-fourier.thomas@gmail.com>
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

Fixes: 236caa7cc351 ("mmc: SDIO driver for Marvell SoCs")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/mmc/host/mvsdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index a9e6277789ba..79df2fa89a3f 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -292,7 +292,7 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 		host->pio_ptr = NULL;
 		host->pio_size = 0;
 	} else {
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 	}
 
-- 
2.43.0

