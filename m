From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: RESEND:[PATCH V3] sdhci: only reprogram retuning timer when flag
 is set
Date: Thu, 20 Mar 2014 13:32:55 +0800
Message-ID: <532A7D87.4000009@intel.com>
References: <1393012782-23917-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22090 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbaCTFcb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Mar 2014 01:32:31 -0400
In-Reply-To: <1393012782-23917-1-git-send-email-arend@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>, Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Dong Aisheng <dongas86@gmail.com>

On 02/22/2014 03:59 AM, Arend van Spriel wrote:
> When the host->tuning_count is zero it means that the
> retuning is disabled. This is checked on the first
> run of sdhci_execute_tuning() by the if statement below:
> 
> 	if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
> 	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
> 
> So only when tuning_count is non-zero it will set the host
> flag SDHCI_USING_RETUNING_TIMER. The else statement is only
> for re-programming the timer, which means that flag must be
> set. Because that is not checked the else statement is executed
> in the first run when tuning_count is zero.
> 
> This was seen on a host controller which indicated
> SDHCI_TUNING_MODE_1 (0) and tuning_count being zero. Suspect
> that (one of) these registers is not properly set.
> 
> Cc: Dong Aisheng <dongas86@gmail.com>
> Cc: Aaron Lu <aaron.lwe@gmail.com>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>

In addition to solve your problem, this patch also makes sense in the
common case, so:

Reviewed-by: Aaron Lu <aaron.lu@intel.com>
