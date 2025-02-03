Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C81DED52;
	Mon,  3 Feb 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738614884; cv=none; b=gCaL+ddmVtI22mWwcDuxXr3FjSQ505O2aBqwte+2g8uWFu3eCP5EegIfbNgRo7rx/m5HD9Uqw3TgYPvZ43wmiCp5Gn/BgGIkFVDJjrUoHZ8h5tPjCeC2Tgqn5VGYOYKZd4gJXLM4bsVTpxwXWlKTc5XAPfVPJkOSeWtbAVCZyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738614884; c=relaxed/simple;
	bh=EAeSZsEDX1ib5/p7yERGJrswm+LH1jqXTbhe1wcXYGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=biloXJbzzrQObt24Pi+10qf2xNnPTeX2sBCFpwxTnPpNVxeh65fCecENGWAlic9QDv0ev+WQ6W8EsBIawDFouy+0iFItKHrkZOTf1CaSA6IFt0LjcHkLtBAVeHa+K7/GYcjtuoXwc7ynmayjpK7dUzCX5LiFu6NBzdZi+2xquE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=mUHZTKxE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="mUHZTKxE"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E7CC925B82;
	Mon,  3 Feb 2025 21:34:41 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQNzOzCoF0iC; Mon,  3 Feb 2025 21:34:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1738614873; bh=EAeSZsEDX1ib5/p7yERGJrswm+LH1jqXTbhe1wcXYGA=;
	h=From:Subject:Date:To:Cc;
	b=mUHZTKxEiWUANeZOoCR0aFcxv3cj3LwtJpd+uY0biVNj/UOnJCh3E3zyHkWCVlFS2
	 /ytK3ZgYiD2Q9pWq8/BctGn/Xt4g+CtvpPXladyjbG3BQ9RVN/jyjNKjZQvAKFReXQ
	 4cwQmGdTOJYmbFp/ycrfwxb6IcsY3wOuvK0kj6umrY59RcsS6623ZPtSX4J5zxizyi
	 GSr8aLiHTcOQhK59zk+o5+e5ZtL3OL5VC8HO4tLUDo97QbetBc8RNi1Xjseo4Ie38t
	 gJIRcPtB1ktzGxRHxj5W+bUTNjT2pDOLsaJpuS7veSOLDzi7vzsFNCh87J7h2DzvPn
	 pOl+n+q2FNAhA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/3] Introduce DW MMC support for Exynos7870
Date: Tue, 04 Feb 2025 02:04:15 +0530
Message-Id: <20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEcooWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNj3dSKyrz8YnMLcwPd3NxkXXPTpMRkUwvjZAszEyWgpoKi1LTMCrC
 B0bG1tQA3JSOmYAAAAA==
X-Change-ID: 20250203-exynos7870-mmc-75bac583c864
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Sergey Lisov <sleirsgoevy@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738614863; l=1084;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=EAeSZsEDX1ib5/p7yERGJrswm+LH1jqXTbhe1wcXYGA=;
 b=qiCPbp+pIGYnk5pDS2RAVULHu3jjnGqOrQmXwc6zupEtRps4CoZ7nndf2E0DtDP8mWnWtIIlf
 iy01GG24f1MC1WZM0dPSEjWVNI3cxhTcMZNcd01jIK/I9cyyryX0Jzj
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

This series adds support for SMU and non-SMU variants of Exynos7870 DW
MMC controllers.

Some DW MMC controllers require two 32-bit r/w from a 64-bit FIFO,
the series implements that feature as well.

This patch series is a part of Exynos7870 upstreaming.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (1):
      dt-bindings: mmc: samsung,exynos-dw-mshc: add exynos7870 support

Sergey Lisov (2):
      mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
      mmc: dw_mmc: add exynos7870 DW MMC support

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |  2 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 41 +++++++++-
 drivers/mmc/host/dw_mmc.c                          | 94 +++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                          | 27 +++++++
 4 files changed, 161 insertions(+), 3 deletions(-)
---
base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
change-id: 20250203-exynos7870-mmc-75bac583c864

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

