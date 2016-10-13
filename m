From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/6] mmc/memstick: rtsx_usb: Fix runtime PM issues
Date: Thu, 13 Oct 2016 13:37:34 +0200
Message-ID: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

The rtsx_usb_sdmmc (mmc/sd) and rtsx_usb_ms (memstick) devices are interfacing
an rtsx_usb device (managed by an mfd driver) while communicating with the
cards. The mmc/sd and memstick devices are children of the usb device.

Issues has been reported [1] for rtsx, which have been investigated, discussed,
fixed, tested, etc, particularly when using mmc/sd cards. During the
investigation, some changes was proposed and tested successfully. In this
series I have picked up these changes and created some proper patches with
change-logs.

It turned out that most of the problems was related to the runtime PM
deployment in the memstick and the mmc/sd driver, which are fixed in this
series.

A couple of more issues were also discussed [2], which needs to be fixed as
well. Although they are out of scope for this series, so we will have to look
into those at a later point. Here's a brief summary of these leftovers:

*)
It seems reasonable to turn off autosuspend for usb devices and instead rely on
the usb device's children to deal with autosuspend. The reason is simply that
the children has better knowledge of when using autosuspend makes sense.

**)
Polling card detect mode is used both for mmc/sd and memstick. Because of the
lack of synchronization between the polling attempts for these subsystems, the
usb device may be powered on for unnecessary long intervals, thus we are
wasting power.

Besides the above changes, I folded in a change in the mmc core which improves
the behaviour for mmc hosts using MMC_CAP2_NO_PRESCAN_POWERUP, which is the
case for the rtsx_usb_sdmmc driver.  This change should improve the boot time
with ~100ms per rtsx_usb_sdmmc device.

Finally, as I couldn't find an active maintainer for the memstick
subsystem/driver and because the author of the drivers can be reached, I
volunteer to take this all through my mmc tree. Please tell me if that is
problem to any of you.

[1]
https://www.spinics.net/lists/linux-usb/msg146998.html
[2]
https://www.spinics.net/lists/linux-mmc/msg39235.html


Alan Stern (1):
  memstick: rtsx_usb_ms: Runtime resume the device when polling for
    cards

Ulf Hansson (5):
  mmc: rtsx_usb_sdmmc: Avoid keeping the device runtime resumed when
    unused
  mmc: rtsx_usb_sdmmc: Handle runtime PM while changing the led
  memstick: rtsx_usb_ms: Manage runtime PM when accessing the device
  mmc: rtsx_usb_sdmmc: Enable runtime PM autosuspend
  mmc: core: Don't power off the card when starting the host

 drivers/memstick/host/rtsx_usb_ms.c |  6 ++++++
 drivers/mmc/core/core.c             |  9 ++++-----
 drivers/mmc/host/rtsx_usb_sdmmc.c   | 10 +++++-----
 3 files changed, 15 insertions(+), 10 deletions(-)

-- 
1.9.1
