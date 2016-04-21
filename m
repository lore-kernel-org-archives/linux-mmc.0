From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH v4 0/3] mmc: usdhi6rol0: UHS support
Date: Thu, 21 Apr 2016 15:55:41 +0200
Message-ID: <cover.1461246772.git.larper@axis.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch set adds UHS support to the usdhi6rol0 driver, with control of the
regulator and pin state settings.

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

Lars Persson (3):
  mmc: dt: usdhi6rol0: add optional pinctrl binding
  mmc: usdhi6rol0: add support for UHS modes
  mmc: usdhi6rol0: add pinctrl to set pin drive strength

 .../devicetree/bindings/mmc/usdhi6rol0.txt         |  6 ++
 drivers/mmc/host/usdhi6rol0.c                      | 71 +++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
