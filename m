Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1117B516;
	Mon, 30 Sep 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736563; cv=none; b=MVnqwM6ZHPAdyZMu57oIBxBb7YpC6b/PpASS3/PO6utRVkY1W6VFbwFTsdhblnsBTpBNeFrEvZiMLz+2tUUyKW3Q8pQbYJJB4FJpPB/ygX7Yeid9d5IRaDbCUwpZwfQwaf3KHRtlHmv2waxxvgvf12TUJiaud2CPy5ZnRfGRtnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736563; c=relaxed/simple;
	bh=Qqh/hGu2mFPMEXD/hLAjyaD03WXmExxiqqz+q1V/oDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WM3hDQQIApBuaPVl7lZy3A8t1mRLzd36W7xyhhyebKah2IURYJCIZO398iCIpFggD/Wq+WrDqjD1RIdvFzH7aSx9xHkJD8QREqgF9ug5JpQnKhZ29jALHnWrNNdgasUdyTEXq1ucUwW+bNpy0z8qozHiv+Orqve7UsuGY9NMBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA1pZUsE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA1pZUsE"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7179069d029so3495208b3a.2;
        Mon, 30 Sep 2024 15:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736562; x=1728341362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xszBDXhCdb0aB17XDm2OeZTEXlfiZ1uBmMn3tuJfbM=;
        b=mA1pZUsECBdUA+TxPbbjl5y6J8R4kgU7Ffa7aprciKsZ35JgX1lW1OWPbJtsnp/GMY
         mC6/iVOELbvRUQamcj5wyPMetdUbrAZL/HSRfKXs7B2dXMpaaACUX8ICWCC81+ud3iIn
         DrMhTZ4CM2GeXpCHW7K044xZlZTUExY8mE76DvcicCM7waCZRMgT/5YcNhX98ZQLRDXP
         A8XYWeo16mBzI7nLcv/L1VdgUe+5bzMsXVsHVuNoi1+7nmroqnAre+I13x4bV5e12LrM
         8sv2U3xlp+xmSvG43vsMKHBsSDOCnJEKcWDC+PeX0LhYxpYgmi7GjVmZhXmHjrnkl6cJ
         wiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736562; x=1728341362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xszBDXhCdb0aB17XDm2OeZTEXlfiZ1uBmMn3tuJfbM=;
        b=v77jhQ62rYBT2tSVbj1HyTIdlq9mdglHFF/g6X5Q/jg5YUwsE6R85in661qUy1CDfq
         rJ9pWoJHetRdGw8AukrT4QhvOTnpADn9DA7MzPKFUzeid2JcHBW0B28IciPuw0XDMDsC
         XGyY6XUPGSXGy2A61FfoWsFbf3AI2l8dFTSEYzoC+8lNgNaQahOWuNo5Xk8jALbjAoDX
         ZmhPoFGdFaK+sllBANIs1owjrU7xzS9ESzd2UiLqhE+KveyMBgrytG2gfOgARkCTtlIM
         eGwU1/kd+e6slEPFE4xb3WJ2mTZ0bmjXhu1lVL4yTHAz+EwyMkkretO4UQFfdEUNACvn
         EIJA==
X-Forwarded-Encrypted: i=1; AJvYcCWR5EdmeGt80bxNgNPWRXvHYghiy9fp6El2+1ANr3j64Q3qrxItbmvrun3jqsCzxJi51lluuhnkGM2uAVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfGziqkd3iKwEEHIPeIlPWrdwBcBBDcE6HWl9fCcBTpZHZAZy
	l9ljgMcWZIZdf1OazUHWpsLzQV6aq0vm4e4VeTbMJCnAaT+sQMTZ30EdjGdG
X-Google-Smtp-Source: AGHT+IEf4AX2/OJSd2OKQmIQAQNVzsNBaD7ptWjOXjS3029g3K4oYPIoj4Pii6mnziS2Ebog8LIKTg==
X-Received: by 2002:a05:6a20:d805:b0:1cf:4d4e:532b with SMTP id adf61e73a8af0-1d4fa806e2dmr18891455637.43.1727736561727;
        Mon, 30 Sep 2024 15:49:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b391bsm7029528a12.22.2024.09.30.15.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:49:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 0/3] mmc: mtk-sd: add some devm
Date: Mon, 30 Sep 2024 15:49:16 -0700
Message-ID: <20240930224919.355359-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the code. Also a bugfix with devm_clk_get_optional.

Rosen Penev (3):
  mmc: mtk-sd: use devm_mmc_alloc_host
  mmc: mtd-sd: use devm_platform_ioremap_resource
  mmc: mtk-sd: fix devm_clk_get_optional usage

 drivers/mmc/host/mtk-sd.c | 70 ++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

-- 
2.46.2

