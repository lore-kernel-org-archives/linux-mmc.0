From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc: Support of PCI mode for the dw_mmc driver This
 Patch adds the support for the scenario where the Synopsys Designware IP is
 present on the PCI bus.The patch adds the minimal modifications necessary for
 the driver to work on PCI pl
Date: Thu, 29 Sep 2011 10:19:38 +0530
Message-ID: <CANYdXnr+uHW5kq==tVkYAwY10qmZzxhWz-=bjbRJ3j10jjL+dA@mail.gmail.com>
References: <CAFbHwiQ1zKPUjXLinZukbgbz1wqFs9q93W6y_owLiTvn=i-=Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:32963 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab1I2Etj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 00:49:39 -0400
Received: by ywb5 with SMTP id 5so197666ywb.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 21:49:39 -0700 (PDT)
In-Reply-To: <CAFbHwiQ1zKPUjXLinZukbgbz1wqFs9q93W6y_owLiTvn=i-=Bw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

Hi Will,

On Wed, Sep 28, 2011 at 9:03 PM, Will Newton <will.newton@gmail.com> wr=
ote:
> On Wed, Sep 28, 2011 at 4:02 PM, Shashidhar Hiremath
> <shashidharh@vayavyalabs.com> wrote:
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
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
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block, this provides host support =
for SD and MMC interfaces, in both
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PIO and external DMA modes.
>>
>> +config MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 bool "MMC_DW Support On PCI bus"
>> + =C2=A0 =C2=A0 =C2=A0 depends on MMC_DW && PCI
>> + =C2=A0 =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 This selects the PCI for the Synopsys =
Designware Mobile Storage IP.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you have a controller with this int=
erface, say Y or M here.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
>> +
>> +
>> =C2=A0config MMC_DW_IDMAC
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Internal DMAC interface"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MMC_DW
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
>
> This doesn't need an #ifdef.
>
>> =C2=A0#include <linux/scatterlist.h>
>> =C2=A0#include <linux/seq_file.h>
>> =C2=A0#include <linux/slab.h>
>> @@ -101,6 +105,18 @@ struct dw_mci_slot {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_detect_state;
>> =C2=A0};
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static struct pci_device_id dw_mci_id =C2=A0=3D { =C2=A0PCI_DEVICE(=
DEVICE_ID, VENDOR_ID) };
>> +
>> +struct dw_mci_board pci_board_data =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .num_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
>> + =C2=A0 =C2=A0 =C2=A0 .caps =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D DW_MCI_CAPABILITI=
ES,
>> + =C2=A0 =C2=A0 =C2=A0 .bus_hz =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 33 * 1000 * 1000,
>
> Is this value correct? The bus this refers to is the SD bus, so 33MHz
> is not fast.
  I got the driver working with this frequency.Will check the optimal v=
