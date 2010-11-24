From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v1 4/4]use HPI to interrupt background operations
Date: Wed, 24 Nov 2010 13:07:46 +0900
Message-ID: <AANLkTinF3+nUb8ugttyw-A_ss8cyX1iHFzG6bLdGf5d6@mail.gmail.com>
References: <20101123084510.GE17754@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48499 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab0KXEHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2010 23:07:49 -0500
In-Reply-To: <20101123084510.GE17754@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org, alan@linux.intel.com, arjan@linux.intel.com, hang.yuan@intel.com

On Tue, Nov 23, 2010 at 5:45 PM, Chuanxiao Dong
<chuanxiao.dong@intel.com> wrote:
> From 8d2cf8e4b890a3ef0c7b63da57b8b184ab64725d Mon Sep 17 00:00:00 200=
1
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Date: Tue, 23 Nov 2010 12:01:58 +0800
> Subject: [PATCH 4/4] mmc: Add HPI operation to interrupt BKOPS
>
> Before start a new user request, driver need to wait until the
> BKOPS finished, or use HPI to interrupt the BKOPS since user request
> has a higher priority than BKOPS.
>
> This patch implemented using HPI to interrupt BKOPS if eMMC card
> supports HPI.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> =A0drivers/mmc/core/core.c | =A0 51 +++++++++++++++++++++++++++++++++=
+++++++++++++-
> =A01 files changed, 50 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6891169..644ce9d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -202,6 +202,50 @@ static void mmc_wait_done(struct mmc_request *mr=
q)
> =A0}
>
> =A0/**
> + * =A0 =A0 mmc_issue_hpi_cmd - start a hpi to interrupt background
> + * =A0 =A0 operations
> + * =A0 =A0 @card: MMC card need to interrupt
> + *
> + * =A0start MMC_SEND_STATUS/MMC_STOP_TRANSMISSION to stop the
> + * =A0background operations.
> + *
> + * =A0return value:
> + * =A00: successfully interrupt BKOPS
> + * =A0-EINVAL: HPI command invalid
> + * =A0-EIO: failed when interrupt BKOPS
> + */
> +static int mmc_issue_hpi_cmd(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 struct mmc_command cmd;
> + =A0 =A0 =A0 unsigned int opcode;
> + =A0 =A0 =A0 unsigned int flags;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 opcode =3D card->ext_csd.hpi_cmd;
> + =A0 =A0 =A0 if (opcode =3D=3D MMC_STOP_TRANSMISSION)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1B | MMC_CMD_AC;
> + =A0 =A0 =A0 else if (opcode =3D=3D MMC_SEND_STATUS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
> + =A0 =A0 =A0 cmd.opcode =3D opcode;
> + =A0 =A0 =A0 cmd.arg =3D card->rca << 16 | 1;
Maybe missing set the flags;
            cmd.flags =3D flags;

Thank you,
Kyungmin Park
> + =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
> + =A0 =A0 =A0 if (err || (cmd.resp[0] & 0xFDF92000)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "error %d requesting st=
atus %#x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err, cmd.resp[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* abandon this BKOPS, let block laye=
r handle
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> =A0* =A0 =A0 mmc_wait_for_bkops- start a bkops check and wait for
> =A0* =A0 =A0 completion
> =A0* =A0 =A0 @card: MMC card need to check
> @@ -224,9 +268,14 @@ retry:
>
> =A0 =A0 =A0 =A0if (card->ext_csd.hpi_en) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* TODO
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * HPI to interrupt BKOPS if supported
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_issue_hpi_cmd(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err =3D=3D -EINVAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable HPI feature =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi_en =3D=
 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto retry;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&cmd, 0, sizeof(struct mmc_comm=
and));
>
> --
> 1.6.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
