From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: Status of tmio_mmc DMA support for SDIO
Date: Fri, 14 May 2010 18:19:34 +0100
Message-ID: <AANLkTikKmiRe0f9UXQo3bkwxjCVPzivTrTEYyzY3DcMB@mail.gmail.com>
References: <A0C4AD4CC48F4CAAA4C9CB027472149D@RSI45> <Pine.LNX.4.64.1005140843320.6147@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57250 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab0ENRT5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 May 2010 13:19:57 -0400
In-Reply-To: <Pine.LNX.4.64.1005140843320.6147@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "Charles D. Krebs" <ckrebs@therealtimegroup.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, sailaja.sdn@redpinesignals.com, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org

Just saw this - am I right in thinking someone has written SDIO
support for TMIO ? Im afraid I dont appear to have the preceeding
emails.

--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 14 May 2010 09:35, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wro=
te:
> (added linux-mmc and tmio_mmc maintainer to CC)
>
> Hi Charles
>
> On Thu, 13 May 2010, Charles D. Krebs wrote:
>
>> Guennadi,
>>
>> I'm currently using the BSP 2.0 release (2.6.33) for the Renesas 772=
4
>> Ecovec platform. =A0I have two patches (see attached) that enable MM=
C
>> support and SDIO support in that version of the Kernel.
>
> Great, thanks for the patches!
>
> Regarding MMCIF, have you seen these patches:
>
> http://article.gmane.org/gmane.linux.kernel.mmc/1712
> http://article.gmane.org/gmane.linux.ports.sh.devel/7860
>
>> I've seen quite a bit of traffic lately over the linux-sh mailing li=
st
>> regarding the addition of DMA to the tmio driver. =A0Unfortunately, =
I
>> really have no good idea as to what the status is of that developmen=
t,
>> and whether or not it would apply to both MMC and SDIO modes of
>> operation.
>
> The status is: it passes my tests, as long as cache is in write-throu=
gh
> mode. However, on ecovec I seem to have problems with SD: a simple
> mount-compare-overwrite-umount loop aborts even without DMA after a f=
ew
> hundreds of iterations (under 600 in one of my tests) and it happens =
even
> faster with DMA. However, I haven't repeated this test with the lates=
t
> version of the patches, will do it at some point.
>
>> That said, it looks like at least patch [4/b9 v4] has a few
>> parts that accomplish both MMC and SDIO support separately.
>
> Really? I was unaware of that;) I don't think there is any SDIO speci=
fic
> code in that or in any other of my patches for tmio_mmc.
>
>> We have an SDIO based 802.11 b/g/n radio that could definitely benef=
it
>> from DMA support. =A0At this point, what patches I would need to app=
ly,
>> and what configuration changes to the kernel are necessary to test t=
his
>> functionality out? =A0Are there any known limitations to the new cod=
e for
>> SDIO support?
>
> This is the basis patch series:
>
> http://thread.gmane.org/gmane.linux.kernel.mmc/1780
>
> in which patch 4/9 you replace with these three patches:
>
> http://thread.gmane.org/gmane.linux.ports.sh.devel/8068
>
> As for SDIO, there's only one limitation: it's not implemented yet;) =
But
> looking at your patch, it looks like it doesn't touch data paths, onl=
y
> command paths. So, so far I don't see any reason, why DMA shouldn't w=
ork
> for you out of the box... However, you seem to have much more knowled=
ge
> about tmio unit internals, so, maybe you can just check with your
> documentation. As for changes - do not forget to enable the shdma
> dmaengine driver. And look in /proc/interrupts during your tests to s=
ee if
> you're getting any DMA interrupts. You shall see two DMA channels, us=
ed
> per SDHI controller - for Tx and Rx.
>
>> We have a team at Redpine Signals in India that is currently working=
 on