alue.
>
>> + =C2=A0 =C2=A0 =C2=A0 .detect_delay_ms =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 200,
>> + =C2=A0 =C2=A0 =C2=A0 .fifo_depth =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 32,
>> +};
>> +#endif
>> +
>> =C2=A0static struct workqueue_struct *dw_mci_card_workqueue;
>>
>> =C2=A0#if defined(CONFIG_DEBUG_FS)
>> @@ -682,6 +698,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci_slot *slot =3D mmc_priv(mmc=
);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 regs;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 u32 card_detect;
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set default 1 bit mode */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0slot->ctype =3D SDMMC_CTYPE_1BIT;
>> @@ -716,7 +735,15 @@ static void dw_mci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (ios->power_mode) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0case MMC_POWER_UP:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(DW_MM=
C_CARD_NEED_INIT, &slot->flags);
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable Power t=
o the card that has been detected */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card_detect =3D m=
ci_readl(slot->host, CDETECT);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->=
host, PWREN, ((~card_detect) & 0x1));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 case MMC_POWER_OFF:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slot->=
host, PWREN, 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> +#endif
>
> It may be safe to not #ifdef this, all the hardware I have uses an
> external regulator so the PWREN bits do nothing. I could imagine
> hardware that was non-PCI that could use PWREN however.
The hardware that I was using required this to be done .else there was
not power to the card.
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> @@ -1775,7 +1802,12 @@ static bool mci_wait_reset(struct device *dev=
, struct dw_mci *host)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
>> =C2=A0}
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static int __devinit dw_mci_probe(struct pci_dev *pdev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct pci_device_i=
d *entries)
>> +#else
>> =C2=A0static int dw_mci_probe(struct platform_device *pdev)
>> +#endif
>
> Possibly it would be better to split this into three functions:
>
> dw_mci_pci_probe
> dw_mci_platform_probe
> dw_mci_probe
>
> And then the pci/platform probe functions can call the generic probe
> function to do the common parts of the setup.
>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static void __devexit dw_mci_remove(struct pci_dev *pdev)
>> +#else
>> =C2=A0static int __exit dw_mci_remove(struct platform_device *pdev)
>> +#endif
>
> Again this should probably be split into separate functions to reduce
> the number of #ifdefs.
>
>> =C2=A0{
>> +
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev)=
;
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci *host =3D platform_get_drvd=
ata(pdev);
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(host, INTMASK, 0); /* disable =
all mmc interrupt first */
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 pci_set_drvdata(pdev, NULL);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, NULL);
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < host->num_slots; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&pdev=
->dev, "remove slot %d\n", i);
>> @@ -1992,7 +2074,11 @@ static int __exit dw_mci_remove(struct platfo=
rm_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(host, CLKENA, 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(host, CLKSRC, 0);
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 free_irq(pdev->irq, host);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0free_irq(platform_get_irq(pdev, 0), host)=
;
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_workqueue(dw_mci_card_workqueue);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_free_coherent(&pdev->dev, PAGE_SIZE, =
host->sg_cpu, host->sg_dma);
>>
>> @@ -2006,18 +2092,31 @@ static int __exit dw_mci_remove(struct platf=
orm_device *pdev)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(host->regs);
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 pci_release_regions(pdev);
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(host);
>> +#ifndef CONFIG_MMC_DW_PCI
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> +#endif
>> =C2=A0}
>>
>> =C2=A0#ifdef CONFIG_PM
>> =C2=A0/*
>> =C2=A0* TODO: we should probably disable the clock to the card in th=
e suspend path.
>> =C2=A0*/
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static int dw_mci_suspend(struct pci_dev *pdev, pm_message_t mesg)
>> +#else
>> =C2=A0static int dw_mci_suspend(struct platform_device *pdev, pm_mes=
sage_t mesg)
>> +#endif
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, ret;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev)=
;
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci *host =3D platform_get_drvd=
ata(pdev);
>> +#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < host->num_slots; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci=
_slot *slot =3D host->slot[i];
>> @@ -2040,10 +2139,18 @@ static int dw_mci_suspend(struct platform_de=
vice *pdev, pm_message_t mesg)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> =C2=A0}
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static int dw_mci_resume(struct pci_dev *pdev)
>> +#else
>> =C2=A0static int dw_mci_resume(struct platform_device *pdev)
>> +#endif
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, ret;
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 struct dw_mci *host =3D pci_get_drvdata(pdev)=
;
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci *host =3D platform_get_drvd=
ata(pdev);
>> +#endif
>
> Even though these functions are quite simple it would be better to co=
de them as
>
> dw_mci_platform_resume(struct platform_device *pdev)
> =C2=A0calling dw_mci_resume(struct dw_mci *host)
>
> dw_mci_pci_resume(struct pci_dev *pdev)
> =C2=A0calling dw_mci_resume(struct dw_mci *host)
>
> To reduce the #ifdef overhead.
I will add separate functions for probe/suspend/resume/remove etc for
PCI/non-PCI.
>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host->vmmc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regulator_ena=
ble(host->vmmc);
>> @@ -2081,6 +2188,16 @@ static int dw_mci_resume(struct platform_devi=
ce *pdev)
>> =C2=A0#define dw_mci_resume =C2=A0NULL
>> =C2=A0#endif /* CONFIG_PM */
>>
>> +#ifdef CONFIG_MMC_DW_PCI
>> +static struct pci_driver dw_mci_driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
"dw_mmc",
>> + =C2=A0 =C2=A0 =C2=A0 .id_table =C2=A0 =C2=A0 =C2=A0 =3D &dw_mci_id=
,
>> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
dw_mci_probe,
>> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mc=
i_remove,
>> + =C2=A0 =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dw_mc=
i_suspend,
>> + =C2=A0 =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D dw_mc=
i_resume,
>> +};
>> +#else
>> =C2=A0static struct platform_driver dw_mci_driver =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D _=
_exit_p(dw_mci_remove),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D d=
w_mci_suspend,
>> @@ -2089,15 +2206,24 @@ static struct platform_driver dw_mci_driver =
=3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "dw_mmc",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
>> =C2=A0};
>> +#endif
>>
>> =C2=A0static int __init dw_mci_init(void)
>> =C2=A0{
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 return pci_register_driver(&dw_mci_driver);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return platform_driver_probe(&dw_mci_driv=
er, dw_mci_probe);
>> +#endif
>> =C2=A0}
>>
>> =C2=A0static void __exit dw_mci_exit(void)
>> =C2=A0{
>> +#ifdef CONFIG_MMC_DW_PCI
>> + =C2=A0 =C2=A0 =C2=A0 pci_unregister_driver(&dw_mci_driver);
>> +#else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_driver_unregister(&dw_mci_driver=
);
>> +#endif
>> =C2=A0}
>>
>> =C2=A0module_init(dw_mci_init);
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 027d377..3b1e459 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -164,4 +164,16 @@
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(*(volatile u64 __force *)((dev)->regs + =
SDMMC_##reg) =3D (value))
>> =C2=A0#endif
>>
>> +/* PCI Specific macros */
>> +#ifdef CONFIG_MMC_DW_PCI
>> +#define PCI_BAR_NO 2
>> +#define COMPLETE_BAR 0
>> +/* Dummy Device Id and Vendor Id */
>> +#define VENDOR_ID 0x700
>> +#define DEVICE_ID 0x1107
>> +/* Defining the Capabilities */
>> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHS=
PEED |\
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DATA | MMC_CAP_SD=
IO_IRQ)
>> +#endif
>> +
>
> Are these all necessary?
I feel the defines other than capabilities are necessary  are a
must,but will validate them once again
>



--=20
regards,
Shashidhar Hiremath
