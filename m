Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535A78F2B
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038970; cv=none; b=Ni6YAI2ptZQYK4mdxEX5ufpivEgvA59SN4NhCJdiYITNqFtjagv43nvu1m/ro8iixxMgJ9rFwTAAFWImKxu9Gq1o17ZOL23XVfRrzgKiYEUFrlhPy3P7NdEZbNUw8uVwDMoJsU7s6UNGv42L5iRf6vZAvNhdb5KPF33sAP/mmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038970; c=relaxed/simple;
	bh=XVIK6P3cDh2RmjY5FPX61raR0X7pooRB+f/SKenLnGU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g5fmfcWRMSpg/QG0FLRh2EVQ5g0iTFiq7ia+zj1KWiqc+CPz26+ecavFc9q5fw2OfTANNmm4NJwKYIeUfvMxYbmTcLoYx5SWrPIWl3DAzEkt/xFkO0WEgc2gpv26GQ4Gw8K0snoWGQ3lXqdE6moFQ5LS/6YqU0Q+w7ruYzKga0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S2lDYYNx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2lDYYNx"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso594692f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737038966; x=1737643766; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNrjqctMKz1qgAHIHsA7Z6UwsnVoB9RzOyu8rn1dpcM=;
        b=S2lDYYNx34IPRt14H45xXsjPe56VH+HhQ6g50uuguRS/24/LQakvFKBZcq/KoBaL50
         queYhgcLnNF1d1Yv143wxfyOK2ZjiEWGfcShK9frF+h+amlAmePw9OsBotlkSB7HXk8q
         frt/qCLxP1o7dxCorL6sMLmGqT1BNIV0ugP7AGXNUmxxdeq98WrPNpW+RtjF3IUnX/5X
         hFQMEabkOMkAOO1S7KQu1YdWE3pmI0IJOBTwgLw2ycZxNAGl3vjWYsJSBH8kSJ0qrdXy
         RPK6n2cp04zg6UeLDJ5PnrzZWm0btHyjWL6otZIdaK1snki28n80fDK1F2q4Q8fcVu+v
         mFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038966; x=1737643766;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNrjqctMKz1qgAHIHsA7Z6UwsnVoB9RzOyu8rn1dpcM=;
        b=qPCh928qM8hVdGG1v+0yVWUNOJslk2tfKM4D2Hrs497g9mXyadtwfF803llOGehaD+
         53+NNYdzYXw2/KzoJ7+vKe0zuqdIahMS90BRLnyrQy2vLhePijKK5/WeAOFGoDRJPOSP
         L/7br1w139EU2qAQBpdRE1+VMXq1jL69dnl8JWiV/QN43JpFlo3u5cuIBygCZOqNKXRa
         xwCdOVrzGDwHPIVTTtOTOQTa8e9H6S38wFSF/++KdgnOGNsbqkLywHpsD4qdrEBfoOSf
         ApNH10TC0GxVndXxT/+WXSmg0EWE1G2zsFnotKyOaCdncTlDvTl1NAiPGCzVAajwwFyv
         F8qA==
X-Forwarded-Encrypted: i=1; AJvYcCU+8l3fCmpaOi6jDqXEiBRngX9F/JGNYW/uA8HmILB7yBJQGvUJlikgRvVXI4AdfGghPWRZx8/b7BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIiw3DIFut6Gkz/c3hKl0MG1JZp4LMysArjOh2wQfqGzLzAby8
	8q9TbU5biSAWARPeriGOKs3gHPsbAQ90enrIJtjqCD+G5SRLkI6N3Mi5JtmCHFg=
X-Gm-Gg: ASbGncsp2UL8cBloo0VnuD4q8O8tEcxcEjsTwsrEpdctPBrSfhh2Ulpov235pjhZM0M
	3k/8dBvV0pISLfBE4p23T3WdPnG90N4qOzwNI+UWEC5lI0ElDgTdvbRBaed/+cxqAwVah3BvnSy
	bBfwcJh0svr6n3UeXo38rwm0xCo0QcgZTlvsQY/0uu+txqisCHaNfklvPYkKceEHLuyNFvsPtgX
	rri3aHouuEaAS0DPBjxNnO1sJ1wz5RnOSca88BMN+lXnqNotz2MAmIH+01Dej2jZhRBg+YjM5sK
	W0LCWZkfWZ1uWwjf7a563EKMWcp7pYWnELeq
X-Google-Smtp-Source: AGHT+IHl1kBetyaeOjNXShWAh0tzmG4VVpCeXqjWskMJPe10ftzlUB/8CSFuRx56YA1k5IbFK1rVNg==
X-Received: by 2002:a5d:64cb:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-38a872d2a11mr30493102f8f.3.1737038966300;
        Thu, 16 Jan 2025 06:49:26 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm70310f8f.10.2025.01.16.06.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:49:25 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/4] soc: qcom: ice: fix dev reference leaked through
 of_qcom_ice_get
Date: Thu, 16 Jan 2025 14:49:04 +0000
Message-Id: <20250116-qcom-ice-fix-dev-leak-v1-0-84d937683790@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGAciWcC/x2MWwqAIBAArxL73YJGBnWV6MPHWktvBQmkuyd9D
 sNMhkiBKcJQZQiUOPJ5FJB1BXbRx0zIrjA0olFCSoG3PXdkS+j5QUcJN9IrGuO96nXftd5Aaa9
 Axf/fcXrfD46tawpnAAAA
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737038965; l=1305;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=XVIK6P3cDh2RmjY5FPX61raR0X7pooRB+f/SKenLnGU=;
 b=yULsW9f8ssEvEIwNMrzYj/f7k5qacJ3+E77jHSGJ2rn5hN6wtSPSVE4x7pLEBB2tiVmrN95Xp
 hz0cCTM8VKID360TwWCYa3w3quENHLTqwgc4qE9guKQZPT2HIFL4Jcz
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Hi!

I was recently pointed to this driver for an example on how consumers
can get a pointer to the supplier's driver data and I noticed a leak.

Callers of of_qcom_ice_get() leak the device reference taken by
of_find_device_by_node(). Introduce devm variant for of_qcom_ice_get()
to spare consumers of an extra call to put the dev reference.

This set touches mmc and scsi subsystems. Since the fix is trivial for
them, I'd suggest taking everything through the SoC tree with Acked-by
tags if people consider this useful. Thanks!

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (4):
      soc: qcom: ice: introduce devm_of_qcom_ice_get
      mmc: sdhci-msm: fix dev reference leaked through of_qcom_ice_get
      scsi: ufs: qcom: fix dev reference leaked through of_qcom_ice_get
      soc: qcom: ice: make of_qcom_ice_get() static

 drivers/mmc/host/sdhci-msm.c |  2 +-
 drivers/soc/qcom/ice.c       | 37 +++++++++++++++++++++++++++++++++++--
 drivers/ufs/host/ufs-qcom.c  |  2 +-
 include/soc/qcom/ice.h       |  3 ++-
 4 files changed, 39 insertions(+), 5 deletions(-)
---
base-commit: b323d8e7bc03d27dec646bfdccb7d1a92411f189
change-id: 20250110-qcom-ice-fix-dev-leak-bbff59a964fb

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

