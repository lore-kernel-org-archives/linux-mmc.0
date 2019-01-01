From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] mmc: fix boards with CD GPIO and "cd-inverted"
Date: Tue,  1 Jan 2019 20:44:13 +0100
Message-ID: <20190101194414.24766-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: linux@roeck-us.net, bgolaszewski@baylibre.com, ulf.hansson@linaro.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-mmc@vger.kernel.org

As I explained in my original mail [0] I observed that some of my boards
were not detecting their SD card anymore:
- Meson8b Odroid-C1: the one one Kernel CI and another one on my desk
- Meson8b EC-100: on my desk
- Meson GXBB Odroid-C2: on Kernel CI

git bisect pointed to the following commit:
89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")

The one-line change from this series is supposed to fix this issue for
v4.21 (mainline git master).
As explained in the patch description the MMC core code which manages
the GPIO inversion can be cleaned up once no driver depends on it
anymore (it seems that only one driver is left, but I don't have
hardware for it so I can't test it). More details can also be found
in my discussion with Linus on this topic: [1]


[0] https://marc.info/?l=linux-gpio&m=154609359306731&w=3
[1] https://marc.info/?l=linux-mmc&m=154626524506451&w=3


Martin Blumenstingl (1):
  mmc: core: don't override the CD GPIO level when "cd-inverted" is set

 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1