>> the implementation of the radio driver. =A0I'd like to introduce Sai=
laja
>> Sankabathula, Applications Engineering Manager, who is managing the
>> project. =A0I know that the Redpine team is eager to work through a =
couple
>> of issues that they are seeing with the current code that we have, a=
nd
>> that they are more than happy to help debug the new DMA enabled driv=
er
>> code and share the results with the community via any means you thin=
k
>> best (I'd presume at least by copying the linux-sh mailing list).
>
> That right, and also the mmc list and the driver maintainer.
>
>> I'm still rather new to the community development aspect of the Linu=
x kernel -
>> Is there somewhere I can read up about the general development proce=
dure
>> here and how to best interface with the mailing lists?
>
> There are a couple of documents in the Linux kernel source tree, that=
 you
> might find useful:
>
> Documentation/SubmitChecklist
> Documentation/SubmittingPatches
> Documentation/SubmittingDrivers
> Documentation/CodingStyle
> Documentation/email-clients.txt
>
>> I tend to feel a little lost in not knowing what version of the kern=
el
>> these patches are referenced to, if the patches are regularly checke=
d
>> into the kernel repository, etc.
>
> Documents under
>
> Documentation/development-process/
>
> should give you an idea. In short: kernel is being developed in multi=
ple
> topic trees, dedicated to various architectures, drivers, subsystems,=
 etc.
> You work with one or several of those trees, relevant for your
> development, submit your patches to respective mailing lists and
> maintainers, and during the merge window (first two weeks after a fin=
al
> kernel version release) those trees get merged into the central kerne=
l
> tree. Bug-fixes can be merged in at any time, of course.
>
> As for your patch, I think, Ian will have a good look at it, so far a
> couple of quick comments:
>
>> diff -Naur sh-2.6_bsp/arch/sh/kernel/cpu/sh4a/setup-sh7724.c sh-2.6_=
presdio/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
>> --- sh-2.6_bsp/arch/sh/kernel/cpu/sh4a/setup-sh7724.c 2010-03-25 04:=
48:00.000000000 +0000
>> +++ sh-2.6_presdio/arch/sh/kernel/cpu/sh4a/setup-sh7724.c =A0 =A0 20=
10-04-06 07:48:37.000000000 +0000
>> @@ -890,7 +890,7 @@
>> =A0static struct intc_mask_reg mask_registers[] __initdata =3D {
>> =A0 =A0 =A0 { 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
>> =A0 =A0 =A0 =A0 { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
>> - =A0 =A0 =A0 =A0 0, DISABLED, ENABLED, ENABLED } },
>> + =A0 =A0 =A0 =A0 0, ENABLED, ENABLED, ENABLED } },
>> =A0 =A0 =A0 { 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
>> =A0 =A0 =A0 =A0 { VIO_VOU, VIO_VEU1, VIO_BEU0, VIO_CEU0,
>> =A0 =A0 =A0 =A0 =A0 DMAC0A_DEI3, DMAC0A_DEI2, DMAC0A_DEI1, DMAC0A_DE=
I0 } },
>> diff -Naur sh-2.6_bsp/drivers/mfd/sh_mobile_sdhi.c sh-2.6_presdio/dr=
ivers/mfd/sh_mobile_sdhi.c
>> --- sh-2.6_bsp/drivers/mfd/sh_mobile_sdhi.c =A0 2010-03-25 04:48:00.=
000000000 +0000
>> +++ sh-2.6_presdio/drivers/mfd/sh_mobile_sdhi.c =A0 =A0 =A0 2010-04-=
06 07:48:37.000000000 +0000
>> @@ -97,7 +97,7 @@
>>
>> =A0 =A0 =A0 priv->mmc_data.hclk =3D clk_get_rate(priv->clk);
>> =A0 =A0 =A0 priv->mmc_data.set_pwr =3D sh_mobile_sdhi_set_pwr;
>> - =A0 =A0 priv->mmc_data.capabilities =3D MMC_CAP_MMC_HIGHSPEED;
>> + =A0 =A0 priv->mmc_data.capabilities =3D MMC_CAP_MMC_HIGHSPEED | MM=
C_CAP_SDIO_IRQ;
>>
>> =A0 =A0 =A0 memcpy(&priv->cell_mmc, &sh_mobile_sdhi_cell, sizeof(pri=
v->cell_mmc));
>> =A0 =A0 =A0 priv->cell_mmc.driver_data =3D &priv->mmc_data;
>> diff -Naur sh-2.6_bsp/drivers/mmc/host/tmio_mmc.c sh-2.6_presdio/dri=
vers/mmc/host/tmio_mmc.c
>> --- sh-2.6_bsp/drivers/mmc/host/tmio_mmc.c =A0 =A02010-03-25 04:48:0=
0.000000000 +0000
>> +++ sh-2.6_presdio/drivers/mmc/host/tmio_mmc.c =A0 =A0 =A0 =A02010-0=
4-06 07:48:37.000000000 +0000
>> @@ -30,6 +30,7 @@
>> =A0#include <linux/device.h>
>> =A0#include <linux/delay.h>
>> =A0#include <linux/mmc/host.h>
>> +#include <linux/mmc/sdio.h>
>> =A0#include <linux/mfd/core.h>
>> =A0#include <linux/mfd/tmio.h>
>>
>> @@ -146,6 +147,28 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c |=3D TRANSFER_READ;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 switch (cmd->opcode) {
>> + =A0 =A0 case SD_IO_RW_DIRECT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_TRANSACTION_CTL,=
 0x0001);
