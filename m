From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 00/15] mmc: host: Add facility to support re-tuning
Date: Mon, 23 Mar 2015 10:06:06 +0200
Message-ID: <550FC96E.4080706@intel.com>
References: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com> <5506E20B.4090706@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36245 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbbCWIII (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Mar 2015 04:08:08 -0400
In-Reply-To: <5506E20B.4090706@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 16/03/15 16:00, Adrian Hunter wrote:
> On 10/03/15 14:42, Adrian Hunter wrote:
>> Hi
>>
>> Here is V3 of some patches to move re-tuning support
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
> 
> Ulf, ping?

Ping


