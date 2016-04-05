From: David Lechner <david@lechnology.com>
Subject: [PATCH v4 0/3] davinci_mmc fixes
Date: Tue,  5 Apr 2016 12:31:48 -0500
Message-ID: <1459877512-25479-1-git-send-email-david@lechnology.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:57788 "EHLO vern.gendns.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932812AbcDERci (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Apr 2016 13:32:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

This fixes a compiler warning in the "fix unwinding in probe" patch where ret
was used uninitalized.

David Lechner (3):
  mmc: davinci: fix unwinding in probe
  mmc: davinci: prepare clock
  ARM: davinci: remove mmc dma resources

 arch/arm/mach-davinci/devices-da8xx.c |  20 -------
 arch/arm/mach-davinci/devices.c       |  16 ------
 drivers/mmc/host/davinci_mmc.c        | 100 ++++++++++++++--------------------
 3 files changed, 40 insertions(+), 96 deletions(-)

-- 
1.9.1

