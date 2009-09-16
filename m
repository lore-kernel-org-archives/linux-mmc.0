From: Mahadev Cholachagudda <mgudda@gmail.com>
Subject: [PATCH 1/1] CMD12 error recovery support for SD cards
Date: Wed, 16 Sep 2009 16:09:11 +0530
Message-ID: <bd31ea570909160339l5f996e9eh1f87abdbe527a404@mail.gmail.com>
References: <bd31ea570909160334u1b17a068hd8be89c7035232f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f180.google.com ([209.85.222.180]:48302 "EHLO
	mail-pz0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbZIPLFu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2009 07:05:50 -0400
Received: by pzk10 with SMTP id 10so17625pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2009 04:05:53 -0700 (PDT)
In-Reply-To: <bd31ea570909160334u1b17a068hd8be89c7035232f9@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear All,

I've a kernel code base of 2.6.28.9, where in I find that CMD12 error
recovery is not been implemented. It is a wise idea to implement CMD12
error recovery, that involves sending CMD13 to get the status of the
card. If the card is in "trans" state, it means CMD12 error shall be
treated as successfull. If card state is not in "trans", then we have
to send CMD12 again to stop the data transfer and then checking of the
card status through CMD13. This sequence is detailed in the
"Simplified Host Controller specification" on SDCard website. I
believe this is the case for any controller, though I may be wrong.

With the modification done to the code which is attached as patch to
the latest mmc git, it is working at our site. And we do see some
errors with the SDIO controller (proprietary but meets Standard SD
host controller specification) that we are using.

Request you to comment on the patch.

diff -urNd linux-orig/drivers/mmc/card/block.c
linux-current/drivers/mmc/card/block.c
--- linux-orig/drivers/mmc/card/block.c=A0=A0=A0 2009-09-16 15:43:03.66=
7274139 +0530
+++ linux-current/drivers/mmc/card/block.c=A0=A0=A0 2009-09-16
15:36:24.722272962 +0530
@@ -335,6 +335,76 @@
=A0=A0=A0=A0 =A0=A0=A0 =A0* until later as we need to wait for the card=
 to leave
=A0=A0=A0=A0 =A0=A0=A0 =A0* programming mode even when things go wrong.
=A0=A0=A0=A0 =A0=A0=A0 =A0*/
+
+=A0=A0=A0 /* cmd12 error recovery fix */
+=A0=A0=A0 if( (brq.stop.error) && (brq.data.blocks > 1) &&
!mmc_host_is_spi(card->host) &&
+=A0=A0=A0=A0=A0=A0=A0 mmc_card_sd(card) ) {
+
+=A0=A0=A0=A0=A0 struct mmc_request my_mrq;
+=A0=A0=A0=A0=A0 struct mmc_command my_cmd;
+
+=A0=A0=A0=A0=A0 /*
+=A0=A0=A0=A0=A0=A0 * if there is an error for CMD12, get the state of =
the card by
+=A0=A0=A0=A0=A0=A0 * sending cmd13 and then check the state of the car=
d.
+=A0=A0=A0=A0=A0=A0 * If the card state is "tran", consider the cmd12 i=
s successfull
+=A0=A0=A0=A0=A0=A0 * If not, then send again CMD12 to stop the data tr=
ansfer. This time,
+=A0=A0=A0=A0=A0=A0 * any failure to get response, will result in to th=
e card being
+=A0=A0=A0=A0=A0=A0 * non-recoverable.
+=A0=A0=A0=A0=A0=A0 */
+
+=A0=A0=A0=A0=A0 memset(&my_mrq, 0, sizeof(struct mmc_request));
+=A0=A0=A0=A0=A0 memset(&my_cmd, 0, sizeof(struct mmc_command));
+=A0=A0=A0=A0=A0 my_cmd.opcode =3D MMC_SEND_STATUS;
+=A0=A0=A0=A0=A0 my_cmd.arg =3D card->rca << 16;
+=A0=A0=A0=A0=A0 my_cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
+=A0=A0=A0=A0=A0 my_mrq.cmd =3D &my_cmd;
+=A0=A0=A0=A0=A0 mmc_wait_for_req(card->host, &my_mrq);
+
+=A0=A0=A0=A0=A0 if(!my_mrq.cmd->error) {
+=A0=A0=A0=A0=A0=A0=A0 if(R1_CURRENT_STATE(my_cmd.resp[0]) =3D=3D 4) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* card is in "trans" state, so treat the =
CMD12 as succesfull */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 brq.stop.error =3D 0;
+=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0=A0 else {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * card is not still in trans state. Now=
 send CMD12 again and repeat
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the process of checking the card stat=
us using CMD13
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(&my_cmd, 0, sizeof(struct mmc_comma=
nd));
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.opcode =3D MMC_STOP_TRANSMISSION;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.arg =3D 0;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.flags =3D MMC_RSP_SPI_R1B | MMC_RSP=
_R1B | MMC_CMD_AC;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_mrq.cmd =3D &my_cmd;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc_wait_for_req(card->host, &my_mrq);
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* get the card status */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(&my_cmd, 0, sizeof(struct mmc_comma=
nd));
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.opcode =3D MMC_SEND_STATUS;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.arg =3D card->rca << 16;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 my_mrq.cmd =3D &my_cmd;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc_wait_for_req(card->host, &my_mrq);
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 if(!my_mrq.cmd->error) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if(R1_CURRENT_STATE(my_cmd.resp[0]) =
=3D=3D 4) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* card is in "trans" state, s=
o treat the CMD12 as succesfull */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 brq.stop.error =3D 0;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * card is not in "trans" st=
ate yet. Just post an error and
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * error is not recoverable
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 else {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* error for cmd13!!, then something=
 is wrong with the card */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0 }
+=A0=A0=A0 }
+=A0=A0=A0 /* cmd12 error recovery fix */
+
=A0=A0=A0=A0 =A0=A0=A0 if (brq.cmd.error || brq.data.error || brq.stop.=
error) {
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (brq.data.blocks > 1 && rq_data_dir=
(req) =3D=3D READ) {
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* Redo read one sector at a=
 time */

Regards,
Mahadev Cholachagudda
