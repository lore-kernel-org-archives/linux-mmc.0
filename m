Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817042E92D9;
	Fri, 31 Oct 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926318; cv=none; b=VWvzjuwbysoXaNUCU/CW2ibsmRL1o43/U/ruBarkXIv/FyzM+UCWZbYNb9zeVq55ZUaJBFN/tEyXrlRaofT3Z0RctUOYlrOapZXJt8t0WNU62Tc7LJMhdMfubk/ND/1Ia1U5aN5VpiBAaBqbtXkm3tSNaUeB+6F0QIPtLnITvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926318; c=relaxed/simple;
	bh=cJhczTAYgsx2TDxNRRHHAOrXQABsbREMRC2Y2BkDELM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QMnTMvgjqtXdHtJZFucs1YPSc08lFBcYTG3/kjnZPGtcSurKw16G6OZjMj3n59OBrHyj4LalzP0NrZgSS/MqBjAst3buuwlkqaVD/c/eHex5KqdK6AMF1dqRpV1WlhOXwRBTpP1vaYVA2Q5u8VpeIhHxv+IFoE3fWVVeeKZbAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=URXLoNOY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="URXLoNOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761926308;
	bh=cJhczTAYgsx2TDxNRRHHAOrXQABsbREMRC2Y2BkDELM=;
	h=From:Subject:Date:To:Cc:From;
	b=URXLoNOYWGU0QgfiLlt4mvTUdGeIu3uthu4N1AY7CNi74FLph6gsIqAM0LLRsjIDx
	 S/ZfdvzQhnOKMeEtpth9vZ1Br/cRFu8uXrPqj4eqcu7X8anhgfRirm4decBd4aL1hP
	 m4FC4jFKVUsDKwdm/1cdiJIPSFqDetapJzZtiQ0v21ap4I5HSqDSAmZ/sC24Q0CoZR
	 xLRb5jKm2JvZFJgVCkIl7ajvkpksyAdfW8rpEL2OFyqoVvLvD1XHubKgRu1bR6CZui
	 j9jGc/h5oRYVtpjMiH7/iLyIsJTB1OPwwfpVyUyqveTWuSxEc1QNtpnm0xO4/qlXUq
	 alHy0XdJB6tDw==
Received: from jupiter.universe (dyndsl-091-248-209-065.ewe-ip-backbone.de [91.248.209.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 81E0617E1396;
	Fri, 31 Oct 2025 16:58:28 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 17C07480044; Fri, 31 Oct 2025 16:58:28 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/2] mmc: sdhci-of-dwcmshc: Add command queue support
 for Rockchip SOCs
Date: Fri, 31 Oct 2025 16:58:22 +0100
Message-Id: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7cBGkC/42NTQ6CMBBGr0K6dkxb/F95D8OiHQaZCExtkWgId
 7dyApfvJd/7ZpUoMiV1KWYVaeLEMmSwm0Jh64Y7AdeZldV2b7TZQRR8YMsBqO8R8EmQXiFIHKE
 86to7b83BlirvQ6SG32v7VmVuOY0SP+vVZH72n+pkQMPZnBpd1qTRmytK1zkv0W1RelUty/IFz
 4pmZsYAAAA=
X-Change-ID: 20251014-rockchip-emmc-cqe-support-370dbab21623
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=cJhczTAYgsx2TDxNRRHHAOrXQABsbREMRC2Y2BkDELM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkE3KNTzwa5DPlEUuhutOzhncvnKuSQleAW6
 MoCohIu4ZgwuIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpBNyjAAoJENju1/PI
 O/qa7hEP/0Tw6Mo0PI5hSxdRpDkGxO/gGyN1IKDH/G25H6NCj6/iWXXgW6hdK8GEEAN3mo7eqe5
 DEnwCnchBKz64WKHWkEiZcD7GvHHspQ4GDjP93p9uN3NvCo72aNJBZejAGWv7lD1jlIfpFqGK7f
 MOvDWfdjWCWmqqPhJik1yu8QEgCgK0HefBvkm8b5WRj4BNioMHJ12SPc0iUfwlON80Yn3KNvEhK
 qxYGCITpzu8fxnMCi/7WN39Z1ru1n9WPHc7vQjf5aZpswcxlDfrqDsVU2HaSXg37e0oBI6UvZOW
 stksSymsltUPsrbwYlqFIti7sakYZRvBk2t7/wcWPlZp17Rd6BZzntN4IUUX+lLc4cVPJs0m2XM
 mz5mnEuYtVTrVCuYXQAXVHXWmkkKfzP066o/1vylyxzG5AgvD5A1rRhQ3ItISq1Cg3TOZzNUjnJ
 5lKXJJGEjd1UbmZluIWcwajXihtCJ5Sb+W4Nzo7tbNeUChkJEGa965maGk6Ary3h2nKBvOzSpR3
 MknBpJpNdHiB8tJwXZG0GPrIa92zds4R6fwoA/D8savq6JJo7IiTSKNPL9OYvhPQX4PYd8q+Nvj
 1+CovJwslL0av3mH2S+rOMeOH5W0WGN4N2s9DlvIWBo0GMD9iXRlberaeGd9EIe+uJ8lMZn6Tho
 QzxVsLRWhMka0jYCitGMsTg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Right now at least the recent Rockchip SoCs do not support system
suspend with the mainline kernel. I'm currently looking into
improving support for the RK3576 platform.

On the Sige5 one of the issues is the eMMC controller, which fails
to suspend when trying to disable CQE support. While investigating
I found a missing Rockchip quirk in the Rockchip kernel, which is
needed for CQE. Since the RK3576 DT has been upstreamed with the
'supports-cqe' property (RK3588 does not yet have it), we run into
this problem for that platform.

A simple workaround would be to drop the 'supports-cqe' property,
but DT is supposed to describe hardware and the hardware does
support CQE. Thus let's add proper support instead, which also
allows adding the flag for RK3588. IMHO the patch seems a bit
intrusive for backporting, so it might be sensible to drop
'supports-cqe' there instead. Thus I have not added any stable
tags.

Note, that there are more suspend related problems on the platform,
this is just fixing some parts :)

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20251014-rockchip-emmc-cqe-support-v1-0-918f03de0cb1@collabora.com
- rename rk35xx_sdhci_cqe_disabled to rk35xx_sdhci_cqe_disable
- fix device-tree typo in commit message
- drop duplicated DWCMSHC_SDHCI_CQE_TRNS_MODE setting
- use pre_enable/post_disable to avoid manually calling cqe_wait_for_idle()
  before accessing CQHCI_ENABLE bit

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (2):
      mmc: sdhci-of-dwcmshc: Add command queue support for rockchip SOCs
      arm64: dts: rockchip: add eMMC CQE support for rk3588

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 93 ++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 3 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-rockchip-emmc-cqe-support-370dbab21623

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

