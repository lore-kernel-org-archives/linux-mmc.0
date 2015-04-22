From: Angelo Dureghello <angelo@sysam.it>
Subject: emmc 4.4x fast boot question
Date: Wed, 22 Apr 2015 15:11:24 +0200
Message-ID: <55379DFC.4040907@sysam.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tbjjbihbhdcag.turbo-smtp.net ([199.187.173.206]:17470 "HELO
	tbjjbihbhdcag.turbo-smtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756802AbbDVNSA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2015 09:18:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

hi experts,

trying to use imx6q "eMMC Fast Boot" mode without success. Can't
get any clarification from freescale still, so i try here.

 From the imx6q boot flow diagram seems there can be some gain using it.

Once studying on the Micron eMMC i have connected to imx6q, (as per
TN-52-06: Booting from Embedded MMC - JEDEC 4.41 online pdf) i see
this mode is just called "boot mode" or "alternate boot mode", and seems 
to allow to boot from SLC mmcblk0boot0 or mmcblk0boot1
partitions setting EXT_CSD[179] partition to 1 or 2 in bits 3to5.

In this way i can boot from mmcblk0boot0. but if i enable the hw
imx6q GPIO BOOT_CFG1[4] "Fast Boot" mode, i cannot boot anymore.

If i look signal with scope, booting i don't see the initial
CMD pulled low as should be for the Boot mode.
If i enable imx6q "fast boot" (BOOT_CFG1[4]) i just see a
continuos and long train of bits on both CMD and CLK from the reset.

So i can boot from special SLC mmcblk0boot0 but without imx6
"Fast Boot" enabled. So i am trying to understand why this Fast Boot 
feature (BOOT_CFG1[4] set) can't be used.

In case you can give any help on this it will be really appreciated.

Best regards,
Angelo Dureghello



