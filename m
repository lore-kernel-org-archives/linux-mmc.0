From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader
 doesn't work
Date: Wed, 23 Dec 2015 22:24:47 +0800
Message-ID: <CAKT61h-j=Nkci1xi=SKoKtg3q7hu0dD4wCLPxridezcNGXHLXw@mail.gmail.com>
References: <CAONpWdsteBnqTcFbKpcOQFueyeJJWEmn9DJitD43f59xV8sDyg@mail.gmail.com>
 <BY2PR04MB184372CAAC1FA0C5373D73238FEF0@BY2PR04MB1843.namprd04.prod.outlook.com>
 <CAONpWduF6iH4Rr5Y610KP1RE342nWAajR27KFbu1N2iet4R0ZA@mail.gmail.com>
 <BY2PR04MB18438CFFD181C72EFEF408908FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
 <CAPDyKFotgz3czCs8XaXwC4kT53Lp0h=n03OUMtO6BUTwTnDYzQ@mail.gmail.com>
 <BY2PR04MB18432C804C263313D2349C848FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
 <CAONpWdvo+b=Y26zsCYsHFHjJ+8yAnYfoJOsirdS-he2s1unDgg@mail.gmail.com>
 <CAONpWdsHJEHjedfQrjXru0fETRL3NfXG6cyoQAYtLYAKb5i-2Q@mail.gmail.com>
 <CY1PR04MB184843666E915C564A1858CB8FE50@CY1PR04MB1848.namprd04.prod.outlook.com>
 <CAPDyKFqMPfrTdF4JNU-QUBN-va+Xk0EAqHysQ_HpKkmMfQzQNg@mail.gmail.com> <BY2PR04MB184390AF6009AF69FE9AA4268FE60@BY2PR04MB1843.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33569 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbbLWOZI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2015 09:25:08 -0500
Received: by mail-yk0-f182.google.com with SMTP id 140so195505565ykp.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Dec 2015 06:25:07 -0800 (PST)
In-Reply-To: <BY2PR04MB184390AF6009AF69FE9AA4268FE60@BY2PR04MB1843.namprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Guo <peter.guo@bayhubtech.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alex Ballas <alex@ballas.org>, "adam8157@gmail.com" <adam8157@gmail.com>, "linux-mmc@VGER.KERNEL.ORG" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

2015-12-23 14:39 GMT+08:00 Peter Guo <peter.guo@bayhubtech.com>:
> Hi Ulf,
>
> Thanks for your suggestion, Please check my comment.
>
> BR
> Peter.guo
>
> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Tuesday, December 22, 2015 4:30 PM
> To: Peter Guo
> Cc: Alex Ballas; adam8157@gmail.com; linux-mmc@VGER.KERNEL.ORG; Adria=
n Hunter; Russell King - ARM Linux
> Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Re=
ader doesn't work
>
> + Adrian, Russell
>
> On 22 December 2015 at 04:24, Peter Guo <peter.guo@bayhubtech.com> wr=
ote:
>>> Hi Ulf & Alex,
>>>
>>> Below is the complete analysis of this issue.
>>>
>>> The basic flow of send command is as below:
>>> (1) Upper layer  prepare the command parameter;
>>> (2) Call sdhci_send_command, and sdhci_send_command will call
>>> sdhci_set_transfer_mode  to set Host Register 0xC;
>>> (3) Call sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
>>> SDHCI_COMMAND) to send command;
>>>
>>> For Linux kernel mainstream (without any quirk), MMC case:
>>> (1) It will call  mmc_get_ext_csd and this is an DMA transfer, then=
 DMA enable bit will be set to 1 (0xC[0]=3D1'b1).
>>> (2) Then next Command is mmc_switch(cmd6) which is none-data comman=
d, the driver will keep DMA enable bit to 1; this will let our Host fai=
led to execute the CMD06.
>>>
>>> According to SD Host Spec(SD Host Controller Specification verson 4=
=2E1 page 41):
>>> Bit0 of  Transfer Mode Register(0x0C) is DMA Enable bit, this bit s=
et to 1 means a DMA operation shall begin when  Host Driver writes to t=
he upper byte of Command Register(0x0F).
>>>
>>> The DMA enable bit should be set to zero for this none-data command=
(CMD6).
>> Our host follow the spec. so I think it should be the sdhci driver=E2=
=80=99s issue (sdhci_set_transfer_mode).
>>>
>>>
>>> So We tried  SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD to fix =
above issue.
>
>>This quirk seems a bit strange. It looks like a generic problem being=
 solved by the wrong approach. Although, my knowledge of sdhci HW is li=
mited so I might be wrong.
>
>>Why doesn't sdhci *always* reset the related registers when the comma=
nd or data transfer gets *completed*? Instead as currently, delaying th=
at until the *next* request is started and via using SDHCI_QUIRK2_CLEAR=
_TRANSFERMODE_REG_BEFORE_CMD?
>
> Yes, this is one solution. We can clear TRANSMER_MODE register(0xC) a=
fter SD cmd done to solve current issue, below is the change method:
> static void sdhci_tasklet_finish(unsigned long param) {
>         .....
>         host->mrq =3D NULL;
>         host->cmd =3D NULL;
>         host->data =3D NULL;
>         sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);//Add Clear Tran=
sfer Mode here
>         .....
> }
>
> But the Disadvantage of this method is: Driver need do additional one=
 register write operation after each command. Please check whether you =
