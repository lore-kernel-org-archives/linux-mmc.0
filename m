From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: make sure of clearing HLE interrupt
Date: Thu, 29 Nov 2012 23:59:08 +0900
Message-ID: <CAELcNGRK7tU_+NgAkSGsyn-SNTFkDNYRFMeypdkvMiwsafYV5w@mail.gmail.com>
References: <001c01cdcd52$e58a2260$b09e6720$%jun@samsung.com>
	<50B5EB38.9030401@imgtec.com>
	<001201cdce04$187dc8a0$497959e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57560 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab2K2O7J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Nov 2012 09:59:09 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so13093941obb.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Nov 2012 06:59:09 -0800 (PST)
In-Reply-To: <001201cdce04$187dc8a0$497959e0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>

2012/11/29 Seungwon Jeon <tgih.jun@samsung.com>:
> Hi James,
>
> On Wednesday, November 28, 2012, James Hogan wrote:
>> Hi,
>>
>> On 28/11/12 10:26, Seungwon Jeon wrote:
>> > Even though HLE interrupt is enabled, there is no touch.
>> > This patch clears HLE interrupt which is not unhandled.
>>
>> It's not entirely clear from this description what the patch is tryi=
ng
>> to do. I presume from the patch you're trying to say something like:
>> "Even though the HLE interrupt is enabled, it isn't handled, so hand=
le
>> the HLE interrupt by printing an error message."
> Currently, there is no code to clean the HLE interrupt, when it happe=
ns.
> So, interrupt will signaled permanently and then system is affected b=
adly.
> The purpose of this patch to prevent this. Printing an message is jus=
t to inform error.
>
>>
>> According to the TRM though, in the section Error Handling (HLE is a=
lso
>> mentioned elsewhere):
>> >  Hardware locked error =96 Set when the DWC_mobile_storage cannot =
load a command issued by
>> > software. When software sets the start_cmd bit in the CMD register=
, the DWC_mobile_storage tries
>> > to load the command. If the command buffer is already filled with =
a command, this error is raised.
>> > The software then has to reload the command.
>>
>> So it sounds like the last command should be reloaded (either on
>> interrupt or the interrupt status should be checked after starting a
>> command). Is this done elsewhere already?
> I didn't see that for normal command.
> We need to investigate about HLE case more. It's difficult to meet HL=
E.
> For this, I think this patch is effective at least.
> If you have any good idea, please let me know.
As mentioned at spec, if raised HLE when buffer is already filled with
a command and try to load the other command,
how about the clear the buffer and reload the command?
If we need to consider others, i will also think this problem.

Best Regards,
Jaehoon Chung
>
> Thanks,
> Seungwon Jeon
>>
>> Cheers
>> James
>>
>> >
>> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> > ---
>> >  drivers/mmc/host/dw_mmc.c |   11 +++++++++++
>> >  1 files changed, 11 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> > index 6785d62..b6db0ae 100644
>> > --- a/drivers/mmc/host/dw_mmc.c
>> > +++ b/drivers/mmc/host/dw_mmc.c
>> > @@ -1009,6 +1009,11 @@ static void dw_mci_tasklet_func(unsigned lo=
ng priv)
>> >     state =3D host->state;
>> >     data =3D host->data;
>> >
>> > +   if (host->cmd_status & SDMMC_INT_HLE) {
>> > +           dev_err(host->dev, "hardware locked write error\n");
>> > +           goto unlock;
>> > +   }
>> > +
>> >     do {
>> >             prev_state =3D state;
>> >
>> > @@ -1577,6 +1582,12 @@ static irqreturn_t dw_mci_interrupt(int irq=
, void *dev_id)
>> >             if (!pending)
>> >                     break;
>> >
>> > +           if (pending & SDMMC_INT_HLE) {
>> > +                   mci_writel(host, RINTSTS, SDMMC_INT_HLE);
>> > +                   host->cmd_status =3D pending;
>> > +                   tasklet_schedule(&host->tasklet);
>> > +           }
>> > +
>> >             if (pending & DW_MCI_CMD_ERROR_FLAGS) {
>> >                     mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLA=
GS);
>> >                     host->cmd_status =3D pending;
>> >
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
