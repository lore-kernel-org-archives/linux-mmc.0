From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] Improve handling of card removal
Date: Fri, 20 Jan 2012 13:55:55 +0200
Message-ID: <4F19564B.9070501@intel.com>
References: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61007 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab2ATLzy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Jan 2012 06:55:54 -0500
In-Reply-To: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 19/01/12 18:39, Ulf Hansson wrote:
> These patches is based upon the patch recently pushed to the mmc mailing list:
> mmc: core: Force a "detect" to handle non-properly removed cards
> 
> According to Adrian Hunters comment about adding a CAP2 flag to enable
> this feature has been done.
> 
> Patch 2 depends on patch 1; but patch 1 can also be discussed separately.

There should only be 1 patch otherwise you are breaking bisectablility for
people not setting MMC_CAP2_DETECT_ON_ERR

> 
> Ulf Hansson (2):
>   mmc: core: Prevent I/O as soon as possible at card removal
>   mmc: core: Detect card removal on I/O error
> 
>  drivers/mmc/core/core.c  |   19 ++++++++++++++++---
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 

