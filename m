From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: host: use pr_err for sdhci_dumpregs
Date: Wed, 15 Jun 2016 14:28:41 +0300
Message-ID: <57613BE9.9060807@intel.com>
References: <CC22646CC0522A488A20F7A66BFD619308D491@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41912 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbcFOLcq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Jun 2016 07:32:46 -0400
In-Reply-To: <CC22646CC0522A488A20F7A66BFD619308D491@irsmsx105.ger.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Baranowska, BeataX" <beatax.baranowska@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>

On 30/05/16 10:59, Baranowska, BeataX wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> 
> sdhci_dumpregs is used to dump registers when error happens. Thus it should
> use pr_err instead of pr_debug to show more information about the hardware.
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

