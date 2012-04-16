From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH V4]mmc: remove MMC bus legacy suspend/resume method
Date: Mon, 16 Apr 2012 05:47:05 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33E9D0E24@DBDE01.ent.ti.com>
References: <20120411115438.GA303@intel.com> <4F858A25.20302@stericsson.com>
 <87y5q2s4yo.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab2DPFr0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Apr 2012 01:47:26 -0400
In-Reply-To: <87y5q2s4yo.fsf@laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>

On Wed, Apr 11, 2012 at 20:14:47, Chris Ball wrote:
> Hi,
> 
> On Wed, Apr 11 2012, Ulf Hansson wrote:
> > On 04/11/2012 01:54 PM, Chuanxiao Dong wrote:
> >> MMC bus is using legacy suspend/resume method, which is not compatible if
> >> runtime pm callbacks are used. In this scenario, MMC bus suspend/resume
> >> callbacks cannot be called when system entering S3. So change to use the new
> >> defined dev_pm_ops for system sleeping mode
> >>
> >> Signed-off-by: Chuanxiao Dong<chuanxiao.dong@intel.com>
> >> ---
> >> Changes in v2:
> >> 	use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks as Rafael
> >> 	suggested
> >>
> >> Changes in v3:
> >> 	remove NULL pointer define for runtime callbacks when PM_RUNTIME is not
> >> 	selected, as Ulf Hansson suggested
> >>
> >> Changes in v4:
> >> 	fix the warning when disable CONFIG_PM_RUNTIME
> >>
> >
> > Looks good to me! Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> Thanks!  Pushed to mmc-next for 3.4.

Can you consider my Tested-by for this patch.

Tested on AM335x Platform. Solves major issue/crash reported at 
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg65425.html

Tested-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>

> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Regards, 
Gururaja
