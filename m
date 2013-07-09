From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH 0/5] mmc: dw_mmc: fixes for suspend/resume on exynos
Date: Tue,  9 Jul 2013 10:31:06 -0700
Message-ID: <1373391071-6312-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:47448 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab3GIRbo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2013 13:31:44 -0400
Received: by mail-qc0-f202.google.com with SMTP id z1so520896qcx.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2013 10:31:44 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This series of patches addresses some suspend/resume problems with
dw_mmc on exynos platforms.  Since suspend/resume is not fully working
on ToT Linux (3.10) on exynos5250-snow, this series was tested against
the current ToT ChromeOS 3.8 tree.  I have confirmed basic booting
and eMMC / SD card usage (and compiling, honest!) against ToT Linux.


Doug Anderson (5):
  mmc: dw_mmc: Invalidate cache of current_speed after suspend/resume
  mmc: dw_mmc: Add suspend/resume callbacks; disable irq during suspend
  mmc: dw_mmc: Add exynos resume callback to clear WAKEUP_INT
  mmc: dw_mmc: Always setup the bus after suspend/resume
  mmc: dw_mmc: Set timeout to max upon resume

 drivers/mmc/host/dw_mmc-exynos.c | 23 +++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c        | 26 ++++++++++++++++++++++----
 drivers/mmc/host/dw_mmc.h        |  4 ++++
 3 files changed, 49 insertions(+), 4 deletions(-)

-- 
1.8.3

