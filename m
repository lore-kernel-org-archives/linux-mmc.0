From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/5] mmc: dw_mmc: Fix the CTO timer patch, plus the DTO timer
Date: Thu, 12 Oct 2017 13:11:13 -0700
Message-ID: <20171012201118.23570-1-dianders@chromium.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com
Cc: xzy.xu@rock-chips.com, amstan@chromium.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, linux-samsung-soc@vger.kernel.org, kernel@esmil.dk, Douglas Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Recently we landed 03de19212ea3 ("mmc: dw_mmc: introduce timer for
broken command transfer over scheme").  I found a bunch of problems
with that patch, so this series attempts to solve some of them.

This also fixes the DTO timer in some of the same ways even though I
haven't personally seen problems with the DTO timer.

NOTE: this series has only been lighly tested so far.  I can at least
reproduce the need for the CTO timer on one of my devices and so I can
confirm that part still works.  As mentioned in the 3rd patch I also
ran the mmc_test kernel module on this and did manage to see the 3rd
patch doing something useful.

Changes in v2:
- Removed extra "int i"
- Fix the DTO timeout calculation new for v2
- Cleanup the DTO timer new for v2

Douglas Anderson (5):
  mmc: dw_mmc: cancel the CTO timer after a voltage switch
  mmc: dw_mmc: Fix the CTO timeout calculation
  mmc: dw_mmc: Add locking to the CTO timer
  mmc: dw_mmc: Fix the DTO timeout calculation
  mmc: dw_mmc: Cleanup the DTO timer like the CTO one

 drivers/mmc/host/dw_mmc.c | 162 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 146 insertions(+), 16 deletions(-)

-- 
2.15.0.rc0.271.g36b669edcc-goog
