From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/1] mmc: Support of PCI mode for the dw_mmc driver This
 Patch adds the support for the scenario where the Synopsys Designware IP is
 present on the PCI bus.The patch adds the minimal modifications necessary for
 the driver to work on PCI pl
Date: Wed, 28 Sep 2011 16:33:41 +0100
Message-ID: <CAFbHwiQ1zKPUjXLinZukbgbz1wqFs9q93W6y_owLiTvn=i-=Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54741 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab1I1Pdn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 11:33:43 -0400
Received: by ywb5 with SMTP id 5so6495934ywb.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 08:33:42 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

On Wed, Sep 28, 2011 at 4:02 PM, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
>
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> =A0drivers/mmc/host/Kconfig =A0 | =A0 11 ++++
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0126 ++++++++++++++++++++++++++++=
++++++++++++++++
> =A0drivers/mmc/host/dw_mmc.h =A0| =A0 12 ++++
> =A0include/linux/mmc/dw_mmc.h | =A0 =A04 ++
> =A04 files changed, 153 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c87096..84d8908 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -526,6 +526,17 @@ config MMC_DW
> =A0 =A0 =A0 =A0 =A0block, this provides host support for SD and MMC i=
nterfaces, in both
> =A0 =A0 =A0 =A0 =A0PIO and external DMA modes.
>
> +config MMC_DW_PCI
> + =A0 =A0 =A0 bool "MMC_DW Support On PCI bus"
> + =A0 =A0 =A0 depends on MMC_DW && PCI
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This selects the PCI for the Synopsys Designware Mo=
bile Storage IP.
> +
> + =A0 =A0 =A0 =A0 If you have a controller with this interface, say Y=
 or M here.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> +
> +
> =A0config MMC_DW_IDMAC
> =A0 =A0 =A0 =A0bool "Internal DMAC interface"
> =A0 =A0 =A0 =A0depends on MMC_DW
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0f714..74f28a5 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -21,7 +21,11 @@
> =A0#include <linux/interrupt.h>
> =A0#include <linux/ioport.h>
> =A0#include <linux/module.h>
> +#ifdef CONFIG_MMC_DW_PCI
> +#include <linux/pci.h>
> +#else
> =A0#include <linux/platform_device.h>
> +#endif

This doesn't need an #ifdef.

