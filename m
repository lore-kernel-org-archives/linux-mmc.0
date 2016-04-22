From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 01/23] mmc: sdhci: removed unneeded function wrappers
Date: Fri, 22 Apr 2016 13:27:21 +0300
Message-ID: <5719FC89.9010404@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54236 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbcDVKbK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2016 06:31:10 -0400
In-Reply-To: <1460741387-23815-2-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> After commit d6463f170cf0 ("mmc: sdhci: Remove redundant runtime PM calls"),
> some of original sdhci_do_xx() function wrappers becomes meaningless,
> so remove them.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Didn't apply cleanly, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

