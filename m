From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Subject: [PATCH v2 0/4] mmc: sdhci: sdhci_set_bus_width() cleanup
Date: Mon, 14 Aug 2017 22:00:22 +0200
Message-ID: <cover.1502740497.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Some SDHCI drivers are reimplementing sdhci_set_bus_width() just because
they support 8-bit bus but don't advertise full SDHCI 3.0 compliance.
This unnecessarily duplicates the function. Let's remove those duplicates.

v2:
	- added commit messages from Adrian Hunter

Michał Mirosław (4):
  mmc: sdhci: key 8BITBUS bit off MMC_CAP_8_BIT_DATA
  mmc: sdhci-tegra: use generic sdhci_set_bus_width()
  mmc: sdhci-pci: use generic sdhci_set_bus_width()
  mmc: sdhci-s3c: use generic sdhci_set_bus_width()

 drivers/mmc/host/sdhci-pci-core.c | 30 +++---------------------------
 drivers/mmc/host/sdhci-s3c.c      | 34 +---------------------------------
 drivers/mmc/host/sdhci-tegra.c    | 23 ++---------------------
 drivers/mmc/host/sdhci.c          |  5 ++---
 4 files changed, 8 insertions(+), 84 deletions(-)

-- 
2.11.0
