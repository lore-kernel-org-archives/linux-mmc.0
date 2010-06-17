From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] MMC driver full patch for Moorestown platform
Date: Fri, 18 Jun 2010 08:56:59 +0900
Message-ID: <AANLkTimFAYL_Kgr1KMGScctaZq4UX41ORuKAuxqbMlcs@mail.gmail.com>
References: <20100617151623.9951.41387.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39610 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab0FQX5A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2010 19:57:00 -0400
Received: by vws18 with SMTP id 18so80877vws.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2010 16:57:00 -0700 (PDT)
In-Reply-To: <20100617151623.9951.41387.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: pierre@ossman.eu, linux-mmc@vger.kernel.org

On Fri, Jun 18, 2010 at 12:17 AM, Alan Cox <alan@linux.intel.com> wrote=
:
> From: JiebingLi <jiebing.li@intel.com>
>
> This patch enables Moorestown Langwell A-3 platform.
>
> The main thrust of this is adding support for serialization of device=
s as
> we do on various other bits of hardware with bugs. We also deal with =
spurious
> interrupts and clock rewriting.
>
> The PCI handling code is slightly tweaked so that the driver specific=
 methods
> can override the number of slots, and a method provided so devices ca=
n indicate
> they only support one slot even if the PCI config says otherwise.
>
> The serialization support is as clean as we can see how to make it an=
d as
> general as possible - with just one pair of tiny changes to the core =
code
> that can be used by any future driver with such limits.
>
> Quirks tidied up by Alan Cox
>
> Signed-off-by: JiebingLi <jiebing.li@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>
> =A0drivers/mmc/core/core.c =A0 =A0 =A0| =A0 =A06 ++
> =A0drivers/mmc/host/sdhci-pci.c | =A0 48 ++++++++++++++++++-
> =A0drivers/mmc/host/sdhci.c =A0 =A0 | =A0108 ++++++++++++++++++++++++=
++++++++++--------
> =A0drivers/mmc/host/sdhci.h =A0 =A0 | =A0 =A07 +++
> =A0include/linux/mmc/host.h =A0 =A0 | =A0 =A02 +
> =A0include/linux/pci_ids.h =A0 =A0 =A0| =A0 =A02 +
> =A06 files changed, 151 insertions(+), 22 deletions(-)
>
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 569e94d..10d1c8d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -213,9 +213,15 @@ void mmc_wait_for_req(struct mmc_host *host, str=
uct mmc_request *mrq)
> =A0 =A0 =A0 =A0mrq->done_data =3D &complete;
> =A0 =A0 =A0 =A0mrq->done =3D mmc_wait_done;
>
> + =A0 =A0 =A0 if (host->port_mutex)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(host->port_mutex);
> +
> =A0 =A0 =A0 =A0mmc_start_request(host, mrq);
>
> =A0 =A0 =A0 =A0wait_for_completion(&complete);
> +
> + =A0 =A0 =A0 if (host->port_mutex)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(host->port_mutex);
> =A0}
>
> =A0EXPORT_SYMBOL(mmc_wait_for_req);
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pc=
i.c
> index 65483fd..9ce725b 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -39,6 +39,8 @@
>
> =A0#define MAX_SLOTS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08
>
> +static DEFINE_MUTEX(port_mutex);
> +
> =A0struct sdhci_pci_chip;
> =A0struct sdhci_pci_slot;
>
> @@ -364,6 +366,30 @@ static const struct sdhci_pci_fixes sdhci_via =3D=
 {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D via_probe,
> =A0};
>
> +static int single_slot(struct sdhci_pci_chip *chip)
> +{
> + =A0 =A0 =A0 chip->num_slots =3D 1;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * ADMA operation is disabled for Moorestown platform due to
> + * hardware bugs.
> + */
> +static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 =3D {
> + =A0 =A0 =A0 .quirks =A0 =A0 =A0 =A0 =3D SDHCI_QUIRK_BROKEN_ADMA |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_SERIALI=
ZE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_BROKEN_=
RESETALL |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_FORCE_F=
ULL_SPEED_MODE,
> +};
> +
> +static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1 =3D {
> + =A0 =A0 =A0 .quirks =A0 =A0 =A0 =A0 =3D SDHCI_QUIRK_BROKEN_ADMA |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_BROKEN_=
RESETALL |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_FORCE_F=
ULL_SPEED_MODE,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D single_slot
> +};
> +
> =A0static const struct pci_device_id pci_ids[] __devinitdata =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR=
_ID_RICOH,
> @@ -445,6 +471,22 @@ static const struct pci_device_id pci_ids[] __de=
vinitdata =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.driver_data =A0 =A0=3D (kernel_ulong_=
t)&sdhci_via,
> =A0 =A0 =A0 =A0},
>
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR_=
ID_INTEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D PCI_DEVICE_=
ID_INTEL_MRST_SD0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subvendor =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subdevice =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D (kernel_ulong_t=
)&sdhci_intel_mrst_hc0,
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR_=
ID_INTEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D PCI_DEVICE_=
ID_INTEL_MRST_SD1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subvendor =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subdevice =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D (kernel_ulong_t=
)&sdhci_intel_mrst_hc1,
> + =A0 =A0 =A0 },
> +
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 /* Generic SD host controller */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDH=
CI << 8), 0xFFFF00)
> =A0 =A0 =A0 =A0},
> @@ -643,6 +685,9 @@ static struct sdhci_pci_slot * __devinit sdhci_pc=
i_probe_slot(
>
> =A0 =A0 =A0 =A0host->irq =3D pdev->irq;
>
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_SERIALIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->port_mutex =3D &port_mutex;
> +
> =A0 =A0 =A0 =A0ret =3D pci_request_region(pdev, bar, mmc_hostname(hos=
t->mmc));
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "cannot request re=
gion\n");
> @@ -728,6 +773,7 @@ static int __devinit sdhci_pci_probe(struct pci_d=
ev *pdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> =A0 =A0 =A0 =A0slots =3D PCI_SLOT_INFO_SLOTS(slots) + 1;
> +
> =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
> =A0 =A0 =A0 =A0if (slots =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> @@ -769,7 +815,7 @@ static int __devinit sdhci_pci_probe(struct pci_d=
ev *pdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 for (i =3D 0;i < slots;i++) {
> + =A0 =A0 =A0 for (i =3D 0;i < chip->num_slots;i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0slot =3D sdhci_pci_probe_slot(pdev, ch=
ip, first_bar + i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(slot)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i--;i >=3D 0;i--)
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..e720106 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -162,9 +162,11 @@ static void sdhci_reset(struct sdhci_host *host,=
 u8 mask)
> =A0 =A0 =A0 =A0/* hw clears the bit when it's done */
> =A0 =A0 =A0 =A0while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (timeout =3D=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Re=
set 0x%x never completed.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(host->mmc), (int)mask);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_dumpregs(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(host->quirks & SD=
HCI_QUIRK_BROKEN_RESETALL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR "%s: Reset 0x%x never completed.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host->mmc), (int)mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_d=
umpregs(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout--;
> @@ -179,10 +181,19 @@ static void sdhci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios);
>
> =A0static void sdhci_init(struct sdhci_host *host, int soft)
> =A0{
> - =A0 =A0 =A0 if (soft)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_reset(host, SDHCI_RESET_CMD|SDHCI=
_RESET_DATA);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_reset(host, SDHCI_RESET_ALL);
> + =A0 =A0 =A0 u32 intmask;
> +
> + =A0 =A0 =A0 intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
> + =A0 =A0 =A0 sdhci_writel(host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 intmask & (SDHCI_INT_CARD_INSERT | SDHC=
I_INT_CARD_REMOVE),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_INT_STATUS);
> +
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_BROKEN_RESETALL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (soft)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_reset(host, SDHCI=
_RESET_CMD|SDHCI_RESET_DATA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_reset(host, SDHCI=
_RESET_ALL);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_E=
ND_BIT |
> @@ -195,6 +206,9 @@ static void sdhci_init(struct sdhci_host *host, i=
nt soft)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->clock =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_ios(host->mmc, &host->mmc->i=
os);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* disable wakeup signal during initialization */
> + =A0 =A0 =A0 sdhci_writeb(host, 0x0, SDHCI_WAKE_UP_CONTROL);
> =A0}
>
> =A0static void sdhci_reinit(struct sdhci_host *host)
> @@ -625,11 +639,8 @@ static u8 sdhci_calc_timeout(struct sdhci_host *=
host, struct mmc_data *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (count >=3D 0xF) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: Too large time=
out requested!\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc)=
);
> + =A0 =A0 =A0 if (count >=3D 0xF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count =3D 0xE;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return count;
> =A0}
> @@ -873,6 +884,36 @@ static void sdhci_finish_data(struct sdhci_host =
*host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tasklet_schedule(&host->finish_tasklet=
);
> =A0}
>
> +/*
> + * HW problem exists in LNW A3 so clock register has to be set
> + * for every command if both SDIO0 and SDIO1 are enabled.
> + */
> +static void sdhci_clock_reset(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 u16 clk;
> + =A0 =A0 =A0 unsigned long timeout;
> +
> + =A0 =A0 =A0 clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 clk |=3D SDHCI_CLOCK_CARD_EN;
> + =A0 =A0 =A0 sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 /* Wait max 10 ms */
> + =A0 =A0 =A0 timeout =3D 10;
> + =A0 =A0 =A0 while (!((clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SDHCI_CLOCK_INT_STABLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: In=
ternal clock never "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "stabil=
ised.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(host->mmc));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_dumpregs(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 }
> +}
> +
> =A0static void sdhci_send_command(struct sdhci_host *host, struct mmc=
_command *cmd)
> =A0{
> =A0 =A0 =A0 =A0int flags;
> @@ -940,6 +981,9 @@ static void sdhci_send_command(struct sdhci_host =
*host, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0if (cmd->data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flags |=3D SDHCI_CMD_DATA;
>
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_SERIALIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_clock_reset(host);
> +
> =A0 =A0 =A0 =A0sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),=
 SDHCI_COMMAND);
> =A0}
>
> @@ -1159,12 +1203,23 @@ static void sdhci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
>
> =A0 =A0 =A0 =A0ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
>
> - =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4)
> + =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_8BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> + =A0 =A0 =A0 } else if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_8BITBUS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_4BITBUS;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_8BITBUS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> + =A0 =A0 =A0 }

In the previous patch. I committed the 8-bit support. If this patch is
merged. there's conflict with previous patch.

>
> - =A0 =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_SD_HS)
> +/*
> + * For LNW A3, HISPD bit has to be cleared in order to enable 50MHz =
clock
> + */
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_FULL_SPEED_MODE)=
 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_SD_HS ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ios->timing =3D=3D MMC_TIMING_MMC_HS))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_HISPD;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_HISPD;

it's also added. no HISPD support. of course ths situation is
different. in case of s5pc110 there's no HISPD bit at controller so I
added no HISPD quirks, but in your case, it has HISPD but you don't
want to use it.

Thank you,
Kyungmin Park

> @@ -1365,11 +1420,18 @@ static void sdhci_cmd_irq(struct sdhci_host *=
host, u32 intmask)
> =A0{
> =A0 =A0 =A0 =A0BUG_ON(intmask =3D=3D 0);
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Intel MRST:
> + =A0 =A0 =A0 =A0* HW problem exists in LNW A3 which leads to fake in=
terrupt on SDIO1
> + =A0 =A0 =A0 =A0* if SDIO0 and SDIO1 are both enabled.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0if (!host->cmd) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Got command interr=
upt 0x%08x even "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "though no command oper=
ation was in progress.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc)=
, (unsigned)intmask);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_dumpregs(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_SERIAL=
IZE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Go=
t command interrupt 0x%08x even "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "though=
 no command operation in progress.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(host->mmc), (unsigned)intmask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_dumpregs(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -1676,7 +1738,8 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (debug_quirks)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks =3D debug_quirks;
>
> - =A0 =A0 =A0 sdhci_reset(host, SDHCI_RESET_ALL);
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_BROKEN_RESETALL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_reset(host, SDHCI_RESET_ALL);
>
> =A0 =A0 =A0 =A0host->version =3D sdhci_readw(host, SDHCI_HOST_VERSION=
);
> =A0 =A0 =A0 =A0host->version =3D (host->version & SDHCI_SPEC_VER_MASK=
)
> @@ -1796,8 +1859,11 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> +
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_DO_HISPD)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP_SD_HIGHSPEED | =
MMC_CAP_MMC_HIGHSPEED);
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> @@ -1855,7 +1921,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D (caps & SDHCI_MA=
X_BLOCK_MASK) >>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_=
MAX_BLOCK_SHIFT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->max_blk_size >=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->max_blk_size > 3) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING "%=
s: Invalid maximum block size, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"assum=
ing 512 bytes\n", mmc_hostname(mmc));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D =
0;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..cf96152 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -67,6 +67,7 @@
> =A0#define =A0SDHCI_CTRL_LED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> =A0#define =A0SDHCI_CTRL_4BITBUS =A0 =A00x02
> =A0#define =A0SDHCI_CTRL_HISPD =A0 =A0 =A00x04
> +#define =A0SDHCI_CTRL_8BITBUS =A0 =A00x20
> =A0#define =A0SDHCI_CTRL_DMA_MASK =A0 0x18
> =A0#define =A0 SDHCI_CTRL_SDMA =A0 =A0 =A00x00
> =A0#define =A0 SDHCI_CTRL_ADMA1 =A0 =A0 0x08
> @@ -240,6 +241,12 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<25)
> =A0/* Controller cannot support End Attribute in NOP ADMA descriptor =
*/
> =A0#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<26)
> +/* Controller can only handle full speed mode */
> +#define SDHCI_QUIRK_FORCE_FULL_SPEED_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1<<27)
> +/* Controller has an issue with software reset all function */
> +#define SDHCI_QUIRK_BROKEN_RESETALL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(1<<28)
> +/* Controller has an issue when its two slots enabled together */
> +#define SDHCI_QUIRK_SERIALIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1<<29)
>
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0 =A0=
 =A0 =A0 =A0 =A0/* Device IRQ */
> =A0 =A0 =A0 =A0void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0 =
=A0 /* Mapped address */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f65913c..648740e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -211,6 +211,8 @@ struct mmc_host {
>
> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 *debugfs_root;
>
> + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0*port_mutex;
> +
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 private[0] ____cache=
line_aligned;
> =A0};
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4eb4679..f5ebea1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2398,6 +2398,8 @@
> =A0#define PCI_DEVICE_ID_INTEL_82375 =A0 =A0 =A00x0482
> =A0#define PCI_DEVICE_ID_INTEL_82424 =A0 =A0 =A00x0483
> =A0#define PCI_DEVICE_ID_INTEL_82378 =A0 =A0 =A00x0484
> +#define PCI_DEVICE_ID_INTEL_MRST_SD0 =A0 0x0807
> +#define PCI_DEVICE_ID_INTEL_MRST_SD1 =A0 0x0808
> =A0#define PCI_DEVICE_ID_INTEL_I960 =A0 =A0 =A0 0x0960
> =A0#define PCI_DEVICE_ID_INTEL_I960RM =A0 =A0 0x0962
> =A0#define PCI_DEVICE_ID_INTEL_8257X_SOL =A00x1062
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
