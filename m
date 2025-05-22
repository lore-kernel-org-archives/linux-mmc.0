Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82247258CC2
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950353; cv=none; b=ty2OtOXNm2zYnaBaqgAVdBAlf/BArMjnYlsKPbmyotc/i1f3TtDsovQ2fyB6hZr2tX3Sh/hIiFfs8Guf3dX+hqNuC0+lsnCAoVpz1k+5sB2G3T6xuhB+TIqt1Jz7RNbmLFZt4MkRyMNYSiT5vaB0HIU/dx6rSAC9d4VSaUio2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950353; c=relaxed/simple;
	bh=DJx/aLS1TGfy8I3D0Cv/JMVu0rnq4KxpL+LBDnwUdg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRJYC3tb8ANSZsFRnwgw5LPLN9ZrZwXwuWiieIYcYMff4JbfQ2rfAoMQJWeE+zsjfUkkJBTHrn2+jNljH4N+mHrRUKEBG9RMMG+lYRwuUFXvgd9cCt+2VkI3pc4IG2DloJ6Sc0LXmjfP+gWgdXsNypV2I8wXPXHVOy2bQwYxqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uax8tqAd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uax8tqAd"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-551eb17123cso8150762e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747950349; x=1748555149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqdIrlhupGwlncjOV9Hzqn7rsNd9R0o91HFcTndTQoE=;
        b=uax8tqAdSDH6AcDsTW3Jet/tWK6kYjcEwI16XOLeAGY9eGxM99vaKpppKhkqzO5Gi6
         FGtEOkIG1F6KtyfVCHx7TTinDMWINqSSQPU97Z6ff7zBlmWT3BPPKYarOMzd8CImUvzu
         bhs0goWC8IX4ZWTUi/GP/yBeURxLU4ixIajhtEeDV5ucU2q0X9MdPIzJdKW6PU5sUlel
         v+Qd4zURLB3Rt2mxJH+wrxeK2H9pQVsVWKyssPJQ8S3b5H5HrmxXKrK1+3aF+G3GTmsj
         NAYLX4yxPy9mjscRpeOLrcVnREcgcXvjRBfKvGX9Nug2juNcsq1MIiKT4AL8GlwwZWcK
         047g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747950349; x=1748555149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqdIrlhupGwlncjOV9Hzqn7rsNd9R0o91HFcTndTQoE=;
        b=rCy5SgSEzri43hqh4ZEqOMuyXo4Uf1EPlP/ybsE4wIyG0cImBnUH/ZocX6my4O479W
         H0WgJWjdVjh17P0yrPlsM4PjKQef2Ri+AtoJlEzL0yOzwoIVd1G/wIJ7Tz7vPENCF0zF
         d7SYn/G6WzAFOn3nfwucpEbGc1nZTOzUxoydBMf0y0TccSTonpe5y9guoBltSeOjHDZb
         oG7rrCWH6anjWNmHKm/6klgtfyXNW6mPolTmZPSdifSMH74VOr9Vg+/vJkKNbREnlvHG
         iM8koqbpqkKSWOtwJkuoRkTbXLFsVK/tvhhCiSPnbBwKaJi7jbzuSeFHkd3upRENlv8n
         oGAg==
X-Forwarded-Encrypted: i=1; AJvYcCVu6S2M7pWaTpEBWAmjA1BIb5t4dTxVm9vm9KCej9Iwdru5XgixyV/KBnLPwXNikHU6Z1LkylXz1y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtIJtfrtYsnW4+1ZNSHee4uy6QkUvbvI76lvXbnMs4VY11MzW
	3vlS9ykjvEosWUBp35EfkI9rrMkQW+RaBoz/2AC6Kv1IO7vp4CXa/1v+Z4DR9GIjRNs=
X-Gm-Gg: ASbGnctHaWIiIz5Ca59+Od97gEEI/lc2iCZsohk+8a8mUH/gAft/fQqoHWiY1zhfxH/
	cVoKBKWkSl5bOgZo3rv+X5ym5bAOA2PZ9RKUNTad8n7fymZTRnAN2XHaVtJJSnzsblxz7FUEllw
	U6m/IdgjVzscGw8iB63wbvvX/wIBFBP5E9PuZYkSRvA3HnTRVF7YMA5ybIAMHOy/AsQzGS+uPhF
	w1WUuIj58DD8HvErt69yCifhZqKJyP5+SNcT35nasgU27OkUoA4NI26cOrStgbM50zNgJbG2/Lx
	CiEwuovRbSfMOcjGfalequDDMMcRhAq6qXUK7u5P2EfXKKvJJ3D1YPSiq3DoqsuriQzrzM4zv/b
	yJqr3nsWQmE7t8SK4Hb9VK/Zy1jPxelke+0SW
X-Google-Smtp-Source: AGHT+IG+1WOzXAzO+qsS1YYWCu4EXbkGcHy3c/2SG1FKBiP2nI4pbnNDQFuWw7TtSiy4ji1kz+G1qQ==
X-Received: by 2002:a05:6512:630e:b0:549:b179:e905 with SMTP id 2adb3069b0e04-550e7197701mr6913914e87.9.1747950349564;
        Thu, 22 May 2025 14:45:49 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551faf6be77sm1739796e87.84.2025.05.22.14.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 14:45:48 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.15-rc8
Date: Thu, 22 May 2025 23:45:46 +0200
Message-ID: <20250522214546.168524-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.15-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15-rc6

for you to fetch changes up to 71c9475b1e2cc4d31370b1b7a328bdfeea5d53b4:

  mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk to am62 compatible (2025-05-19 14:26:12 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci_am654: Fix MMC init failures on am62x boards
 - sdhci-of-dwcmshc: Add PD workaround on RK3576 to avoid hang

----------------------------------------------------------------
Judith Mendez (1):
      mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk to am62 compatible

Nicolas Frattaroli (1):
      mmc: sdhci-of-dwcmshc: add PD workaround on RK3576

 drivers/mmc/host/sdhci-of-dwcmshc.c | 40 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci_am654.c      | 35 +++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)
