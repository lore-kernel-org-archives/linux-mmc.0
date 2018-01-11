From: Craig Bergstrom <craigb@google.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-pci-o2micro: Add hardware tuning for eMMC
Date: Wed, 10 Jan 2018 16:53:08 -0800
Message-ID: <CAOJUGyfrCY4uw+wSTOFEPU41zaa9Np_4UqmDhGhZT-45qwHATA@mail.gmail.com>
References: <CY4PR04MB047375B124358A33FB077C6EED3C0@CY4PR04MB0473.namprd04.prod.outlook.com>
 <64a8b6a8-ba1b-a298-5115-d8379f121cab@intel.com> <CAOJUGycsUF199s-6_=NGR+pU=m0HTY8ZHUZ2aU4G8CB5V8JqbQ@mail.gmail.com>
 <BN6PR04MB0900DDCACB5FEF8B0E3B6D998B110@BN6PR04MB0900.namprd04.prod.outlook.com>
 <CAOJUGyfhcqPGvnG3WXBTgWfBBG3rrSCcpOGJc6_f9TywXVt0uQ@mail.gmail.com> <BN6PR04MB0900F1F2F19C4A642731ACEF8B110@BN6PR04MB0900.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36513 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeAKAxK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jan 2018 19:53:10 -0500
Received: by mail-qk0-f196.google.com with SMTP id d21so2245641qkj.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jan 2018 16:53:10 -0800 (PST)
In-Reply-To: <BN6PR04MB0900F1F2F19C4A642731ACEF8B110@BN6PR04MB0900.namprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Gotcha.

Thank you for the detailed explanation. I will give that a try and see
if it fixes the problem.

Cheers,
Craig


On Wed, Jan 10, 2018 at 3:05 PM, Shirley Her (SC)
<shirley.her@bayhubtech.com> wrote:
> Hi, Craig:
>
> The upstream user is using SD card not eMMC for this device in the curren=
t market. BIOS does not need to set bit 4 of 0x308 to 1 for device that onl=
y use SD card. Since Bayhub already shipped this device in the market to su=
pport SD card and we can not just upstream driver to only support eMMC for =
this device.
>
> We can implement a driver that can detect SD or eMMC is used in the devic=
e but it will require a lot of code changes and retry which will delay the =
card init time plus there is no device+eMMC configuration in the market now=
.
>
> Since this is the 1st time this device is used to support eMMC, so we use=
 0x308 bit 4 to identify the device is connected to eMMC and BIOS can help =
to do the job which makes driver implementation simpler.
>
>
> Thanks,
> Shirley
>
>
> -----Original Message-----
> From: Craig Bergstrom [mailto:craigb@google.com]
> Sent: Wednesday, January 10, 2018 2:33 PM
> To: Shirley Her (SC)
> Cc: Adrian Hunter; LinuxPatchCommit; ulf.hansson@linaro.org; linux-mmc@vg=
er.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] mmc: sdhci-pci-o2micro: Add hardware tuning for =
eMMC
>
> Hey Shirley,
>
> If all upstream users of this device need to set bit 4 of 0x308 to 1, sho=
uld the upstream driver do that?
>
> Craig
>
>
> On Wed, Jan 10, 2018 at 12:05 PM, Shirley Her (SC) <shirley.her@bayhubtec=
h.com> wrote:
>> Hi, Craig:
>>
>> As the message said during sign off as below. BIOS needs to set x0308 bi=
t 4 to 1 so the driver will skip 3.3V in eMMC initialization process. It me=
ans depthcharge needs to set 0x308 bit 4 to 1 first in order for driver to =
use eMMC 1.8V.
>>
>> In some case of eMMC used as boot device, the eMMC signaling voltage
>>> is fixed to 1.8v, bios can set o2 sd host controller register 0x308
>>> bit4 to let host controller skip try 3.3.v signaling voltage in eMMC
>>> initialize process.
>>
>> Thanks,
>> Shirley
>>
>> -----Original Message-----
>> From: Craig Bergstrom [mailto:craigb@google.com]
>> Sent: Thursday, December 21, 2017 9:18 AM
>> To: Adrian Hunter
>> Cc: LinuxPatchCommit; ulf.hansson@linaro.org;
>> linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Shirley Her
>> (SC)
>> Subject: Re: [PATCH 1/3] mmc: sdhci-pci-o2micro: Add hardware tuning
>> for eMMC
>>
>> Thanks for sending these patches out, I would be very excited to see the=
se devices supported by Linux.
>>
>> I'm trying them out with a SEABIRD device (pci device 1217:8620).
>> When I boot up and load the driver, it don't see any indication of the e=
xistence of block device and I see these messages repeatedly spammed to the=
 kernel logs:
