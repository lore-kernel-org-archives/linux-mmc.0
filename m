From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 0/2] add ESP8089 WiFi chip driver
Date: Fri, 21 Jul 2017 16:35:00 +0200
Message-ID: <20170721143502.1991-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: ulf.hansson@linaro.org, gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, hdegoede@redhat.com, baolin.wang@linaro.org, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, wens@csie.org, icenowy@aosc.xyz, maxime.ripard@free-electrons.com, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

The Espressif ESP8089 WiFi chips can be often found in cheap tablets.
There is one in A23 Polaroid tablets for example.

The chip is often embedded as an eMMC SDIO device.

At the moment, there is no publicly available datasheet for this chip.

The code was taken from an out-of-tree repository and has seen a first
pass in the cleanup process.

Three firmwares are needed and will be soon posted to linux-firmware.

Hans already tried to push the first patch and there had been some
discussions going on with Ulf here[1]. Basically, Ulf proposed to send
an RFC of a better solution to the problem Hans exposed in his cover
letter.
I've been looking for a few hours where this RFC could be and I
unfortunately haven't found it. Moreover, nothing recently submitted
matches a potential solution to this problem (but I may be wrong). I'm
basically trying to revive the discussion on this matter since only a
hack can make this driver work ATM (see Hans' cover letter).

I am posting this driver to staging as it still requires some cleanup
but can be used as is.

Thanks,
Quentin

[1] http://www.spinics.net/lists/linux-mmc/msg38410.html

Hans de Goede (1):
  mmc: Add mmc_force_detect_change_begin / _end functions

Quentin Schulz (1):
  staging: net: wireless: add ESP8089 WiFi driver

 drivers/mmc/core/core.c                     |   47 +-
 drivers/staging/Kconfig                     |    2 +
 drivers/staging/Makefile                    |    1 +
 drivers/staging/esp8089/Kconfig             |   13 +
 drivers/staging/esp8089/Makefile            |    7 +
 drivers/staging/esp8089/esp_ctrl.c          |  527 ++++++++
 drivers/staging/esp8089/esp_ctrl.h          |   48 +
 drivers/staging/esp8089/esp_debug.c         |  247 ++++
 drivers/staging/esp8089/esp_debug.h         |   69 ++
 drivers/staging/esp8089/esp_file.c          |  221 ++++
 drivers/staging/esp8089/esp_file.h          |   30 +
 drivers/staging/esp8089/esp_init_data.h     |   17 +
 drivers/staging/esp8089/esp_io.c            |  294 +++++
 drivers/staging/esp8089/esp_mac80211.c      | 1496 +++++++++++++++++++++++
 drivers/staging/esp8089/esp_mac80211.h      |   33 +
 drivers/staging/esp8089/esp_main.c          |  199 ++++
 drivers/staging/esp8089/esp_pub.h           |  188 +++
 drivers/staging/esp8089/esp_sif.h           |  131 ++
 drivers/staging/esp8089/esp_sip.c           | 1718 +++++++++++++++++++++++++++
 drivers/staging/esp8089/esp_sip.h           |  150 +++
 drivers/staging/esp8089/esp_utils.c         |  133 +++
 drivers/staging/esp8089/esp_utils.h         |   27 +
 drivers/staging/esp8089/esp_wl.h            |   35 +
 drivers/staging/esp8089/esp_wmac.h          |   87 ++
 drivers/staging/esp8089/sdio_sif_esp.c      |  552 +++++++++
 drivers/staging/esp8089/sip2_common.h       |  388 ++++++
 drivers/staging/esp8089/slc_host_register.h |  263 ++++
 include/linux/mmc/host.h                    |    7 +
 28 files changed, 6925 insertions(+), 5 deletions(-)
 create mode 100644 drivers/staging/esp8089/Kconfig
 create mode 100644 drivers/staging/esp8089/Makefile
 create mode 100644 drivers/staging/esp8089/esp_ctrl.c
 create mode 100644 drivers/staging/esp8089/esp_ctrl.h
 create mode 100644 drivers/staging/esp8089/esp_debug.c
 create mode 100644 drivers/staging/esp8089/esp_debug.h
 create mode 100644 drivers/staging/esp8089/esp_file.c
 create mode 100644 drivers/staging/esp8089/esp_file.h
 create mode 100644 drivers/staging/esp8089/esp_init_data.h
 create mode 100644 drivers/staging/esp8089/esp_io.c
 create mode 100644 drivers/staging/esp8089/esp_mac80211.c
 create mode 100644 drivers/staging/esp8089/esp_mac80211.h
 create mode 100644 drivers/staging/esp8089/esp_main.c
 create mode 100644 drivers/staging/esp8089/esp_pub.h
 create mode 100644 drivers/staging/esp8089/esp_sif.h
 create mode 100644 drivers/staging/esp8089/esp_sip.c
 create mode 100644 drivers/staging/esp8089/esp_sip.h
 create mode 100644 drivers/staging/esp8089/esp_utils.c
 create mode 100644 drivers/staging/esp8089/esp_utils.h
 create mode 100644 drivers/staging/esp8089/esp_wl.h
 create mode 100644 drivers/staging/esp8089/esp_wmac.h
 create mode 100644 drivers/staging/esp8089/sdio_sif_esp.c
 create mode 100644 drivers/staging/esp8089/sip2_common.h
 create mode 100644 drivers/staging/esp8089/slc_host_register.h

-- 
2.11.0
