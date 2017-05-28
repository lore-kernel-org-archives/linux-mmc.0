From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: Bug: sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
 interrupt.
Date: Sun, 28 May 2017 15:00:41 +0200 (CEST)
Message-ID: <1657024502.940561.1495976441798@email.1und1.de>
References: <433605218.311867.1495813840749@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52930 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdE1NB0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 May 2017 09:01:26 -0400
In-Reply-To: <433605218.311867.1495813840749@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Phil Elwell <phil@raspberrypi.org>, Gerd Hoffmann <kraxel@redhat.com>, Eric Anholt <eric@anholt.net>
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 26. Mai 2017 um 17:50 geschrieben:
> 
> 
> Hi,
> 
> i noticed that the RPI2 with next-20170526 and bcm2835_defconfig doesn't boot from SD card [1]. At least i was able to fix the NULL pointer dereference [2]. Now i'm getting the output see below. I try to narrow this down, but maybe someone already has an idea.
> 

Okay this issue doesn't seems to be related to the bcm2835-sdhost driver.

Test results on RPI 2:

bcm2835-sdhost + bcm2835_defconfig + next-20170526 => boot hang
sdhci-iproc + bcm2835_defconfig + next-20170526 => boot hang
bcm2835-sdhost + bcm2835_defconfig + v4.12-rc2 => boot hang
sdhci-iproc + bcm2835_defconfig + v4.12-rc2 => boot hang
bcm2835-sdhost + bcm2835_defconfig + v4.11 => boot hang
sdhci-iproc + bcm2835_defconfig + v4.11 => boot hang
bcm2835-sdhost + multi_v7_defconfig + v4.12-rc2 => no boot hang
sdhci-iproc + multi_v7_defconfig + v4.12-rc2 => no boot hang

I will send the fix for the NULL pointer dereference as a RFC patch soon.

Stefan
