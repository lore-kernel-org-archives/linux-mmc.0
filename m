Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56638C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Nov 2021 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3779660F4B
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Nov 2021 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhKKPnO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Nov 2021 10:43:14 -0500
Received: from smtp2.axis.com ([195.60.68.18]:33747 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233510AbhKKPnM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Nov 2021 10:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636645223;
  x=1668181223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GoWQum+lKyDSPUD+h2RodiN3NAIKwAyslPa7sCdWChY=;
  b=lJipoOUQeaUR7TI1qs4p1HyLL1AREOUb9lKypKvTE6dKEJlloZfrPDcS
   wsAyGfRTRtoHqTE2yZx/7M3WHwRmTI5cN71siWCnRtEVDpup+oXb2Xr+c
   BsUj5f/If7XO6V+mzpxUKCj4fKUQ7Z1xdIpIJmij4DXL1KdktQZpwd1K0
   iUBde1ySgEyt7cynWaUzO6lwG6hHeahR+mY6TITbmRwoB3yhYNIZD/k5J
   6i/Ix7HN4uWp50pi1htQXJB4otMLsN9p6J4Yntc/2sl0haRQi0sgoFzjz
   nghyT8kfzzNkSZJcpaq/ninZ7Vmk9qSqLShhHZAWum+3sQ7AzIYD6x4oz
   w==;
Date:   Thu, 11 Nov 2021 16:40:20 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>
CC:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel <kernel@axis.com>, Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] mmc: dw_mmc: Avoid hung state if GEN_CMD transfer fails
Message-ID: <20211111154020.GA21634@axis.com>
References: <20211103182716.28419-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103182716.28419-1-marten.lindahl@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 03, 2021 at 07:27:16PM +0100, Mårten Lindahl wrote:
> If we get a data error during a block transfer command, a stop command
> (CMD12) is normally initiated. But this does not work for the general
> command (CMD56), but instead the action is ignored and an uninitialized
> command struct is used for the stop action, with unexpected result.
> 
> Fix this by adding a check for GEN_CMD when preparing stop transmission.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..988c32e93e03 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -335,7 +335,8 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
>  	    cmdr == MMC_WRITE_BLOCK ||
>  	    cmdr == MMC_WRITE_MULTIPLE_BLOCK ||
>  	    cmdr == MMC_SEND_TUNING_BLOCK ||
> -	    cmdr == MMC_SEND_TUNING_BLOCK_HS200) {
> +	    cmdr == MMC_SEND_TUNING_BLOCK_HS200 ||
> +	    cmdr == MMC_GEN_CMD) {
>  		stop->opcode = MMC_STOP_TRANSMISSION;
>  		stop->arg = 0;
>  		stop->flags = MMC_RSP_R1B | MMC_CMD_AC;

While this fix looks correct for CMD56, the "Data transfer mode"
sections of the eMMC and SD specifications list several more data
commands, all of which can be aborted by CMD12, but which aren't handled
in the if above.

If I'm not mistaken, those will also result in an uninitialized stop
command being sent in the case of an error, since the driver calls
send_stop_abort() on any data error.

Is there a reason why those other commands should not be in the list
above, or should we fix this list so that CMD12 is initialized for all
data commands except SD_IO_RW_EXTENDED?
