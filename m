From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4 0/4] mmc: Use runtime pm for blkdevice
Date: Sun, 26 May 2013 13:38:45 -0400
Message-ID: <87wqqlljyy.fsf@octavius.laptop.org>
References: <1367496159-7090-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56696 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649Ab3EZRit (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:38:49 -0400
In-Reply-To: <1367496159-7090-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Thu, 2 May 2013 14:02:35 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Hi Ulf,

On Thu, May 02 2013, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> SDIO has been using runtime pm for a while to handle runtime power save
> operations. This patchset is enabling the option to make the sd/mmc
> blockdevices to use runtime pm as well.
>
> The runtime pm implementation for the block device will make use of
> autosuspend to defer power save operation to after request inactivty for
> a certain time.
>
> Corresponding pm_runtime_get|put calls has been added at those places that
> do requires the card to be fully powered to communicate.
>
> Patch 4 can be considered as a proof of concept patch. It implements
> aggressive power management for (e)MMC/SD. This feature has also been
> discussed on the mmc mailing list previously.
>
> Next step would be to implement the IDLE BKOPS on top of the runtime pm
> callbacks.

Sorry for the delay -- I've pushed all four patches to mmc-next now,
with the goal of merging them for 3.11.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
