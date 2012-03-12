From: joancarles <joancarles@fqingenieria.es>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3-rc5
Date: Mon, 12 Mar 2012 15:50:03 +0100
Message-ID: <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from llsa731-a03.servidoresdns.net ([82.223.190.25]:59701 "EHLO
	llsa987-a03.servidoresdns.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751535Ab2CLOuO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Mar 2012 10:50:14 -0400
In-Reply-To: <20120312132423.GC2459@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, shawn.guo@linaro.org, Hong-Xing.Zhu@freescale.com

Hi

On Mon, 12 Mar 2012 14:24:23 +0100, Wolfram Sang wrote:
>> What could have changed between 2.6.39.3 and 3.3-rc5 to trigger this
>> behaviour? A quick look at
>>
>> git diff v2.6.39 drivers/mmc/host/sdhci-esdhc-imx.c
>
> I'd recommend:
>
> git log v2.6.39.. drivers/mmc/host/sdhci-esdhc-imx.c

I have been staring at those commits, however with very little domain 
knowledge it's a shot in the dark.

> and look at those commits. You should also include the people who did
> those commits in CC when writing mails, otherwise they probably won't
> notice. Richard Zhu and Shawn Guo are from Freescale, and have more
> knowledge about the ESDHC cores.

Done now, thanks. Richard, Shawn, any pointers as to where to start 
looking on this one? Since the i.MX25 eSDHC has four data lines, one 
clock and one command line hard-wired, there is really nothing from a 
hardware point of view that could influence this different behaviour 
between the 2.6.39 and the 3.3-rc7 kernels.

Again, booting the same hardware with a 2.6.39.3 kernel using the 
standard mx25 initialisation routine:

imx25_add_sdhci_esdhc_imx(0, NULL);

works as intended. I can mount the sd card and I can write/remove files 
from it, independent of the file system (VFAT, ext2 have been tested). 
Leaving the sd card inside the slot, and rebooting the device with a 
linux kernel 3.3-rc7 fails, as described earlier. On any 3.3-rc kernels, 
and probably earlier versions as well, it fails with the cited error 
messages earlier in this thread:

http://marc.info/?l=linux-mmc&m=133103397222503&w=3

Changing it to a pdata init as shown below does not change anything 
with
regard to the failure:

imx25_add_sdhci_esdhc_imx(0, &noah_esdhc_pdata);
static const struct esdhc_platform_data noah_esdhc_pdata __initconst = 
{
         .wp_gpio = -EINVAL,
         .cd_gpio = -EINVAL,
         .wp_type = ESDHC_WP_NONE,
         .cd_type = ESDHC_CD_NONE,
};

> Wild guessing, 97e4ba6a5ea903a221d87bcabdaf01efb0a609a5 looks like 
> the
> most likely candidate, but I may be totally wrong.

I extracted it as follows:

git format-patch -1 97e4ba6a5ea90
patch -R -p1 < 0001-mmc-sdhci-esdhc-imx-Enable-ADMA2.patch

compiled and booted and it has no influence on my specific misbehaviour 
of the esdhc driver. So, this can be barred as a possible candidate, I 
reckon.

Thanks and best regards
-- 
Joan C. Abelaira
