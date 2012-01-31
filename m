From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 0/2] Improve handling of card removal
Date: Tue, 31 Jan 2012 14:00:05 +0100
Message-ID: <4F27E5D5.1050906@stericsson.com>
References: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com> <4F19564B.9070501@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:50724 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753185Ab2AaNEM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 08:04:12 -0500
In-Reply-To: <4F19564B.9070501@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Adrian Hunter wrote:
> On 19/01/12 18:39, Ulf Hansson wrote:
>> These patches is based upon the patch recently pushed to the mmc mailing list:
>> mmc: core: Force a "detect" to handle non-properly removed cards
>>
>> According to Adrian Hunters comment about adding a CAP2 flag to enable
>> this feature has been done.
>>
>> Patch 2 depends on patch 1; but patch 1 can also be discussed separately.
> 
> There should only be 1 patch otherwise you are breaking bisectablility for
> people not setting MMC_CAP2_DETECT_ON_ERR

The first patch "Prevent I/O as soon as possible..." does only make sure 
that I/O is prevented as soon as possible but still within the timeout 
for the scheduled detect work. Once the detect work (mmc_rescan) has run 
the "detect_change" flag is preventing any further I/O errors from 
directly trying to detect a card removal.

The second patch introduces the MMC_CAP2_DETECT_ON_ERR, as you suggested.

> 
>> Ulf Hansson (2):
>>   mmc: core: Prevent I/O as soon as possible at card removal
>>   mmc: core: Detect card removal on I/O error
>>
>>  drivers/mmc/core/core.c  |   19 ++++++++++++++++---
>>  include/linux/mmc/host.h |    1 +
>>  2 files changed, 17 insertions(+), 3 deletions(-)
>>
> 
> 

Br
Ulf Hansson

