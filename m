Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80635286400
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648957; cv=none; b=RkpJ20u1QNHEASL55bUXiPemjO8ob8Whh/x7HAqKc0R47dxdoxHhUSJA6vw+RdABaw+6wLROSwUUlltdcutz2T+v43+pLY406L5agvJWVDBQvv9jPD9JaaL0tlAbTdYpXBltgiDvU+WKa8QPI4HNXJqR/TQEySCyDSni2A/9y5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648957; c=relaxed/simple;
	bh=DIn5uBplj/K4tReHwcY2FvfDUOWgc0EzkOC80zJ7+9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Khd7Hk5oDcLIvZ5KEdS0mqqbg0iWqNB/zV6O4X9pA+YFYhWIyepHI0VIltIFeQmLWFZqNakCYeRxFC4nG9uP4puLzqr+4EmnmYM2XQi/0PgxJLrVcKKMyekT6mGqO3LQXUKnr8x6pXiTaB5dkwZ51G/18aAJgMrQN3PlSPG9APk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aXomHO9N; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXomHO9N"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5957c929a5eso1291437e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 06:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763648952; x=1764253752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+udg1Phe8ytM+X9EsegWpxoPPNTufJVhADOIRL6xm4k=;
        b=aXomHO9N78ZlQ3RPAIU9vtn+fC6gcJa4EZ3WO0mk/gTCZJ4Q74WcQzIu026gf3f2fe
         YIcueJBM2RUYR586gEbUPptf9bssGddUoy94Nq/n8LArYT3yrUxwLn6K2fFn9AdZrvm8
         s9f9vEge5qkxUBYCoGSyN8d0UHGfFyvnRs3L4mAQa6bGGbVs6EXZhn5AEG+obydaDIQV
         7z+CD0aLMhVq4m7x+PJ3BU86MbROh1KKJ8wJ40/Q0I+E0WAHK28JEM7tPddufW326qAR
         uvlbCY6KLAYnh++JBbe+HkzAQTSqbTvMFUcnBxE1AewubrflIDncDCRq7Qgr63rbzQgM
         tUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648952; x=1764253752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+udg1Phe8ytM+X9EsegWpxoPPNTufJVhADOIRL6xm4k=;
        b=jHm/tVKob33hVwFJSY6gUek6S/7m5FMaAZi5Cf3mEnvviqLrTG30aVApiIEmEkDA6g
         8H02bAGwej6gpzh8+DiADm/pjmGcpmlgfdbTJBRGxVVu11WRl1fwgeMRQ/hsF+1ew136
         pcyqp/u0QMUKYefEMYxHKjquPOROXD7YA9yKyWZZkROEGMrhPALw50lhrbXDEYXcqCdl
         7zsooXUv3krjZAKEFhDr98vROJf8MMTxHTEvZdMT6C6T87/kp39jszMAJUraGjp+hU+S
         /lvrAfNyMflXe0DWW6+ncH27KU5P0rylWG/gA0c4aawixiqBeNifrbNwP39fuDVpoUq3
         ZUKA==
X-Gm-Message-State: AOJu0Yw3hSNJqErINnk4xG8D1Qr5WqeJJTqU9H0I/qdNi2dZ9fYWmRH7
	Rg5V99EzTU3xXHw4lzL1KVaUx5282lBgY4GSS0o2EDnn1DVonYwWbxpj4U1fjkiKFRSQIiwNyay
	r8Hgz
X-Gm-Gg: ASbGncu2vS9341rPWgVlusGzDutvtTsG9iBM2G/D5alox/yEo7Zu82bGyahzwi+uHPn
	FYLRmfb3HsFAcriqnAn6AxRU8kAQDm/Oiu1kMnkGOzbpXYcDaduUyk7peDj3x79/oNSlw+KyBSC
	XLYZSCTrUMY0RBSRqc9ZSjTa7Tw7GIGLoAWhH8VxYUO5Y7JZiymYmJeM3+rj9B19IQsaMNtHtGO
	Snx0yqlQRWmiQXbnQBZPPw+0nmWEHOBOoKsgO/0gblJFod+fyrrf/IhWIndPhEUp0mwD9eLoLAS
	5X7gvfOeTBTX5C5l/dLa6eP8gC7L2xYxwG38NzE+HoTlRbOCKQv5hESILd7Kh0GbyBeBpdR+gXv
	z0pQZF+fPEIUdDQJQQZyOUXcTG2H5z4oq18SY5Jq8jHBAxqdDUw04SGPkr1iFnIU+hD6CZwwClZ
	AGb55IPAlTY9bHeMuGqZZLuuCrOI2izykqCAFH3rAO8Y/QElN0K+EKNOP+Ft1+
X-Google-Smtp-Source: AGHT+IEQKi/3yNwd4V56q6ztyfsUN5tvH4wf7jLYDmIzqIS/ulLV0u7RHvrSDu29yIV05s9jQ+MLXQ==
X-Received: by 2002:a05:6512:b1d:b0:594:27c6:a23 with SMTP id 2adb3069b0e04-5969e2c6eccmr989896e87.15.1763648951897;
        Thu, 20 Nov 2025 06:29:11 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db39852sm737559e87.0.2025.11.20.06.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:29:11 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	William Qiu <william.qiu@starfivetech.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Shawn Lin as co-maintainer for dw_mmc drivers
Date: Thu, 20 Nov 2025 15:29:02 +0100
Message-ID: <20251120142902.252513-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shawn offered to help with the Synposys Designware MMC/SD/SDIO drivers,
let's add him as a co-maintainer.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..64cb7c0c4ee2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24930,6 +24930,7 @@ F:	include/linux/soc/amd/isp4_misc.h
 
 SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
 M:	Jaehoon Chung <jh80.chung@samsung.com>
+M:	Shawn Lin <shawn.lin@rock-chips.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/dw_mmc*
-- 
2.43.0

