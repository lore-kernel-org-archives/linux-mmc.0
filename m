From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V4]mmc: remove MMC bus legacy suspend/resume method
Date: Wed, 11 Apr 2012 15:41:57 +0200
Message-ID: <4F858A25.20302@stericsson.com>
References: <20120411115438.GA303@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:36274 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754797Ab2DKNmY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Apr 2012 09:42:24 -0400
In-Reply-To: <20120411115438.GA303@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "cjb@laptop.org" <cjb@laptop.org>

On 04/11/2012 01:54 PM, Chuanxiao Dong wrote:
> MMC bus is using legacy suspend/resume method, which is not compatible if
> runtime pm callbacks are used. In this scenario, MMC bus suspend/resume
> callbacks cannot be called when system entering S3. So change to use the new
> defined dev_pm_ops for system sleeping mode
>
> Signed-off-by: Chuanxiao Dong<chuanxiao.dong@intel.com>
> ---
> Changes in v2:
> 	use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks as Rafael
> 	suggested
>
> Changes in v3:
> 	remove NULL pointer define for runtime callbacks when PM_RUNTIME is not
> 	selected, as Ulf Hansson suggested
>
> Changes in v4:
> 	fix the warning when disable CONFIG_PM_RUNTIME
>

Looks good to me! Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>

Kind regards
Ulf Hansson
