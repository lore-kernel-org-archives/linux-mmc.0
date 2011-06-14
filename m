From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect support for mx5
Date: Tue, 14 Jun 2011 13:13:29 +0200
Message-ID: <87ei2wk6na.fsf@lebrac.rtp-net.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<20110614064841.GB30295@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:51133 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab1FNLNk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 07:13:40 -0400
In-Reply-To: <20110614064841.GB30295@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Tue, 14 Jun 2011 14:48:42 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-mmc@vger.kernel.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

Shawn Guo <shawn.guo@freescale.com> writes:

Hi,

> On Fri, Jun 10, 2011 at 06:42:48PM +0800, Shawn Guo wrote:
>> The card-present polling within sdhci based driver is very expensive
>> in terms of the impact to system performance.  We observe a few
>> system performance issues from Freescale and Linaro on mx5 platforms,
>> which have been proved card polling related.
>> 
>> The patch set extends the current sdhci-esdhc-imx card_detect and
>> write_protect support to cover mx5 platforms, and solves above
>> performance issues.
>> 
>> Shawn Guo (4):
>>       mmc: sdhci: fix interrupt storm from card detection
>>       mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
>>       mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
>>       mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
>> 
> Hi Arnaud,
>
> Any chance to play with it yet?

I tried applying the patch 4 (v2) on mmc git and Sascha Hauer's for-next
branch and failed. Can you please tell me on which tree should I apply
it ?

Thanks,
Arnaud
