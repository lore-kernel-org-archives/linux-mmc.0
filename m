From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 00/13] mmc: host: Add facility to support re-tuning
Date: Mon, 12 Jan 2015 15:05:28 +0200
Message-ID: <54B3C698.4030403@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com> <5494312C.9080004@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28559 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbbALNHQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Jan 2015 08:07:16 -0500
In-Reply-To: <5494312C.9080004@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 19/12/14 16:07, Adrian Hunter wrote:
> On 05/12/14 19:40, Adrian Hunter wrote:
>> Hi
>>
>> Here are some patches to move re-tuning support out of
>> sdhci and into the core, and add support for HS400
>> re-tuning.
>>
>> Currently sdhci does re-tuning transparently by
>> calling sdhci_execute_tuning() from its ->request()
>> function.
>>
>> The problem with HS400 re-tuning is that it must be
>> done in HS200 mode. That means using switch commands
>> and making ios changes. That means it potentially
>> conflicts with other command sequences. The new
>> re-tuning support accomodates that, however it is
>> not strictly necessary because HS400 re-tuning
>> should only be needed after runtime suspend when
>> there would not be a conflict.
>>
>> Nevertheless, this approach has more structure
>> and potentially more flexibility.
>>
>>
>> Adrian Hunter (13):
>>       mmc: core: Simplify by adding mmc_execute_tuning()
>>       mmc: host: Add facility to support re-tuning
>>       mmc: core: Disable re-tuning when card is no longer initialized
>>       mmc: core: Move mmc_card_removed() into mmc_start_request()
>>       mmc: core: Add support for re-tuning before each request
>>       mmc: core: Check re-tuning before retrying
>>       mmc: core: Hold re-tuning during switch commands
>>       mmc: core: Hold re-tuning during erase commands
>>       mmc: core: Hold re-tuning while bkops ongoing
>>       mmc: mmc: Comment that callers need to hold re-tuning if the card is put to sleep
>>       mmc: core: Add support for HS400 re-tuning
>>       mmc: sdhci: Always init buf_ready_int
>>       mmc: sdhci: Change to new way of doing re-tuning
>>
>>  drivers/mmc/core/core.c    |  93 +++++++++++++++++++++++++++++++-----
>>  drivers/mmc/core/core.h    |   5 ++
>>  drivers/mmc/core/host.c    |  63 +++++++++++++++++++++++++
>>  drivers/mmc/core/mmc.c     |  58 ++++++++++++++++++-----
>>  drivers/mmc/core/mmc_ops.c |  31 ++++++++----
>>  drivers/mmc/core/sd.c      |  13 ++---
>>  drivers/mmc/core/sdio.c    |  14 ++----
>>  drivers/mmc/host/sdhci.c   | 115 ++++++---------------------------------------
>>  include/linux/mmc/host.h   |  58 +++++++++++++++++++++++
>>  include/linux/mmc/sdhci.h  |   3 --
>>  10 files changed, 296 insertions(+), 157 deletions(-)
> 
> Ulf, do you have any comments?

Ping?

