Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055472621;
	Mon, 23 Mar 2026 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231638; cv=none; b=Z2RSYNgxiJD1JtVXJ3wDB2vVY99dNAodKS6AJWbEuZhPThHFQ41sC7hUuehtFhKTR5tL4mqRUa3ikyrz4FUfqjgX3dEs2f3nBGy+hmyIjQciqqCGIghPqxV7kzK7Xk/E5FNVvtD/fgnZRwbdoUz612bpj6jeZE8oyiOlOptAZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231638; c=relaxed/simple;
	bh=uo2bg2NUBtc2eG09kK4x0w8IEuMmJWwOMwtRMs1f0gw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=arvbpnacvVNKeREVfXKQ/VUdUSRDQAKVGdgIDmJjNBQpdULP3yQQsu0sIA8atm9m4obpPn3B0izxZk2maIZbQhSKvphliWo1wqJFYsEizm+zbYffRGaJuoHoOU96KTgI/2++5HhjXU5XPas/bZf1DEvmhblxVgEGYsyJUKC5/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 23 Mar
 2026 10:07:07 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 10:07:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v3 0/2] Add AST2700 support for aspeed sdhci
Date: Mon, 23 Mar 2026 10:07:06 +0800
Message-ID: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqgwGkC/2WMQQrCMBBFr1JmbSSTQGpceQ9xkSZTMwvbkpSgl
 N7dtCCILt/nv7dApsSU4dwskKhw5nGooA8N+OiGOwkOlUFJZaRGLXKInoUyNmi0fegCQf1OiXp
 +7p3rrXLkPI/ptWcLbutvoaCQwqInh9afnGkvLk9EYSYfj358wJYp6lttP6qqqrYd9tJoabD7U
 9d1fQPxWzSv2gAAAA==
X-Change-ID: 20260313-sdhci-269d319fdbde
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774231627; l=1190;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=uo2bg2NUBtc2eG09kK4x0w8IEuMmJWwOMwtRMs1f0gw=;
 b=DOxpUJhUWPvZiZnyDHwvUlKbEHWZ0XJsLkgoCaw4ZSon8wUAM+MOZJN6bpCF2VGLLUD6Fo0EB
 1PAoHFwvhWfC00P66r4r+mBQXAlOCRsZE8HrwDEFMHSi2939qpxPv4e
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add aspeed sdhci support for AST2700. The AST2700 sdhci
requires an reset. This series updates the binding and driver to
support reset requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
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
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-sdhci-269d319fdbde

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

