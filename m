From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Pass n900 MMC slot names in pdata for legacy user space
Date: Tue, 26 Apr 2016 16:46:21 -0700
Message-ID: <1461714383-9956-1-git-send-email-tony@atomide.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52309 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbcDZXqg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2016 19:46:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Hi all,

N900 needs the MMC slot names to work. Let's pass them in pdata
for now to remove the last remaining blocker for removing omap3
legacy booting support for v4.8.

Then when we have a generic DT binding for the slot names, we
can use that assuming it will work for the n900 legacy user space.

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP2+: n900 needs MMC slot names for legacy user space
  mmc: omap_hsmmc: Check if MMC slot name is passed in pdata

 arch/arm/mach-omap2/pdata-quirks.c | 7 +++++++
 drivers/mmc/host/omap_hsmmc.c      | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.8.1

