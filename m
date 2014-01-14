From: Chris Ball <chris@printf.net>
Subject: Re: wl1271: sdio: is fine-grained runtime_pm possible?
Date: Tue, 14 Jan 2014 03:27:00 +0000
Message-ID: <867ga39raz.fsf@void.printf.net>
References: <CAKZq+rdaCivZTFSTGt9_Q+3KFE9Ft0XfmWZ=1Vr7QcDDs9=Muw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41434 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbaAND1H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 22:27:07 -0500
In-Reply-To: <CAKZq+rdaCivZTFSTGt9_Q+3KFE9Ft0XfmWZ=1Vr7QcDDs9=Muw@mail.gmail.com>
	(Chao Xu's message of "Mon, 13 Jan 2014 20:58:02 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chao Xu <caesarxuchao@gmail.com>
Cc: Luciano Coelho <luciano.coelho@intel.com>, ohad@wizery.com, linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 14 2014, Chao Xu wrote:
> The patch "SDIO Runtime PM Support" implements the pm for wl12xx
> driver this way: the power for sdio is on whenever the WLAN interface
> is on, and the power is down only when the interface is down.
> Is it possible to do pm in a more fine-grained way, such as only
> turning on the power when reading/writing through sdio? An example is
> the mmc_blk_issue_rq() in drivers/mmc/card/block.c, where the host is
> released when there are no more requests. And in turn the host driver,
> such as omap_hsmmc.c, calls pm_runtime_put_autosuspend().
> Is there any fundamental argument against doing fine-grained runtime
> pm for sdio? Or is it just too much trouble for too little power
> saved?
> Thank you!

I feel like I must be missing something, but:

Network devices generate interrupts when you have new network activity
to process, and to generate an interrupt they need to be turned on.

How would you avoid having the WLAN device be unpowered while someone
is trying to talk to you?

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
