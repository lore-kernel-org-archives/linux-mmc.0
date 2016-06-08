From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 0/4] Introduce new caps to improve the card's init sequence
Date: Wed,  8 Jun 2016 16:19:56 +0800
Message-ID: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:48686 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384AbcFHIUX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2016 04:20:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


Hi all,

This patchset is gonna improve the card's init sequence
by exposing some caps to DT.

The basic idea is to skip sending specific init cmd inspired
by Carlo Caione's commit[0].

To make it possible, I firstly expose Carlo's MMC_CAP2_NO_SDIO
to DT and extend two new caps for similar usage of sd and mmc.
We probably need it because for most of the boards, each of the
slots should have a specific function when designed. It's impossible
for one slot which can either to be used as eMMC or a SD card for a
given board. The same for SDIO case.

We could have two ways to improve it
A) Skip sending specific commands if knowing we don't support
the specific card type.
B) Allow sending specific commands if knowing we do support
the specific card type.

A) and B) shouldn't have difference, but I take A) as the final
one as it looks more consistent with Carlo's way, which does not
seem to break anything as possible.

The only roadblock for this patchset to be landed should be the
improvement we gain from it. Theoretically sdio-card doesn't get
improvment as it's already in the first place to be attached.
But considering the sd and (e)MMC case, we should gain more benifit
from it.

>From the test, we can save nearly 2ms for attaching emmc against the
original 8ms. And we gain more than 30us improvement for sd card for
each insert.

[0]: http://permalink.gmane.org/gmane.linux.kernel.mmc/34774



Shawn Lin (4):
  Documentation: mmc: add description for new caps
  mmc: core: expose MMC_CAP2_NO_SDIO to dt-binding
  mmc: core: add cap-no-sd and cap-no-mmc properties
  mmc: core: improve initialization flow

 Documentation/devicetree/bindings/mmc/mmc.txt |  3 +++
 drivers/mmc/core/core.c                       | 10 +++++-----
 drivers/mmc/core/host.c                       |  6 ++++++
 include/linux/mmc/host.h                      |  2 ++
 4 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.3.7


