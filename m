From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v3] mmc: core: Fix the HPI execution sequence
Date: Thu, 21 Jun 2012 18:46:44 +0530
Message-ID: <CANfBPZ-bN3Zo4jqErLWqVJ-8cDXGrWJYRRz_hzgOvqx74x2bUg@mail.gmail.com>
References: <1340184834-12700-1-git-send-email-svenkatr@ti.com>
 <002301cd4f0e$7b380de0$71a829a0$@codeaurora.org> <CANfBPZ89btqCBin8Wyg87w0cEz213oNiC=FJcoxtw1Hb+1n9pw@mail.gmail.com>
 <002d01cd4f9e$33cb7010$9b625030$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:58989 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759580Ab2FUNRI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jun 2012 09:17:08 -0400
Received: by bkcik5 with SMTP id ik5so514018bkc.15
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jun 2012 06:17:05 -0700 (PDT)
In-Reply-To: <002d01cd4f9e$33cb7010$9b625030$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com, alex.lemberg@sandisk.com, Kostya <kdorfman@codeaurora.org>

On Thu, Jun 21, 2012 at 4:38 PM, Subhash Jadavani
<subhashj@codeaurora.org> wrote:
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of S, Venkatraman
>> Sent: Thursday, June 21, 2012 12:55 PM
>> To: Subhash Jadavani
>> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; linkinjeon@gmail.com;
>> jh80.chung@samsung.com; alex.lemberg@sandisk.com; Kostya
>> Subject: Re: [PATCH v3] mmc: core: Fix the HPI execution sequence
>>
>> On Wed, Jun 20, 2012 at 11:29 PM, Subhash Jadavani
>> <subhashj@codeaurora.org> wrote:
>> > Hi Venkatraman,
>> >
>> >> -----Original Message-----
>> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> >> owner@vger.kernel.org] On Behalf Of Venkatraman S
>> >> Sent: Wednesday, June 20, 2012 3:04 PM
>> >> To: cjb@laptop.org
>> >> Cc: linux-mmc@vger.kernel.org; linkinjeon@gmail.com;
>> >> jh80.chung@samsung.com; alex.lemberg@sandisk.com; Venkatraman S;
>> >> Kostya
>> >> Subject: [PATCH v3] mmc: core: Fix the HPI execution sequence
>> >>
>> >> mmc_execute_hpi should send the HPI command only once, and only i=
f
>> >> the card is in PRG state.
>> >>
>> >> According to eMMC spec, the command's completion time is not
>> >> dependent on OUT_OF_INTERRUPT_TIME. Only the transition out of PR=
G
>> >> STATE is guarded by OUT_OF_INTERRUPT_TIME - which is defined to b=
egin
>> >> at the end of sending the command itself.
>> >>
>> >> Specify the default timeout for the actual sending of HPI command=
,
>> >> and
>> > then
>> >> use OUT_OF_INTERRUPT_TIME to wait for the transition out of PRG s=
tate.
>> >
>> > I guess this is not the correct interpretation. cmd.cmd_timeout_ms
>> > should specify for how much time host driver should wait for comma=
nd +
>> > busy line deassertion. So why are you keeping the timeout calculat=
ion
>> > after the command is completed?
>> >
>> If what you stay is correct, the card should be in PRG state after
>> mmc_send_hpi_cmd()
>> returns.
>
>>
>> I understood and observed it as opposite. HPI cmd returns immediatel=
y, and
> the
>> device takes OUT_OF_INTERRUPT_TIME time to come out of PRG state.
>>
>> My experiments / tests confirm that behavior. It takes a few ms (and
> several
>> SEND_STATUS messages later), after HPI, for the card to be out of PR=
G
> state.
>
> What is the HPI command in your case? CMD12 or CMD13? For command CMD=
12, we
> set the R1B flag which would tell the host driver to wait for the DAT=
0 line
> to be deasserted (if host controller support the automatic detection =
of DAT0
> de assertion).
> But HPI command is CMD13 then yes, driver will not wait for DAT0 line=
 de
> assertion.
>
Yes, it has CMD13 - and it makes sense.

> Yes, so to support both CMD12 and CMD13 as HPI command, we can have 2
> options:
> 1.
> =A0 =A0 =A0 =A0- Set the R1B flag for CMD13 as well so controller wai=
ts for the
> PROG_DONE.
> =A0 =A0 =A0 =A0- Once mmc_send_hpi_cmd() returns, you can poll (witho=
ut any
> timeout) until the card is out of programming state.
>
> 2.
> =A0 =A0 =A0 =A0- don't set the R1B flag for CMD13
> =A0 =A0 =A0 =A0- Once mmc_send_hpi_cmd() returns, if HPI command is C=
MD12, you can
> poll (without any timeout) until the card is out of programming state=
=2E But
> if HPI command is CMD13, poll until card is out of programming state =
with
> timeout.
>
> But in both of the above case, if host driver do not support automati=
c
> detection of DAT0 de assertion, we will have to send multiple CMD13
> (send_status) before card comes out of programming state but yes, in =
case

