From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Add option to prevent eMMC sleep command
Date: Wed, 14 Dec 2011 16:34:19 +0100
Message-ID: <4EE8C1FB.5080205@stericsson.com>
References: <1323876036-10206-1-git-send-email-ulf.hansson@stericsson.com> <000601ccba74$afdb0180$0f910480$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:39881 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751974Ab1LNPek (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 10:34:40 -0500
In-Reply-To: <000601ccba74$afdb0180$0f910480$@org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, 'Lee Jones' <lee.jones@linaro.org>

Subhash Jadavani wrote:
> Why is this patch needed? Do you see any issue with eMMC sleep on particular
> cards?
> 
> Regards,
> Subhash

Suppose the eMMC is put in sleep state when doing suspend, at that point 
the kernel crashes. The kernel crash is supposed to be dumped to the 
same eMMC by some other software than the kernel itself. But this 
software do not have support for waking up the eMMC from sleep and is 
thus not able to store the dump.

Br
Ulf Hansson
