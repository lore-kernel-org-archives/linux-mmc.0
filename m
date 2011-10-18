From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/2] mmc: sdhci-s3c: support wakeup during suspend
Date: Tue, 18 Oct 2011 17:09:26 +0900
Message-ID: <4E9D3436.3090109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, 'kgene kim' <kgene.kim@samsung.com>, Wonil Choi <wonil22.choi@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Add codes for enable wakeup on detecting card change(insert or remove).
It is required to enable in case like MMC_UNSAFE_RESUME.

Wonil Choi (2):
  arm: samsung: add wakeup platdata
  mmc: sdhci-s3c: add to enable wakeup for sd-card

 arch/arm/plat-samsung/dev-hsmmc.c          |    1 +
 arch/arm/plat-samsung/dev-hsmmc1.c         |    1 +
 arch/arm/plat-samsung/dev-hsmmc2.c         |    1 +
 arch/arm/plat-samsung/dev-hsmmc3.c         |    1 +
 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 drivers/mmc/host/sdhci-s3c.c               |   15 ++++++++++++++-
 6 files changed, 20 insertions(+), 1 deletions(-)
