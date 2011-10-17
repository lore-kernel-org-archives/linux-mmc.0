From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Linux v3.1-rc8 : SDHC card do not switch to high speed mode
Date: Mon, 17 Oct 2011 20:19:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECE22D47@dbde02.ent.ti.com>
References: <C82BA3053CFD354AACBD25EFBD2A4EC603F959EF6E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59916 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab1JQOth convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 10:49:37 -0400
In-Reply-To: <C82BA3053CFD354AACBD25EFBD2A4EC603F959EF6E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "arindam.nath@amd.com" <arindam.nath@amd.com>, "prakity@marvell.com" <prakity@marvell.com>"prakity@marvell.com" <prakity@marvell.com>, "zhangfei.gao@marvell.com" <zhangfei.gao@marvell.com>, "cjb@laptop.org" <cjb@laptop.org>, "Saxena, Parth" <parth.saxena@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hebbar, Gururaja
> Sent: Thursday, October 13, 2011 8:19 PM
> To: linux-mmc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Subject: Linux v3.1-rc8 : SDHC card do not switch to high speed mode
> 
> Hi all,
> 
> We are porting existing OMAP HSMMC driver (omap_hsmmc.c) to an upcoming
> SOC.
> 
> When testing the driver with SanDisk 16GB SDHC Card (SanDisk Extreme HD
> Video 16GB 20Mb/s), we observed that the card doesn't switch to High Speed
> mode.
> 
> The card shows that it is compatible with SDA spec3.
> 
> We are testing on Linux v3.1-rc8
> 
> 
> In mmc_sd_init_card(), rocr received from card is 0xc0ff8000, (S18A bit
> not set).
> 
> During mmc_sd_setup_card() --> mmc_decode_scr(), when decoding scr, the
> card specifies that it is sda spec3 compatible
> 
> 	if (scr->sda_vsn == SCR_SPEC_VER_2)
> 		/* Check if Physical Layer Spec v3.0 is supported */
> 		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);			--
> > true
> 
> Then during mmc_read_switch(), since it's a sda spec3 card, the code goes
> to read sd3_drv_type & sd3_curr_limit and skips settings hs_max_dtr.
> 
> mmc_sd_switch_hs() returns back since hs_max_dtr == 0
> 
> 	if (card->sw_caps.hs_max_dtr == 0)
> 		return 0;
> 
> Because of this Card isn't switched to High Speed mode.
> 
[Hiremath, Vaibhav] After doing bisect, I could able to nail down the commit which is leading to this issue.


psplinux060:/datalocal/omap-kernel>git bisect good                                        d6d50a15a2897d4133d536dd4343b5cf21163db3 is the first bad commit
commit d6d50a15a2897d4133d536dd4343b5cf21163db3
Author: Arindam Nath <arindam.nath@amd.com>
Date:   Thu May 5 12:18:59 2011 +0530

    mmc: sd: add support for driver type selection

    This patch adds support for setting driver strength during UHS-I
    initialization procedure. Since UHS-I cards set S18A (bit 24) in
    response to ACMD41, we use this as a base for UHS-I initialization.
    We modify the parameter list of mmc_sd_get_cid() so that we can
    save the ROCR from ACMD41 to check whether bit 24 is set.

    We decide whether the Host Controller supports A, C, or D driver
    type depending on the Capabilities register. Driver type B is
    suported by default. We then set the appropriate driver type for
    the card using CMD6 mode 1. As per Host Controller spec v3.00, we
    set driver type for the host only if Preset Value Enable in the
    Host Control2 register is not set. SDHCI_HOST_CONTROL has been
    renamed to SDHCI_HOST_CONTROL1 to conform to the spec.

    Tested by Zhangfei Gao with a Toshiba uhs card and general hs card,
    on mmp2 in SDMA mode.

    Signed-off-by: Arindam Nath <arindam.nath@amd.com>
    Reviewed-by: Philip Rakity <prakity@marvell.com>
    Tested-by: Philip Rakity <prakity@marvell.com>
    Acked-by: Zhangfei Gao <zhangfei.gao@marvell.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>


I am not a MMC/SD expert, but looking at the logic I did change to code to something like,


diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0370e03..1a45059 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -348,10 +348,9 @@ static int mmc_read_switch(struct mmc_card *card)
                }

                card->sw_caps.sd3_curr_limit = status[7];
-       } else {
-               if (status[13] & 0x02)
-                       card->sw_caps.hs_max_dtr = 50000000;
        }
+       if (status[13] & 0x02)
+               card->sw_caps.hs_max_dtr = 50000000;

 out:
        kfree(status);


This resolves the issue, and now card is getting detected properly as a high speed card.
May be I am wrong completely here, any pointers? Any comments? 

Thanks,
Vaibhav

> Is there any solution for this? Has anyone seen this issue.
> 
> Thanks in advance.
> 
> 
> I am also attaching the log I get from the sd dev attr
> 
> Regards
> Gururaja
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> cid
> 0353445344313647800c03994400ac6f
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> csd
> 400e00325b59000076b27f800a404013
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> date
> 12/2010
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> erase_size
> 512
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> fwrev
> 0x0
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> hwrev
> 0x8
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> name
> SD16G
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> manfid
> 0x000003
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> oemid
> 0x5344
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> preferred_erase_size
> 4194304
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> scr
> 0235800000000000
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> serial
> 0x0c039944
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> type
> SD
> 
> root@arago-
> armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat
> uevent
> DRIVER=mmcblk
> MMC_TYPE=SD
> MMC_NAME=SD16G
> MODALIAS=mmc:block
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
