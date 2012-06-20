From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v3] mmc: core: Fix the HPI execution sequence
Date: Wed, 20 Jun 2012 23:29:42 +0530
Message-ID: <002301cd4f0e$7b380de0$71a829a0$@codeaurora.org>
References: <1340184834-12700-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0024_01CD4F3C.94F293D0"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:24580 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab2FTR7t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jun 2012 13:59:49 -0400
In-Reply-To: <1340184834-12700-1-git-send-email-svenkatr@ti.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com, alex.lemberg@sandisk.com, 'Kostya' <kdorfman@codeaurora.org>

This is a multipart message in MIME format.

------=_NextPart_000_0024_01CD4F3C.94F293D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Venkatraman,

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Venkatraman S
> Sent: Wednesday, June 20, 2012 3:04 PM
> To: cjb@laptop.org
> Cc: linux-mmc@vger.kernel.org; linkinjeon@gmail.com;
> jh80.chung@samsung.com; alex.lemberg@sandisk.com; Venkatraman S; Kostya
> Subject: [PATCH v3] mmc: core: Fix the HPI execution sequence
> 
> mmc_execute_hpi should send the HPI command only once, and only if the
> card is in PRG state.
> 
> According to eMMC spec, the command's completion time is not dependent on
> OUT_OF_INTERRUPT_TIME. Only the transition out of PRG STATE is guarded by
> OUT_OF_INTERRUPT_TIME - which is defined to begin at the end of sending
> the command itself.
> 
> Specify the default timeout for the actual sending of HPI command, and
then
> use OUT_OF_INTERRUPT_TIME to wait for the transition out of PRG state.

I guess this is not the correct interpretation. cmd.cmd_timeout_ms should
specify for how much time host driver should wait for command + busy line
deassertion. So why are you keeping the timeout calculation after the
command is completed?

mmc_send_hpi_cmd() returns means the host controller driver have ensured
that BUSY indication is removed so after mmc_send_hpi_cmd(), if you want to
check if the card is still in PROGRAMMING state, it should be unconditional
check in loop (rather than timeout based) until card is out of programming
state.

To me, mmc_send_hpi_cmd() implementation should not be anything different
than mmc_switch(). In mmc_switch() also, after mmc_wait_for_cmd() returns it
continuously keeps checking if card is programming or not.

Regards,
Subhash

