From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of PCI mode for the dw_mmc driver
Date: Mon, 3 Oct 2011 14:32:44 +0530
Message-ID: <CANYdXnqixbM5Aout6NUHRVxzZL-LvngXRbFWywKX1O80zJdn4A@mail.gmail.com>
References: <1317318052-2750-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E858109.8010807@imgtec.com>
	<CANYdXnr96oh5_dQKUEqAvTT7tRZR4Kb918t7EhgwzcQkgEusGA@mail.gmail.com>
	<4E8972F1.4090604@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64333 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab1JCJCp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2011 05:02:45 -0400
Received: by iaqq3 with SMTP id q3so4792477iaq.19
        for <linux-mmc@vger.kernel.org>; Mon, 03 Oct 2011 02:02:44 -0700 (PDT)
In-Reply-To: <4E8972F1.4090604@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Matt Fleming <matt@console-pimps.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org

Hi ,
  Actually these are not really dummy Id's.The vendor Id ad Device Id
were given by Synopsys for the PCI platform.

On Mon, Oct 3, 2011 at 2:01 PM, James Hogan <james.hogan@imgtec.com> wr=
ote:
> Hi
>
> On 10/03/2011 07:50 AM, Shashidhar Hiremath wrote:
>> Hi James,
>> =C2=A0 Can I add =C2=A0separate files for PCI/Platform and from ther=
e call
>> common probe/remove api's similar to SDHCI driver in kernel ?
>
> yes, that sounds like a good idea.
>
> In what way are the PCI device and vendor ids dummy?
>
> Cheers
> James
>
>>
>> On Fri, Sep 30, 2011 at 2:12 PM, James Hogan <james.hogan@imgtec.com=
> wrote:
>>> Hi
>>>
>>> On 09/29/2011 06:40 PM, Shashidhar Hiremath wrote:
>>>> Support of PCI mode for the dw_mmc driver This Patch adds the supp=
ort for the scenario where the Synopsys Designware IP is present on the=
 PCI bus.The patch adds the minimal modifications necessary for the dri=
ver to work on PCI platform. The Driver has also been tested for on the=
 PCI platform with single Card Slot.
