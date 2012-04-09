From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH V2]mmc: remove MMC bus legacy suspend/resume method
Date: Mon, 9 Apr 2012 05:22:14 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33182780B@DBDE01.ent.ti.com>
References: <20120405075118.GA29395@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34478 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab2DIFWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 01:22:24 -0400
In-Reply-To: <20120405075118.GA29395@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>

On Thu, Apr 05, 2012 at 13:21:18, Chuanxiao Dong wrote:
> MMC bus is using legacy suspend/resume method, which is not compatible if
> runtime pm callbacks are used. In this scenario, MMC bus suspend/resume
> callbacks cannot be called when system entering S3. So change to use the new
> defined dev_pm_ops for system sleeping mode
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> Changes in v2:
> 	use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks as Rafael
> 	suggested
> 
>  drivers/mmc/card/block.c |    2 +-
>  drivers/mmc/core/bus.c   |   26 ++++++++++++--------------
>  include/linux/mmc/card.h |    2 +-
>  3 files changed, 14 insertions(+), 16 deletions(-)
> 

Tested on AM335x Platform. Solves major issue/crash reported at 
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg65425.html

Tested-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>

..snip..


Regards, 
Gururaja