>> + =A0 =A0 =A0 =A0 =A0 =A0 enable_mmc_sdio_irqs(host, TMIO_SDIO_STAT_=
IOIRQ);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SD_IO_RW_EXTENDED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_TRANSACTION_CTL,=
 0x0001);
>> + =A0 =A0 =A0 =A0 =A0 =A0 enable_mmc_sdio_irqs(host, TMIO_SDIO_STAT_=
IOIRQ);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (data->flags & MMC_DATA_READ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->sg->length <=3D =
512)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D CMD_=
SD_IO_RW_EXTENDED_SREAD;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D CMD_=
SD_IO_RW_EXTENDED_MREAD;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else { /* MMC_DATA_WRITE */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->sg->length <=3D =
512)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D CMD_=
SD_IO_RW_EXTENDED_SWRITE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D CMD_=
SD_IO_RW_EXTENDED_MWRITE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 enable_mmc_irqs(host, TMIO_MASK_CMD);
>>
>> =A0 =A0 =A0 /* Fire off the command */
>> @@ -235,8 +258,13 @@
>> =A0 =A0 =A0 if (stop) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stop->opcode =3D=3D 12 && !stop->arg=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CT=
L_STOP_INTERNAL_ACTION, 0x000);
>> +#if 0
>
> I realise, this wasn't a final patch submission, but just a remark - =
you
> don't want commented out code in the final version
>
>> + =A0 =A0 /* CMD_SD_IO_RW_EXTENDED_MREAD and CMD_SD_IO_RW_EXTENDED_M=
WRITE
>> + =A0 =A0 =A0* are not necessary.
>> + =A0 =A0 =A0*/
>
> multi-line comment style is wrong. Should have been
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* CMD_SD_IO_RW_EXTENDED_MREAD and CMD_SD_IO_RW_EXTEN=
DED_MWRITE
> + =A0 =A0 =A0 =A0* are not necessary.
> + =A0 =A0 =A0 =A0*/
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> +#endif
>
> But essentially, maybe you can preserve this check and just replace:
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(host->cmd->opcode !=
=3D SD_IO_RW_EXTENDED);
>
> or something similar.
>
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 tmio_mmc_finish_request(host);
>> @@ -298,6 +326,7 @@
>> =A0{
>> =A0 =A0 =A0 struct tmio_mmc_host *host =3D devid;
>> =A0 =A0 =A0 unsigned int ireg, irq_mask, status;
>> + =A0 =A0 unsigned short ireg_io, irq_mask_io, status_io;
>
> I would use u16 to explicitly specify 16-bit data.
>
>>
>> =A0 =A0 =A0 pr_debug("MMC IRQ begin\n");
>>
>> @@ -305,15 +334,31 @@
>> =A0 =A0 =A0 irq_mask =3D sd_ctrl_read32(host, CTL_IRQ_MASK);
>> =A0 =A0 =A0 ireg =3D status & TMIO_MASK_IRQ & ~irq_mask;
>>
>> + =A0 =A0 status_io =3D sd_ctrl_read16(host, CTL_SDIO_STATUS);
>> + =A0 =A0 irq_mask_io =3D sd_ctrl_read16(host, CTL_SDIO_IRQ_MASK);
>> + =A0 =A0 ireg_io =3D status_io & TMIO_SDIO_MASK_IRQ & ~irq_mask_io;
>> +
>> =A0 =A0 =A0 pr_debug_status(status);
>> =A0 =A0 =A0 pr_debug_status(ireg);
>>
>> =A0 =A0 =A0 if (!ireg) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ireg_io & TMIO_SDIO_STAT_IOIRQ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ack_mmc_sdio_irqs(host, TM=
IO_SDIO_STAT_IOIRQ);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_signal_sdio_irq(host->=
mmc);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (ireg_io & TMIO_SDIO_STAT_EXWT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ack_mmc_sdio_irqs(host, TM=
IO_SDIO_STAT_EXWT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (ireg_io & TMIO_SDIO_STAT_EXPUB52)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ack_mmc_sdio_irqs(host, TM=
IO_SDIO_STAT_EXPUB52);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ack_mmc_sdio_irqs(host, TM=
IO_SDIO_STAT_RESERVE);
>> +
>> +#if 0
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_mmc_irqs(host, status & ~irq_mas=
k);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("tmio_mmc: Spurious irq, disabl=
ing! "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0x%08x 0x%08x 0x%08x\n"=
, status, irq_mask, ireg);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug_status(status);
>> +#endif
>
> Same here, I think, you can preserve this interrupt disabling, if you
> extend the test to mean "no SD and no SDIO bit is set."
>
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 }
>> @@ -321,6 +366,12 @@
>> =A0 =A0 =A0 while (ireg) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Card insert / remove attempts */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ireg & (TMIO_STAT_CARD_INSERT | TMIO=
_STAT_CARD_REMOVE)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ireg & TMIO_STAT_CARD_=
REMOVE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_wr=
ite16(host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 CTL_TRANSACTION_CTL, 0x0000);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_mm=
c_sdio_irqs(host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 TMIO_SDIO_STAT_IOIRQ);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ack_mmc_irqs(host, TMIO_=
STAT_CARD_INSERT |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TMIO_STA=
T_CARD_REMOVE);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host->=
mmc, msecs_to_jiffies(100));
>> @@ -462,10 +513,20 @@
>> =A0 =A0 =A0 return (sd_ctrl_read16(host, CTL_STATUS) & TMIO_STAT_WRP=
ROTECT) ? 0 : 1;
>> =A0}
>>
>> +static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enab=
le)
>> +{
>> + =A0 =A0 struct tmio_mmc_host *host =3D mmc_priv(mmc);
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 enable_mmc_sdio_irqs(host, TMIO_SDIO_STAT_=
IOIRQ);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 disable_mmc_sdio_irqs(host, TMIO_SDIO_STAT=
_IOIRQ);
>> +}
>> +
>> =A0static struct mmc_host_ops tmio_mmc_ops =3D {
>> =A0 =A0 =A0 .request =A0 =A0 =A0 =A0=3D tmio_mmc_request,
>> =A0 =A0 =A0 .set_ios =A0 =A0 =A0 =A0=3D tmio_mmc_set_ios,
>> =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D tmio_mmc_get_ro,
>> + =A0 =A0 .enable_sdio_irq =3D tmio_mmc_enable_sdio_irq,
>
> Don't be shy, add one more TAB to all struct members to align them
> properly;)
>
>> =A0};
>>
>> =A0#ifdef CONFIG_PM
>> diff -Naur sh-2.6_bsp/drivers/mmc/host/tmio_mmc.h sh-2.6_presdio/dri=
vers/mmc/host/tmio_mmc.h
>> --- sh-2.6_bsp/drivers/mmc/host/tmio_mmc.h =A0 =A02010-03-25 04:48:0=
0.000000000 +0000
>> +++ sh-2.6_presdio/drivers/mmc/host/tmio_mmc.h =A0 =A0 =A0 =A02010-0=
4-06 07:48:37.000000000 +0000
>> @@ -24,6 +24,8 @@
>> =A0#define CTL_SD_ERROR_DETAIL_STATUS 0x2c
>> =A0#define CTL_SD_DATA_PORT 0x30
>> =A0#define CTL_TRANSACTION_CTL 0x34
>> +#define CTL_SDIO_STATUS 0x36
>> +#define CTL_SDIO_IRQ_MASK 0x38
>> =A0#define CTL_RESET_SD 0xe0
>> =A0#define CTL_SDIO_REGS 0x100
>> =A0#define CTL_CLK_AND_WAIT_CTL 0x138
>> @@ -62,6 +64,23 @@
>> =A0#define TMIO_MASK_IRQ =A0 =A0 (TMIO_MASK_READOP | TMIO_MASK_WRITE=
OP | TMIO_MASK_CMD)
>>
>>
>> +/* Definitions for values the CTRL_SDIO_STATUS register can take. *=
/
>> +#define TMIO_SDIO_STAT_RESERVE =A0 =A0 =A0 0x0006 /* reserve bit */
>> +#define TMIO_SDIO_STAT_IOIRQ 0x0001
>> +#define TMIO_SDIO_STAT_EXPUB52 =A0 =A0 =A0 0x4000
>> +#define TMIO_SDIO_STAT_EXWT =A00x8000
>> +
>> +#define CMD_SD_IO_RW_EXTENDED_SREAD =A00x1C35
>> +#define CMD_SD_IO_RW_EXTENDED_MREAD =A00x7C35
>> +#define CMD_SD_IO_RW_EXTENDED_SWRITE 0x0C35
>> +#define CMD_SD_IO_RW_EXTENDED_MWRITE 0x6C35
>
> You can put these four lines in tmio_mmc.c, and maybe "SDIO" without =
an
> underscore?
>
>> +
>> +/* Define some SDIO IRQ masks */
>> +#define TMIO_SDIO_MASK_IRQ =A0 (TMIO_SDIO_STAT_IOIRQ =A0 | \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TMIO_SD=
IO_STAT_EXPUB52 | \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TMIO_SD=
IO_STAT_EXWT =A0 =A0| \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TMIO_SD=
IO_STAT_RESERVE)
>> +
>> =A0#define enable_mmc_irqs(host, i) \
>> =A0 =A0 =A0 do { \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mask;\
>> @@ -86,6 +105,29 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write32((host), CTL_STATUS, mask=
); \
>> =A0 =A0 =A0 } while (0)
>>
>> +#define enable_mmc_sdio_irqs(host, i) \
>> + =A0 =A0 do { \
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 mask;\
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask =A0=3D sd_ctrl_read16((host), CTL_SDI=
O_IRQ_MASK); \
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask &=3D ~((i) & TMIO_SDIO_MASK_IRQ); \
>> + =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16((host), CTL_SDIO_IRQ_MASK,=
 mask); \
>> + =A0 =A0 } while (0)
>> +
>> +#define disable_mmc_sdio_irqs(host, i) \
>> + =A0 =A0 do { \
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 mask;\
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask =A0=3D sd_ctrl_read16((host), CTL_SDI=
O_IRQ_MASK); \
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask |=3D ((i) & TMIO_SDIO_MASK_IRQ); \
>> + =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16((host), CTL_SDIO_IRQ_MASK,=
 mask); \
>> + =A0 =A0 } while (0)
>> +
>> +#define ack_mmc_sdio_irqs(host, i) \
>> + =A0 =A0 do { \
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 mask;\
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask =A0=3D sd_ctrl_read16((host), CTL_SDI=
O_STATUS); \
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask &=3D ~((i) & TMIO_SDIO_MASK_IRQ); \
>> + =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16((host), CTL_SDIO_STATUS, m=
ask); \
>> + =A0 =A0 } while (0)
>>
>> =A0struct tmio_mmc_host {
>> =A0 =A0 =A0 void __iomem *ctl;
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
