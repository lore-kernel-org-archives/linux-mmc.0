From: Ravikumar Kattekola <rk@ti.com>
Subject: [PATCH 0/3] mmc: host: omap_hsmmc: miscellaneous fixes
Date: Mon, 30 Jan 2017 15:41:55 +0530
Message-ID: <1485771118-13748-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, peter.ujfalusi@ti.com, nsekhar@ti.com, tony@atomide.com, afenkart@gmail.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kishon@ti.com, rk@ti.com
List-Id: linux-mmc@vger.kernel.org

A few issues have been identified during mmc testing and following
set of patches fixes a couple of them related to
*timeout handling and ceb error handling*

Tested on DRA75X PG 2.0 Rev H EVM

Kishon Vijay Abraham I (1):
  mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout value
    for CMD6

Ravikumar Kattekola (2):
  mmc: host: omap_hsmmc: reset cmd line on ceb error
  mmc: host: omap_hsmmc: avoid possible overflow of timeout value

 drivers/mmc/host/omap_hsmmc.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
1.9.1
