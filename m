Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB8350A37;
	Tue, 24 Mar 2026 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317535; cv=none; b=mAhSJTOF9EzvOiZv1vX/bKVm1ZPPkZvqVfRg74DEiV+pFwT0NIsd+2+kguKZj7msCH4TCPY54oj7sPL9plBH/2yNsS1hrJNtmzJSORjixS5Nc+YLob5r0cqfzrkPekps9hpFxdKKZbbZ5EeiUsI0sY1PVQg4ZA5qFWAOiWR4qDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317535; c=relaxed/simple;
	bh=s+I5YSEbSEp+9lLyO9dsRxjOmbpDSxZpMfJMlwzBGoc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=M1128mI1c4GmJGB2tyOxjtBZNwSYheChvW8pgJcwSXoel8Yb7Q4ngJ+B7OZsQj6RjgLHnla1RnPLMJHnNVi7giJngAgfF7X+lD7cQAoHLpwuMLVy+14OvrbQ+pMtzwXIplykbJ9vNT7iwRtqLrLsFse+/avbLQnXHya9h84BUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 24 Mar
 2026 09:58:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 09:58:50 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v4 0/2] Add AST2700 support for aspeed sdhci
Date: Tue, 24 Mar 2026 09:58:48 +0800
Message-ID: <20260324-sdhci-v4-0-c8c2060ccb5c@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANjvwWkC/22NQQ6CMBBFr0K6tqbTQqGuvIdxQdupdCGQljQaw
 t0tJBqiLt9k3vsziRg8RnIqZhIw+eiHPkN5KIjp2v6G1NvMhDMumQBBo+2Mp1wqK0A5qy2S/Ds
 GdP6xdS7XzJ2P0xCeWzbBev0uJKCMKjDYgjJNK+tzG0dEO6Hpjma4kzWT+F6t3yrPqlAaHJOCS
 dB/VbFT+WdVrKuiqirdOFkC/KjLsrwAX3pCLBUBAAA=
X-Change-ID: 20260313-sdhci-269d319fdbde
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774317530; l=1402;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=s+I5YSEbSEp+9lLyO9dsRxjOmbpDSxZpMfJMlwzBGoc=;
 b=a7xnHWdVNI/krXJBx3hH11kYaVE8muKYxv6Wf3hCjTob81jwypfIeCC2h4DsAuZZvkHziOWLU
 Efiylyt6Vn8AmJChl8js8qr093Quify2cGDRzgJ3gCdQC5E6qgICd7V
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add aspeed sdhci support for AST2700. The AST2700 sdhci
requires an reset. This series updates the binding and driver to
support reset requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v4:
- 2/2 rebase git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
  next branch fix the conflit.
- Link to v3: https://lore.kernel.org/r/20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com

Changes in v3:
- 1/2 Add items list const for ast2700 ast2600 compatible
- 1/2 Move if/then/else block after required: (per example-schema)
- Link to v2: https://lore.kernel.org/r/20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com

Changes in v2:
- 1/2 use items for ast2700 compatible.
- 2/2 use devm_reset_control_get_optional_exclusive_deasserted for
  reset.
- Link to v1: https://lore.kernel.org/r/20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com

---
Ryan Chen (2):
      dt-bindings: mmc: sdhci-of-aspeed: Add AST2700 compatible
      mmc: sdhci-of-aspeed: Handle optional controller reset

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      | 41 +++++++++++++++++-----
 drivers/mmc/host/sdhci-of-aspeed.c                 |  6 ++++
 2 files changed, 39 insertions(+), 8 deletions(-)
---
base-commit: 50d349cb70cdb6db352dec114e6381a31870b4ff
change-id: 20260313-sdhci-269d319fdbde

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

