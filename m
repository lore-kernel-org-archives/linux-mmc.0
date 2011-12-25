From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] mmc: dw_mmc: Support predefined mutiple block transfers
Date: Sat, 24 Dec 2011 21:09:33 -0500
Message-ID: <m2k45lz9k2.fsf@bob.laptop.org>
References: <006901ccc088$4b6aafb0$e2400f10$%jun@samsung.com>
	<CAFbHwiSqKQ_VXpDfO6EYCS4eMM0-vNoqbnqRd_fFX-v4fZBd2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48968 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab1LYCJl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Dec 2011 21:09:41 -0500
In-Reply-To: <CAFbHwiSqKQ_VXpDfO6EYCS4eMM0-vNoqbnqRd_fFX-v4fZBd2g@mail.gmail.com>
	(Will Newton's message of "Thu, 22 Dec 2011 11:40:47 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi,

On Thu, Dec 22 2011, Will Newton wrote:
> On Thu, Dec 22, 2011 at 9:01 AM, Seungwon Jeon <tgih.jun@samsung.com>=
 wrote:
>> This patch adds the support for predefined multiple block r/w.
>> dw_mmc can support MMC_CAP_CMD23 capability.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 34 ++++++++++++++++++++++++=
++++------
>> =C2=A01 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 3aaeb08..04653e8 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -588,11 +588,11 @@ static void dw_mci_setup_bus(struct dw_mci_slo=
t *slot)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(host, CTYPE, (slot->ctype << s=
lot->id));
>> =C2=A0}
>>
>> -static void dw_mci_start_request(struct dw_mci *host,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci_slot *slot)
>> +static void __dw_mci_start_request(struct dw_mci *host,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci_slot =
*slot,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_command =
*cmd)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_request *mrq;
>> - =C2=A0 =C2=A0 =C2=A0 struct mmc_command *cmd;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_data *data;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 cmdflags;
>>
>> @@ -610,14 +610,13 @@ static void dw_mci_start_request(struct dw_mci=
 *host,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->completed_events =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->data_status =3D 0;
>>
>> - =C2=A0 =C2=A0 =C2=A0 data =3D mrq->data;
>> + =C2=A0 =C2=A0 =C2=A0 data =3D cmd->data;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dw_mci_set_ti=
meout(host);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(ho=
st, BYTCNT, data->blksz*data->blocks);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mci_writel(ho=
st, BLKSIZ, data->blksz);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> - =C2=A0 =C2=A0 =C2=A0 cmd =3D mrq->cmd;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cmdflags =3D dw_mci_prepare_command(slot-=
>mmc, cmd);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* this is the first command, send the in=
itialization clock */
>> @@ -635,6 +634,16 @@ static void dw_mci_start_request(struct dw_mci =
*host,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->stop_cm=
dr =3D dw_mci_prepare_command(slot->mmc, mrq->stop);
>> =C2=A0}
>>
>> +static void dw_mci_start_request(struct dw_mci *host,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci_slot *slot)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct mmc_request *mrq =3D slot->mrq;
>> + =C2=A0 =C2=A0 =C2=A0 struct mmc_command *cmd;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 cmd =3D mrq->sbc ? mrq->sbc : mrq->cmd;
>> + =C2=A0 =C2=A0 =C2=A0 __dw_mci_start_request(host, slot, cmd);
>> +}
>> +
>> =C2=A0/* must be called with host->lock held */
>> =C2=A0static void dw_mci_queue_request(struct dw_mci *host, struct
>> dw_mci_slot *slot,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mmc_request *mrq)
>> @@ -889,7 +898,14 @@ static void dw_mci_tasklet_func(unsigned long p=
riv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0cmd =3D host->cmd;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0host->cmd =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0set_bit(EVENT_CMD_COMPLETE, &host->completed_events);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dw_mci_command_complete(host, host->mrq->cmd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dw_mci_command_complete(host, cmd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if ((cmd =3D=3D host->mrq->sbc) && !cmd->error) {
>
> The inner set of parentheses here is not strictly required.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_state =3D state =3D STATE_S=
ENDING_CMD;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __dw_mci_start_request(host, hos=
t->cur_slot,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->mrq->cmd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unlock;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!host->mrq->data || cmd->error) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dw_mci_request_end(host, host=
->mrq);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto unlock;
>> @@ -967,6 +983,12 @@ static void dw_mci_tasklet_func(unsigned long p=
riv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto unlock;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (host->mrq->sbc && !data->error) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data->stop->error =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dw_mci_request_end(host, host->m=
rq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unlock;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0prev_state =3D state =3D STATE_SENDING_STOP;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!data->error)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_stop_cmd(host, data);
>> --
>> 1.7.0.4
>
> Otherwise looks ok.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.3 with Will's ACK and suggested change=
=2E

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
