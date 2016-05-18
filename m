From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 1/3] mmc: core: Add a facility to "pause" re-tuning
Date: Wed, 18 May 2016 09:44:32 +0300
Message-ID: <573C0F50.7020608@intel.com>
References: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
 <1462361893-11897-2-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrg3Fe8ypdzrbxD5DxHBNs7-6yVma-7X7NY4JfNzVzGPQ@mail.gmail.com>
 <5731DC12.4090906@intel.com>
 <CAPDyKFozyrzAPcw3v=XUEkMevLxxZ_AgHWXkwkYPN=AJkTAgXQ@mail.gmail.com>
 <5732F498.6090203@intel.com> <57341F2D.1020703@intel.com>
 <CAPDyKFqGo_MgBo=Xc74O6yi_rpZUWyK00wnBi7Ebdda0ejrwcA@mail.gmail.com>
 <573482FD.6040906@intel.com> <5739BE8C.3010403@intel.com>
 <CAPDyKFpjoWHXp=H0R6pPM9pvF5BuP49MhwVzBQgr+01SXGGYQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36000 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbcERGs2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 May 2016 02:48:28 -0400
In-Reply-To: <CAPDyKFpjoWHXp=H0R6pPM9pvF5BuP49MhwVzBQgr+01SXGGYQg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

On 17/05/16 18:06, Ulf Hansson wrote:
> On 16 May 2016 at 14:35, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Re-tuning is not possible when switched to the RPMB
>> partition.  However re-tuning should not be needed
>> if re-tuning is done immediately before switching,
>> a small set of operations is done, and then we
>> immediately switch back to the main partition.
>>
>> To ensure that re-tuning can't be done for a short
>> while, add a facility to "pause" re-tuning.
>>
>> The existing facility to hold / release re-tuning
>> is used but it also flags re-tuning as needed to cause
>> re-tuning before the next command (which will be the
>> switch to RPMB).
>>
>> We also need to "unpause" in the recovery path, which
>> is catered for by adding it to mmc_retune_disable().
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
> 
> Thanks, re-applied the series with this v3 version of patch 1/3.
> 
> If the tests from kernelci and in linux-next works out okay, I intend
> to send this as fixes for 4.7 rc1.

Thank you!

