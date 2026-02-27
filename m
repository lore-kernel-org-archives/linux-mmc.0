Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507035970F
	for <linux-mmc@vger.kernel.org>; Fri, 27 Feb 2026 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211510; cv=none; b=cyqQcUpHzuZpNJToifMpouckJ6DJUK2N2FTjqOTpaYWxytLV+3KqqKHPOME8eVHkHQABom75Az2e/yGGCyKa6RlP7MmE9V9NaCQVOGFhqz3pFGtqGEZmLyNNa3gQd9kCl/kJ04LhQRIf7GM8fn6/ArEoVFfqbGC1qr/eyWqwHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211510; c=relaxed/simple;
	bh=NmGbhWQxPY4yHYXvIXav3RGKgsjLtzPd2OaIdd3CZdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efI9rmngjw1iHvrzi7TvrulieDly1ZXT1jBtSwo4V3fYSuLGddLbB2KG2HK1jd1dQYI0bZNgXLd2TXfhN+6eW3Xcp9hRVzmtVAbGNKysTFUSSQ42MaPZllMNGg7JsPm/A31++ykF0O2XHGl+J0oZA5+GOmlGLv60woOVRzFzW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SDkETlQi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDkETlQi"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-386b553c70eso28891411fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Feb 2026 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772211506; x=1772816306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9ob/6X/haXupx6RcSExbAaX64hsUZ173Z9pRTc0CRY=;
        b=SDkETlQiUnHZMD/SXByY1exPxsuQjO4j5r1hjPaYPgUexhuz9i6McuaOdh/S5TBSdh
         fpGYUZa+FlaleAYl0emGzugRS6acrae2/Fx0/9uPHONNe/jZIKzU/Mz8m4unXtwE2tAg
         juhcCCyxtqAWXEgOYBuWsbF9+mCJzVR9I77l+7eKYeOExVkn5Qior4Am9ZosQq0SQVsC
         3Rm0Ts9MHkR946+SUVl+ao9W1Og4hu1UdyT15oBdKsS++Gvn3EFw+LAl4+X4YW0//7rn
         HKB6lKDugrgvX1YhA8/orQhzlYstoWNJ7zeaBR36+RuUgyyuEDawkItRzCEOfjyYRm7a
         +xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211506; x=1772816306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9ob/6X/haXupx6RcSExbAaX64hsUZ173Z9pRTc0CRY=;
        b=WZn9v+eW6cgcSp0EQsoDew4zVfNYyFGA6zpJmej56kQAjaIVerPzelG5l0otZs2jwK
         X5xDjLjElXvaWeLaskWrqu+shy+87Bsqz032S5SmZHcWcmIZ2WCcmtoINVcF2329Qxyy
         irqXy47v/MLslJiD38lgHJ/MZvkEzUJSL272nCpZMZ9WJYr5iquBgDwSg7BZhaFo/AMh
         cC21hXKty4cGeVf2do+qsfCOu2tHh2nHzb9iBikC/sCVnknheXRovDY0GpP8PLRZWRzD
         LVGVCM7hk9GpP2Ub3T3jLdmDBBkRPIL32qBVW94bJxkEbaY+g43XaEr42fyR4tr9D/JT
         PDhw==
X-Forwarded-Encrypted: i=1; AJvYcCUZZAXy1Ud7TmEAGqDMgnDp5XfwjfB8ZAKSoqqqDEArUYnq+r05D9ccSDEaUoHuApYR9dAhoNKDMxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9ulIknu8jsnmNSPb6HVTLa4cH9NcTn1u6pVG9ese4CS27KMw
	7FAGSSAAktGpn2fzwIsj6tIspbGH7cV1R4yEpOKuxn/KsFTtvokH4CJatffrcBp4jQYcYZtKFJv
	E/ZMlqI8=
X-Gm-Gg: ATEYQzyMh/YPXvv07w2a5HdtqOzctCvm+72XfZcD9NwSN2BcXPTQ+bWfjpaYsHFhgvN
	uD+2K9Y9tW8EqOfRjN9aQu+RYzsYRZ0dZ/xkJ72ZKY06mi1dlqpU7U5qefRz/CPrSrt386qui6h
	GHgT46VIBuRzb2cixao7b7HZxfelEL9PsFWYSN2l0QnhsQCHcKeQincKoLx7nPLAI5GOD1SAwja
	bVktGPdn9CZDyRfTzRLyfmT5cxmB3d5pr/Q+NIo6cJUPCQWx6IIzt3q+eLl8Q8im5W1H7EoNewR
	NSuIpNqnIuALCyMo8np+DjczPWPEC8OBRSYbQ67XIUZhFVpiRtriAFaELKaRRJQdQJB4SMYx94p
	rLmJUmmAwNWdQ+DjcgDpXSWV264Rwi8LW8YKKHXMMgbTMcGA++/9qLqB+5sH6YmU/JY6W+4EI9z
	3/uHOqjXdRBq3obYyXyoMIH/iONho5/Bt9c2uW1oIWuX1ZOhriz8jI//Q7u1WPVPfje57dzQZf
X-Received: by 2002:a05:651c:4408:20b0:386:eca2:3635 with SMTP id 38308e7fff4ca-389ff13b62emr20394971fa.16.1772211506335;
        Fri, 27 Feb 2026 08:58:26 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1136acaa1sm384383e87.59.2026.02.27.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:58:26 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v7.0-rc2
Date: Fri, 27 Feb 2026 17:58:25 +0100
Message-ID: <20260227165825.236709-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v7.0-rc2.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1

for you to fetch changes up to 901084c51a0a8fb42a3f37d2e9c62083c495f824:

  mmc: core: Avoid bitfield RMW for claim/retune flags (2026-02-23 13:45:50 +0100)

----------------------------------------------------------------
MMC core:
 - Avoid bitfield RMW for claim/retune flags

MMC host:
 - dw_mmc-rockchip: Fix runtime PM support for internal phase support
 - mmci: Fix device_node reference leak in of_get_dml_pipe_index()
 - sdhci-brcmstb: Use correct register offset for V1 pin_sel restore

----------------------------------------------------------------
Felix Gu (1):
      mmc: mmci: Fix device_node reference leak in of_get_dml_pipe_index()

Kamal Dasu (1):
      mmc: sdhci-brcmstb: use correct register offset for V1 pin_sel restore

Penghe Geng (1):
      mmc: core: Avoid bitfield RMW for claim/retune flags

Shawn Lin (1):
      mmc: dw_mmc-rockchip: Fix runtime PM support for internal phase support

 drivers/mmc/host/dw_mmc-rockchip.c | 38 +++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/mmci_qcom_dml.c   |  1 +
 drivers/mmc/host/sdhci-brcmstb.c   |  2 +-
 include/linux/mmc/host.h           |  9 +++++----
 4 files changed, 44 insertions(+), 6 deletions(-)
