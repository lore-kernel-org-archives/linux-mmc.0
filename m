From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Thu, 14 Jun 2012 16:46:47 +0300
Message-ID: <4FD9EB47.6000905@intel.com>
References: <4FD1821D.4070603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:58333 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075Ab2FNNq0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Jun 2012 09:46:26 -0400
In-Reply-To: <4FD1821D.4070603@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On 08/06/12 07:39, Jaehoon Chung wrote:
> Enable eMMC background operations (BKOPS) feature.
> 
> If URGENT_BKOPS is set after a response, note that BKOPS
> are required. After all I/O requests are finished, run
> BKOPS if required. Should read/write operations be requested
> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> and then service the request.
> If BKOPS-STATUS is upper than LEVEL2, need to check until clear
> the BKOPS-STATUS vaule. 
> 
> If you want to enable this feature, set MMC_CAP2_BKOPS.
> And if you want to set the BKOPS_EN bit in ext_csd register,
> use the MMC_CAP2_INIT_BKOPS.
> 
> Future considerations
>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>  * Interrupt ongoing BKOPS before powering off the card.
>  * How get BKOPS_STATUS value.(periodically send ext_csd command?)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> ---

I would not expect this to work nicely with runtime PM.  I expect that BKOPS
would need to be stopped beforehand.  But that would limit the time
available for BKOPS since runtime PM would always kick in and stop it.  How
is runtime PM to be handled?
