From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning
Date: Tue, 03 Jul 2012 20:37:33 -0400
Message-ID: <874npo744y.fsf@octavius.laptop.org>
References: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36548 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754Ab2GDAhk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 20:37:40 -0400
In-Reply-To: <1341307669-20834-1-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Tue, 3 Jul 2012 17:27:49 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Subhash Jadavani <subhashj@codeaurora.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Tue, Jul 03 2012, Aaron Lu wrote:
> V2:
> Fix for SDIO case: both SD and SDIO cards use cmd19 while eMMC use cmd21.
>
> V1:
> For SD hosts using retuning mode 1, when retuning timer expired, it will
> need to do retuning in sdhci_request before processing the actual
> request. But the retuning command is fixed: cmd19 for SD card and cmd21
> for eMMC card, so we can't use the original request's command to do the
> tuning.
>
> And since the tuning command depends on the card type atteched to the
> host, we will need to know the card type to use the correct tuning
> command.
>
> Cc: stable <stable@vger.kernel.org> [3.3+]
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> ---

Thanks, pushed to mmc-next for 3.6 with Philip's Reviewed-by.

For next time, please put the patch changelog at this point in the patch
(after ---) so that it doesn't show up in the recorded commit message.

Also, please don't e-mail the patch to stable@ before it has entered
mainline.  They'll pick it up from the CC in the commit message when
Linus merges it, they don't want a copy of the patch before then.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
