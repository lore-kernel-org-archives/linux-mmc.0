Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0763F6C22
	for <linux-mmc@vger.kernel.org>; Thu, 13 Aug 2026 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599266; cv=none; b=SH3PjBD29jKAzJww0XEQei/zzE9SREvaDdKqyDZPkbR815L9JuHtTQzMxTn+Zi/e3oN5aJQ5y9fOTFLwtKnxMo3/Pc1mx/IiE7y8mOQ3yWE4bjk9TzcMlOfSMPWeagOq/VNlhrsM6PPs91MhWCgEs0Sd3/MzZVbUwazVtNo2h1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599266; c=relaxed/simple;
	bh=ikPR/Ibwd8ndAW6bzvAvqytJfjTbiBz9OeekzVrRU+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7hbMpc3TU8FZBjEjVXiEHwWhdHV92q39sNh3ETOV/Vjcg5h5/ADvOBYxgDP3EDgLGh8gZIlHzUbGP9ChvGql/EiWvyeUUhPSuLzDLMvIjRbz+CAZhCqOqtVJUVNGzPy4Mh1xFkV/WWU9HUwDmTmYnCIOP/ZM7pucn10LR01PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmvEz2Qd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmvEz2Qd"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2060865a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 22:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786599261; x=1787204061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lh941E03WqQoOdzW0XPuu5W0k5Y6sQxubyIZa23gmJo=;
        b=jmvEz2QdhYDPkqiWWOm0Jh/1BIVzWvUtNISDFEmsW6imp88DPPIQqZFqC8+O9vpLXW
         qa3HKLzGAI8MWPJDuM6YykzkXafva3qA6JWQlX3evlZnIh+wDnIpS1CPlVd9w+s5G6aK
         sdqpBxR+s4WMs8TJP5GaYSScTURaMgsTb3yMOMVJRwjEziKnpS36l7Qrx/gmO+UF7Guo
         jDLJRsALWpIHvYc85aEViToljAdiA7eDgk2l3OZzl6EnuaXfQMYBS47SAdxbHkrv2ro7
         1OUQ22I1twZ0mAlt8EqNoVhCwEFqdyeFYPVhSwVb1RLksu7Tfq3rx1HVtCcgbOo2P8Xg
         7LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599261; x=1787204061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lh941E03WqQoOdzW0XPuu5W0k5Y6sQxubyIZa23gmJo=;
        b=Nu42UO4zLwiKvYrd+VndBHz5A3zTuzuc3n+KmOrriHqD51FLjA2VOl+VvZ0aig3Hww
         wBKjQrx6RyneyD03wwMtWbePuXzO+V2JjVek4Yq0cn0rEILh7W/GNMGMdFUiGqzj3xn4
         xkBghq9muqr3/lZYp15pu4DZL6a8iDhuhpbULQ1KfCOI9qskDoAq0NguWQx3cvFEpGBQ
         3cynTLb+kbjX1XjKVWm/UcU2C6uGy5rkHUnkrknTfUrDFckBzTI6bD6sXG2siqKxvBOK
         JAwQ+WT38SKETbpESP59yITztLX97lId9dcPUZFnn1iaQc1EbA2MvNIfX2fkq3UhzOb1
         jtBw==
X-Forwarded-Encrypted: i=1; AHgh+RoinimUJYHZJLGgT0Xz4UGGmB70zO7RlhzDi3mX0njKlNR6nbeg0AkPIsVyNKzBQcP14p/PuSXrdF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3x/SDxSrcD4wPpEA22JqtjYXQ9T8iukK6vJY1KeUiSUcO/Ph5
	SHlMpynxRJXFzcXN8h7WZJR2Q6YBeOkFUDd/7vM+IZu0E6vry0kVQcUm
X-Gm-Gg: AR+sD11j8pBsNb01P/hzULZbXX84MNPMN9qut1+LbUG25jw8sBDOiEoz73ygkWzclM+
	f1F85W6bDap1I1J67y6+XituHJMDngIiw6rt+iJelgeI5et0IuaOn8FXoAVobFWE4LQt7V9QFQy
	IA8Fy4n9t5enlXFjeUiHTF7SzHvOv0oTVO9lqZrlcyUV3qFf1rtFXPGTTq7R5PyO9uYG217x4Mb
	z/5Fb6AVa93ciqSXE1YLvbwYOERNLG3HAghHE3UQdxdIGaCkAih/LnKqZcHrGY7KWNYIc9HzWXs
	mNv3zoHejjY6952BYrjp6iX2Xr8LXL+r9HtMe3PrEfXgQiouNjdEGMkTpZymhgTvlnc2ySsy2gv
	aBM6SP6u78/v4EYXvZ9+Cv/RSaXJRq/uRSmWrcNCZ17kZG5V6sU2nGgoz7M/IIPVIRiTedDAUy2
	fpZCaifSllSCnE3vLqIVSHzlyu1JX38znfyyshQFbPSNQzigf9ieC0XpRFmPOwI8ofGvBC8vwE2
	QRUyRKROgz9pkvxL0Q4TzSY8CbekBIJA5/YKeqLDRUXWEksjZ1WHF4ifvJvkFz7bgNTykg6D0uw
	QVU9cr68fYgEiz4=
X-Received: by 2002:a17:90a:d647:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3931e04a995mr4154302a91.8.1786599260750;
        Wed, 12 Aug 2026 22:34:20 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d872ec5sm594734a91.0.2026.08.12.22.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:34:20 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 0/3] mmc: Handle errors from optional IRQ lookup
Date: Thu, 13 Aug 2026 12:34:01 +0700
Message-ID: <20260813053404.21553-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series improves error handling for optional IRQ lookups in several
MMC drivers.

I noticed that mmc: litex_mmc handles the return value from
platform_get_irq_optional() correctly, distinguishing the case where an
optional IRQ is not available from other errors. This series follows the
same approach in the affected drivers.

Changes in v2:
 - Use parse_fail for proper cleanup on IRQ lookup errors.
 - Initialize cd_irq to -ENXIO.

Best regards,
Phuc

bui duc phuc (3):
  mmc: meson-gx: Handle errors from optional IRQ lookup
  mmc: davinci: Handle errors from optional IRQ lookup
  mmc: davinci: Handle optional IRQ return value correctly

 drivers/mmc/host/davinci_mmc.c  | 6 +++++-
 drivers/mmc/host/meson-gx-mmc.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.43.0

