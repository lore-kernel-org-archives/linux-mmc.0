From: Mahadev Cholachagudda <mgudda@gmail.com>
Subject: Re: [PATCH 1/1] CMD12 error recovery support for SD cards
Date: Wed, 23 Sep 2009 14:20:19 +0530
Message-ID: <bd31ea570909230150y5fea0905n6970d000002c97cb@mail.gmail.com>
References: <bd31ea570909160334u1b17a068hd8be89c7035232f9@mail.gmail.com>
	 <bd31ea570909160339l5f996e9eh1f87abdbe527a404@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:39196 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbZIWIuP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2009 04:50:15 -0400
Received: by pzk26 with SMTP id 26so429028pzk.4
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2009 01:50:19 -0700 (PDT)
In-Reply-To: <bd31ea570909160339l5f996e9eh1f87abdbe527a404@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Pierre Ossman <pierre@ossman.eu>, Pierre Ossman <drzeus-list@drzeus.cx>, madhu.sudhana@nxp.com

Dear Sir,

Any comments on this.

Regards,
Mahadev

2009/9/16 Mahadev Cholachagudda <mgudda@gmail.com>:
> Dear All,
>
> I've a kernel code base of 2.6.28.9, where in I find that CMD12 error
> recovery is not been implemented. It is a wise idea to implement CMD1=
2
> error recovery, that involves sending CMD13 to get the status of the
> card. If the card is in "trans" state, it means CMD12 error shall be
> treated as successfull. If card state is not in "trans", then we have
> to send CMD12 again to stop the data transfer and then checking of th=
e
> card status through CMD13. This sequence is detailed in the
> "Simplified Host Controller specification" on SDCard website. I
> believe this is the case for any controller, though I may be wrong.
>
> With the modification done to the code which is attached as patch to
> the latest mmc git, it is working at our site. And we do see some
> errors with the SDIO controller (proprietary but meets Standard SD
> host controller specification) that we are using.
>
> Request you to comment on the patch.
>
> diff -urNd linux-orig/drivers/mmc/card/block.c
> linux-current/drivers/mmc/card/block.c
> --- linux-orig/drivers/mmc/card/block.c=A0=A0=A0 2009-09-16 15:43:03.=
667274139 +0530
> +++ linux-current/drivers/mmc/card/block.c=A0=A0=A0 2009-09-16
> 15:36:24.722272962 +0530
> @@ -335,6 +335,76 @@
> =A0=A0=A0=A0 =A0=A0=A0 =A0* until later as we need to wait for the ca=
rd to leave
> =A0=A0=A0=A0 =A0=A0=A0 =A0* programming mode even when things go wron=
g.
> =A0=A0=A0=A0 =A0=A0=A0 =A0*/
> +
> +=A0=A0=A0 /* cmd12 error recovery fix */
> +=A0=A0=A0 if( (brq.stop.error) && (brq.data.blocks > 1) &&
> !mmc_host_is_spi(card->host) &&
> +=A0=A0=A0=A0=A0=A0=A0 mmc_card_sd(card) ) {
> +
> +=A0=A0=A0=A0=A0 struct mmc_request my_mrq;
> +=A0=A0=A0=A0=A0 struct mmc_command my_cmd;
> +
> +=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0 * if there is an error for CMD12, get the state o=
f the card by
> +=A0=A0=A0=A0=A0=A0 * sending cmd13 and then check the state of the c=
ard.
> +=A0=A0=A0=A0=A0=A0 * If the card state is "tran", consider the cmd12=
 is successfull
> +=A0=A0=A0=A0=A0=A0 * If not, then send again CMD12 to stop the data =
transfer. This time,
> +=A0=A0=A0=A0=A0=A0 * any failure to get response, will result in to =
the card being
> +=A0=A0=A0=A0=A0=A0 * non-recoverable.
> +=A0=A0=A0=A0=A0=A0 */
> +
> +=A0=A0=A0=A0=A0 memset(&my_mrq, 0, sizeof(struct mmc_request));
> +=A0=A0=A0=A0=A0 memset(&my_cmd, 0, sizeof(struct mmc_command));
> +=A0=A0=A0=A0=A0 my_cmd.opcode =3D MMC_SEND_STATUS;
> +=A0=A0=A0=A0=A0 my_cmd.arg =3D card->rca << 16;
> +=A0=A0=A0=A0=A0 my_cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +=A0=A0=A0=A0=A0 my_mrq.cmd =3D &my_cmd;
> +=A0=A0=A0=A0=A0 mmc_wait_for_req(card->host, &my_mrq);
> +
> +=A0=A0=A0=A0=A0 if(!my_mrq.cmd->error) {
> +=A0=A0=A0=A0=A0=A0=A0 if(R1_CURRENT_STATE(my_cmd.resp[0]) =3D=3D 4) =
{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* card is in "trans" state, so treat th=
e CMD12 as succesfull */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 brq.stop.error =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0 else {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * card is not still in trans state. N=
ow send CMD12 again and repeat
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the process of checking the card st=
atus using CMD13
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(&my_cmd, 0, sizeof(struct mmc_com=
mand));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.opcode =3D MMC_STOP_TRANSMISSION;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.arg =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.flags =3D MMC_RSP_SPI_R1B | MMC_R=
SP_R1B | MMC_CMD_AC;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_mrq.cmd =3D &my_cmd;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc_wait_for_req(card->host, &my_mrq);
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* get the card status */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(&my_cmd, 0, sizeof(struct mmc_com=
mand));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.opcode =3D MMC_SEND_STATUS;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.arg =3D card->rca << 16;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC=
;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_mrq.cmd =3D &my_cmd;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc_wait_for_req(card->host, &my_mrq);
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 if(!my_mrq.cmd->error) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if(R1_CURRENT_STATE(my_cmd.resp[0]=
) =3D=3D 4) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* card is in "trans" state,=
 so treat the CMD12 as succesfull */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 brq.stop.error =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * card is not in "trans" =
state yet. Just post an error and
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * error is not recoverabl=
e
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 else {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* error for cmd13!!, then somethi=
ng is wrong with the card */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0 }
> +=A0=A0=A0 }
> +=A0=A0=A0 /* cmd12 error recovery fix */
> +
> =A0=A0=A0=A0 =A0=A0=A0 if (brq.cmd.error || brq.data.error || brq.sto=
p.error) {
> =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (brq.data.blocks > 1 && rq_data_d=
ir(req) =3D=3D READ) {
> =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* Redo read one sector at=
 a time */
>
> Regards,
> Mahadev Cholachagudda
>



--=20
Cheers,
Mahadev