>>
>> [    0.855163] mmc1: Unknown controller version (3). You may
>> experience problems.
>> [    0.862519] mmc1: SDHCI controller on PCI [0000:01:00.0] using ADMA
>> [   93.152163] mmc1: Timeout waiting for hardware cmd interrupt.
>> [   93.157911] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI R=
EGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [   93.164347] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
>> [   93.170782] mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
>> [   93.177218] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
>> [   93.183652] mmc1: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000001
>> [   93.190088] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [   93.196523] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
>> [   93.202956] mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00018000
>> [   93.209392] mmc1: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
>> [   93.215826] mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000001
>> [   93.222260] mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
>> [   93.228694] mmc1: sdhci: Cmd:       0x0000371a | Max curr: 0x005800c8
>> [   93.235127] mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
>> [   93.241562] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>> [   93.247994] mmc1: sdhci: Host ctl2: 0x00000000
>> [   93.252435] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
>> [   93.258863] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> [  103.392164] mmc1: Timeout waiting for hardware cmd interrupt.
>> [  103.397913] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI R=
EGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [  103.404350] mmc1: sdhci: =
Sys addr:  0x00000000 | Version:  0x00000603 [  103.410786] mmc1: sdhci: Bl=
k size:  0x00000000 | Blk cnt:  0x00000000 [  103.417221] mmc1: sdhci: Argu=
ment:  0x00000000 | Trn mode: 0x00000000
>> [  103.423654] mmc1: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000001
>> [  103.430089] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [  103.436523] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
>> [  103.442955] mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00018000
>> [  103.449390] mmc1: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083=
 [  103.455823] mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000001
>> [  103.462255] mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
>> [  103.468689] mmc1: sdhci: Cmd:       0x0000371a | Max curr: 0x005800c8
>> [  103.475126] mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
>> [  103.481560] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>> [  103.487994] mmc1: sdhci: Host ctl2: 0x00000000 [  103.492435] mmc1:
>> sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000 [  103.498867]
>> mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Is it expected that this should "just work", or am I doing something wro=
ng?  My patched kernel is based on 4.14.2.
>>
>> On Tue, Dec 19, 2017 at 2:05 AM, Adrian Hunter <adrian.hunter@intel.com>=
 wrote:
