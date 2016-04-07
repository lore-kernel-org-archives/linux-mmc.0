From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2] mmc: sdhci: Remove redundant runtime PM calls
Date: Thu, 7 Apr 2016 17:28:53 +0300
Message-ID: <57066EA5.2090507@intel.com>
References: <1460019399-922-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7107 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbcDGOdI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Apr 2016 10:33:08 -0400
In-Reply-To: <1460019399-922-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>

On 07/04/16 11:56, Ulf Hansson wrote:
> Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
> devices"), made some calls to the runtime PM API from the driver
> redundant. Especially those which deals with runtime PM reference
> counting, so let's remove them.
> 
> Moreover as SDHCI have its own wrapper functions for runtime PM these
> becomes superfluous, so let's remove them as well.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

