From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader
 doesn't work
Date: Tue, 22 Dec 2015 09:30:00 +0100
Message-ID: <CAPDyKFqMPfrTdF4JNU-QUBN-va+Xk0EAqHysQ_HpKkmMfQzQNg@mail.gmail.com>
References: <CAONpWdsteBnqTcFbKpcOQFueyeJJWEmn9DJitD43f59xV8sDyg@mail.gmail.com>
	<BY2PR04MB184372CAAC1FA0C5373D73238FEF0@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAONpWduF6iH4Rr5Y610KP1RE342nWAajR27KFbu1N2iet4R0ZA@mail.gmail.com>
	<BY2PR04MB18438CFFD181C72EFEF408908FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAPDyKFotgz3czCs8XaXwC4kT53Lp0h=n03OUMtO6BUTwTnDYzQ@mail.gmail.com>
	<BY2PR04MB18432C804C263313D2349C848FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAONpWdvo+b=Y26zsCYsHFHjJ+8yAnYfoJOsirdS-he2s1unDgg@mail.gmail.com>
	<CAONpWdsHJEHjedfQrjXru0fETRL3NfXG6cyoQAYtLYAKb5i-2Q@mail.gmail.com>
	<CY1PR04MB184843666E915C564A1858CB8FE50@CY1PR04MB1848.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33259 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbLVIaB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 03:30:01 -0500
Received: by mail-yk0-f173.google.com with SMTP id 140so156702923ykp.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Dec 2015 00:30:01 -0800 (PST)
In-Reply-To: <CY1PR04MB184843666E915C564A1858CB8FE50@CY1PR04MB1848.namprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Guo <peter.guo@bayhubtech.com>
Cc: Alex Ballas <alex@ballas.org>, "adam8157@gmail.com" <adam8157@gmail.com>, "linux-mmc@VGER.KERNEL.ORG" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

+ Adrian, Russell

On 22 December 2015 at 04:24, Peter Guo <peter.guo@bayhubtech.com> wrot=
e:
> Hi Ulf & Alex,
>
> Below is the complete analysis of this issue.
>
> The basic flow of send command is as below:
> (1) Upper layer  prepare the command parameter;
> (2) Call sdhci_send_command, and sdhci_send_command will call sdhci_s=
et_transfer_mode  to set Host Register 0xC;
> (3) Call sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI=
_COMMAND) to send command;
>
> For Linux kernel mainstream (without any quirk), MMC case:
> (1) It will call  mmc_get_ext_csd and this is an DMA transfer, then D=
MA enable bit will be set to 1 (0xC[0]=3D1'b1).
> (2) Then next Command is mmc_switch(cmd6) which is none-data command,=
 the driver will keep DMA enable bit to 1; this will let our Host faile=
d to execute the CMD06.
>
> According to SD Host Spec(SD Host Controller Specification verson 4.1=
 page 41):
> Bit0 of  Transfer Mode Register(0x0C) is DMA Enable bit, this bit set=
 to 1 means a DMA operation shall begin when  Host Driver writes to the=
 upper byte of Command Register(0x0F).
>
> The DMA enable bit should be set to zero for this none-data command(C=
MD6).
> Our host follow the spec. so I think it should be the sdhci driver=E2=
=80=99s issue (sdhci_set_transfer_mode).
>
>
> So We tried  SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD to fix ab=
ove issue.

This quirk seems a bit strange. It looks like a generic problem being
solved by the wrong approach. Although, my knowledge of sdhci HW is
limited so I might be wrong.

Why doesn't sdhci *always* reset the related registers when the
command or data transfer gets *completed*? Instead as currently,
delaying that until the *next* request is started and via using
SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD?

>
> But it encounter new problem as Alex reported for tuning command as t=
uning command flow in sdhci_execute_tuning function is:
> (1). cmd.data =3D NULL;
> (2). sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
> (3). sdhci_send_command(host, &cmd);
> As data is null, this quirk will  set 0x0C[0:15] to ALL zero before s=
end tuning command including SDHCI_TRNS_READ, and the tuning command wi=
ll failed.

I see.

Sdhci's sdhci_execute_tuning() function must be converted to use
mmc_send_tuning().

This means the regular request path will be maintained and thus no
special treatment should be needed.

Nevertheless, if my suggestions around changing sdhci's default
behaviour instead of using
SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD, perhaps you don't need
to fix sdhci_execute_tuning() to solve the error here!?

>
> So, can we commit one patch as below to fix this DMA enable bit for n=
on-data command bug if you cannot accept add new QUIRK?

Nope, no new quirks.

> Code should like below(sdhci_set_transfer_mode):
>                 if (data =3D=3D NULL) {
>                                 if (host->quirks2 &
>                                                 SDHCI_QUIRK2_CLEAR_TR=
ANSFERMODE_REG_BEFORE_CMD) {
>                                                 sdhci_writew(host, 0x=
0, SDHCI_TRANSFER_MODE);
>                                 } else {
>                                 /* clear Auto CMD settings for no dat=
a CMDs */
>                                                 mode =3D sdhci_readw(=
host, SDHCI_TRANSFER_MODE);
>                                                 sdhci_writew(host, mo=
de & ~(SDHCI_TRNS_AUTO_CMD12 | SDHCI_TRNS_DMA    /*Clear DMA enable bit=
 also for no data CMDs*/
>                                                                 SDHCI=
_TRNS_AUTO_CMD23), SDHCI_TRANSFER_MODE);
>                                 }
>                                 return;
>                 }

Thanks for the suggested solution, although I think this looks like
yet another hacky workaround for a generic problem.

Before I further consider that change, can you please look into my
suggestions above and see if any of those can simplify the solution?

[...]

Kind regards
Uffe
