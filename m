From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: BUG/PATCH?  mmcblk devices don't suspend properly.
Date: Thu, 5 Apr 2012 08:57:35 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33182495F@DBDE01.ent.ti.com>
References: <20120330134745.2baa2766@notabene.brown>
 <4F7543D9.7000100@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54399 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab2DEI5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Apr 2012 04:57:44 -0400
In-Reply-To: <4F7543D9.7000100@codeaurora.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>, NeilBrown <neilb@suse.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "per.forlin@linaro.org" <per.forlin@linaro.org>

I contacted the original author of the patch (http://comments.gmane.org/gmane.linux.kernel.mmc/9168)
And he has posted the 2nd version of the commit. 

[PATCH V2]mmc: remove MMC bus legacy suspend/resume method

MMC bus is using legacy suspend/resume method, which is not compatible if
runtime pm callbacks are used. In this scenario, MMC bus suspend/resume
callbacks cannot be called when system entering S3. So change to use the new
defined dev_pm_ops for system sleeping mode

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
Changes in v2:
	use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks as Rafael
	suggested


May be you can test your setup with this patch.


On Fri, Mar 30, 2012 at 10:55:45, Sujit Reddy Thumma wrote:
> On 3/30/2012 8:17 AM, NeilBrown wrote:
> >
> > I've been experimenting with removing the call to sys_sync() in
> > enter_state().  For me (with verbose debugging and syslog running)
> > this causes a noticeable delay when entering suspend.
> >
[...snip...]
> >
> > Since removing the sys_sync() call I've notices a number of problems with
> > suspend/resume, the most obvious being that resume blocks in mmc_claim_host:
> >
> > [  263.585754] susman          D c046455c  5604  1086   1084 0x00000000
> > [  263.592498] [<c046455c>] (__schedule+0x584/0x614) from [<c0302630>] (__mmc_claim_host+0xb8/0x154)
> > [  263.601806] [<c0302630>] (__mmc_claim_host+0xb8/0x154) from [<c0308640>] (mmc_sd_resume+0x34/0x5c)
> > [  263.611206] [<c0308640>] (mmc_sd_resume+0x34/0x5c) from [<c0301ce4>] (mmc_resume_host+0xc8/0x15c)

[...snip...]

> This was pointed out earlier and a patch is posted but looks like it 
> never went into mmc tree -- 
> http://comments.gmane.org/gmane.linux.kernel.mmc/9168
> 
> >
> >
> > Thanks for any help you can provide,
> >
> > NeilBrown
> >
> 
> --

Regards, 
Gururaja