>>> On 04/12/17 11:39, LinuxPatchCommit wrote:
>>>> Dear All,
>>>>
>>>> For O2micro/Bayhubtech SD Host DeviceID 8620, eMMC HS200 mode is worki=
ng at 1.8v and it uses hardware tuning. The hardware tuning only needs to s=
end one tuning command instead of multiple tuning commands with software tu=
ning.
>>>>
>>>> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-pci-o2micro.c | 276
>>>> ++++++++++++++++++++++++++++++-----
>>>>  1 file changed, 239 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c
>>>> b/drivers/mmc/host/sdhci-pci-o2micro.c
>>>> index 14273ca00641..2a7ffd240497 100644
>>>> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>>>> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>>>> @@ -16,22 +16,223 @@
>>>>   */
>>>>
>>>>  #include <linux/pci.h>
>>>> -
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regulator/fixed.h>
>>>> +#include <linux/regulator/machine.h> #include <linux/mmc/host.h>
>>>> +#include <linux/mmc/mmc.h> #include <linux/delay.h>
>>>>  #include "sdhci.h"
>>>>  #include "sdhci-pci.h"
>>>>  #include "sdhci-pci-o2micro.h"
>>>>
>>>> +static void sdhci_o2_start_tuning(struct sdhci_host *host) {
>>>> +     u16 ctrl;
>>>> +
>>>> +     ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> +     ctrl |=3D SDHCI_CTRL_EXEC_TUNING;
>>>> +     if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
>>>> +             ctrl |=3D SDHCI_CTRL_TUNED_CLK;
>>>> +     sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>>> +
>>>> +     /*
>>>> +      * As per the Host Controller spec v3.00, tuning command
>>>> +      * generates Buffer Read Ready interrupt, so enable that.
>>>> +      *
>>>> +      * Note: The spec clearly says that when tuning sequence
>>>> +      * is being performed, the controller does not generate
>>>> +      * interrupts other than Buffer Read Ready interrupt. But
>>>> +      * to make sure we don't hit a controller bug, we _only_
>>>> +      * enable Buffer Read Ready interrupt here.
>>>> +      */
>>>> +     sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
>>>> +     sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
>>>> + }
>>>> +
>>>> +static void sdhci_o2_end_tuning(struct sdhci_host *host) {
>>>> +     sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>>> +     sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE); }
>>>> +
>>>> +static inline bool sdhci_data_line_cmd(struct mmc_command *cmd) {
>>>> +     return cmd->data || cmd->flags & MMC_RSP_BUSY; }
>>>> +
>>>> +static void sdhci_del_timer(struct sdhci_host *host, struct
>>>> +mmc_request
>>>> +*mrq) {
>>>> +     if (sdhci_data_line_cmd(mrq->cmd))
>>>> +             del_timer(&host->data_timer);
>>>> +     else
>>>> +             del_timer(&host->timer); }
>>>> +
>>>> +static void sdhci_o2_set_tuning_mode(struct sdhci_host *host, bool
>>>> +hw) {
>>>> +     u16 reg;
>>>> +
>>>> +     if (hw) {
>>>> +             // enable hardware tuning
>>>> +             reg =3D sdhci_readw(host, O2_SD_VENDOR_SETTING);
>>>> +             reg &=3D (~O2_SD_HW_TUNING_ENABLE);
>>>> +             sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
>>>> +     } else {
>>>> +             reg =3D sdhci_readw(host, O2_SD_VENDOR_SETTING);
>>>> +             reg |=3D O2_SD_HW_TUNING_ENABLE;
>>>> +             sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
>>>> +     }
>>>> +}
>>>> +
>>>> +static u8 data_buf[64];
>>>> +
>>>> +static void sdhci_o2_send_tuning(struct sdhci_host *host, u32 opcode)=
 {
>>>> +     struct mmc_command cmd =3D { };
>>>> +     struct mmc_data data =3D { };
>>>> +     struct scatterlist sg;
>>>> +     struct mmc_request mrq =3D { };
>>>> +     unsigned long flags;
>>>> +     u32 b =3D host->sdma_boundary;
>>>> +     int size =3D sizeof(data_buf);
>>>> +
>>>> +     cmd.opcode =3D opcode;
>>>> +     cmd.flags =3D MMC_RSP_PRESENT | MMC_RSP_OPCODE | MMC_RSP_CRC;
>>>> +     cmd.mrq =3D &mrq;
>>>> +     mrq.cmd =3D &cmd;
>>>> +     mrq.data =3D &data;
>>>> +     data.blksz =3D size;
>>>> +     data.blocks =3D 1;
>>>> +     data.flags =3D MMC_DATA_READ;
>>>> +
>>>> +     data.timeout_ns =3D 150 * NSEC_PER_MSEC;
>>>> +
>>>> +     data.sg =3D &sg;
>>>> +     data.sg_len =3D 1;
>>>> +     sg_init_one(&sg, data_buf, size);
>>>> +
>>>> +     spin_lock_irqsave(&host->lock, flags);
>>>> +
>>>> +     sdhci_writew(host, SDHCI_MAKE_BLKSZ(b, 64), SDHCI_BLOCK_SIZE);
>>>> +
>>>> +     /*
>>>> +      * The tuning block is sent by the card to the host controller.
>>>> +      * So we set the TRNS_READ bit in the Transfer Mode register.
>>>> +      * This also takes care of setting DMA Enable and Multi Block
>>>> +      * Select in the same register to 0.
>>>> +      */
>>>> +     sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
>>>> +
>>>> +     sdhci_send_command(host, &cmd);
>>>> +
>>>> +     host->cmd =3D NULL;
>>>> +
>>>> +     sdhci_del_timer(host, &mrq);
>>>> +
>>>> +     host->tuning_done =3D 0;
>>>> +
>>>> +     mmiowb();
>>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>> +
>>>> +     /* Wait for Buffer Read Ready interrupt */
>>>> +     wait_event_timeout(host->buf_ready_int, (host->tuning_done =3D=
=3D 1),
>>>> +                        msecs_to_jiffies(50));
>>>> +
>>>> +}
>>>> +
>>>> +static void sdhci_o2_reset_tuning(struct sdhci_host *host) {
>>>> +     u16 ctrl;
>>>> +
>>>> +     ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> +     ctrl &=3D ~SDHCI_CTRL_TUNED_CLK;
>>>> +     ctrl &=3D ~SDHCI_CTRL_EXEC_TUNING;
>>>> +     sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2); }
>>>> +
>>>> +static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32
>>>> +opcode) {
>>>> +
>>>> +     int i;
>>>> +
>>>> +     sdhci_o2_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
>>>
>>> So it looks like you send the tuning command only once.  Is that right?
>>> Maybe you could briefly outline what the tuning procedure is, and how
>>> it differs from sdhci_execute_tuning().
>>>
>>>> +
>>>> +     for (i =3D 0; i < 150; i++) {
>>>> +             u16 ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> +
>>>> +             if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
>>>> +                     if (ctrl & SDHCI_CTRL_TUNED_CLK) {
>>>> +                             pr_info("%s: HW tuning ok !\n",
>>>> +                                     mmc_hostname(host->mmc));
>>>> +                             host->tuning_done =3D true;
>>>> +                             return;
>>>> +                     }
>>>> +                     pr_warn("%s: HW tuning failed !\n",
>>>> +                             mmc_hostname(host->mmc));
>>>> +
>>>> +                     break;
>>>> +             }
>>>> +
>>>> +             mdelay(1);
>>>> +     }
>>>> +
>>>> +     pr_info("%s: Tuning failed, falling back to fixed sampling clock=
\n",
>>>> +             mmc_hostname(host->mmc));
>>>> +     sdhci_o2_reset_tuning(host);
>>>> +
>>>> +}
>>>> +
>>>> +static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode) =
{
>>>> +     struct sdhci_host *host =3D mmc_priv(mmc);
>>>> +     int current_bus_width =3D 0;
>>>> +
>>>> +     /*
>>>> +      * This handler only implements the eMMC tuning that is specific=
 to
>>>> +      * this controller.  Fall back to the standard method for other =
TINMING.
>>>> +      */
>>>> +     if (host->timing !=3D MMC_TIMING_MMC_HS200)
>>>> +             return sdhci_execute_tuning(mmc, opcode);
>>>> +
>>>> +     if (WARN_ON(opcode !=3D MMC_SEND_TUNING_BLOCK_HS200))
>>>> +             return -EINVAL;
>>>> +
>>>> +     /*
>>>> +      * o2 sdhci host didn't support 8bit emmc tuning
>>>> +      */
>>>> +     if (mmc->ios.bus_width =3D=3D MMC_BUS_WIDTH_8) {
>>>> +             current_bus_width =3D mmc->ios.bus_width;
>>>> +             mmc->ios.bus_width =3D MMC_BUS_WIDTH_4;
>>>> +             mmc->ops->set_ios(mmc, &mmc->ios);
>>>> +     }
>>>> +
>>>> +     sdhci_o2_set_tuning_mode(host, true);
>>>> +
>>>> +     sdhci_o2_start_tuning(host);
>>>> +
>>>> +     __sdhci_o2_execute_tuning(host, opcode);
>>>> +
>>>> +     sdhci_o2_end_tuning(host);
>>>> +
>>>> +     if (current_bus_width =3D=3D MMC_BUS_WIDTH_8) {
>>>> +             mmc->ios.bus_width =3D current_bus_width;
>>>> +             mmc->ops->set_ios(mmc, &mmc->ios);
>>>> +     }
>>>> +
>>>> +     host->flags &=3D ~SDHCI_HS400_TUNING;
>>>> +     return 0;
>>>> +}
>>>> +
>>>>  static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value=
)  {
>>>>       u32 scratch_32;
>>>> -     pci_read_config_dword(chip->pdev,
>>>> -                           O2_SD_PLL_SETTING, &scratch_32);
>>>> +     pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING,
>>>> + &scratch_32);
>>>>
>>>>       scratch_32 &=3D 0x0000FFFF;
>>>>       scratch_32 |=3D value;
>>>>
>>>> -     pci_write_config_dword(chip->pdev,
>>>> -                            O2_SD_PLL_SETTING, scratch_32);
>>>> +     pci_write_config_dword(chip->pdev, O2_SD_PLL_SETTING,
>>>> + scratch_32);
>>>>  }
>>>>
>>>>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip) @@ -40,23 =
+241,19 @@ static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>>>>       u32 scratch_32;
>>>>
>>>>       /* Set led of SD host function enable */
>>>> -     ret =3D pci_read_config_dword(chip->pdev,
>>>> -                                 O2_SD_FUNC_REG0, &scratch_32);
>>>> +     ret =3D pci_read_config_dword(chip->pdev, O2_SD_FUNC_REG0,
>>>> + &scratch_32);
>>>>       if (ret)
>>>>               return;
>>>>
>>>>       scratch_32 &=3D ~O2_SD_FREG0_LEDOFF;
>>>> -     pci_write_config_dword(chip->pdev,
>>>> -                            O2_SD_FUNC_REG0, scratch_32);
>>>> +     pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG0,
>>>> + scratch_32);
>>>>
>>>> -     ret =3D pci_read_config_dword(chip->pdev,
>>>> -                                 O2_SD_TEST_REG, &scratch_32);
>>>> +     ret =3D pci_read_config_dword(chip->pdev, O2_SD_TEST_REG,
>>>> + &scratch_32);
>>>>       if (ret)
>>>>               return;
>>>>
>>>>       scratch_32 |=3D O2_SD_LED_ENABLE;
>>>> -     pci_write_config_dword(chip->pdev,
>>>> -                            O2_SD_TEST_REG, scratch_32);
>>>> +     pci_write_config_dword(chip->pdev, O2_SD_TEST_REG,
>>>> + scratch_32);
>>>>
>>>>  }
>>>>
>>>> @@ -104,8 +301,7 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sd=
hci_pci_chip *chip)
>>>>       scratch_32 |=3D 0x00CC;
>>>>       pci_write_config_dword(chip->pdev, O2_SD_CAP_REG0, scratch_32);
>>>>       /* Set DLL Tuning Window */
>>>> -     ret =3D pci_read_config_dword(chip->pdev,
>>>> -                                 O2_SD_TUNING_CTRL, &scratch_32);
>>>> +     ret =3D pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL,
>>>> +&scratch_32);
>>>>       if (ret)
>>>>               return;
>>>>       scratch_32 &=3D ~(0x000000FF);
>>>> @@ -137,8 +333,7 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sd=
hci_pci_chip *chip)
>>>>       scratch_32 |=3D 0x30000000;
>>>>       pci_write_config_dword(chip->pdev, O2_SD_CAPS, scratch_32);
>>>>
>>>> -     ret =3D pci_read_config_dword(chip->pdev,
>>>> -                                 O2_SD_MISC_CTRL4, &scratch_32);
>>>> +     ret =3D pci_read_config_dword(chip->pdev, O2_SD_MISC_CTRL4,
>>>> +&scratch_32);
>>>>       if (ret)
>>>>               return;
>>>>       scratch_32 &=3D ~(0x000f0000);
>>>> @@ -151,6 +346,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot =
*slot)
>>>>       struct sdhci_pci_chip *chip;
>>>>       struct sdhci_host *host;
>>>>       u32 reg;
>>>> +     int ret;
>>>>
>>>>       chip =3D slot->chip;
>>>>       host =3D slot->host;
>>>> @@ -164,6 +360,22 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot=
 *slot)