> 
> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> CC: Kostya <kdorfman@codeaurora.org>
> ---
> v2 discussions: http://marc.info/?l=linux-mmc&m=133657255616390&w=2
> 
> v2->v3:
> 	Return gracefully for card idle states (suggested by kdorfman)
> 
>  drivers/mmc/core/core.c    |   57
++++++++++++++++++++++++++-----------------
> -
>  drivers/mmc/core/mmc_ops.c |    1 -
>  2 files changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 80ec427..08ed144 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -404,6 +404,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)  {
>  	int err;
>  	u32 status;
> +	unsigned long starttime;
> 
>  	BUG_ON(!card);
> 
> @@ -419,30 +420,40 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>  		goto out;
>  	}
> 
> -	/*
> -	 * If the card status is in PRG-state, we can send the HPI command.
> -	 */
> -	if (R1_CURRENT_STATE(status) == R1_STATE_PRG) {
> -		do {
> -			/*
> -			 * We don't know when the HPI command will finish
> -			 * processing, so we need to resend HPI until out
> -			 * of prg-state, and keep checking the card status
> -			 * with SEND_STATUS.  If a timeout error occurs when
> -			 * sending the HPI command, we are already out of
> -			 * prg-state.
> -			 */
> -			err = mmc_send_hpi_cmd(card, &status);
> -			if (err)
> -				pr_debug("%s: abort HPI (%d error)\n",
> -					 mmc_hostname(card->host), err);
> +	switch (R1_CURRENT_STATE(status)) {
> 
> -			err = mmc_send_status(card, &status);
> -			if (err)
> -				break;
> -		} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
> -	} else
> -		pr_debug("%s: Left prg-state\n", mmc_hostname(card->host));
> +	case R1_STATE_IDLE:
> +	case R1_STATE_READY:
> +	case R1_STATE_STBY: /* intentional fall through */
> +		/* In idle states, HPI is not needed and the caller
> +		 can issue the next intended command immediately */
> +		goto out;
> +		break;
> +	case R1_STATE_PRG:
> +		break;
> +	default:
> +		/* In all other states, it's illegal to issue HPI */
> +		pr_debug("%s: HPI cannot be sent. Card state=%d\n",
> +			mmc_hostname(card->host),
> R1_CURRENT_STATE(status));
> +		err = -EINVAL;
> +		goto out;
> +		break;
> +	}
> +
> +	starttime = jiffies;
> +	err = mmc_send_hpi_cmd(card, &status);
> +	if (err)
> +		goto out;
> +
> +	do {
> +		err = mmc_send_status(card, &status);
> +
> +		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
> +			break;
> +		if (jiffies_to_msecs(jiffies - starttime) >=
> +			card->ext_csd.out_of_int_time)
> +			err = -ETIMEDOUT;
> +	} while (!err);
> 
>  out:
>  	mmc_release_host(card->host);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 69370f4..0ed2cc5 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -569,7 +569,6 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32
> *status)
> 
>  	cmd.opcode = opcode;
>  	cmd.arg = card->rca << 16 | 1;
> -	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
> 
>  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>  	if (err) {
> --
> 1.7.10.rc2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_0024_01CD4F3C.94F293D0
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment

Received: from DFLE70.ent.ti.com (dfle70.ent.ti.com [128.247.5.40])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q5K9YYSr005565;
	Wed, 20 Jun 2012 04:34:34 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q5K9YYp4028088;
	Wed, 20 Jun 2012 04:34:34 -0500
Received: from arroyo.ext.ti.com ([192.94.94.40]:61000 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab2FTJev (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 05:34:51 -0400
Received: from localhost ([172.24.190.156])	by legion.dal.design.ti.com
 (8.11.7p1+Sun/8.11.7) with ESMTP id q5K9YVW01081;	Wed, 20 Jun 2012 04:34:31
 -0500 (CDT)
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com
 [128.247.22.53])	by dlelxv24.itg.ti.com (8.13.8/8.13.8) with ESMTP id
 q5K9YXUt009454;	Wed, 20 Jun 2012 04:34:33 -0500
Received: from dlelxv24.itg.ti.com (172.17.1.199) by dfle70.ent.ti.com
 (128.247.5.40) with Microsoft SMTP Server id 14.1.323.3; Wed, 20 Jun 2012
 04:34:34 -0500
Received: from gatewayhorse1.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTP id 8DCA210004D3;
	Wed, 20 Jun 2012 02:34:53 -0700 (PDT)
Received: from vger.kernel.org ([209.132.180.67])
  by gatewayhorse1.qualcomm.com with ESMTP; 20 Jun 2012 02:34:53 -0700
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab2FTJew (ORCPT <rfc822;venkatg@codeaurora.org>
	+ 2 others); Wed, 20 Jun 2012 05:34:52 -0400
Return-Path: <linux-mmc-owner@vger.kernel.org>
From: "Venkatraman S" <svenkatr@ti.com>
Sender: <linux-mmc-owner@vger.kernel.org>
To: <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>,
	<linkinjeon@gmail.com>,
	<jh80.chung@samsung.com>,
	<alex.lemberg@sandisk.com>,
	"Venkatraman S" <svenkatr@ti.com>,
	"Kostya" <kdorfman@codeaurora.org>
Subject: [PATCH v3] mmc: core: Fix the HPI execution sequence
Date: Wed, 20 Jun 2012 15:03:54 +0530
Message-ID: <1340184834-12700-1-git-send-email-svenkatr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGtxSHLa4Hdn1tC1rJVs2VVlTUrFg==

mmc_execute_hpi should send the HPI command only
once, and only if the card is in PRG state.

According to eMMC spec, the command's completion time is
not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
defined to begin at the end of sending the command itself.

Specify the default timeout for the actual sending of HPI
command, and then use OUT_OF_INTERRUPT_TIME to wait for
the transition out of PRG state.

Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
CC: Kostya <kdorfman@codeaurora.org>
---
v2 discussions: http://marc.info/?l=linux-mmc&m=133657255616390&w=2

v2->v3: 
	Return gracefully for card idle states (suggested by kdorfman)

 drivers/mmc/core/core.c    |   57
++++++++++++++++++++++++++------------------
 drivers/mmc/core/mmc_ops.c |    1 -
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 80ec427..08ed144 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -404,6 +404,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 {
 	int err;
 	u32 status;
+	unsigned long starttime;
 
 	BUG_ON(!card);
 
@@ -419,30 +420,40 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 		goto out;
 	}
 
-	/*
-	 * If the card status is in PRG-state, we can send the HPI command.
-	 */
-	if (R1_CURRENT_STATE(status) == R1_STATE_PRG) {
-		do {
-			/*
-			 * We don't know when the HPI command will finish
-			 * processing, so we need to resend HPI until out
-			 * of prg-state, and keep checking the card status
-			 * with SEND_STATUS.  If a timeout error occurs when
-			 * sending the HPI command, we are already out of
-			 * prg-state.
-			 */
-			err = mmc_send_hpi_cmd(card, &status);
-			if (err)
-				pr_debug("%s: abort HPI (%d error)\n",
-					 mmc_hostname(card->host), err);
+	switch (R1_CURRENT_STATE(status)) {
 
-			err = mmc_send_status(card, &status);
-			if (err)
-				break;
-		} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
-	} else
-		pr_debug("%s: Left prg-state\n", mmc_hostname(card->host));
+	case R1_STATE_IDLE:
+	case R1_STATE_READY:
+	case R1_STATE_STBY: /* intentional fall through */
+		/* In idle states, HPI is not needed and the caller
+		 can issue the next intended command immediately */
+		goto out;
+		break;
+	case R1_STATE_PRG:
+		break;
+	default:
+		/* In all other states, it's illegal to issue HPI */
+		pr_debug("%s: HPI cannot be sent. Card state=%d\n",
+			mmc_hostname(card->host), R1_CURRENT_STATE(status));
+		err = -EINVAL;
+		goto out;
+		break;
+	}
+
+	starttime = jiffies;
+	err = mmc_send_hpi_cmd(card, &status);
+	if (err)
+		goto out;
+
+	do {
+		err = mmc_send_status(card, &status);
+
+		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
+			break;
+		if (jiffies_to_msecs(jiffies - starttime) >=
+			card->ext_csd.out_of_int_time)
+			err = -ETIMEDOUT;
+	} while (!err);
 
 out:
 	mmc_release_host(card->host);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 69370f4..0ed2cc5 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -569,7 +569,6 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 
 	cmd.opcode = opcode;
 	cmd.arg = card->rca << 16 | 1;
-	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
-- 
1.7.10.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_0024_01CD4F3C.94F293D0--

