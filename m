From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v3] mmc: core: Fix the HPI execution sequence
Date: Thu, 21 Jun 2012 16:38:31 +0530
Message-ID: <002d01cd4f9e$33cb7010$9b625030$@codeaurora.org>
References: <1340184834-12700-1-git-send-email-svenkatr@ti.com> <002301cd4f0e$7b380de0$71a829a0$@codeaurora.org> <CANfBPZ89btqCBin8Wyg87w0cEz213oNiC=FJcoxtw1Hb+1n9pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:2164 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab2FULIg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jun 2012 07:08:36 -0400
In-Reply-To: <CANfBPZ89btqCBin8Wyg87w0cEz213oNiC=FJcoxtw1Hb+1n9pw@mail.gmail.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'S, Venkatraman'" <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com, alex.lemberg@sandisk.com, 'Kostya' <kdorfman@codeaurora.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of S, Venkatraman
> Sent: Thursday, June 21, 2012 12:55 PM
> To: Subhash Jadavani
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; linkinjeon@gmail.com;
> jh80.chung@samsung.com; alex.lemberg@sandisk.com; Kostya
> Subject: Re: [PATCH v3] mmc: core: Fix the HPI execution sequence
>=20
> On Wed, Jun 20, 2012 at 11:29 PM, Subhash Jadavani
> <subhashj@codeaurora.org> wrote:
> > Hi Venkatraman,
> >
> >> -----Original Message-----
> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> >> owner@vger.kernel.org] On Behalf Of Venkatraman S
> >> Sent: Wednesday, June 20, 2012 3:04 PM
> >> To: cjb@laptop.org
> >> Cc: linux-mmc@vger.kernel.org; linkinjeon@gmail.com;
> >> jh80.chung@samsung.com; alex.lemberg@sandisk.com; Venkatraman S;
> >> Kostya
> >> Subject: [PATCH v3] mmc: core: Fix the HPI execution sequence
> >>
> >> mmc_execute_hpi should send the HPI command only once, and only if
> >> the card is in PRG state.
> >>
> >> According to eMMC spec, the command's completion time is not
> >> dependent on OUT_OF_INTERRUPT_TIME. Only the transition out of PRG
> >> STATE is guarded by OUT_OF_INTERRUPT_TIME - which is defined to be=
gin
> >> at the end of sending the command itself.
> >>
> >> Specify the default timeout for the actual sending of HPI command,
> >> and
> > then
> >> use OUT_OF_INTERRUPT_TIME to wait for the transition out of PRG st=
ate.
> >
> > I guess this is not the correct interpretation. cmd.cmd_timeout_ms
> > should specify for how much time host driver should wait for comman=
d +
> > busy line deassertion. So why are you keeping the timeout calculati=
on
> > after the command is completed?
> >
> If what you stay is correct, the card should be in PRG state after
> mmc_send_hpi_cmd()
> returns.

>=20
> I understood and observed it as opposite. HPI cmd returns immediately=
, and
the
> device takes OUT_OF_INTERRUPT_TIME time to come out of PRG state.
>=20
> My experiments / tests confirm that behavior. It takes a few ms (and
several
> SEND_STATUS messages later), after HPI, for the card to be out of PRG
state.

What is the HPI command in your case? CMD12 or CMD13? For command CMD12=
, we
set the R1B flag which would tell the host driver to wait for the DAT0 =
line
to be deasserted (if host controller support the automatic detection of=
 DAT0
de assertion).
But HPI command is CMD13 then yes, driver will not wait for DAT0 line d=
e
assertion.

Yes, so to support both CMD12 and CMD13 as HPI command, we can have 2
options:
1.=20
	- Set the R1B flag for CMD13 as well so controller waits for the
PROG_DONE.
	- Once mmc_send_hpi_cmd() returns, you can poll (without any
timeout) until the card is out of programming state.

2.
	- don't set the R1B flag for CMD13
	- Once mmc_send_hpi_cmd() returns, if HPI command is CMD12, you can
poll (without any timeout) until the card is out of programming state. =
But
if HPI command is CMD13, poll until card is out of programming state wi=
th
timeout.

But in both of the above case, if host driver do not support automatic
detection of DAT0 de assertion, we will have to send multiple CMD13
(send_status) before card comes out of programming state but yes, in ca=
se
card gets stuck in programming state forever then we will end up sendin=
g
CMD13 forever. In this case timeout based wait is fine. So if you want =
to
take of case where card is stuck in programming state forever, your
implementation is fine. Is this your intention here? I have few comment=
s on
your code below.
=09
Regards,
Subhash

