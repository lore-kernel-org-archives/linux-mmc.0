From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] mmc: renesas_sdhi: bugfixes for v4.14
Date: Tue, 17 Oct 2017 16:30:19 +0900
Message-ID: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This patch set is based on mainline v4.14-rc5.

Yoshihiro Shimoda (2):
  mmc: renesas_sdhi: fix swiotlb buffer is full
  mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
1.9.1
