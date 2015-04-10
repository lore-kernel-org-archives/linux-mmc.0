From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 00/15] mmc: host: Add facility to support re-tuning
Date: Fri, 10 Apr 2015 13:39:51 +0300
Message-ID: <5527A877.9030204@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com> <551B8E7B.9020605@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30175 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386AbbDJKl6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Apr 2015 06:41:58 -0400
In-Reply-To: <551B8E7B.9020605@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 01/04/15 09:21, Adrian Hunter wrote:
> On 27/03/15 22:57, Adrian Hunter wrote:
>> Hi
>>
>> Here is V4 of some patches to move re-tuning support
>> out of sdhci and into the core, and add support for HS400
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
>> re-tuning support accomodates that.
>>
>> These patches now depend on Ulf's patch:
>>
>>     mmc: core: Enable runtime PM management of host devices
>>
>>
>> Changes in V4:
>>
>>     mmc: host: Add facility to support re-tuning
>>
>> 	Assume mmc_claim_host() runtime resumes the host
>> 	controller so there are no races with runtime pm.
>> 	Consequently remove now un-needed re-tuning host
>> 	operations.
>>
>>     mmc: core: Add support for re-tuning before each request
>>
>> 	Call mmc_retune() prior to ->request()
>>
>>     mmc: sdhci: Change to new way of doing re-tuning
>>
>> 	Updated to reflect the changes above.
> 
> Hi
> 
> What is the status of this?

Hi

What needs to be done to move this forward?

Regards
Adrian

