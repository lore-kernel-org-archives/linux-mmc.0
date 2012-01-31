From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] Improve handling of card removal
Date: Tue, 31 Jan 2012 15:56:43 +0200
Message-ID: <4F27F31B.6020401@intel.com>
References: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com> <4F19564B.9070501@intel.com> <4F27E5D5.1050906@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56486 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab2AaN4l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 31 Jan 2012 08:56:41 -0500
In-Reply-To: <4F27E5D5.1050906@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 31/01/12 15:00, Ulf Hansson wrote:
> Adrian Hunter wrote:
>> On 19/01/12 18:39, Ulf Hansson wrote:
>>> These patches is based upon the patch recently pushed to the mmc mailing
>>> list:
>>> mmc: core: Force a "detect" to handle non-properly removed cards
>>>
>>> According to Adrian Hunters comment about adding a CAP2 flag to enable
>>> this feature has been done.
>>>
>>> Patch 2 depends on patch 1; but patch 1 can also be discussed separately.
>>
>> There should only be 1 patch otherwise you are breaking bisectablility for
>> people not setting MMC_CAP2_DETECT_ON_ERR
> 
> The first patch "Prevent I/O as soon as possible..." does only make sure
> that I/O is prevented as soon as possible but still within the timeout for
> the scheduled detect work. Once the detect work (mmc_rescan) has run the
> "detect_change" flag is preventing any further I/O errors from directly
> trying to detect a card removal.
> 
> The second patch introduces the MMC_CAP2_DETECT_ON_ERR, as you suggested.

For drivers not using MMC_CAP2_DETECT_ON_ERR, the first patch introduces a
change in behaviour and the second patch removes it again.  Anyone doing a
git bisect that lands between the patches will see that change in behaviour.
 There is no reason for that - just make it one patch.

> 
>>
>>> Ulf Hansson (2):
>>>   mmc: core: Prevent I/O as soon as possible at card removal
>>>   mmc: core: Detect card removal on I/O error
>>>
>>>  drivers/mmc/core/core.c  |   19 ++++++++++++++++---
>>>  include/linux/mmc/host.h |    1 +
>>>  2 files changed, 17 insertions(+), 3 deletions(-)
>>>
>>
>>
> 
> Br
> Ulf Hansson
> 
> 

