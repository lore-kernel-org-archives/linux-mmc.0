From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: eMMC initialisation fails: invalid UHS-I mode
Date: Fri, 10 Mar 2017 09:30:04 +0100
Message-ID: <98664253-9a68-fa59-7f17-438b0d522fe8@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exsmtp01.microchip.com ([198.175.253.37]:26102 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755134AbdCJIaX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2017 03:30:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>

Hi,

I have discovered a bit late that the eMMC on sama5d2_xplained board is 
no longer working since the initialisation fails.

It was working with 4.9. Doing a git bisect, the commit which causes my 
issue is e173f891:
mmc: core: Update CMD13 polling policy when switch to HS DDR mode

Here are the logs:
mmc0: Invalid UHS-I mode selected
mmc0: switch to bus width 8 ddr failed
mmc0: error -110 whilst initialising MMC card

I have not dig much yet. Did someone already report or experience the 
same thing?

It seems that switching to the new timing before checking the switch 
status doesn't work so the timing is set back to MMC_TIMING_MMC_HS that 
causes the invalid UHS-I mode when getting preset value.

Regards

Ludovic
