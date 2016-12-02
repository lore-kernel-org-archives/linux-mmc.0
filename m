From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 0/5] mmc: sdhci: Tidy tuning
Date: Fri, 2 Dec 2016 10:28:26 +0200
Message-ID: <5f30261c-3e5e-bae1-b706-434cfa024534@intel.com>
References: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFqbpGQuzirU98MTX4TXjn6inDY8K8NozrSwBZVJGMDyLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41406 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbcLBId3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Dec 2016 03:33:29 -0500
In-Reply-To: <CAPDyKFqbpGQuzirU98MTX4TXjn6inDY8K8NozrSwBZVJGMDyLg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 01/12/16 16:57, Ulf Hansson wrote:
> On 1 December 2016 at 15:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here are some tidy-ups wrt SDHCI tuning.  Un-tested so far.
> 
> Nice. Thanks!
> 
>>
>> Any other suggestions?  Otherwise I will test and submit the whole series.
> 
> As an additional step, could you try to make use of mmc_send_tuning(),
> instead of sending the command internally from sdhci_send_tuning()?

mmc_send_tuning() is not a good fit.  SDHCI tuning command does not have a
data payload (or rather the hardware does it automatically) so unless
mmc_send_tuning() is changed it will return -EIO.  If that is changed then,
SDHCI request function needs to be changed to special-case the tuning
command because the interrupt setup is different.  Then the problem is that
there is no timeout interrupt so another timer is needed, so a special case
would have to be created for that too.

The current code is much simpler.

