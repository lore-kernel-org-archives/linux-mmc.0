From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [RACE] between rescan thread and clock-gate work
Date: Mon, 11 Apr 2011 18:12:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104111722380.20798@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63593 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1DKQMs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 12:12:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by axis700.grange (Postfix) with ESMTP id 199F6189B85
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 18:12:44 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all

I'm observing re-entry into driver's (tmio) .set_ios() method, caused by a 
race between the card-detect rescan thread along the lines of

[kworker/u:0 worker-thread]
mmc_claim_host()
mmc_rescan()
mmc_rescan_try_freq() /* yes, there are also other paths to call 
			.set_ios() from here */
mmc_go_idle()
mmc_set_chip_select()
mmc_set_ios()
host->ops->set_ios()

and the clock-gate work, scheduled from a command completion:

mmc_request_done()
mmc_host_clk_gate()
schedule_work()
[kworker/0:1 worker-thread] - after mmc_release_host()
mmc_host_clk_gate_delayed()
mutex_lock(&host->clk_gate_mutex)
mmc_gate_clock()
mmc_set_ios()
host->ops->set_ios()

Replacing the clk_gate_mutex mutex with claiming and releasing the host 
fixes the problem for me, but I'm not sure, whether this is the correct 
solution.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