can accept this change or not. Also it is looks weird to touch setting =
registers here.

I noticed your discussing since it is me to send this
SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD patch long time ago. :)

As I know, It is not necessary to clear this transfer mode register
for a normal workable host. But I must do this quirk for my abnormal
host behavior.

>
>>>
>>> But it encounter new problem as Alex reported for tuning command as=
 tuning command flow in sdhci_execute_tuning function is:
>>> (1). cmd.data =3D NULL;
>>> (2). sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE); (3).
>>> sdhci_send_command(host, &cmd); As data is null, this quirk will  s=
et
>>> 0x0C[0:15] to ALL zero before send tuning command including SDHCI_T=
RNS_READ, and the tuning command will failed.
>
>>I see.
>
>>Sdhci's sdhci_execute_tuning() function must be converted to use mmc_=
send_tuning().
>
>>This means the regular request path will be maintained and thus no sp=
ecial treatment should be needed.
>
>>Nevertheless, if my suggestions around changing sdhci's default behav=
iour instead of using SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD, >=
perhaps you don't need to fix sdhci_execute_tuning() to solve the error=
 here!?
>
> I have checked the mmc_send_tuning flow, and it can't replace sdhci_e=
xecute_tuning because the tuning command for sdhci.c is special command=
 compare with normal command for 2 points:
> (1) It don't generate Command Complete Interrupt(register 0x30 bit0)
> (2) It has no data for host driver to read but SDHCI_TRNS_READ flag n=
eed to be set.
>

Here it is reason why I did not met same issue with yours in tuning
mode when I am using this quirk, since I just use mmc_send_tuning to
do software tuning, which is precondition of using this quirk.


>>>
>>> So, can we commit one patch as below to fix this DMA enable bit for=
 non-data command bug if you cannot accept add new QUIRK?
>
>>Nope, no new quirks.
>
>>> Code should like below(sdhci_set_transfer_mode):
>>>                 if (data =3D=3D NULL) {
>>>                                 if (host->quirks2 &
>>>                                                 SDHCI_QUIRK2_CLEAR_=
TRANSFERMODE_REG_BEFORE_CMD) {
>>>                                                 sdhci_writew(host, =
0x0, SDHCI_TRANSFER_MODE);
>>>                                 } else {
>>>                                 /* clear Auto CMD settings for no d=
ata CMDs */
>>>                                                 mode =3D sdhci_read=
w(host, SDHCI_TRANSFER_MODE);
>>>                                                 sdhci_writew(host, =
mode & ~(SDHCI_TRNS_AUTO_CMD12 | SDHCI_TRNS_DMA    /*Clear DMA enable b=
it also for no data CMDs*/
>>>                                                                 SDH=
CI_TRNS_AUTO_CMD23), SDHCI_TRANSFER_MODE);
>>>                                 }
>>>                                 return;
>>>                 }
>
>>Thanks for the suggested solution, although I think this looks like y=
et another hacky workaround for a generic problem.
>
>>Before I further consider that change, can you please look into my su=
ggestions above and see if any of those can simplify the solution?
>
>>[...]
>
>
> So my suggestion is:
> (1) mmc_send_tuning can't replace sdhci_execute_tuning as tuning comm=
and is special one;
> (2) modify the sdhci_set_transfer_mode to clear SDHCI_TRNS_DMA withou=
t quirk is better than clear transfer mode after command done. From my =
point of view, SDHCI_TRNS_DMA should be cleared for no-data command bef=
ore issue command. It follows the spec.
>
>
> BR
> Peter.Guo
>
>



--=20
---
Vincent Wan(Zongshun)
www.mcuos.com
