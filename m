Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFCCC7EE23
	for <linux-mmc@archiver.kernel.org>; Mon,  8 May 2023 11:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbjEHLrA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 May 2023 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjEHLqu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2023 07:46:50 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407F59E7
        for <linux-mmc@vger.kernel.org>; Mon,  8 May 2023 04:46:47 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E2F103A19BC
        for <linux-mmc@vger.kernel.org>; Mon,  8 May 2023 13:46:45 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D83EA3A196E
        for <linux-mmc@vger.kernel.org>; Mon,  8 May 2023 13:46:45 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Mon,  8 May 2023 13:46:45 +0200 (CEST)
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: RE: [PATCH 3/3] mmc: block: ioctl: Add error aggregation flag
Thread-Topic: [PATCH 3/3] mmc: block: ioctl: Add error aggregation flag
Thread-Index: AdlntYltCGNgWPv+Tc2Z1o0i39Q1TwZ7QDXQ
Date:   Mon, 8 May 2023 11:46:44 +0000
Message-ID: <f4434f3226404d0cae470886832b05d6@hyperstone.com>
References: <043d49e37e254eb8aa8a2c5fc56a028b@hyperstone.com>
In-Reply-To: <043d49e37e254eb8aa8a2c5fc56a028b@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27612.005
X-TMASE-Result: 10--27.665900-10.000000
X-TMASE-MatchedRID: oHOSwQSJZWj/9O/B1c/Qy8/TUbRlF35/ld00Q5SO0q4utoY2UtFqGPVH
        KR9dQRzv1HizS2UwAqa5hiunv4GcS4IokrTYtYlKHWRJEfGP5nmUq+GQ/zyJdKJXp9dweNlvNyl
        ek8JXQTdG391z8AkhmuvkJBFg3vCcYPx7yddt9jIF7cpFXK76TdDZ1FFTJUym5MDAlfnFRGrXQj
        bjf/eQSak0GlHrLJycAzqpCxXEiQwQlJEJlaovbjo39wOA02LhbbR2OHKjX2Y6FHRWx2FGsL8FH
        rw7frluf146W0iUu2umUJpFI8DJTfil247XDr/jqdwbW9Wx9tAibYmzSbsTwr5TVqwOzxj8qF9F
        0eLR2eoPqa51CdJTIM/KyMYufa5mIU+ehk8Xygdp5gkCyfx58MnlJe2gk8vIdFY+YGPfKwy2f+Q
        YDlJvIMw/xnPT4YLVQPM/Gtm49YNe01kJEvaGm54CIKY/Hg3AY2fxc+IAshv3IRre2/Nqdhd65A
        KojGV5vECLuM+h4RB+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 21cfb239-faa9-4edd-b778-1dc269f1c7df-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Did anyone find the time to look at this yet?
Any comments?

-----Original Message-----
From: Christian Löhle 
Sent: Wednesday, April 5, 2023 1:58 PM
To: Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter <adrian.hunter@intel.com>; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 3/3] mmc: block: ioctl: Add error aggregation flag

> Userspace currently has no way of checking for error bits of detection mode X. These are error bits that are only detected by the card when executing the command. For e.g. a sanitize operation this may be minutes after the RSP was seen by the host.
> 
> Currently userspace programs cannot see these error bits reliably.
> They could issue a multi ioctl cmd with a CMD13 immediately following it, but since errors of detection mode X are automatically cleared (they are all clear condition B).
> mmc_poll_for_busy of the first ioctl may have already hidden such an error flag.
> 
> In case of the security operations: sanitize, secure erases and RPMB writes, this could lead to the operation not being performed successfully by the card with the user not knowing.
> If the user trusts that this operation is completed (e.g. their data is sanitized), this could be a security issue.
> An attacker could e.g. provoke a eMMC (VCC) flash fail, where a successful sanitize of a card is not possible. A card may move out of PROG state but issue a bit 19 R1 error.
> 
> This patch therefore will also have the consequence of a mmc-utils patch, which enables the bit for the security-sensitive operations.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c       | 34 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/mmc/ioctl.h |  2 ++
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index 35ff7101cbb1..386a508bd720 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -457,7 +457,7 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
>  			 sizeof(ic->response)))
>  		return -EFAULT;
>  
> -	if (!idata->ic.write_flag) {
> +	if (!idata->ic.write_flag && idata->buf) {
>  		if (copy_to_user((void __user *)(unsigned long)ic->data_ptr,
>  				 idata->buf, idata->buf_bytes))
>  			return -EFAULT;
> @@ -610,13 +610,43 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
>  
>  	/* No need to poll when using HW busy detection. */
> -	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> +	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp &&
> +			!(idata->ic.write_flag & MMC_AGGREGATE_PROG_ERRORS))
>  		return 0;
>  
>  	if (mmc_host_is_spi(card->host)) {
>  		if (idata->ic.write_flag)
>  			err = mmc_spi_err_check(card);
>  	}
> +	/*
> +	 * We want to receive a meaningful R1 response for errors of detection
> +	 * type X, which are only set after the card has executed the command.
> +	 * In that case poll CMD13 until PROG is left and return the
> +	 * accumulated error bits.
> +	 * If we're lucky host controller has busy detection for R1B and
> +	 * this is just a single CMD13.
> +	 * We can abuse resp[1] as the post-PROG R1 here, as all commands
> +	 * that go through PRG have an R1 response and therefore only
> +	 * use resp[0].
> +	 */
> +	else if (idata->ic.write_flag & MMC_AGGREGATE_PROG_ERRORS) {
> +		unsigned long timeout = jiffies +
> +			msecs_to_jiffies(busy_timeout_ms);
> +		bool done = false;
> +		unsigned long delay_ms = 1;
> +		u32 status;
> +
> +		do {
> +			done = time_after(jiffies, timeout);
> +			msleep(delay_ms++);
> +			err = __mmc_send_status(card, &status, 1);
> +			if (err)
> +				return err;
> +			idata->ic.response[1] |= status;
> +		} while (R1_CURRENT_STATE(status) != R1_STATE_TRAN && !done);
> +		if (done)
> +			return -ETIMEDOUT;
> +	}
>  	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
>  	else if (idata->rpmb || r1b_resp)
>  		err = mmc_poll_for_busy(card, busy_timeout_ms, false, diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h index b2ff7f5be87b..a9d84ae8d57d 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -8,9 +8,11 @@
>  struct mmc_ioc_cmd {
>  	/*
>  	 * Direction of data: nonzero = write, zero = read.
> +	 * Bit 30 selects error aggregation post-PROG state.
>  	 * Bit 31 selects 'Reliable Write' for RPMB.
>  	 */
>  	int write_flag;
> +#define MMC_AGGREGATE_PROG_ERRORS (1 << 30)
>  #define MMC_RPMB_RELIABLE_WRITE (1 << 31)
>  
>  	/* Application-specific command.  true = precede with CMD55 */
> --
> 2.37.3
> 
>

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

