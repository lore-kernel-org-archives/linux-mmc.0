From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] staging: net: wireless: add ESP8089 WiFi driver
Date: Fri, 21 Jul 2017 17:01:39 +0200
Message-ID: <D6633BE9-51E0-434B-B536-D94DE9342C10@holtmann.org>
References: <20170721143502.1991-1-quentin.schulz@free-electrons.com>
 <20170721143502.1991-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:50769 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbdGUPBo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jul 2017 11:01:44 -0400
In-Reply-To: <20170721143502.1991-2-quentin.schulz@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, shawn.lin@rock-chips.com, adrian.hunter@intel.com, baolin.wang@linaro.org, hdegoede@redhat.com, maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, icenowy@aosc.xyz, wens@csie.org

Hi Quentin,

> The Espressif ESP8089 WiFi chips can be often found in cheap tablets.
> There is one in A23 Polaroid tablets for example.
> 
> The chip is often embedded as an eMMC SDIO device.
> 
> The code was taken from an out-of-tree repository and has seen a first
> pass in the cleanup process.
> 
> At the moment, there is no publicly available datasheet for this chip.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Icenowy Zheng <icenowy@aosc.xyz>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> drivers/staging/Kconfig                     |    2 +
> drivers/staging/Makefile                    |    1 +
> drivers/staging/esp8089/Kconfig             |   13 +
> drivers/staging/esp8089/Makefile            |    7 +
> drivers/staging/esp8089/esp_ctrl.c          |  527 ++++++++
> drivers/staging/esp8089/esp_ctrl.h          |   48 +
> drivers/staging/esp8089/esp_debug.c         |  247 ++++
> drivers/staging/esp8089/esp_debug.h         |   69 ++
> drivers/staging/esp8089/esp_file.c          |  221 ++++
> drivers/staging/esp8089/esp_file.h          |   30 +
> drivers/staging/esp8089/esp_init_data.h     |   17 +
> drivers/staging/esp8089/esp_io.c            |  294 +++++
> drivers/staging/esp8089/esp_mac80211.c      | 1496 +++++++++++++++++++++++
> drivers/staging/esp8089/esp_mac80211.h      |   33 +
> drivers/staging/esp8089/esp_main.c          |  199 ++++
> drivers/staging/esp8089/esp_pub.h           |  188 +++
> drivers/staging/esp8089/esp_sif.h           |  131 ++
> drivers/staging/esp8089/esp_sip.c           | 1718 +++++++++++++++++++++++++++
> drivers/staging/esp8089/esp_sip.h           |  150 +++
> drivers/staging/esp8089/esp_utils.c         |  133 +++
> drivers/staging/esp8089/esp_utils.h         |   27 +
> drivers/staging/esp8089/esp_wl.h            |   35 +
> drivers/staging/esp8089/esp_wmac.h          |   87 ++
> drivers/staging/esp8089/sdio_sif_esp.c      |  552 +++++++++
> drivers/staging/esp8089/sip2_common.h       |  388 ++++++
> drivers/staging/esp8089/slc_host_register.h |  263 ++++
> 26 files changed, 6876 insertions(+)
> create mode 100644 drivers/staging/esp8089/Kconfig
> create mode 100644 drivers/staging/esp8089/Makefile
> create mode 100644 drivers/staging/esp8089/esp_ctrl.c
> create mode 100644 drivers/staging/esp8089/esp_ctrl.h
> create mode 100644 drivers/staging/esp8089/esp_debug.c
> create mode 100644 drivers/staging/esp8089/esp_debug.h
> create mode 100644 drivers/staging/esp8089/esp_file.c
> create mode 100644 drivers/staging/esp8089/esp_file.h
> create mode 100644 drivers/staging/esp8089/esp_init_data.h
> create mode 100644 drivers/staging/esp8089/esp_io.c
> create mode 100644 drivers/staging/esp8089/esp_mac80211.c
> create mode 100644 drivers/staging/esp8089/esp_mac80211.h
> create mode 100644 drivers/staging/esp8089/esp_main.c
> create mode 100644 drivers/staging/esp8089/esp_pub.h
> create mode 100644 drivers/staging/esp8089/esp_sif.h
> create mode 100644 drivers/staging/esp8089/esp_sip.c
> create mode 100644 drivers/staging/esp8089/esp_sip.h
> create mode 100644 drivers/staging/esp8089/esp_utils.c
> create mode 100644 drivers/staging/esp8089/esp_utils.h
> create mode 100644 drivers/staging/esp8089/esp_wl.h
> create mode 100644 drivers/staging/esp8089/esp_wmac.h
> create mode 100644 drivers/staging/esp8089/sdio_sif_esp.c
> create mode 100644 drivers/staging/esp8089/sip2_common.h
> create mode 100644 drivers/staging/esp8089/slc_host_register.h

why are you putting this into staging? Is it that bad?

Regards

Marcel

