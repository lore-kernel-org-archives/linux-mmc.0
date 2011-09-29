From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc: Support of PCI mode for the dw_mmc driver This
 Patch adds the support for the scenario where the Synopsys Designware IP is
 present on the PCI bus.The patch adds the minimal modifications necessary for
 the driver to work on PCI pl
Date: Thu, 29 Sep 2011 10:11:27 +0530
Message-ID: <CANYdXnqr100w52kEcQbDtWORf1qpp1xP096qLO_Yu963YeV6mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62272 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab1I2El2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 00:41:28 -0400
Received: by yib18 with SMTP id 18so195057yib.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 21:41:27 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

Hi James,
thanks for the reply.
got your point .I will modify it by looking at few examples.

On Wed, Sep 28, 2011 at 8:52 PM, James Hogan <james.hogan@imgtec.com> w=
rote:
> Hi
>
> On 09/28/2011 04:02 PM, Shashidhar Hiremath wrote:
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>
> Looks like your description ended up all in the subject.
>
>> ---
>> =C2=A0drivers/mmc/host/Kconfig =C2=A0 | =C2=A0 11 ++++
>> =C2=A0drivers/mmc/host/dw_mmc.c =C2=A0| =C2=A0126 ++++++++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0drivers/mmc/host/dw_mmc.h =C2=A0| =C2=A0 12 ++++
>> =C2=A0include/linux/mmc/dw_mmc.h | =C2=A0 =C2=A04 ++
>> =C2=A04 files changed, 153 insertions(+), 0 deletions(-)
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
>> index ff0f714..74f28a5 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -21,7 +21,11 @@
>> =C2=A0#include <linux/interrupt.h>
>> =C2=A0#include <linux/ioport.h>
>> =C2=A0#include <linux/module.h>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +#include <linux/pci.h>
>> +#else
>> =C2=A0#include <linux/platform_device.h>
>> +#endif
>> =C2=A0#include <linux/scatterlist.h>
>> =C2=A0#include <linux/seq_file.h>
>> =C2=A0#include <linux/slab.h>
>> @@ -101,6 +105,18 @@ struct dw_mci_slot {
>> =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 last_detect_state;
>> =C2=A0};
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static struct pci_device_id dw_mci_id =C2=A0=3D { =C2=A0PCI_DEVICE(=
DEVICE_ID, VENDOR_ID) };
>> +
>> +struct dw_mci_board pci_board_data =3D {
>> + =C2=A0 =C2=A0 .num_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
>> + =C2=A0 =C2=A0 .caps =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D DW_MCI_CAPABILITIES,
>> + =C2=A0 =C2=A0 .bus_hz =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 33 * 1000 * 1000,
>> + =C2=A0 =C2=A0 .detect_delay_ms =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D 200,
>> + =C2=A0 =C2=A0 .fifo_depth =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 32,
>> +};
>> +#endif
>> +
>> =C2=A0static struct workqueue_struct *dw_mci_card_workqueue;
>>
>> =C2=A0#if defined(CONFIG_DEBUG_FS)
>> @@ -682,6 +698,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot *slot =3D mmc_priv(mmc);
>> =C2=A0 =C2=A0 =C2=A0 u32 regs;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 u32 card_detect;
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 /* set default 1 bit mode */
>> =C2=A0 =C2=A0 =C2=A0 slot->ctype =3D SDMMC_CTYPE_1BIT;
>> @@ -716,7 +735,15 @@ static void dw_mci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
>> =C2=A0 =C2=A0 =C2=A0 switch (ios->power_mode) {
>> =C2=A0 =C2=A0 =C2=A0 case MMC_POWER_UP:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(DW_MMC_CARD=
_NEED_INIT, &slot->flags);
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable Power to the c=
ard that has been detected */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card_detect =3D mci_read=
l(slot->host, CDETECT);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->host, P=
WREN, ((~card_detect) & 0x1));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case MMC_POWER_OFF:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->host, P=
WREN, 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 default:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> =C2=A0 =C2=A0 =C2=A0 }
>> @@ -1775,7 +1802,12 @@ static bool mci_wait_reset(struct device *dev=
, struct dw_mci *host)
>> =C2=A0 =C2=A0 =C2=A0 return false;
>> =C2=A0}
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static int __devinit dw_mci_probe(struct pci_dev *pdev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct pci_device_id *entr=
ies)
>> +#else
>> =C2=A0static int dw_mci_probe(struct platform_device *pdev)
>> +#endif
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host;
>> =C2=A0 =C2=A0 =C2=A0 struct resource *regs;
>> @@ -1783,6 +1815,16 @@ static int dw_mci_probe(struct platform_devic=
e *pdev)
>> =C2=A0 =C2=A0 =C2=A0 int irq, ret, i, width;
>> =C2=A0 =C2=A0 =C2=A0 u32 fifo_size;
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 ret =3D pci_enable_device(pdev);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 if (pci_request_regions(pdev, "dw_mmc")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 irq =3D pdev->irq;
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 regs =3D platform_get_resource(pdev, IORESOURCE=
_MEM, 0);
>> =C2=A0 =C2=A0 =C2=A0 if (!regs)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENXIO;
>> @@ -1790,19 +1832,26 @@ static int dw_mci_probe(struct platform_devi=
ce *pdev)
>> =C2=A0 =C2=A0 =C2=A0 irq =3D platform_get_irq(pdev, 0);
>> =C2=A0 =C2=A0 =C2=A0 if (irq < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return irq;
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 host =3D kzalloc(sizeof(struct dw_mci), GFP_KER=
NEL);
>> =C2=A0 =C2=A0 =C2=A0 if (!host)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>>
>> =C2=A0 =C2=A0 =C2=A0 host->pdev =3D pdev;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 host->pdata =3D pdata =3D &pci_board_data;
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 host->pdata =3D pdata =3D pdev->dev.platform_da=
ta;
>> +#endif
>> +#ifndef CONFIG_MMC_DW_PCI
>> =C2=A0 =C2=A0 =C2=A0 if (!pdata || !pdata->init) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "Platform data must supply init function\n");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>> =C2=A0 =C2=A0 =C2=A0 }
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!pdata->select_slot && pdata->num_slots > 1=
) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,
>> @@ -1825,9 +1874,17 @@ static int dw_mci_probe(struct platform_devic=
e *pdev)
>> =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&host->queue);
>>
>> =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 host->regs =3D pci_iomap(pdev, PCI_BAR_NO, COMPLETE_=
BAR);
>> + =C2=A0 =C2=A0 if (!host->regs) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EIO;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_res;
>> + =C2=A0 =C2=A0 }
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 host->regs =3D ioremap(regs->start, resource_si=
ze(regs));
>> =C2=A0 =C2=A0 =C2=A0 if (!host->regs)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_freehost;
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 host->dma_ops =3D pdata->dma_ops;
>> =C2=A0 =C2=A0 =C2=A0 dw_mci_init_dma(host);
>> @@ -1903,11 +1960,19 @@ static int dw_mci_probe(struct platform_devi=
ce *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_dmaunmap;
>> =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&host->card_work, dw_mci_work_routine=
_card);
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 ret =3D request_irq(irq, dw_mci_interrupt, IRQF_SHAR=
ED, "dw-mci", host);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 ret =3D request_irq(irq, dw_mci_interrupt, 0, "=
dw-mci", host);
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 if (ret)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_workqueue;
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 pci_set_drvdata(pdev, host);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 if (host->pdata->num_slots)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->num_slots =3D=
 host->pdata->num_slots;
>> @@ -1966,21 +2031,38 @@ err_dmaunmap:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_put(host-=
>vmmc);
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +err_free_res:
>> + =C2=A0 =C2=A0 pci_release_regions(pdev);
>> +#endif
>>
>> =C2=A0err_freehost:
>> =C2=A0 =C2=A0 =C2=A0 kfree(host);
>> =C2=A0 =C2=A0 =C2=A0 return ret;
>> =C2=A0}
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static void __devexit dw_mci_remove(struct pci_dev *pdev)
>> +#else
>> =C2=A0static int __exit dw_mci_remove(struct platform_device *pdev)
>> +#endif
>> =C2=A0{
>> +
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 int i;
>>
>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, INTMASK, 0); /* disable all mm=
c interrupt first */
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 pci_set_drvdata(pdev, NULL);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev,=
 "remove slot %d\n", i);
