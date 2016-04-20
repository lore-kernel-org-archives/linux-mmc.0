From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH v3 0/3] mmc: usdhi6rol0: UHS support
Date: Wed, 20 Apr 2016 16:53:10 +0200
Message-ID: <cover.1461163234.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:50607 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbcDTOxS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 10:53:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

This patch set adds UHS support to the usdhi6rol0 driver, with control of the
regulator and pin state settings.

Changes since v2:
- dt: renamed pins_uhs to state_uhs.
- dt: made default optional in pinctrl-names.
- dt: document that use of state_uhs also requires a default pin state.
- add error handling for missing pin states.

Changes since v1:
- Use mmc_regulator_set_vqmmc().

Lars Persson (3):
  mmc: dt: usdhi6rol0: add optional pinctrl binding
  mmc: usdhi6rol0: add support for UHS modes
  mmc: usdhi6rol0: add pinctrl to set pin drive strength

 .../devicetree/bindings/mmc/usdhi6rol0.txt         |  6 +++
 drivers/mmc/host/usdhi6rol0.c                      | 62 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.1.4

