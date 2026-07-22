Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50E40F757;
	Wed, 22 Jul 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717194; cv=none; b=JPOXH2uGK2QwinCV6nsbM0HVP/zAC3SbPrviP0GYDefM51U3umlfu0pgr2C5+PdQZhVoKxb0i3MS7eL4cJX/A1+ccLLCZ0xqaKn4sVWQsXIFg6nGOTsXh8/E10bt0N/KM6oJL263B8vBwq+DilmOQe1/FWn8JgltPLLfrmzQiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717194; c=relaxed/simple;
	bh=+E9mnDrkm85YIgkx4FFzIzmVAnYNeA+fffZMlwscomM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MnxK2vB1eC42YkW/H3cn6Pmw1wqelMLpdYVytg2jo6V14J8iUg1bxGAR0ecoY/lj0wPuxrm1NMcMr6V47a85+6O5P0BX5f9fBY7JsflZZYwkMex68+eYENMnLCwlK+84JC3H/jLZDYnkWVM0M6zFZGJ9TkTBasAT09sBQ7cyLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TElvSGv8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TElvSGv8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E2FFC19425;
	Wed, 22 Jul 2026 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784717194;
	bh=+E9mnDrkm85YIgkx4FFzIzmVAnYNeA+fffZMlwscomM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TElvSGv8mhNx1VNjfkBfGZATb8E6rCepyv9VxFc9Y1qicNF1GCdrh399L3AuKNx5p
	 UoXOHgThHGgm0MakXUBePfCG7jGsp3gnn0yNaE6APO6tXSX9SA6h8a75Qo00yOUEQx
	 vPgFOETXH+gq1k05G3atEtABbkiyfnPD3b8g8y/96ZPkjV/cAfvY2LJjt2gGKqIa7p
	 Plvz6twhov82kSfmD3rHcHthMzWFY4atBjcqOGgnAntoh0eqy4X/ZOuvQDhFxZ1qH6
	 t2lfVMwHb/tvjIx+yD9hCplf+1fbzhUBaJ4sVL8ypCwslxBDf4D+/qVyI6PGln4QyA
	 fokGbGbqINiuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B8C4453A;
	Wed, 22 Jul 2026 10:46:34 +0000 (UTC)
From: Rohan Joshi via B4 Relay <devnull+rohan1sj.cadence.com@kernel.org>
Subject: [PATCH v3 0/2] CQE support for cadence eMMC host controller
Date: Wed, 22 Jul 2026 16:18:36 +0530
Message-Id: <20260722-cdns_sdhci_cqe-support-v3-0-4412856a4488@cadence.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASgYGoC/62NsQ6CMBRFf4V0tqZUKMbJ/zCGwOurdLCFPmg0h
 H+3wODk5nhucs+ZGWGwSOySzSxgtGS9S3A6ZAy6xj2QW52YSSGVqGTOQTuqSXdgaxiQ09T3Poy
 8NQUW2oBBVbF07gMa+9rEt/vOAYcp+cfv2FkafXhv8Ziv694phfrViZILXpWFSTU8t6q8QqPRA
 R7BP9kqjfIfomVZPgjdpLgcAQAA
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mparab@cadence.com, pawell@cadence.com, 
 sjakhade@cadence.com, mpillai@cadence.com, rohan1sj@cadence.com, 
 razb@mobileye.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784717318; l=2000;
 i=rohan1sj@cadence.com; s=20260406; h=from:subject:message-id;
 bh=+E9mnDrkm85YIgkx4FFzIzmVAnYNeA+fffZMlwscomM=;
 b=ufAs3iZyBRmr7cwS50TwNCYnlbwMi0lE/0qhV+pli+qgGSg7Oofoyfva5onS58AIQX7aQG7tK
 2sBpF2L+02ADiNbZh5ybVg+YIUSfs+GmDP5F4jEJ5gD7bE4/M4sdYLc
X-Developer-Key: i=rohan1sj@cadence.com; a=ed25519;
 pk=YuwylizMVlVj8I4+VPMZ6xrFR2wyqJAWZyj90OVZgD0=
X-Endpoint-Received: by B4 Relay for rohan1sj@cadence.com/20260406 with
 auth_id=723
X-Original-From: Rohan Joshi <rohan1sj@cadence.com>
Reply-To: rohan1sj@cadence.com

Hi,

This series adds CQE (Command Queue Engine) support for cadence
eMMC host controller. the driver enables CQE when both the
conditions mentioned below are met
        1. Hardware reports the presence of CQE
        2. DT provides a "cqhci" register space

The driver handles amd,pensando-elba platform separately
since it requires an additional byte-lane control
register space. The space is mapped via index "1".
The cqhci-core function "cqhci_pltfm_init" maps CQE
via a named resource "cqchi" and hence DT needs to define
the same if the CQE needs to be enabled

The patch adds three named resources to cater for the
above mentioned requirement. It creates the two possible
combinations for amd,pensando-elba platform,
        [hc, bctl] or [hc, bctl, cqhci]
and the other platforms,
        [hc] or [hc, cqhci]

Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
---
Changes in v3:
- Device Tree updates to account for multiple platforms supporting CQE
- Link to v2: https://patch.msgid.link/20260506-cdns_sdhci_cqe-support-v2-0-754fe4de8b65@cadence.com

Changes in v2:
- Use dev_err_probe() for error messages when in probe path
- Updated commit messages as per subsystem naming conventions
- Select MMC_CQHCI in Kconfig for MMC_SDHCI_CADENCE
- Drop new dt-binding example and corrected existing one
- Link to v1: https://patch.msgid.link/20260407-cdns_sdhci_cqe-support-v1-0-13efc0810631@cadence.com

---
Rohan Joshi (2):
      dt-bindings: mmc: cdns,sdhci: Add CQE support
      mmc: sdhci-cadence: add CQE support

 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |  28 ++++-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/sdhci-cadence.c                   | 124 ++++++++++++++++++++-
 3 files changed, 146 insertions(+), 7 deletions(-)
---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260721-cdns_sdhci_cqe-support-bf4e4dfcfe67

Best regards,
-- 
Rohan Joshi <rohan1sj@cadence.com>