I think that's the case with OMAP, and I assumed it to be common.

> card gets stuck in programming state forever then we will end up send=
ing
> CMD13 forever. In this case timeout based wait is fine. So if you wan=
t to
> take of case where card is stuck in programming state forever, your
> implementation is fine. Is this your intention here? I have few comme=
nts on
> your code below.
>
Yes - that was atleast the intention. I didn't assume DAT0 de assertati=
on was
auto detectable, and even otherwise, PRG state was to be polled later
anyway.

> Regards,
> Subhash
>
>>
>> > mmc_send_hpi_cmd() returns means the host controller driver have
>> > ensured that BUSY indication is removed so after mmc_send_hpi_cmd(=
),
>> > if you want to check if the card is still in PROGRAMMING state, it
>> > should be unconditional check in loop (rather than timeout based)
>> > until card is out of programming state.
>> >
>> > To me, mmc_send_hpi_cmd() implementation should not be anything
>> > different than mmc_switch(). In mmc_switch() also, after
>> > mmc_wait_for_cmd() returns it continuously keeps checking if card =
is
>> programming or not.
>> >
>> > Regards,
>> > Subhash
>> >
>> >>
>> >> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
>> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> >> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
>> >> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>> >> CC: Kostya <kdorfman@codeaurora.org>
>> >> ---
>> >> v2 discussions: http://marc.info/?l=3Dlinux-mmc&m=3D1336572556163=
90&w=3D2
>> >>
>> >> v2->v3:
>> >> =A0 =A0 =A0 Return gracefully for card idle states (suggested by =
kdorfman)
>> >>
>> >> =A0drivers/mmc/core/core.c =A0 =A0| =A0 57
>> > ++++++++++++++++++++++++++-----------------
>> >> -
>> >> =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 -
>> >> =A02 files changed, 34 insertions(+), 24 deletions(-)
>> >>
>> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c in=
dex
>> >> 80ec427..08ed144 100644
>> >> --- a/drivers/mmc/core/core.c
>> >> +++ b/drivers/mmc/core/core.c
>> >> @@ -404,6 +404,7 @@ int mmc_interrupt_hpi(struct mmc_card *card) =
=A0{
>> >> =A0 =A0 =A0 int err;
>> >> =A0 =A0 =A0 u32 status;
>> >> + =A0 =A0 unsigned long starttime;
>> >>
>> >> =A0 =A0 =A0 BUG_ON(!card);
>> >>
>> >> @@ -419,30 +420,40 @@ int mmc_interrupt_hpi(struct mmc_card *card=
)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> =A0 =A0 =A0 }
>> >>
>> >> - =A0 =A0 /*
>> >> - =A0 =A0 =A0* If the card status is in PRG-state, we can send th=
e HPI
> command.
>> >> - =A0 =A0 =A0*/
>> >> - =A0 =A0 if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 do {
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't know when=
 the HPI command will
>> >> finish
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processing, so we =
need to resend HPI until
>> >> out
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of prg-state, and =
keep checking the card
>> >> status
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with SEND_STATUS. =
=A0If a timeout error occurs
>> >> when
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sending the HPI co=
mmand, we are already out
>> >> of
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prg-state.
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_hpi_cm=
d(card, &status);
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debu=
g("%s: abort HPI (%d error)\n",
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0mmc_hostname(card->host),
>> >> err);
>> >> + =A0 =A0 switch (R1_CURRENT_STATE(status)) {
>> >>
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status=
(card, &status);
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 } while (R1_CURRENT_STATE(status) =3D=3D=
 R1_STATE_PRG);
>> >> - =A0 =A0 } else
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Left prg-state\n",
>> >> mmc_hostname(card->host));
>> >> + =A0 =A0 case R1_STATE_IDLE:
>> >> + =A0 =A0 case R1_STATE_READY:
>> >> + =A0 =A0 case R1_STATE_STBY: /* intentional fall through */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* In idle states, HPI is not needed an=
d the caller
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0can issue the next intended command =
immediately */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 case R1_STATE_PRG:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 default:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* In all other states, it's illegal to=
 issue HPI */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: HPI cannot be sent. Card =
state=3D%d\n",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
),
>> >> R1_CURRENT_STATE(status));
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 starttime =3D jiffies;
>> >> + =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
>> >> + =A0 =A0 if (err)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> +
>> >> + =A0 =A0 do {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(card, &status);
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err && R1_CURRENT_STATE(status) =3D=
=3D R1_STATE_TRAN)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - starttim=
e) >=3D
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.out_of_in=
t_time)
>
> When you are comparing snapshot of 2 different jiffies, you should be=
 using
> time_after() or time_before() macros others this will not take case o=
f
> jiffies wraparound.

Ok- I'll send out an updated version.
