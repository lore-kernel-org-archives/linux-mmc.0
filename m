From: Hans de Goede <hdegoede@redhat.com>
Subject: Help needed: Enabling HPI causes some eMMC devices to stop working
Date: Wed, 18 Feb 2015 20:15:11 +0100
Message-ID: <54E4E4BF.3090507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbbBRTPQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Feb 2015 14:15:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

As part of the Linux Allwinner SoC support work I do in my
spare time, I'm working on getting stock Linux running on
the Utoo P66 Allwinner A13 based tablet.

This tablet is interesting because it uses an eMMC rather then
raw nand as is typically seen on Allwinner tablets.

It has taken me a while to get the kernel to talk to the eMMC,
in the end the following hack does the trick:


From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 18 Feb 2015 20:04:03 +0100
Subject: [PATCH] mmc: HACK: disable HPI

HACK: trying to enable HPI breaks EMMC access on the Utoo P66 tablet I'm
trying to get supported, so disable it. FIXME: come up with a proper fix.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
  drivers/mmc/core/mmc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1d41e85..b343587 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1418,7 +1418,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
         /*
          * Enable HPI feature (if supported)
          */
-       if (card->ext_csd.hpi) {
+       if (0 && card->ext_csd.hpi) {
                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
                                 EXT_CSD_HPI_MGMT, 1,
                                 card->ext_csd.generic_cmd6_time);

This patch has one good thing going for it, which it is that it makes
the eMMC work, without this talking to the eMMC fails as soon as the
kernel tries to read the partition table, with response-timeout errors
when doing a mmc command 18 to read sector 0.

So this is as far as I've come, and beyond this my mmc knowledge is simply
not good enough. Could this be a controller specific problem ? IOW do
we need a controller flag to not enable HPi, like we've
MMC_CAP2_BOOTPART_NOACC ? Or is this likely more something specific to the eMMC
used.

Assuming for now it is something specific to the eMMC used, how do we fix this?

Is there maybe some way to figure out that enabling HPI is not a good idea on
this eMMC?

Or do we need a quirk for this in devicetree? Now a days we can tie info to an sdio
slave device in devicetree, so that is an option too.

Thanks & Regards,

Hans
