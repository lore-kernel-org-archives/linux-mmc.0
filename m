Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0309229B8F8
	for <linux-mmc@vger.kernel.org>; Sat,  8 Nov 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643614; cv=none; b=D3qXzIr5cdTTj9cTqNx+Ro0qy5nriw/kyaJtXb9Za7j2VqRales8sLAzujMqxazMhMZWxPXNPtdRG9ZgZvgjtQmNij1tZ5z9A96E/LZ1Ihx13x3bMf5N9F+RLGFcdEtW7mf4uEY5WK7KFp6aFIUal38VsYVHe0Wj6mpg4HcZN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643614; c=relaxed/simple;
	bh=fIhUPNIq43wji3Mk4iQYsn7ciQjs0jxKDfIN9kIEqzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSRZdgpjVx2ZqJjFrlGvR6oTu+LGEWWqWayOoJOvQH2whHtqhJq6tNMigpAovDmk355PNID4rolEo2x70m9usDkDboZxqt6/X0ddUJdlr2EGzL1q2QRpcAt5TIdU8E6TndsqEHHKH/NZwfuTdEltZqQZG4ENLGKyga9ZewyR3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=E/WIEQuN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E/WIEQuN"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso3330655a12.3
        for <linux-mmc@vger.kernel.org>; Sat, 08 Nov 2025 15:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643611; x=1763248411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oO3j4actqzf2xVKKJ0nWDgX3aF/G+cl1rlsWPWa+z8=;
        b=E/WIEQuN6AcdfcsY/eJweh09/g73nbGarmoYlGt9et9k3fdFb2JjCYkc15ycb8kq8x
         rtkSUpkVZKqJBypmyqJ51CcBW4mnDE/zVyOdHwO6c1WKg820EgzPqLQbewE61nOqlHlj
         sOLu2hpmrNC2TVxIZ20AJxVzkACal9epbff06jkGr7UlXJadGRfSQSCVe6VpBd/KPTw5
         yPNyRzBxv0zooRKqXLAx1zhxKxn/x8Yzsxe/Qmz6qGuWDfuJhhM8fe6Gnr7N8yjS9oGs
         GLgF1DsbhVet+QCoCtdvGAYCp42Sfd2jn/3Khx9KQGb7Yf7xYBfWi5IW2vslVg6CtuSj
         X0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643611; x=1763248411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5oO3j4actqzf2xVKKJ0nWDgX3aF/G+cl1rlsWPWa+z8=;
        b=dL7YxS1JZlQNmQjrJyKs3lkjUQS13UPuiRBo8YsbWQQMHTl1N0JRKdaT7KpI8HX/+F
         qKqCiKXrZBmFNrX63lKKP55rAJ8fN2QPPY5Y9GNPniWlKlzbEjn1sTrl06umcSe1HpC2
         AJHqBBYkVR7fzVb8akZ2uM9RePhnEaZ4EWBwhqu+suB2K24J88LAJ4asqpI26eF5Ktxj
         vdIloTz1LcESN2U2/nSwFQDCW0J72+QjY5MsIbBY2LCX9RM8179s6YnAVA00ElEoEHA0
         DLoG5cuioZlsb0aFo9UUIbi5yoztDP89DccPGJUudX7VlZAsM0Bux5q6QPa8idtVTuR7
         mFHg==
X-Forwarded-Encrypted: i=1; AJvYcCWntZl8RHPqF5kngN9EWjGZeWvSfS4EHIuuco+YXbk2UmMYyhCFSfEwQN1/U53aYIdfB7rS1yncLKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKSxTcxG1Ra/6GklLZXf6jj2Ne6QocKJSkpsarLteU2PlSatR
	RA+fatHluBtJJkylGSFwyJD+gtJ0I35uMUN3OLlT/PPweJ0ADvWMX7or8mYkoA==
X-Gm-Gg: ASbGnctzmf2NeqozBLTmRmPKeOfaSRSat490j29gzTdJlJxt66Id8Yts9/TtZQFueVx
	6ikJcfJ3o9d6hnY3sKE2d67ufNfzmq3xTiQif4glduqokKoYR1Xxw4PC0F2Xb3G5rKXd93FTQtN
	TupKL3bX/bEPwNUcQgpfIF+SdMJCnuTdWHn3cye1nMnPvPGbp3XvkphW5s4NQaM8Kr/DMtYiPPs
	GITMTKDiivn7rA8tdsHo4mAvkFkeGglQEwXJrSz7UV8txRAc2cR1/MoiEu9CsBpLAxb/YABtsv6
	AnUto3owhghRo8BOmKi1t9bhDe4Egn08jCFuG2OQpSZuMYZwV2oeK2y/jWvwW3l8ZX/m0SrNm/A
	y8XjPTi0QgMpX9HVbAffHYjeZL8fZuUCxXuLLh6IqP0Y9/l35/iWJjwe6SRJjck3cxlL1q2yhOC
	y6n3ydUQolKS/QYZ9oHL4JN6UAKq38V5zp4p2CJ0Gdg0ojYUtFLGKBdugO/xx2YZFBRtaeUXuRy
	FaK5ITUSHppIepTj5umTAppckyITyOq96gEtiaDLYg=
X-Google-Smtp-Source: AGHT+IGKjmu35eL8DzEjWyR+sT9K1rO2NK/av8+BPsQU60PgD99LUOCuaaHsb7hf+eDzu3/wZf4PEA==
X-Received: by 2002:a05:6402:44c3:b0:63c:1170:656a with SMTP id 4fb4d7f45d1cf-6415e809ff8mr2471765a12.37.1762643611141;
        Sat, 08 Nov 2025 15:13:31 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:29 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 6/7] mmc: meson-mx-sdio: Fix indentation in meson_mx_mmc_irq_thread()
Date: Sun,  9 Nov 2025 00:12:52 +0100
Message-ID: <20251108231253.1641927-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the second line with arguments for dma_unmap_sg() aligned.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 052bcf8f32df..e8b63dc45dd8 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -436,8 +436,7 @@ static irqreturn_t meson_mx_mmc_irq_thread(int irq, void *irq_data)
 
 	if (cmd->data) {
 		dma_unmap_sg(mmc_dev(host->mmc), cmd->data->sg,
-				cmd->data->sg_len,
-				mmc_get_dma_dir(cmd->data));
+			     cmd->data->sg_len, mmc_get_dma_dir(cmd->data));
 
 		cmd->data->bytes_xfered = cmd->data->blksz * cmd->data->blocks;
 	}
-- 
2.51.2

