From: Neil Armstrong <narmstrong@neotion.com>
Subject: [PATCH 0/3] Add boot_enable attribute to eMMC device for boot mode
 operation selection
Date: Fri, 19 Apr 2013 14:41:42 +0200
Message-ID: <51713B86.2090001@neotion.com>
Reply-To: narmstrong@neotion.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Namjae Jeon <linkinjeon@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Subhash Jadavani <subhashj@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Since eMMC 4.3 a special boot mode operation was introduced to retrieve
data from the eMMC device with a very simple procedure. Since the Linux
kernel exports these device boot partitions, it may be useful to select
the boot partition from the user space.

The patch has been tested on a Toshiba eMMC conforming with eMMC 4.5
specifications.

Neil Armstrong (3):
  Add BOOT_PARTITION_ENABLE definition to MMC EXT_CSD PART_CONFIG
  Add boot_enable sysfs attribute to select MMC boot operation
    partition
  Add Documentation for MMC boot_enable attribute

 Documentation/mmc/mmc-dev-parts.txt |    6 +++
 drivers/mmc/card/block.c            |   72
++++++++++++++++++++++++++++++++++-
 include/linux/mmc/mmc.h             |    1 +
 3 files changed, 78 insertions(+), 1 deletions(-)
