From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of PCI mode for the dw_mmc driver
Date: Fri, 30 Sep 2011 12:17:55 +0530
Message-ID: <CANYdXnr2GgazCRmQT3z5y4ZG9fC4DYU70=jcVLdktM95M7Td+w@mail.gmail.com>
References: <1317318052-2750-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E8520B4.7070504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45026 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab1I3Grz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2011 02:47:55 -0400
Received: by iaqq3 with SMTP id q3so1512919iaq.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2011 23:47:55 -0700 (PDT)
In-Reply-To: <4E8520B4.7070504@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Matt Fleming <matt@console-pimps.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org

thanks for reply Jaehoon,
  The reason I had hard coded was the PCI card that I was using had a
single SD/MMC slot. I will make necessary change and submit another
patch.

On Fri, Sep 30, 2011 at 7:21 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> Hi Shashidhar.
>
> On 09/30/2011 02:40 AM, Shashidhar Hiremath wrote:
>
>> Support of PCI mode for the dw_mmc driver This Patch adds the suppor=
t for the scenario where the Synopsys Designware IP is present on the P=
CI bus.The patch adds the minimal modifications necessary for the drive=
r to work on PCI platform. The Driver has also been tested for on the P=
CI platform with single Card Slot.
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>> ---
>> v2:
>> *As per Suggestions by Will Newton and James Hogan
>> -Reduced the number of ifdefs
>>
>> =C2=A0drivers/mmc/host/Kconfig =C2=A0 | =C2=A0 11 ++
>> =C2=A0drivers/mmc/host/dw_mmc.c =C2=A0| =C2=A0352 ++++++++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0drivers/mmc/host/dw_mmc.h =C2=A0| =C2=A0 13 ++
>> =C2=A0include/linux/mmc/dw_mmc.h | =C2=A0 =C2=A04 +
>> =C2=A04 files changed, 380 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 8c87096..84d8908 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -526,6 +526,17 @@ config MMC_DW
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 block, this provides host support for SD=
 and MMC interfaces, in both
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 PIO and external DMA modes.
>>
>> +config MMC_DW_PCI
>> + =C2=A0 =C2=A0 bool "MMC_DW Support On PCI bus"
>> + =C2=A0 =C2=A0 depends on MMC_DW && PCI
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 This selects the PCI for the Synopsys Designw=
are Mobile Storage IP.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If you have a controller with this interface,=
 say Y or M here.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
>> +
>> +
>> =C2=A0config MMC_DW_IDMAC
>> =C2=A0 =C2=A0 =C2=A0 bool "Internal DMAC interface"
>> =C2=A0 =C2=A0 =C2=A0 depends on MMC_DW
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index ff0f714..0bd9e16 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -21,6 +21,7 @@
>> =C2=A0#include <linux/interrupt.h>
>> =C2=A0#include <linux/ioport.h>
>> =C2=A0#include <linux/module.h>
>> +#include <linux/pci.h>
>> =C2=A0#include <linux/platform_device.h>
>> =C2=A0#include <linux/scatterlist.h>
>> =C2=A0#include <linux/seq_file.h>
>> @@ -101,6 +102,7 @@ struct dw_mci_slot {
>> =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 last_detect_state;
>> =C2=A0};
>>
>> +
>> =C2=A0static struct workqueue_struct *dw_mci_card_workqueue;
>>
>> =C2=A0#if defined(CONFIG_DEBUG_FS)
>> @@ -682,6 +684,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot *slot =3D mmc_priv(mmc);
>> =C2=A0 =C2=A0 =C2=A0 u32 regs;
>> + =C2=A0 =C2=A0 u32 card_detect;
>>
>> =C2=A0 =C2=A0 =C2=A0 /* set default 1 bit mode */
>> =C2=A0 =C2=A0 =C2=A0 slot->ctype =3D SDMMC_CTYPE_1BIT;
>> @@ -716,6 +719,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
>> =C2=A0 =C2=A0 =C2=A0 switch (ios->power_mode) {
>> =C2=A0 =C2=A0 =C2=A0 case MMC_POWER_UP:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(DW_MMC_CARD=
_NEED_INIT, &slot->flags);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable Power to the c=
ard that has been detected */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card_detect =3D mci_read=
l(slot->host, CDETECT);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enabling power for ca=
rd 0 when PCI is the interface */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->host, P=
WREN, ((~card_detect) & 0x1));
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case MMC_POWER_OFF:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->host, P=
WREN, 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>
>
> Using shift with slot->id.(1bit per card).
>
> Regards,
> Jaehoon Chung
>



--=20
regards,
Shashidhar Hiremath
