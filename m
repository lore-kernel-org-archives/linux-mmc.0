From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of SDIO irq for dw_mmc
Date: Tue, 23 Aug 2011 15:26:56 +0100
Message-ID: <CAAG0J99+=9Hsu7w_TMKcgKXAdEC100RftwGX=gJdiT38eQsSDg@mail.gmail.com>
References: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41463 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab1HWO05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2011 10:26:57 -0400
Received: by qyk38 with SMTP id 38so2002162qyk.19
        for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 07:26:57 -0700 (PDT)
In-Reply-To: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi,

On 23 August 2011 14:20, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> The Patch adds the support for SDIO interrupts for all slots.
> It includes enabling of SDIO interrupts through dw_mci_enable_sdio_ir=
q
> and the handling of the slot specific interrupts in the Interrupt Ser=
vice
> Routine.
>
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> v2:
> * As per Suggestions by James Hogan
> -fixed code that was disabling other interrupts.
> -removed [int_mask &=3D 0xFFFF0000; and int_mask &=3D 0xFFFF0000;] as=
 it
> was unnecessary
> -modified (slot->id + 16) with appropriate Macro SDMMC_INT_SDIO(i)
> =A0drivers/mmc/host/dw_mmc.c | =A0 35 +++++++++++++++++++++++++++++++=
----
> =A0drivers/mmc/host/dw_mmc.h | =A0 =A02 +-
> =A02 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 66dcddb..b06f8f1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -746,11 +746,29 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
> =A0 =A0 =A0 =A0return present;
> =A0}
>
> +static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
> +{
> + =A0 =A0 =A0 struct dw_mci_slot *slot =3D mmc_priv(mmc);
> + =A0 =A0 =A0 struct dw_mci *host =3D slot->host;
> + =A0 =A0 =A0 u32 int_mask;
> +
> + =A0 =A0 =A0 /* Enable/disable Slot Specific SDIO interrupt */
> + =A0 =A0 =A0 int_mask =3D mci_readl(host, INTMASK);
> + =A0 =A0 =A0 if (enb) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, INTMASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(int_mask | (1 <=
< SDMMC_INT_SDIO(slot->id))));
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, INTMASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(int_mask & ~(1 =
<< SDMMC_INT_SDIO(slot->id))));
> + =A0 =A0 =A0 }
> +}
> +
> =A0static const struct mmc_host_ops dw_mci_ops =3D {
> - =A0 =A0 =A0 .request =A0 =A0 =A0 =A0=3D dw_mci_request,
> - =A0 =A0 =A0 .set_ios =A0 =A0 =A0 =A0=3D dw_mci_set_ios,
> - =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D dw_mci_get_ro,
> - =A0 =A0 =A0 .get_cd =A0 =A0 =A0 =A0 =3D dw_mci_get_cd,
> + =A0 =A0 =A0 .request =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D dw_mci_requ=
est,
> + =A0 =A0 =A0 .set_ios =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D dw_mci_set_=
ios,
> + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D dw_mci_get_=
ro,
> + =A0 =A0 =A0 .get_cd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D dw_mci_get_=
cd,
> + =A0 =A0 =A0 .enable_sdio_irq =A0 =A0 =A0 =A0=3D dw_mci_enable_sdio_=
irq,
> =A0};
>
> =A0static void dw_mci_request_end(struct dw_mci *host, struct mmc_req=
uest *mrq)
> @@ -1179,6 +1197,7 @@ static irqreturn_t dw_mci_interrupt(int irq, vo=
id *dev_id)
> =A0 =A0 =A0 =A0struct dw_mci *host =3D dev_id;
> =A0 =A0 =A0 =A0u32 status, pending;
> =A0 =A0 =A0 =A0unsigned int pass_count =3D 0;
> + =A0 =A0 =A0 int i;
>
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D mci_readl(host, RINTSTS);
> @@ -1249,6 +1268,14 @@ static irqreturn_t dw_mci_interrupt(int irq,
> void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tasklet_schedule(&host=
->card_tasklet);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Handle SDIO Interrupts */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < host->num_slots; i++)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dw_mci_slot *slo=
t =3D host->slot[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pending & SDMMC_INT=
_SDIO(i)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_wri=
tel(host, RINTSTS, SDMMC_INT_SDIO(i));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sig=
nal_sdio_irq(slot->mmc);

A potential problem that just occured to me, is that the TRM says (in
the note after the table of interrupt status bits):
"The SDIO interrupts, receive fifo data request (RXDR), and transmit
=46IFO data request (txdr) are set by level-sensitive interrupt sources=
=2E
Therefore, the interrupt source should be first cleared before you can
clear the interrupt bit of the Raw interrupt register"

I'm guessing the source would get cleared somewhere in the
mmc_signal_sdio_irq function, depending on the sdio driver, therefore
I think it'd be more correct to clear each interrupt after the
mmc_signal_sdio_irq() call to prevent it immediately retriggering.

Cheers
James

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0} while (pass_count++ < 5);
>
> =A0#ifdef CONFIG_MMC_DW_IDMAC
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 23c662a..ecf1043 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -82,7 +82,7 @@
> =A0#define SDMMC_CTYPE_4BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> =A0#define SDMMC_CTYPE_1BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0/* Interrupt status & mask register defines */
> -#define SDMMC_INT_SDIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(16)
> +#define SDMMC_INT_SDIO(n) =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT((16 + (n)))
> =A0#define SDMMC_INT_EBE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(15)
> =A0#define SDMMC_INT_ACD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(14)
> =A0#define SDMMC_INT_SBE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(13)
> --
> 1.7.2.3
>
>
> --
> regards,
> Shashidhar Hiremath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
James Hogan