>>>>
>>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>>> ---
>>>> v2:
>>>> *As per Suggestions by Will Newton and James Hogan
>>>> -Reduced the number of ifdefs
>>>>
>>>> =C2=A0drivers/mmc/host/Kconfig =C2=A0 | =C2=A0 11 ++
>>>> =C2=A0drivers/mmc/host/dw_mmc.c =C2=A0| =C2=A0352 ++++++++++++++++=
++++++++++++++++++++++++++++
>>>> =C2=A0drivers/mmc/host/dw_mmc.h =C2=A0| =C2=A0 13 ++
>>>> =C2=A0include/linux/mmc/dw_mmc.h | =C2=A0 =C2=A04 +
>>>> =C2=A04 files changed, 380 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 8c87096..84d8908 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -526,6 +526,17 @@ config MMC_DW
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 block, this provides host support for =
SD and MMC interfaces, in both
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 PIO and external DMA modes.
>>>>
>>>> +config MMC_DW_PCI
>>>> + =C2=A0 =C2=A0 bool "MMC_DW Support On PCI bus"
>>>> + =C2=A0 =C2=A0 depends on MMC_DW && PCI
>>>> + =C2=A0 =C2=A0 help
>>>> + =C2=A0 =C2=A0 =C2=A0 This selects the PCI for the Synopsys Desig=
nware Mobile Storage IP.
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 If you have a controller with this interfac=
e, say Y or M here.
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
>>>> +
>>>> +
>>>> =C2=A0config MMC_DW_IDMAC
>>>> =C2=A0 =C2=A0 =C2=A0 bool "Internal DMAC interface"
>>>> =C2=A0 =C2=A0 =C2=A0 depends on MMC_DW
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index ff0f714..0bd9e16 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -21,6 +21,7 @@
>>>> =C2=A0#include <linux/interrupt.h>
>>>> =C2=A0#include <linux/ioport.h>
>>>> =C2=A0#include <linux/module.h>
>>>> +#include <linux/pci.h>
>>>> =C2=A0#include <linux/platform_device.h>
>>>> =C2=A0#include <linux/scatterlist.h>
>>>> =C2=A0#include <linux/seq_file.h>
>>>> @@ -101,6 +102,7 @@ struct dw_mci_slot {
>>>> =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_detect_state;
>>>> =C2=A0};
>>>>
>>>> +
>>>> =C2=A0static struct workqueue_struct *dw_mci_card_workqueue;
>>>>
>>>> =C2=A0#if defined(CONFIG_DEBUG_FS)
>>>> @@ -682,6 +684,7 @@ static void dw_mci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
>>>> =C2=A0{
>>>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot *slot =3D mmc_priv(mmc);
>>>> =C2=A0 =C2=A0 =C2=A0 u32 regs;
>>>> + =C2=A0 =C2=A0 u32 card_detect;
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 /* set default 1 bit mode */
>>>> =C2=A0 =C2=A0 =C2=A0 slot->ctype =3D SDMMC_CTYPE_1BIT;
>>>> @@ -716,6 +719,13 @@ static void dw_mci_set_ios(struct mmc_host *m=
mc, struct mmc_ios *ios)
>>>> =C2=A0 =C2=A0 =C2=A0 switch (ios->power_mode) {
>>>> =C2=A0 =C2=A0 =C2=A0 case MMC_POWER_UP:
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(DW_MMC_CA=
RD_NEED_INIT, &slot->flags);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable Power to the=
 card that has been detected */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card_detect =3D mci_re=
adl(slot->host, CDETECT);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enabling power for =
card 0 when PCI is the interface */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->host,=
 PWREN, ((~card_detect) & 0x1));
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>> + =C2=A0 =C2=A0 case MMC_POWER_OFF:
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->host,=
 PWREN, 0);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>> =C2=A0 =C2=A0 =C2=A0 default:
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>> @@ -1775,6 +1785,345 @@ static bool mci_wait_reset(struct device *=
dev, struct dw_mci *host)
>>>> =C2=A0 =C2=A0 =C2=A0 return false;
>>>> =C2=A0}
>>>>
>>>> +#ifdef CONFIG_MMC_DW_PCI
>>>> +
>>>> +static struct pci_device_id dw_mci_id =C2=A0=3D { =C2=A0PCI_DEVIC=
E(DEVICE_ID, VENDOR_ID) };
>>>> +
>>>> +struct dw_mci_board pci_board_data =3D {
>>>> + =C2=A0 =C2=A0 .num_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
>>>> + =C2=A0 =C2=A0 .caps =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D DW_MCI_CAPABILITIES,
>>>> + =C2=A0 =C2=A0 .bus_hz =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 33 * 1000 * 1000,
>>>> + =C2=A0 =C2=A0 .detect_delay_ms =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D 200,
>>>> + =C2=A0 =C2=A0 .fifo_depth =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 32,
>>>> +};
>>>> +
>>>> +static int __devinit dw_mci_probe(struct pci_dev *pdev,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct pci_device_id *entr=
ies)
>>>> +{
>>>> + =C2=A0 =C2=A0 struct dw_mci *host;
>>>> + =C2=A0 =C2=A0 struct resource *regs;
>>>> + =C2=A0 =C2=A0 struct dw_mci_board *pdata;
>>>> + =C2=A0 =C2=A0 int irq, ret, i, width;
>>>> + =C2=A0 =C2=A0 u32 fifo_size;
>>>> +
>>>> + =C2=A0 =C2=A0 ret =3D pci_enable_device(pdev);
>>>> + =C2=A0 =C2=A0 if (ret)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>>>> + =C2=A0 =C2=A0 if (pci_request_regions(pdev, "dw_mmc")) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>>>> + =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 irq =3D pdev->irq;
>>>> +
>>>> + =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KERNEL=
);
>>>> + =C2=A0 =C2=A0 if (!host)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>>>> +
>>>> + =C2=A0 =C2=A0 host->pdev =3D pdev;
>>>> + =C2=A0 =C2=A0 host->pdata =3D pdata =3D &pci_board_data;
>>>> +
>>>> + =C2=A0 =C2=A0 if (!pdata->select_slot && pdata->num_slots > 1) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "Platform data must supply select_slot function\n");
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 if (!pdata->bus_hz) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "Platform data must supply bus speed\n");
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 host->bus_hz =3D pdata->bus_hz;
>>>> + =C2=A0 =C2=A0 host->quirks =3D pdata->quirks;
>>>> +
>>>> + =C2=A0 =C2=A0 spin_lock_init(&host->lock);
>>>> + =C2=A0 =C2=A0 INIT_LIST_HEAD(&host->queue);
>>>> +
>>>> + =C2=A0 =C2=A0 ret =3D -ENOMEM;
>>>> + =C2=A0 =C2=A0 host->regs =3D pci_iomap(pdev, PCI_BAR_NO, COMPLET=
E_BAR);
>>>> + =C2=A0 =C2=A0 if (!host->regs) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EIO;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_res;
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 host->dma_ops =3D pdata->dma_ops;
>>>> + =C2=A0 =C2=A0 dw_mci_init_dma(host);
>>>> +
>>>> + =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0* Get the host data width - this assumes tha=
t HCON has been set with
>>>> + =C2=A0 =C2=A0 =C2=A0* the correct values.
>>>> + =C2=A0 =C2=A0 =C2=A0*/
>>>> + =C2=A0 =C2=A0 i =3D (mci_readl(host, HCON) >> 7) & 0x7;
>>>> + =C2=A0 =C2=A0 if (!i) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->push_data =3D dw=
_mci_push_data16;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->pull_data =3D dw=
_mci_pull_data16;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D 16;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->data_shift =3D 1=
;
>>>> + =C2=A0 =C2=A0 } else if (i =3D=3D 2) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->push_data =3D dw=
_mci_push_data64;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->pull_data =3D dw=
_mci_pull_data64;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D 64;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->data_shift =3D 3=
;
>>>> + =C2=A0 =C2=A0 } else {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check for a reserve=
d value, and warn if it is */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN((i !=3D 1),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"H=
CON reports a reserved host data width!\n"
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"D=
efaulting to 32-bit access.\n");
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->push_data =3D dw=
_mci_push_data32;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->pull_data =3D dw=
_mci_pull_data32;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D 32;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->data_shift =3D 2=
;
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 /* Reset all blocks */
>>>> + =C2=A0 =C2=A0 if (!mci_wait_reset(&pdev->dev, host)) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_dmaunmap;
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 /* Clear the interrupts for the host controller */
>>>> + =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>> + =C2=A0 =C2=A0 mci_writel(host, INTMASK, 0); /* disable all mmc i=
nterrupt first */
>>>> +
>>>> + =C2=A0 =C2=A0 /* Put in max timeout */
>>>> + =C2=A0 =C2=A0 mci_writel(host, TMOUT, 0xFFFFFFFF);
>>>> +
>>>> + =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0* FIFO threshold settings =C2=A0RxMark =C2=A0=
=3D fifo_size / 2 - 1,
>>>> + =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Tx Mark =3D fifo_size /=
 2 DMA Size =3D 8
>>>> + =C2=A0 =C2=A0 =C2=A0*/
>>>> + =C2=A0 =C2=A0 if (!host->pdata->fifo_depth) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Power-on value=
 of RX_WMark is FIFO_DEPTH-1, but this may
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* have been over=
written by the bootloader, just like we're
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* about to do, s=
o if you know the value for your hardware, you
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* should put it =
in the platform data.
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo_size =3D mci_read=
l(host, FIFOTH);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo_size =3D 1 + ((fi=
fo_size >> 16) & 0x7ff);
>>>> + =C2=A0 =C2=A0 } else {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo_size =3D host->pd=
ata->fifo_depth;
>>>> + =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 host->fifo_depth =3D fifo_size;
>>>> + =C2=A0 =C2=A0 host->fifoth_val =3D ((0x2 << 28) | ((fifo_size/2 =
- 1) << 16) |
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ((fifo_size/2) << 0));
>>>> + =C2=A0 =C2=A0 mci_writel(host, FIFOTH, host->fifoth_val);
>>>> +
>>>> + =C2=A0 =C2=A0 /* disable clock to CIU */
>>>> + =C2=A0 =C2=A0 mci_writel(host, CLKENA, 0);
>>>> + =C2=A0 =C2=A0 mci_writel(host, CLKSRC, 0);
>>>> +
>>>> + =C2=A0 =C2=A0 tasklet_init(&host->tasklet, dw_mci_tasklet_func, =
(unsigned long)host);
>>>> + =C2=A0 =C2=A0 dw_mci_card_workqueue =3D alloc_workqueue("dw-mci-=
card",
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 WQ_MEM_RECLAIM | WQ_NON_REENTRANT, 1);
>>>> + =C2=A0 =C2=A0 if (!dw_mci_card_workqueue)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_dmaunmap;
>>>> + =C2=A0 =C2=A0 INIT_WORK(&host->card_work, dw_mci_work_routine_ca=
rd);
>>>> +
>>>> + =C2=A0 =C2=A0 ret =3D request_irq(irq, dw_mci_interrupt, IRQF_SH=
ARED, "dw-mci", host);
>>>> + =C2=A0 =C2=A0 if (ret)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_workqueue;
>>>> +
>>>> + =C2=A0 =C2=A0 pci_set_drvdata(pdev, host);
>>>> +
>>>> + =C2=A0 =C2=A0 if (host->pdata->num_slots)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->num_slots =3D ho=
st->pdata->num_slots;
>>>> + =C2=A0 =C2=A0 else
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->num_slots =3D ((=
mci_readl(host, HCON) >> 1) & 0x1F) + 1;
>>>> +
>>>> + =C2=A0 =C2=A0 /* We need at least one slot to succeed */
>>>> + =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D dw_mci_init_sl=
ot(host, i);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ret =3D -ENODEV;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto err_init_slot;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0* Enable interrupts for command done, data o=
ver, data empty, card det,
>>>> + =C2=A0 =C2=A0 =C2=A0* receive ready and error such as transmit, =
receive timeout, crc error
>>>> + =C2=A0 =C2=A0 =C2=A0*/
>>>> + =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>> + =C2=A0 =C2=A0 mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDM=
MC_INT_DATA_OVER |
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDMMC_INT=
_TXDR | SDMMC_INT_RXDR |
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DW_MCI_ER=
ROR_FLAGS | SDMMC_INT_CD);
>>>> + =C2=A0 =C2=A0 mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* =
Enable mci interrupt */
>>>> +
>>>> + =C2=A0 =C2=A0 dev_info(&pdev->dev, "DW MMC controller at irq %d,=
 "
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%d bit host dat=
a width, "
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%u deep fifo\n"=
,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq, width, fifo=
_size);
>>>> + =C2=A0 =C2=A0 if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev, "=
Internal DMAC interrupt fix enabled.\n");
>>>> +
>>>> + =C2=A0 =C2=A0 return 0;
>>>> +
>>>> +err_init_slot:
>>>> + =C2=A0 =C2=A0 /* De-init any initialized slots */
>>>> + =C2=A0 =C2=A0 while (i > 0) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->slot[i])
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dw_mci_cleanup_slot(host->slot[i], i);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i--;
>>>> + =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 free_irq(irq, host);
>>>> +
>>>> +err_workqueue:
>>>> + =C2=A0 =C2=A0 destroy_workqueue(dw_mci_card_workqueue);
>>>> +
>>>> +err_dmaunmap:
>>>> + =C2=A0 =C2=A0 if (host->use_dma && host->dma_ops->exit)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops->exit(ho=
st);
>>>> + =C2=A0 =C2=A0 dma_free_coherent(&host->pdev->dev, PAGE_SIZE,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 host->sg_cpu, host->sg_dma);
>>>> + =C2=A0 =C2=A0 iounmap(host->regs);
>>>> +
>>>> + =C2=A0 =C2=A0 if (host->vmmc) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_disable(host=
->vmmc);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_put(host->vm=
mc);
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> +err_free_res:
>>>> + =C2=A0 =C2=A0 pci_release_regions(pdev);
>>>> +
>>>> +err_freehost:
>>>> + =C2=A0 =C2=A0 kfree(host);
>>>> + =C2=A0 =C2=A0 return ret;
>>>> +}
>>>> +
>>>> +static void __devexit dw_mci_remove(struct pci_dev *pdev)
>>>> +{
>>>> +
>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>>>> + =C2=A0 =C2=A0 int i;
>>>> +
>>>> + =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>> + =C2=A0 =C2=A0 mci_writel(host, INTMASK, 0); /* disable all mmc i=
nterrupt first */
>>>> +
>>>> + =C2=A0 =C2=A0 pci_set_drvdata(pdev, NULL);
>>>> +
>>>> + =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev, "r=
emove slot %d\n", i);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->slot[i])
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dw_mci_cleanup_slot(host->slot[i], i);
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 /* disable clock to CIU */
>>>> + =C2=A0 =C2=A0 mci_writel(host, CLKENA, 0);
>>>> + =C2=A0 =C2=A0 mci_writel(host, CLKSRC, 0);
>>>> +
>>>> + =C2=A0 =C2=A0 free_irq(pdev->irq, host);
>>>> + =C2=A0 =C2=A0 destroy_workqueue(dw_mci_card_workqueue);
>>>> + =C2=A0 =C2=A0 dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_=
cpu, host->sg_dma);
>>>> +
>>>> + =C2=A0 =C2=A0 if (host->use_dma && host->dma_ops->exit)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops->exit(ho=
st);
>>>> +
>>>> + =C2=A0 =C2=A0 if (host->vmmc) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_disable(host=
->vmmc);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_put(host->vm=
mc);
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 iounmap(host->regs);
>>>> +
>>>> + =C2=A0 =C2=A0 pci_release_regions(pdev);
>>>> + =C2=A0 =C2=A0 kfree(host);
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_PM
>>>> +/*
>>>> + * TODO: we should probably disable the clock to the card in the =
suspend path.
>>>> + */
>>>> +static int dw_mci_suspend(struct pci_dev *pdev, pm_message_t mesg=
)
>>>> +{
>>>> + =C2=A0 =C2=A0 int i, ret;
>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>>>> +
>>>> + =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot *sl=
ot =3D host->slot[i];
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!slot)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmc_suspend_ho=
st(slot->mmc);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 while (--i >=3D 0) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot =3D host->slot[i];
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (slot)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_resume_=
host(host->slot[i]->mmc);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ret;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 if (host->vmmc)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_disable(host=
->vmmc);
>>>> +
>>>> + =C2=A0 =C2=A0 return 0;
>>>> +}
>>>> +
>>>> +static int dw_mci_resume(struct pci_dev *pdev)
>>>> +{
>>>> + =C2=A0 =C2=A0 int i, ret;
>>>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>>>> +
>>>> + =C2=A0 =C2=A0 if (host->vmmc)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_enable(host-=
>vmmc);
>>>> +
>>>> + =C2=A0 =C2=A0 if (host->dma_ops->init)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dma_ops->init(ho=
st);
>>>> +
>>>> + =C2=A0 =C2=A0 if (!mci_wait_reset(&pdev->dev, host)) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 /* Restore the old value at FIFOTH register */
>>>> + =C2=A0 =C2=A0 mci_writel(host, FIFOTH, host->fifoth_val);
>>>> +
>>>> + =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>> + =C2=A0 =C2=A0 mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDM=
MC_INT_DATA_OVER |
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDMMC_INT=
_TXDR | SDMMC_INT_RXDR |
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DW_MCI_ER=
ROR_FLAGS | SDMMC_INT_CD);
>>>> + =C2=A0 =C2=A0 mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>>>> +
>>>> + =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot *sl=
ot =3D host->slot[i];
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!slot)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmc_resume_hos=
t(host->slot[i]->mmc);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ret;
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 return 0;
>>>> +}
>>>> +#else
>>>> +#define dw_mci_suspend =C2=A0 =C2=A0 =C2=A0 NULL
>>>> +#define dw_mci_resume =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL
>>>> +#endif /* CONFIG_PM */
>>>> +
>>>> +static struct pci_driver dw_mci_driver =3D {
>>>> + =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "dw_m=
mc",
>>>> + =C2=A0 =C2=A0 .id_table =C2=A0 =C2=A0 =C2=A0 =3D &dw_mci_id,
>>>> + =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mc=
i_probe,
>>>> + =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_rem=
ove,
>>>> + =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_sus=
pend,
>>>> + =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_res=
ume,
>>>> +};
>>>> +
>>>> +static int __init dw_mci_init(void)
>>>> +{
>>>> + =C2=A0 =C2=A0 return pci_register_driver(&dw_mci_driver);
>>>> +}
>>>> +
>>>> +static void __exit dw_mci_exit(void)
>>>> +{
>>>> + =C2=A0 =C2=A0 pci_unregister_driver(&dw_mci_driver);
>>>> +}
>>>> +#else
>>>> +
>>>
>>> Duplication isn't the same as abstraction, and it's much worse to
>>> maintain than lots of #ifdefs. What we meant was to abstract the co=
mmon
>>> code into separate static functions which are used by both pci/plat=
form
>>> probe/remove/suspend/resume functions (as Will has already describe=
d).
>>>
>>> These functions should also have pci/platform in their names to
>>> distinguish them more easily. Also I see no reason why pci and plat=
form
>>> registration should be mutually exclusive, i.e. the platform driver=
 can
