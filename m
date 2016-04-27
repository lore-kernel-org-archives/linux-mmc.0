From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH v5 0/4] mmc: usdhi6rol0: UHS support
Date: Wed, 27 Apr 2016 17:21:25 +0200
Message-ID: <cover.1461770066.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:33498 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbcD0PVl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2016 11:21:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

This patch set adds UHS support to the usdhi6rol0 driver, with control of the
regulator and pin state settings.

Changes since v4:
- Add a fix patch to remove UHS capabilities that were announced without
  actual driver support.

Changes since v3:
- No error print for failure of mmc_regulator_set_vqmmc().
- Do not set UHS caps if the vqmmc regulator is missing.
- No not set UHS caps if the no-1-8-v property is set.

Changes since v2:
- dt: renamed pins_uhs to state_uhs.
- dt: made default optional in pinctrl-names.
- dt: document that use of state_uhs also requires a default pin state.
- add error handling for missing pin states.

Changes since v1:
- Use mmc_regulator_set_vqmmc().

Lars Persson (4):
  mmc: dt: usdhi6rol0: add optional pinctrl binding
  mmc: usdhi6rol0: do not announce UHS capabilities
  mmc: usdhi6rol0: add support for UHS modes
  mmc: usdhi6rol0: add pinctrl to set pin drive strength

 .../devicetree/bindings/mmc/usdhi6rol0.txt         |  6 +++
 drivers/mmc/host/usdhi6rol0.c                      | 60 +++++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

-- 
2.1.4