>>>>               if (reg & 0x1)
>>>>                       host->quirks |=3D
>>>> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>>>>
>>>> +             if (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_SEABIRD0)=
 {
>>>> +                     ret =3D pci_read_config_dword(chip->pdev,
>>>> +                                                 O2_SD_MISC_SETTING, =
&reg);
>>>> +                     if (ret)
>>>> +                             return -EIO;
>>>> +                     if (reg & (1 << 4)) {
>>>> +                             pr_info("%s: emmc 1.8v flag is set,
>>>> +                                     force 1.8v signaling voltage\n",
>>>> +                                     mmc_hostname(host->mmc));
>>>> +                             host->flags &=3D ~(SDHCI_SIGNALING_330);
>>>> +                             host->flags |=3D SDHCI_SIGNALING_180;
>>>> +                     }
>>>> +             }
>>>> +
>>>> +             host->mmc_host_ops.execute_tuning =3D
>>>> + sdhci_o2_execute_tuning;
>>>> +
>>>>               if (chip->pdev->device !=3D PCI_DEVICE_ID_O2_FUJIN2)
>>>>                       break;
>>>>               /* set dll watch dog timer */ @@ -191,8 +403,7 @@ int
>>>> sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>>>>       case PCI_DEVICE_ID_O2_8320:
>>>>       case PCI_DEVICE_ID_O2_8321:
>>>>               /* This extra setup is required due to broken ADMA. */
>>>> -             ret =3D pci_read_config_byte(chip->pdev,
>>>> -                             O2_SD_LOCK_WP, &scratch);
>>>> +             ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP,
>>>> + &scratch);
>>>>               if (ret)
>>>>                       return ret;
>>>>               scratch &=3D 0x7f;
>>>> @@ -202,8 +413,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip=
)
>>>>               pci_write_config_byte(chip->pdev, O2_SD_MULTI_VCC3V,
>>>> 0x08);
>>>>
>>>>               /* Disable CLK_REQ# support after media DET */
>>>> -             ret =3D pci_read_config_byte(chip->pdev,
>>>> -                             O2_SD_CLKREQ, &scratch);
>>>> +             ret =3D pci_read_config_byte(chip->pdev, O2_SD_CLKREQ,
>>>> + &scratch);
>>>>               if (ret)
>>>>                       return ret;
>>>>               scratch |=3D 0x20;
>>>> @@ -224,16 +434,14 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *ch=
ip)
>>>>               pci_write_config_byte(chip->pdev, O2_SD_ADMA2, 0x08);
>>>>
>>>>               /* Disable the infinite transfer mode */
>>>> -             ret =3D pci_read_config_byte(chip->pdev,
>>>> -                             O2_SD_INF_MOD, &scratch);
>>>> +             ret =3D pci_read_config_byte(chip->pdev, O2_SD_INF_MOD,
>>>> + &scratch);
>>>>               if (ret)
>>>>                       return ret;
>>>>               scratch |=3D 0x08;
>>>>               pci_write_config_byte(chip->pdev, O2_SD_INF_MOD,
>>>> scratch);
>>>>
>>>>               /* Lock WP */
>>>> -             ret =3D pci_read_config_byte(chip->pdev,
>>>> -                             O2_SD_LOCK_WP, &scratch);
>>>> +             ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP,
>>>> + &scratch);
>>>>               if (ret)
>>>>                       return ret;
>>>>               scratch |=3D 0x80;
>>>> @@ -243,8 +451,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip=
)
>>>>       case PCI_DEVICE_ID_O2_SDS1:
>>>>       case PCI_DEVICE_ID_O2_FUJIN2:
>>>>               /* UnLock WP */
>>>> -             ret =3D pci_read_config_byte(chip->pdev,
>>>> -                             O2_SD_LOCK_WP, &scratch);
>>>> +             ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP,
>>>> + &scratch);
>>>>               if (ret)
>>>>                       return ret;
>>>>
>>>> @@ -319,15 +526,13 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *ch=
ip)
>>>>               if (ret)
>>>>                       return ret;
>>>>               scratch_32 &=3D ~(0xE0);
>>>> -             pci_write_config_dword(chip->pdev,
>>>> -                                    O2_SD_CAP_REG2, scratch_32);
>>>> +             pci_write_config_dword(chip->pdev, O2_SD_CAP_REG2,
>>>> + scratch_32);
>>>>
>>>>               if (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_FUJIN2)
>>>>                       sdhci_pci_o2_fujin2_pci_init(chip);
>>>>
>>>>               /* Lock WP */
>>>> -             ret =3D pci_read_config_byte(chip->pdev,
>>>> -                                        O2_SD_LOCK_WP, &scratch);
>>>> +             ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP,
>>>> + &scratch);
>>>>               if (ret)
>>>>                       return ret;
>>>>               scratch |=3D 0x80;
>>>> @@ -336,8 +541,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip=
)
>>>>       case PCI_DEVICE_ID_O2_SEABIRD0:
>>>>       case PCI_DEVICE_ID_O2_SEABIRD1:
>>>>               /* UnLock WP */
>>>> -             ret =3D pci_read_config_byte(chip->pdev,
>>>> -                             O2_SD_LOCK_WP, &scratch);
>>>> +             ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP,
>>>> + &scratch);
>>>>               if (ret)
>>>>                       return ret;
>>>>
>>>> @@ -369,11 +573,9 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chi=
p)
>>>>               }
>>>>
>>>>               /* Set Tuning Windows to 5 */
>>>> -             pci_write_config_byte(chip->pdev,
>>>> -                             O2_SD_TUNING_CTRL, 0x55);
>>>> +             pci_write_config_byte(chip->pdev, O2_SD_TUNING_CTRL,
>>>> + 0x55);
>>>>               /* Lock WP */
>>>> -             ret =3D pci_read_config_byte(chip->pdev,
>>>> -                                        O2_SD_LOCK_WP, &scratch);
>>>> +             ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP,
>>>> + &scratch);
>>>>               if (ret)
>>>>                       return ret;
>>>>               scratch |=3D 0x80;
>>>> --
>>>> 2.14.1
>>>>
>>>
