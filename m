From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of SDIO irq for dw_mmc
Date: Wed, 24 Aug 2011 10:27:37 +0100
Message-ID: <CAAG0J9_hj-KOxn-bpCrvqdYHsxWhGcpd-aWsZv09Et_OFQELWA@mail.gmail.com>
References: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
	<CAAG0J99+=9Hsu7w_TMKcgKXAdEC100RftwGX=gJdiT38eQsSDg@mail.gmail.com>
	<CANYdXnpFuVNq9CDUZMNJSvLRPFv0td=iS10cEh3-t+-6HU-F6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46307 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1HXJ1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2011 05:27:37 -0400
Received: by vxi9 with SMTP id 9so834034vxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2011 02:27:37 -0700 (PDT)
In-Reply-To: <CANYdXnpFuVNq9CDUZMNJSvLRPFv0td=iS10cEh3-t+-6HU-F6Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

On 24 August 2011 09:18, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> Hi James,
> =A0 =A0If I understand your concern correctly, for level triggered
> interrupts,the interrupt action needs to taken first,than the
> interrupt source needs to be cleared,only then I can clear Raw
> Interrupt Status register right ?
>
> So ,accordingly ,will the below code be in appropriate order ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pending & SDMMC_INT_SDIO(i)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_signal_sd=
io_irq(slot->mmc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(ho=
st, RINTSTS, SDMMC_INT_SDIO(i));

Having looked in more detail, mmc_signal_sdio_irq() disables the
interrupt and wakes up the sdio irq thread, so the order doesn't make
a difference. Clearing RINTSTS will always just cause it to get set
again until the sdio irq thread runs and clears the interrupt
condition. It still needs to be cleared somewhere though, so assuming
v2 of the patch works,
Acked-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>
>
> On Tue, Aug 23, 2011 at 7:56 PM, James Hogan <james@albanarts.com> wr=
ote:
>> Hi,
>>
>> On 23 August 2011 14:20, Shashidhar Hiremath
>> <shashidharh@vayavyalabs.com> wrote:
>>> The Patch adds the support for SDIO interrupts for all slots.
>>> It includes enabling of SDIO interrupts through dw_mci_enable_sdio_=
irq
>>> and the handling of the slot specific interrupts in the Interrupt S=
ervice
>>> Routine.
>>>
>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>> ---
>>> v2:
>>> * As per Suggestions by James Hogan
>>> -fixed code that was disabling other interrupts.
>>> -removed [int_mask &=3D 0xFFFF0000; and int_mask &=3D 0xFFFF0000;] =
as it
>>> was unnecessary
>>> -modified (slot->id + 16) with appropriate Macro SDMMC_INT_SDIO(i)
>>> =A0drivers/mmc/host/dw_mmc.c | =A0 35 +++++++++++++++++++++++++++++=
++----
>>> =A0drivers/mmc/host/dw_mmc.h | =A0 =A02 +-
>>> =A02 files changed, 32 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 66dcddb..b06f8f1 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -746,11 +746,29 @@ static int dw_mci_get_cd(struct mmc_host *mmc=
)
>>> =A0 =A0 =A0 =A0return present;
>>> =A0}
>>>
>>> +static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>>> +{
>>> + =A0 =A0 =A0 struct dw_mci_slot *slot =3D mmc_priv(mmc);
>>> + =A0 =A0 =A0 struct dw_mci *host =3D slot->host;
>>> + =A0 =A0 =A0 u32 int_mask;
>>> +
>>> + =A0 =A0 =A0 /* Enable/disable Slot Specific SDIO interrupt */
>>> + =A0 =A0 =A0 int_mask =3D mci_readl(host, INTMASK);
>>> + =A0 =A0 =A0 if (enb) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, INTMASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(int_mask | (1=
 << SDMMC_INT_SDIO(slot->id))));
