From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH 0/3] Enable ADMA and multiblock in s3c64xx SDHCI controller
Date: Tue, 04 May 2010 11:43:17 +0200
Message-ID: <4BDFEC35.8010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, pierre@ossman.eu, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, sdhci-devel@lists.ossman.eu
Cc: ben-linux@fluff.org, thomas.ab@samsung.com
List-Id: linux-mmc@vger.kernel.org

This is a resend of the following patches, rebased against 2.6.34-rc6:

Maurus Cuelenaere (1):
  SDHCI: Enable multiblock transfers in sdhci-s3c

Thomas Abraham (2):
  s3c6410: Add new quirk in sdhci driver and update ADMA descriptor
    build.
  s3c6410: Enable ADMA feature in 6410 sdhci controller.

 drivers/mmc/host/sdhci-s3c.c |   10 +---------
 drivers/mmc/host/sdhci.c     |   20 +++++++++++++++-----
 drivers/mmc/host/sdhci.h     |    2 ++
 3 files changed, 18 insertions(+), 14 deletions(-)

--
Maurus Cuelenaere
