From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Fri, 05 Oct 2012 12:50:29 -0400
Message-ID: <87r4pcg8x6.fsf@octavius.laptop.org>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45865 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756721Ab2JEQuj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Oct 2012 12:50:39 -0400
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

Thanks, I've merged this now.  I've got an eMMC 4.5 sample on the way
to me, I'll help out with making sure that suspend/resume is tested.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
