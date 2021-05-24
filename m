Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C747EC2B9F7
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 16:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD69C6117A
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 16:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhEXQLa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 12:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236367AbhEXQIn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 May 2021 12:08:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37EAC613F9;
        Mon, 24 May 2021 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621872434;
        bh=jPw+QKOWI6o1RGgUT4n/9FHwCr3VTPV+8kFU79WZUNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5Zz3fwSVx+0sa+hmuUjzdHOjPiPAWyzRG0V24dTyJSVBJlvEm32SfvaU/Xp+LP2e
         nHp8kehBSRokBS5IJ1gWNRHfwJaoGwMc6x8Fmrx+SYFdgQLeBAzYeRT4O1cR7RClJO
         XyGBVzwCnD13lvCvDjDfNPDUHIa8slYTJ76J1si0=
Date:   Mon, 24 May 2021 18:07:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aviral Gupta <shiv14112001@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com, axboe@kernel.dk,
        beanhuo@micron.com, satyat@google.com, avri.altman@wdc.com,
        richard.peng@oppo.com, guoqing.jiang@cloud.ionos.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] This patch fixes the warning generated due to use of
 symbolic
Message-ID: <YKvPMFuZYn/ypSP1@kroah.com>
References: <20210524155705.5138-1-shiv14112001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524155705.5138-1-shiv14112001@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, May 24, 2021 at 09:27:06PM +0530, Aviral Gupta wrote:
> It's better to use octal permissons instead of symbolic ones because  peoples are more
> familiar with octal permissons.
> WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
> +	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
> 
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +			mode = S_IRUGO;
> 
> WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
> +			mode = S_IRUGO | S_IWUSR;
> 
> WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
> +			debugfs_create_file("ext_csd", S_IRUSR, root, card,
> 
> Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>
> ---
>  drivers/mmc/core/block.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
