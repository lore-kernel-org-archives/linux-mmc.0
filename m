From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: help with 'discard' mount option on eMMC
Date: Thu, 10 Oct 2013 11:53:25 +0300
Message-ID: <52566B05.3000204@codeaurora.org>
References: <loom.20131010T083357-685@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:55664 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab3JJIx3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Oct 2013 04:53:29 -0400
In-Reply-To: <loom.20131010T083357-685@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hello,
Could you please post kernel log of such failure?
What hw are you using?

On 10/10/13 09:44, Prasanna NAVARATNA wrote:
> Hello,
>
> I'm using Hynix eMMC4.41 with Linux kernel 3.4.5.
>
> After mounting ext4 partition /userdata with 'discard' mount option enabled,
> fs triggers TRIM commands to eMMC after every file deletion. With this
> setup, for a continuous reboot test (5s awake and issue reboot and repeat)
> with 10 or 20 iterations, i see data corruption in eMMC consistently.
>
> mount options are :- noatime,nosuid,nodev,noauto_da_alloc,discard
> encryptable="path"
>
> What am i missing here? if 'discard' mount option is removed, then no data
> corruption in eMMC for more than 200 iterations. Does TRIM needs some extra
> care? BKOPS is not enabled in eMMC (is bkops mandatory if using TRIM?)
> Apologies, if this is not proper platform to ask such question. Please guide
> and throw some light.
>
> Thanks,
> Prasanna NAVARATNA
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