>>> + =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, INTMASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(int_mask & ~(=
1 << SDMMC_INT_SDIO(slot->id))));
>>> + =A0 =A0 =A0 }
>>> +}
>>> +
>>> =A0static const struct mmc_host_ops dw_mci_ops =3D {
>>> - =A0 =A0 =A0 .request =A0 =A0 =A0 =A0=3D dw_mci_request,
>>> - =A0 =A0 =A0 .set_ios =A0 =A0 =A0 =A0=3D dw_mci_set_ios,
>>> - =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D dw_mci_get_ro,
>>> - =A0 =A0 =A0 .get_cd =A0 =A0 =A0 =A0 =3D dw_mci_get_cd,
>>> + =A0 =A0 =A0 .request =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D dw_mci_re=
quest,
>>> + =A0 =A0 =A0 .set_ios =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D dw_mci_se=
t_ios,
>>> + =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D dw_mci_ge=
t_ro,
>>> + =A0 =A0 =A0 .get_cd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D dw_mci_ge=
t_cd,
>>> + =A0 =A0 =A0 .enable_sdio_irq =A0 =A0 =A0 =A0=3D dw_mci_enable_sdi=
o_irq,
>>> =A0};
>>>
>>> =A0static void dw_mci_request_end(struct dw_mci *host, struct mmc_r=
equest *mrq)
>>> @@ -1179,6 +1197,7 @@ static irqreturn_t dw_mci_interrupt(int irq, =
void *dev_id)
>>> =A0 =A0 =A0 =A0struct dw_mci *host =3D dev_id;
>>> =A0 =A0 =A0 =A0u32 status, pending;
>>> =A0 =A0 =A0 =A0unsigned int pass_count =3D 0;
>>> + =A0 =A0 =A0 int i;
>>>
>>> =A0 =A0 =A0 =A0do {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D mci_readl(host, RINTSTS);
>>> @@ -1249,6 +1268,14 @@ static irqreturn_t dw_mci_interrupt(int irq,
>>> void *dev_id)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tasklet_schedule(&ho=
st->card_tasklet);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Handle SDIO Interrupts */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < host->num_slots; i+=
+) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dw_mci_slot *s=
lot =3D host->slot[i];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pending & SDMMC_I=
NT_SDIO(i)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_w=
ritel(host, RINTSTS, SDMMC_INT_SDIO(i));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_s=
ignal_sdio_irq(slot->mmc);
>>
>> A potential problem that just occured to me, is that the TRM says (i=
n
>> the note after the table of interrupt status bits):
>> "The SDIO interrupts, receive fifo data request (RXDR), and transmit
>> FIFO data request (txdr) are set by level-sensitive interrupt source=
s.
>> Therefore, the interrupt source should be first cleared before you c=
an
>> clear the interrupt bit of the Raw interrupt register"
>>
>> I'm guessing the source would get cleared somewhere in the
>> mmc_signal_sdio_irq function, depending on the sdio driver, therefor=
e
>> I think it'd be more correct to clear each interrupt after the
>> mmc_signal_sdio_irq() call to prevent it immediately retriggering.
>>
>> Cheers
>> James
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0} while (pass_count++ < 5);
>>>
>>> =A0#ifdef CONFIG_MMC_DW_IDMAC
>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>> index 23c662a..ecf1043 100644
>>> --- a/drivers/mmc/host/dw_mmc.h
>>> +++ b/drivers/mmc/host/dw_mmc.h
>>> @@ -82,7 +82,7 @@
>>> =A0#define SDMMC_CTYPE_4BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
>>> =A0#define SDMMC_CTYPE_1BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>>> =A0/* Interrupt status & mask register defines */
>>> -#define SDMMC_INT_SDIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(16)
>>> +#define SDMMC_INT_SDIO(n) =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT((16 + (n)=
))
>>> =A0#define SDMMC_INT_EBE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(15)
>>> =A0#define SDMMC_INT_ACD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(14)
>>> =A0#define SDMMC_INT_SBE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(13)
>>> --
>>> 1.7.2.3
>>>
>>>
>>> --
>>> regards,
>>> Shashidhar Hiremath
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>>
>>
>> --
>> James Hogan
>>
>
>
>
> --
> regards,
> Shashidhar Hiremath
>



--=20
James Hogan