>> @@ -1992,7 +2074,11 @@ static int __exit dw_mci_remove(struct platfo=
rm_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, CLKENA, 0);
>> =C2=A0 =C2=A0 =C2=A0 mci_writel(host, CLKSRC, 0);
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 free_irq(pdev->irq, host);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 free_irq(platform_get_irq(pdev, 0), host);
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 destroy_workqueue(dw_mci_card_workqueue);
>> =C2=A0 =C2=A0 =C2=A0 dma_free_coherent(&pdev->dev, PAGE_SIZE, host->=
sg_cpu, host->sg_dma);
>>
>> @@ -2006,18 +2092,31 @@ static int __exit dw_mci_remove(struct platf=
orm_device *pdev)
>>
>> =C2=A0 =C2=A0 =C2=A0 iounmap(host->regs);
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 pci_release_regions(pdev);
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 kfree(host);
>> +#ifndef CONFIG_MMC_DW_PCI
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> +#endif
>> =C2=A0}
>>
>> =C2=A0#ifdef CONFIG_PM
>> =C2=A0/*
>> =C2=A0 * TODO: we should probably disable the clock to the card in t=
he suspend path.
>> =C2=A0 */
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static int dw_mci_suspend(struct pci_dev *pdev, pm_message_t mesg)
>> +#else
>> =C2=A0static int dw_mci_suspend(struct platform_device *pdev, pm_mes=
sage_t mesg)
>> +#endif
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int i, ret;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < host->num_slots; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot =
*slot =3D host->slot[i];
>> @@ -2040,10 +2139,18 @@ static int dw_mci_suspend(struct platform_de=
vice *pdev, pm_message_t mesg)
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static int dw_mci_resume(struct pci_dev *pdev)
>> +#else
>> =C2=A0static int dw_mci_resume(struct platform_device *pdev)
>> +#endif
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int i, ret;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host =3D platform_get_drvdata(pd=
ev);
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 if (host->vmmc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_enable(ho=
st->vmmc);
>> @@ -2081,6 +2188,16 @@ static int dw_mci_resume(struct platform_devi=
ce *pdev)
>> =C2=A0#define dw_mci_resume =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL
>> =C2=A0#endif /* CONFIG_PM */
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static struct pci_driver dw_mci_driver =3D {
>> + =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "dw_mmc=
",
>> + =C2=A0 =C2=A0 .id_table =C2=A0 =C2=A0 =C2=A0 =3D &dw_mci_id,
>> + =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_=
probe,
>> + =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_remov=
e,
>> + =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_suspe=
nd,
>> + =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mci_resum=
e,
>> +};
>> +#else
>> =C2=A0static struct platform_driver dw_mci_driver =3D {
>> =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __exit_=
p(dw_mci_remove),
>> =C2=A0 =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mci_=
suspend,
>> @@ -2089,15 +2206,24 @@ static struct platform_driver dw_mci_driver =
=3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "dw_mmc",
>> =C2=A0 =C2=A0 =C2=A0 },
>> =C2=A0};
>> +#endif
>>
>> =C2=A0static int __init dw_mci_init(void)
>> =C2=A0{
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 return pci_register_driver(&dw_mci_driver);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 return platform_driver_probe(&dw_mci_driver, dw=
_mci_probe);
>> +#endif
>> =C2=A0}
>>
>> =C2=A0static void __exit dw_mci_exit(void)
>> =C2=A0{
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 pci_unregister_driver(&dw_mci_driver);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&dw_mci_driver);
>> +#endif
>
>
> I can't help thinking a lot of this could be abstracted better withou=
t
> having to have quite so many #ifdefs. e.g. have generic
> probe/remove/suspend/resume functions which just work with a struct
> dw_mci, and handle any differences based on information in that struc=
t,
> or let the caller handle the differences and pass the relevant
> information in. The PCI/platform specific code would then be nicely
> grouped together in fewer ifdefs. Have you looked at how other driver=
s
> handle this situation?
>
>> =C2=A0}
>>
>> =C2=A0module_init(dw_mci_init);
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 027d377..3b1e459 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -164,4 +164,16 @@
>> =C2=A0 =C2=A0 =C2=A0 (*(volatile u64 __force *)((dev)->regs + SDMMC_=
##reg) =3D (value))
>> =C2=A0#endif
>>
>> +/* PCI Specific macros */
>> +#ifdef CONFIG_MMC_DW_PCI
>> +#define PCI_BAR_NO 2
>> +#define COMPLETE_BAR 0
>> +/* Dummy Device Id and Vendor Id */
>
> In what way are they dummy?
>
>> +#define VENDOR_ID 0x700
>> +#define DEVICE_ID 0x1107
>> +/* Defining the Capabilities */
>> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHS=
PEED |\
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DATA | MMC_CAP_SDIO_IRQ)
>> +#endif
>> +
>> =C2=A0#endif /* _DW_MMC_H_ */
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 6b46819..87af5a6 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -147,7 +147,11 @@ struct dw_mci {
>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 current_speed;
>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 num_slots;
>> =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 fifoth_val;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 struct pci_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pd=
ev;
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 struct platform_device =C2=A0*pdev;
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_board =C2=A0 =C2=A0 *pdata;
>> =C2=A0 =C2=A0 =C2=A0 struct dw_mci_slot =C2=A0 =C2=A0 =C2=A0*slot[MA=
X_MCI_SLOTS];
>>
>
> Cheers
> James
>
>



--=20
regards,
Shashidhar Hiremath
