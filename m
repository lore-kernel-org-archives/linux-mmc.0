From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 00/15] mmc: host: Add facility to support re-tuning
Date: Mon, 04 May 2015 13:39:27 +0300
Message-ID: <55474C5F.5070902@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30496 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbbEDKlk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 May 2015 06:41:40 -0400
In-Reply-To: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 20/04/15 15:09, Adrian Hunter wrote:
> Hi
> 
> Here is V6 of some patches to move re-tuning support
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
> re-tuning support accomodates that.
> 

Hi

I sent a V7 of patch 2, and a couple of patches that fix the
brcm custom sleep re-tuning issue. So is there anything else
that needs to be done?

Regards
Adrian


