From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/11] omap_hsmmc: voltage switching and tuning
Date: Wed, 5 Aug 2015 20:30:52 +0530
Message-ID: <55C22524.5050304@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com> <20150805104355.GE16878@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46110 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbbHEPBW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Aug 2015 11:01:22 -0400
In-Reply-To: <20150805104355.GE16878@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, mugunthanvnm@ti.com

Hi,

On Wednesday 05 August 2015 04:13 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [150730 00:49]:
>> Patch series implements voltage switching and tuning for omap_hsmmc
>> driver.
>>
>> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
>> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.
> 
> Your tests are missing omap3?

I don't have one at my disposal :-( I'll try to find one and add omap3 tests.
> 
> I suggest you add some omap3 tests in general as otherwise you are
> only testing a subset of the driver features and completely missing
> things like rutnime PM and save and restore for the deeper idle
> states.

yeah, I'll do those tests and re-post the series.

Thanks
Kishon

