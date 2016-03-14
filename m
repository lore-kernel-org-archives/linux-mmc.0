From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 0/5] davinci_mmc fixes
Date: Mon, 14 Mar 2016 17:54:36 -0500
Message-ID: <1457996081-21975-1-git-send-email-david@lechnology.com>
References: <56E6BF7E.7020401@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:59485 "EHLO vern.gendns.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbcCNW40 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Mar 2016 18:56:26 -0400
In-Reply-To: <56E6BF7E.7020401@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nsekhar@ti.com
Cc: khilman@kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, David Lechner <david@lechnology.com>

I've updated the patche set based on feedback. This is tested on linux-next with
LEGO MINDSTORMS EV3 (da850), both with and without device tree enabled.

David Lechner (5):
  mmc: davinci: remove matching string
  mmc: davinci: fix unwinding in probe
  mmc: davinci: prepare clock
  mmc: davinci: don't use dma platform resources
  arm: davinci: remove mmc dma resources

 arch/arm/mach-davinci/devices-da8xx.c |  20 ------
 arch/arm/mach-davinci/devices.c       |  16 -----
 drivers/mmc/host/davinci_mmc.c        | 112 +++++++++++-----------------------
 3 files changed, 37 insertions(+), 111 deletions(-)

-- 
1.9.1

