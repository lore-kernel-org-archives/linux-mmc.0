Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84C2D8393;
	Fri, 13 Mar 2026 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773379688; cv=none; b=jWkBf1KJxtuK4Pubr8hrSN781cX2bhYGXev7lB7y8zLywzr60ewkqXuHRBsdlfz4IffAdlOvSrAW9s7OcMRmemcLSgwWkVSBWZbFeK+2SuJP3xVtQdZppJnejX7dtidpmqpmuCF03udaz024SoEk9lYXv6qxP1iEtdncw0h0i90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773379688; c=relaxed/simple;
	bh=SB7CAsVDuvC/UzUyKBRMDViK4RWtIuE3C0YGThbJYq0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IoVaA8k/3cpuoK4zVrm2w9ni2AB6S+bL5Ko7dQa5n6gAKW1ANLBp3uoHl8zR8lYjtAXK11uwr1kh6pFb+dDRF/0QvMvGPNy62WQ4AjMXRBDvWSUTxQUKc0gQw4Zl/QL5H2fzLG5nCJTDcrBSoVEuXUk0gX36QGMjuFWKVN8RdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 13:27:57 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 13:27:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 0/2] Add AST2700 support for aspeed sdhci
Date: Fri, 13 Mar 2026 13:27:55 +0800
Message-ID: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFugs2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nj3eKUjORMXSMzyxRjQ8u0lKSUVCWg2oKi1LTMCrA50bG1tQDY/8O
 hVwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773379677; l=705;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=SB7CAsVDuvC/UzUyKBRMDViK4RWtIuE3C0YGThbJYq0=;
 b=Sz8w6I60BX3Vi3i6P7kBBwzTQn0pfRzJThSD8zp37uZ+jJVimsrLjFNIOak0m2xEst+vT2F/N
 95Y8AtIXkKEDQuF/Bwnobj6YtdVzMRtuzaTwuVCBBZe58KT3vWTrK/H
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add aspeed sdhci support for AST2700. The AST2700 sdhci
requires an reset. This series updates the binding and driver to
support reset requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Ryan Chen (2):
      dt-bindings: mmc: sdhci-of-aspeed : Add ast2700 support
      mmc: sdhci-of-aspeed: Add ast2700 support

 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 16 ++++++++++++++++
 drivers/mmc/host/sdhci-of-aspeed.c                      | 11 +++++++++++
 2 files changed, 27 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-sdhci-269d319fdbde

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