>>> still be registered even if PCI is enabled.
>>>
>>>> =C2=A0static int dw_mci_probe(struct platform_device *pdev)
>>>> =C2=A0{
>>>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host;
>>>> @@ -1974,6 +2323,7 @@ err_freehost:
>>>>
>>>> =C2=A0static int __exit dw_mci_remove(struct platform_device *pdev=
)
>>>> =C2=A0{
>>>> +
>>>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(=
pdev);
>>>> =C2=A0 =C2=A0 =C2=A0 int i;
>>>>
>>>> @@ -2100,6 +2450,8 @@ static void __exit dw_mci_exit(void)
>>>> =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&dw_mci_driver);
>>>> =C2=A0}
>>>>
>>>> +#endif/* CONFIG_MMC_DW_PCI */
>>>> +
>>>> =C2=A0module_init(dw_mci_init);
>>>> =C2=A0module_exit(dw_mci_exit);
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>>> index 027d377..54bc604 100644
>>>> --- a/drivers/mmc/host/dw_mmc.h
>>>> +++ b/drivers/mmc/host/dw_mmc.h
>>>> @@ -164,4 +164,17 @@
>>>> =C2=A0 =C2=A0 =C2=A0 (*(volatile u64 __force *)((dev)->regs + SDMM=
C_##reg) =3D (value))
>>>> =C2=A0#endif
>>>>
>>>> +/* PCI Specific macros */
>>>> +#ifdef CONFIG_MMC_DW_PCI
>>>> +#define PCI_BAR_NO 2
>>>> +#define COMPLETE_BAR 0
>>>> +/* Dummy Device Id and Vendor Id */
>>>> +#define VENDOR_ID 0x700
>>>> +#define DEVICE_ID 0x1107
>>>
>>> Again, in what way are these values dummy? if somebody were to want=
 to
>>> use this, would they have to change them for their specific hardwar=
e? Is
>>> that a common thing to have to do for other drivers like this?
>>>
>>>> +/* Defining the Capabilities */
>>>> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIG=
HSPEED |\
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DA=
TA |\
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP_SDIO_IRQ)
>>>> +#endif /* CONFIG_MMC_DW_PCI */
>>>> +
>>>> =C2=A0#endif /* _DW_MMC_H_ */
>>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc=
=2Eh
>>>> index 6b46819..87af5a6 100644
>>>> --- a/include/linux/mmc/dw_mmc.h
>>>> +++ b/include/linux/mmc/dw_mmc.h
>>>> @@ -147,7 +147,11 @@ struct dw_mci {
>>>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 current_speed;
>>>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_slots;
>>>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifoth_val;
>>>> +#ifdef CONFIG_MMC_DW_PCI
>>>> + =C2=A0 =C2=A0 struct pci_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=
pdev;
>>>> +#else
>>>> =C2=A0 =C2=A0 =C2=A0 struct platform_device =C2=A0*pdev;
>>>> +#endif
>>>
>>> The only time this is used is to find &host->pdev->dev for logging
>>> calls. It'd be better to replace these with a single struct device =
*,
>>> then it'll work with both platform and pci enabled.
>>>
>>>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_board =C2=A0 =C2=A0 *pdata;
>>>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot =C2=A0 =C2=A0 =C2=A0*slot[=
MAX_MCI_SLOTS];
>>>>
>>>
>>>
>>
>>
>>
>
>



--=20
regards,
Shashidhar Hiremath
