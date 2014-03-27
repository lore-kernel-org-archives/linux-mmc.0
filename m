From: Lee Chen <achieveforce@gmail.com>
Subject: Re: =?utf-8?b?d2FpdF9mb3JfY29tcGxldGlvbg==?= in =?utf-8?b?bW1jX3dhaXRfZm9yX3JlcV9kb25l?= never returns
Date: Thu, 27 Mar 2014 05:39:08 +0000 (UTC)
Message-ID: <loom.20140327T063548-227@post.gmane.org>
References: <8D4F0053-96FB-4ED3-B224-275E3CDDCFBC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58152 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbaC0FpG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Mar 2014 01:45:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1WT37f-0005Oz-Ex
	for linux-mmc@vger.kernel.org; Thu, 27 Mar 2014 06:45:03 +0100
Received: from ool-2f10c831.dyn.optonline.net ([47.16.200.49])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 27 Mar 2014 06:45:03 +0100
Received: from achieveforce by ool-2f10c831.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 27 Mar 2014 06:45:03 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Jon Ringle <jonringle <at> gmail.com> writes:

> 
> I'm porting an arm board from linux-3.10 to linux-3.12 and found that I
can no longer detect the SD card. I
> found that the wait_for_completion(&mrq->completion) in
> drivers/mmc/core/core.c:mmc_wait_for_req_done() is never returning.
> 
> I was able to bisect the problem to this commit:
> 0244ad004a54e39308d495fee0a2e637f8b5c317 is the first bad commit
> commit 0244ad004a54e39308d495fee0a2e637f8b5c317
> Author: Martin Schwidefsky <schwidefsky <at> de.ibm.com>
> Date:   Fri Aug 30 09:39:53 2013 +0200
> 
> 


I noticed that issue as well. Did you get any response on this? I am
thinking replace the "wait_for_completion" with
"wait_for_completion_timeout". What value of the time out you think is
appropriate? I used 1000.

