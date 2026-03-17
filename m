Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16D37FF6D;
	Tue, 17 Mar 2026 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773727013; cv=none; b=XvMw3HOj2GjQPzXfdzDBx2a9LtdG388aPzLnT/RWlmLZDShTpq33xJqz+m8HXeDa0sU9CERsNrwMGVw2EZ2deum+J7TkMvIX132rWongDaIsQJBd6Ut/JbD3sNQAMndVe55a92sZTUsCCbuV8IsXxGzEWHfbEHPKl6QcboTrIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773727013; c=relaxed/simple;
	bh=gW4uZHnAnJisSYc/KOIrw22KZpU+AhjS9RzlefavDzA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=aPxXt9k55X+0kMdbkiG3o+HKqBHyoRDiLVQ0WO0yttWIR3wtjFHwx8j8za61zSOSIwxHkc16B62BfiUOUch7Tt2AzBZtMXKFyInLlIJrpAGjLCe/VWO01fUy6yMVABkNna6MzypgmWurWv3ZN1sDr4vbIqUcWvEEAHVkJZoH4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 17 Mar
 2026 13:56:42 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 17 Mar 2026 13:56:42 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v2 0/2] Add AST2700 support for aspeed sdhci
Date: Tue, 17 Mar 2026 13:56:41 +0800
Message-ID: <20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABntuGkC/13MQQ7CIBCF4as0sxbDQILiyns0XSBMZRaWBhqia
 bi72KXL/+Xl26FQZipwG3bIVLlwWnqo0wA+uuVJgkNvUFIZqVGLEqJnoYwNGu0cHoGgf9dMM78
 PZ5x6Ry5byp+Drfhb/4WKQgqLnhxaf3XmcndlJQob+Xj26QVTa+0LGSLq2Z8AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773727002; l=966;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=gW4uZHnAnJisSYc/KOIrw22KZpU+AhjS9RzlefavDzA=;
 b=uTbjtNoFDdzN6vBYxAPYMvALUaSypnwqYJgAOXy6A8x794z0nSIeXfXu6o6UqSOHWggQfzIPj
 ti0B9NzhzSvAZkNgX+guDCa1DZrwSmssLeZJ6ok/0tX822ESfO/HJCQ
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add aspeed sdhci support for AST2700. The AST2700 sdhci
requires an reset. This series updates the binding and driver to
support reset requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v2:
- 1/2 use items for ast2700 compatible.
- 2/2 use devm_reset_control_get_optional_exclusive_deasserted for
  reset.
- Link to v1: https://lore.kernel.org/r/20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com

---
Ryan Chen (2):
      mmc: dt-bindings: sdhci-of-aspeed: Add AST2700 fallback compatibles
      mmc: sdhci-of-aspeed: Handle optional controller reset

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      | 39 +++++++++++++++++-----
 drivers/mmc/host/sdhci-of-aspeed.c                 |  6 ++++
 2 files changed, 37 insertions(+), 8 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-sdhci-269d319fdbde

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

