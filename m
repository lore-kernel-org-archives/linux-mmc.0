From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time.
	Change Kconfig
Date: Mon, 22 Nov 2010 19:15:05 -0800
Message-ID: <CA1E5969-5B37-4B0B-8730-F938DE76B278@marvell.com>
References: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
 <AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
 <20101123025548.GA29770@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54412 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751691Ab0KWDQY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Nov 2010 22:16:24 -0500
In-Reply-To: <20101123025548.GA29770@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Mark F. Brown" <mark.brown314@gmail.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

>From dd7fc6c87544f7bb4437f226f50ed1571f8e6a79 Mon Sep 17 00:00:00 2001
From: philip <philip@philip-laptop.(none)>
Date: Fri, 19 Nov 2010 11:02:15 -0800
Subject: [PATCH] [PATCH} - revised sdhci: sdhci-pxa only supports mmp2 at this time - enforce this

sdhci-pxa.c does not handle pxa168 and pxa9xx at this time.
The code does not take into account differences in the private registers
nor other nuances.  Restrict support to mmp2 until these issues are
resolved.

This patch is a revision of the previous patch - it uses CPU_MMP2
instead or the MACH_FLINT / MACH_  config variables

Signed-off-by: Mark Brown <markb@marvell.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6466189..e5387fe 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -168,12 +168,12 @@ config MMC_SDHCI_S3C
 
 config MMC_SDHCI_PXA
 	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
-	depends on ARCH_PXA || ARCH_MMP
+	depends on (ARCH_PXA || ARCH_MMP) && CPU_MMP2
 	select MMC_SDHCI
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-	  This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
-	  If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
+	  This selects the Marvell(R) MMP2 SD Host Controller.
+	  If you have a MMP2 platform with SD Host Controller
 	  and a card slot, say Y or M here.
 
 	  If unsure, say N.
-- 
1.6.0.4


On Nov 22, 2010, at 6:55 PM, Chris Ball wrote:

> Hi,
> 
> On Mon, Nov 22, 2010 at 09:46:14PM -0500, Mark F. Brown wrote:
>>>  config MMC_SDHCI_PXA
>>>        tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
>>> -       depends on ARCH_PXA || ARCH_MMP
>>> +       depends on (ARCH_PXA || ARCH_MMP) && (MACH_MARVELL_JASPER || MACH_FLINT)
>>>        select MMC_SDHCI
>>>        select MMC_SDHCI_IO_ACCESSORS
>>>        help
>>> -         This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
>>> -         If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
>>> +         This selects the Marvell(R) MMP2 SD Host Controller.
>>> +         If you have a MMP2 platform with SD Host Controller
>>>          and a card slot, say Y or M here.
>> 
>> Currently the driver sdhci-pxa only supports the 88AP610 (MMP2)
>> platform only. Until the sdhci-pxa code fixed or forked to support
>> pxa168 and pxa910 we need to Philip's patch. Any feedback on this
>> would be good thanks.
> 
> I don't mind changing the Kconfig text, but tying an SoC-level host
> controller to dependencies on specific machines seems pretty wrong.
> We should ask Haojian and Eric what they think.  I think Philip
> suggested using CPU_MMP2 at one point -- how about that?
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

