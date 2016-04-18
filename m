From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH v2 0/3] mmc: usdhi6rol0: UHS support
Date: Mon, 18 Apr 2016 15:44:52 +0200
Message-ID: <cover.1460986983.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:50295 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbcDRNpZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Apr 2016 09:45:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

This patch set adds UHS support to the usdhi6rol0 driver, with control of the
regulator and pin state settings.

Changes since v1:
- Use mmc_regulator_set_vqmmc().

Lars Persson (3):
  mmc: dt: usdhi6rol0: add optional pinctrl binding
  mmc: usdhi6rol0: add support for UHS modes
  mmc: usdhi6rol0: add pinctrl to set pin drive strength

 .../devicetree/bindings/mmc/usdhi6rol0.txt         |  4 ++
 drivers/mmc/host/usdhi6rol0.c                      | 51 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
2.1.4