>=20
> > mmc_send_hpi_cmd() returns means the host controller driver have
> > ensured that BUSY indication is removed so after mmc_send_hpi_cmd()=
,
> > if you want to check if the card is still in PROGRAMMING state, it
> > should be unconditional check in loop (rather than timeout based)
> > until card is out of programming state.
> >
> > To me, mmc_send_hpi_cmd() implementation should not be anything
> > different than mmc_switch(). In mmc_switch() also, after
> > mmc_wait_for_cmd() returns it continuously keeps checking if card i=
s
> programming or not.
> >
> > Regards,
> > Subhash
> >
> >>
> >> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> >> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> >> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> CC: Kostya <kdorfman@codeaurora.org>
> >> ---
> >> v2 discussions: http://marc.info/?l=3Dlinux-mmc&m=3D13365725561639=
0&w=3D2
> >>
> >> v2->v3:
> >> =A0 =A0 =A0 Return gracefully for card idle states (suggested by k=
dorfman)
> >>
> >> =A0drivers/mmc/core/core.c =A0 =A0| =A0 57
> > ++++++++++++++++++++++++++-----------------
> >> -
> >> =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 -
> >> =A02 files changed, 34 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c ind=
ex
> >> 80ec427..08ed144 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -404,6 +404,7 @@ int mmc_interrupt_hpi(struct mmc_card *card) =A0=
{
> >> =A0 =A0 =A0 int err;
> >> =A0 =A0 =A0 u32 status;
> >> + =A0 =A0 unsigned long starttime;
> >>
> >> =A0 =A0 =A0 BUG_ON(!card);
> >>
> >> @@ -419,30 +420,40 @@ int mmc_interrupt_hpi(struct mmc_card *card)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> =A0 =A0 =A0 }
> >>
> >> - =A0 =A0 /*
> >> - =A0 =A0 =A0* If the card status is in PRG-state, we can send the=
 HPI
command.
> >> - =A0 =A0 =A0*/
> >> - =A0 =A0 if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 do {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't know when =
the HPI command will
> >> finish
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processing, so we n=
eed to resend HPI until
> >> out
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of prg-state, and k=
eep checking the card
> >> status
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with SEND_STATUS. =A0=
If a timeout error occurs
> >> when
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sending the HPI com=
mand, we are already out
> >> of
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prg-state.
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_hpi_cmd=
(card, &status);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug=
("%s: abort HPI (%d error)\n",
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0mmc_hostname(card->host),
> >> err);
> >> + =A0 =A0 switch (R1_CURRENT_STATE(status)) {
> >>
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(=
card, &status);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 } while (R1_CURRENT_STATE(status) =3D=3D=
 R1_STATE_PRG);
> >> - =A0 =A0 } else
> >> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Left prg-state\n",
> >> mmc_hostname(card->host));
> >> + =A0 =A0 case R1_STATE_IDLE:
> >> + =A0 =A0 case R1_STATE_READY:
> >> + =A0 =A0 case R1_STATE_STBY: /* intentional fall through */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* In idle states, HPI is not needed and=
 the caller
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0can issue the next intended command i=
mmediately */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case R1_STATE_PRG:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 default:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* In all other states, it's illegal to =
issue HPI */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: HPI cannot be sent. Card s=
tate=3D%d\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host)=
,
> >> R1_CURRENT_STATE(status));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 starttime =3D jiffies;
> >> + =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
> >> + =A0 =A0 if (err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> +
> >> + =A0 =A0 do {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(card, &status);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err && R1_CURRENT_STATE(status) =3D=
=3D R1_STATE_TRAN)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - starttime=
) >=3D
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.out_of_int=
_time)

When you are comparing snapshot of 2 different jiffies, you should be u=
sing
time_after() or time_before() macros others this will not take case of
jiffies wraparound.

> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ETIMEDOUT;
> >> + =A0 =A0 } while (!err);
> >>
> >> =A0out:
> >> =A0 =A0 =A0 mmc_release_host(card->host);
> >> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops=
=2Ec
> >> index 69370f4..0ed2cc5 100644
> >> --- a/drivers/mmc/core/mmc_ops.c
> >> +++ b/drivers/mmc/core/mmc_ops.c
> >> @@ -569,7 +569,6 @@ int mmc_send_hpi_cmd(struct mmc_card *card,
> u32
> >> *status)
> >>
> >> =A0 =A0 =A0 cmd.opcode =3D opcode;
> >> =A0 =A0 =A0 cmd.arg =3D card->rca << 16 | 1;
> >> - =A0 =A0 cmd.cmd_timeout_ms =3D card->ext_csd.out_of_int_time;
> >>
> >> =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
> >> =A0 =A0 =A0 if (err) {
> >> --
> >> 1.7.10.rc2
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c"
> >> in
> > the body
> >> of a message to majordomo@vger.kernel.org More majordomo info at
> >> http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

