From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Wed, 03 Oct 2012 17:03:11 -0400
Message-ID: <87k3v7i7zk.fsf@octavius.laptop.org>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37194 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971Ab2JCVDW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Oct 2012 17:03:22 -0400
In-Reply-To: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Thu, 13 Sep 2012 11:20:53 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Saugata Das <saugata.das@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

Hi Ulf,

On Thu, Sep 13 2012, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> This patch fixup the broken suspend sequence for eMMC
> with sleep support. Additionally it reworks the eMMC4.5
> Power Off Notification feature so it fits together with
> the existing sleep feature.
>
> The CMD0 based re-initialization of the eMMC at resume
> is re-introduced to maintain compatiblity for devices
> using sleep.
>
> A host shall use MMC_CAP2_POWEROFF_NOTIFY to enable the
> Power Off Notification feature. We might be able to
> remove this cap later on, if we think that Power Off
> Notification always is preferred over sleep, even if the
> host is not able to cut the eMMC VCCQ power.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
> CC: Girish K S <girish.shivananjappa@linaro.org>
> CC: Asutosh Das <asutoshd@codeaurora.org>

I gave this patch a try on a board with an eMMC 4.41, but it didn't
resolve the crash that I see.  After applying the patch, I still see:

[   25.191917] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[   25.319299] mmc1: Got data interrupt 0x00000002 even though no data operation was in progress.
[   25.335054] PM: Device d4281000.sdhci failed to suspend: error -110
[   25.341461] PM: Some devices failed to suspend

and the suspend aborts.  If I modify mmc_card_can_sleep() to always
return false, the suspend completes without errors, so I know that
something in the sleep code is responsible for my crash.

Any suggestions?  Perhaps it's a different bug in the eMMC sleep code.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