> =A0#include <linux/scatterlist.h>
> =A0#include <linux/seq_file.h>
> =A0#include <linux/slab.h>
> @@ -101,6 +105,18 @@ struct dw_mci_slot {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_detec=
t_state;
> =A0};
>
> +#ifdef CONFIG_MMC_DW_PCI
> +static struct pci_device_id dw_mci_id =A0=3D { =A0PCI_DEVICE(DEVICE_=
ID, VENDOR_ID) };
> +
> +struct dw_mci_board pci_board_data =3D {
> + =A0 =A0 =A0 .num_slots =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 1,
> + =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D DW_MCI_CAPABILITIES,
> + =A0 =A0 =A0 .bus_hz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 33 * 1000 * 1000,

Is this value correct? The bus this refers to is the SD bus, so 33MHz
is not fast.

> + =A0 =A0 =A0 .detect_delay_ms =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 200=
,
> + =A0 =A0 =A0 .fifo_depth =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 32,
> +};
> +#endif
> +
> =A0static struct workqueue_struct *dw_mci_card_workqueue;
>
> =A0#if defined(CONFIG_DEBUG_FS)
> @@ -682,6 +698,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, =
struct mmc_ios *ios)
> =A0{
> =A0 =A0 =A0 =A0struct dw_mci_slot *slot =3D mmc_priv(mmc);
> =A0 =A0 =A0 =A0u32 regs;
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 u32 card_detect;
> +#endif
>
> =A0 =A0 =A0 =A0/* set default 1 bit mode */
> =A0 =A0 =A0 =A0slot->ctype =3D SDMMC_CTYPE_1BIT;
> @@ -716,7 +735,15 @@ static void dw_mci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
> =A0 =A0 =A0 =A0switch (ios->power_mode) {
> =A0 =A0 =A0 =A0case MMC_POWER_UP:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_bit(DW_MMC_CARD_NEED_INIT, &slot->=
flags);
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable Power to the card that has be=
en detected */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_detect =3D mci_readl(slot->host, C=
DETECT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(slot->host, PWREN, ((~card_d=
etect) & 0x1));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case MMC_POWER_OFF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(slot->host, PWREN, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +#endif

It may be safe to not #ifdef this, all the hardware I have uses an
external regulator so the PWREN bits do nothing. I could imagine
hardware that was non-PCI that could use PWREN however.

> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> @@ -1775,7 +1802,12 @@ static bool mci_wait_reset(struct device *dev,=
 struct dw_mci *host)
> =A0 =A0 =A0 =A0return false;
> =A0}
>
> +#ifdef CONFIG_MMC_DW_PCI
> +static int __devinit dw_mci_probe(struct pci_dev *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con=
st struct pci_device_id *entries)
> +#else
> =A0static int dw_mci_probe(struct platform_device *pdev)
> +#endif

Possibly it would be better to split this into three functions:

dw_mci_pci_probe
dw_mci_platform_probe
dw_mci_probe

And then the pci/platform probe functions can call the generic probe
function to do the common parts of the setup.

> +#ifdef CONFIG_MMC_DW_PCI
> +static void __devexit dw_mci_remove(struct pci_dev *pdev)
> +#else
> =A0static int __exit dw_mci_remove(struct platform_device *pdev)
> +#endif

Again this should probably be split into separate functions to reduce
the number of #ifdefs.

> =A0{
> +
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
> +#else
> =A0 =A0 =A0 =A0struct dw_mci *host =3D platform_get_drvdata(pdev);
> +#endif
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0mci_writel(host, RINTSTS, 0xFFFFFFFF);
> =A0 =A0 =A0 =A0mci_writel(host, INTMASK, 0); /* disable all mmc inter=
rupt first */
>
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 pci_set_drvdata(pdev, NULL);
> +#else
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, NULL);
> +#endif
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < host->num_slots; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "remove slot %d\n"=
, i);
> @@ -1992,7 +2074,11 @@ static int __exit dw_mci_remove(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0mci_writel(host, CLKENA, 0);
> =A0 =A0 =A0 =A0mci_writel(host, CLKSRC, 0);
>
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 free_irq(pdev->irq, host);
> +#else
> =A0 =A0 =A0 =A0free_irq(platform_get_irq(pdev, 0), host);
> +#endif
> =A0 =A0 =A0 =A0destroy_workqueue(dw_mci_card_workqueue);
> =A0 =A0 =A0 =A0dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu,=
 host->sg_dma);
>
> @@ -2006,18 +2092,31 @@ static int __exit dw_mci_remove(struct platfo=
rm_device *pdev)
>
> =A0 =A0 =A0 =A0iounmap(host->regs);
>
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 pci_release_regions(pdev);
> +#endif
> =A0 =A0 =A0 =A0kfree(host);
> +#ifndef CONFIG_MMC_DW_PCI
> =A0 =A0 =A0 =A0return 0;
> +#endif
> =A0}
>
> =A0#ifdef CONFIG_PM
> =A0/*
> =A0* TODO: we should probably disable the clock to the card in the su=
spend path.
> =A0*/
> +#ifdef CONFIG_MMC_DW_PCI
> +static int dw_mci_suspend(struct pci_dev *pdev, pm_message_t mesg)
> +#else
> =A0static int dw_mci_suspend(struct platform_device *pdev, pm_message=
_t mesg)
> +#endif
> =A0{
> =A0 =A0 =A0 =A0int i, ret;
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
> +#else
> =A0 =A0 =A0 =A0struct dw_mci *host =3D platform_get_drvdata(pdev);
> +#endif
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < host->num_slots; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct dw_mci_slot *slot =3D host->slo=
t[i];
> @@ -2040,10 +2139,18 @@ static int dw_mci_suspend(struct platform_dev=
ice *pdev, pm_message_t mesg)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#ifdef CONFIG_MMC_DW_PCI
> +static int dw_mci_resume(struct pci_dev *pdev)
> +#else
> =A0static int dw_mci_resume(struct platform_device *pdev)
> +#endif
> =A0{
> =A0 =A0 =A0 =A0int i, ret;
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 struct dw_mci *host =3D pci_get_drvdata(pdev);
> +#else
> =A0 =A0 =A0 =A0struct dw_mci *host =3D platform_get_drvdata(pdev);
> +#endif

Even though these functions are quite simple it would be better to code=
 them as

dw_mci_platform_resume(struct platform_device *pdev)
 calling dw_mci_resume(struct dw_mci *host)

dw_mci_pci_resume(struct pci_dev *pdev)
 calling dw_mci_resume(struct dw_mci *host)

To reduce the #ifdef overhead.

>
> =A0 =A0 =A0 =A0if (host->vmmc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_enable(host->vmmc);
> @@ -2081,6 +2188,16 @@ static int dw_mci_resume(struct platform_devic=
e *pdev)
> =A0#define dw_mci_resume =A0NULL
> =A0#endif /* CONFIG_PM */
>
> +#ifdef CONFIG_MMC_DW_PCI
> +static struct pci_driver dw_mci_driver =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dw_mmc",
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D &dw_mci_id,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D dw_mci_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D dw_mci_remove,
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D dw_mci_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D dw_mci_resume,
> +};
> +#else
> =A0static struct platform_driver dw_mci_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __exit_p(dw_mci_remove),
> =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0=3D dw_mci_suspend,
> @@ -2089,15 +2206,24 @@ static struct platform_driver dw_mci_driver =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "dw_mmc"=
,
> =A0 =A0 =A0 =A0},
> =A0};
> +#endif
>
> =A0static int __init dw_mci_init(void)
> =A0{
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 return pci_register_driver(&dw_mci_driver);
> +#else
> =A0 =A0 =A0 =A0return platform_driver_probe(&dw_mci_driver, dw_mci_pr=
obe);
> +#endif
> =A0}
>
> =A0static void __exit dw_mci_exit(void)
> =A0{
> +#ifdef CONFIG_MMC_DW_PCI
> + =A0 =A0 =A0 pci_unregister_driver(&dw_mci_driver);
> +#else
> =A0 =A0 =A0 =A0platform_driver_unregister(&dw_mci_driver);
> +#endif
> =A0}
>
> =A0module_init(dw_mci_init);
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 027d377..3b1e459 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -164,4 +164,16 @@
> =A0 =A0 =A0 =A0(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) =
=3D (value))
> =A0#endif
>
> +/* PCI Specific macros */
> +#ifdef CONFIG_MMC_DW_PCI
> +#define PCI_BAR_NO 2
> +#define COMPLETE_BAR 0
> +/* Dummy Device Id and Vendor Id */
> +#define VENDOR_ID 0x700
> +#define DEVICE_ID 0x1107
> +/* Defining the Capabilities */
> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSP=
EED |\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_SD_HIGHSPEED=
 | MMC_CAP_8_BIT_DATA | MMC_CAP_SDIO_IRQ)
> +#endif
> +

Are these all necessary?
