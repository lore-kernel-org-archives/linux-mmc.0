From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 00/15] mmc: host: Add facility to support re-tuning
Date: Mon, 09 Feb 2015 10:43:12 +0200
Message-ID: <54D87320.6080104@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21069 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760080AbbBIIpN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Feb 2015 03:45:13 -0500
In-Reply-To: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 29/01/15 11:00, Adrian Hunter wrote:
> Hi
> 
> Here is V2 of some patches to move re-tuning support
> out of sdhci and into the core, and add support for HS400
> re-tuning.
> 
> Currently sdhci does re-tuning transparently by
> calling sdhci_execute_tuning() from its ->request()
> function.
> 
> The problem with HS400 re-tuning is that it must be
> done in HS200 mode. That means using switch commands
> and making ios changes. That means it potentially
> conflicts with other command sequences. The new
> re-tuning support accomodates that, however it is
> not strictly necessary because HS400 re-tuning
> should only be needed after runtime suspend when
> there would not be a conflict.
> 
> Nevertheless, this approach has more structure
> and potentially more flexibility.
> 
> Changes in V2:
> 
>     Added support to the block driver for re-tuning
>     and retrying after a CRC error. The host driver
>     is left to decide when an error indicates re-tuning
>     is needed. The block driver will retry a data request
>     once if re-tuning is flagged as needed.
> 
>     SDIO drivers need not be aware of re-tuning because
>     retrying will anyway cause re-tuning when re-tuning
>     is flagged as needed. Nevertheless SDIO drivers could
>     use the need_retune flag to instigate a retry when
>     otherwise they might not have.

Ulf, Arend, is this OK?


