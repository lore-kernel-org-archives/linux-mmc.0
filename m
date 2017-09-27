From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/3] mmc: dw_mmc: Fix the CTO timer patch
Date: Wed, 27 Sep 2017 13:56:28 -0700
Message-ID: <20170927205631.31559-1-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com
Cc: briannorris@chromium.org, amstan@chromium.org, xzy.xu@rock-chips.com, Douglas Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Recently we landed 03de19212ea3 ("mmc: dw_mmc: introduce timer for
broken command transfer over scheme").  I found a bunch of problems
with that patch, so this series attempts to solve some of them.

NOTE: this series has only been lighly tested so far.  I can at least
reproduce the need for the CTO timer on one of my devices and so I can
confirm that part still works.  As mentioned in the 3rd patch I also
ran the mmc_test kernel module on this and did manage to see the 3rd
patch doing something useful.


Douglas Anderson (3):
  mmc: dw_mmc: cancel the CTO timer after a voltage switch
  mmc: dw_mmc: Fix the CTO timeout calculation
  mmc: dw_mmc: Add locking to the CTO timer

 drivers/mmc/host/dw_mmc.c | 101 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 12 deletions(-)

-- 
2.14.2.822.g60be5d43e6-goog
