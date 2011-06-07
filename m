From: yingchun li <sword.l.dragon@gmail.com>
Subject: sdhci.c after suspend, my sd host controller cannot work normally,
Date: Tue, 7 Jun 2011 21:38:20 +0800
Message-ID: <BANLkTi=swa+FCvVMnDn3PpqEOtJPS_m0VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56538 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab1FGNiW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 09:38:22 -0400
Received: by wya21 with SMTP id 21so3560133wya.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 06:38:21 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,
     I have an android box, and the kernel is 2.6.32. and my sd card
 host driver use the sdhci driver.
    now I have a problem when sdhost suspend and resume.
>From the log,  after the system suspend,  just before sdhost resume,
there is  a sdhci_request io happen. in the sdhci_request, it still
call sdhci_send_command to issue a command, but here the sdhost
is in the suspend state and the card has been power off, so the
command  fails.

   I want to know is this a power manage bug or sdhost bug?
does the sd card io request that happens between suspend and resume
is possible? or the sdhci_request should check more sd host state
before send command?

 In sdhci_request
     if (!present || host->flags & SDHCI_DEVICE_DEAD) {
               host->mrq->cmd->error = -ENOMEDIUM;
               tasklet_schedule(&host->finish_tasklet);
    } else
              sdhci_send_command(host, mrq->cmd);
In my case the __present__ is true and SDHCI device is not dead,
because my sdcard has the quirk
 'SDHCI_QUIRK_NO_CARD_NO_RESET' and the card
is always in the slot.

could you expert give me some advice? thanks a lot.
below are the config of my sd card:

CONFIG_MMC=y
CONFIG_MMC_DEBUG=y
CONFIG_MMC_UNSAFE_RESUME=y
# CONFIG_MMC_EMBEDDED_SDIO is not set
# CONFIG_MMC_PARANOID_SD_INIT is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_BOUNCE=y
CONFIG_MMC_BLOCK_DEFERRED_RESUME=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
