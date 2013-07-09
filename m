From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/5] mmc: dw_mmc: fixes for suspend/resume on exynos
Date: Tue,  9 Jul 2013 16:19:16 -0700
Message-ID: <1373411961-23812-1-git-send-email-dianders@chromium.org>
References: <1373391071-6312-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373391071-6312-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This series of patches addresses some suspend/resume problems with
dw_mmc on exynos platforms.  Since suspend/resume is not fully working
on ToT Linux (3.10) on exynos5250-snow, this series was tested against
the current ToT ChromeOS 3.8 tree.  I have confirmed basic booting
and eMMC / SD card usage (and compiling, honest!) against ToT Linux.

Changes in v2:
- Fix typo (some -> come)
- Use ~0 instead of 0xFFFFFFFF; add comment about value
- Use suspend_noirq as per James Hogan.

Doug Anderson (5):
  mmc: dw_mmc: Invalidate cache of current_speed after suspend/resume
  mmc: dw_mmc: Add suspend_noirq/resume_noirq callbacks for dw_mmc-pltfm
  mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT
  mmc: dw_mmc: Always setup the bus after suspend/resume
  mmc: dw_mmc: Set timeout to max upon resume

 drivers/mmc/host/dw_mmc-exynos.c | 23 +++++++++++++++++++++++
 drivers/mmc/host/dw_mmc-pltfm.c  | 37 ++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/dw_mmc.c        | 15 +++++++++++----
 drivers/mmc/host/dw_mmc.h        |  4 ++++
 4 files changed, 72 insertions(+), 7 deletions(-)

-- 
1.8.3
