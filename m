From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 01/23] mmc: sdhci: removed unneeded function wrappers
Date: Tue, 10 May 2016 09:32:36 +0300
Message-ID: <57318084.7020107@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-2-git-send-email-aisheng.dong@nxp.com>
 <5719FC89.9010404@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26034 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbcEJGgc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2016 02:36:32 -0400
In-Reply-To: <5719FC89.9010404@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 22/04/16 13:27, Adrian Hunter wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
>> After commit d6463f170cf0 ("mmc: sdhci: Remove redundant runtime PM calls"),
>> some of original sdhci_do_xx() function wrappers becomes meaningless,
>> so remove them.
>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Didn't apply cleanly, otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Ulf, will you apply this one?

