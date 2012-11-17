From: Trey Ramsay <tramsay@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] mmc: Bad device can cause mmc driver to hang
Date: Fri, 16 Nov 2012 23:16:21 -0600
Message-ID: <50A71DA5.2070905@linux.vnet.ibm.com>
References: <87k3tpkz53.fsf@octavius.laptop.org> <1353079901-8773-1-git-send-email-tramsay@linux.vnet.ibm.com> <876255bluf.fsf@octavius.laptop.org> <50A6D1C7.302@linux.vnet.ibm.com> <87mwyh9ia0.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:35133 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab2KQFQ1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Nov 2012 00:16:27 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-mmc@vger.kernel.org> from <tramsay@linux.vnet.ibm.com>;
	Fri, 16 Nov 2012 22:16:26 -0700
In-Reply-To: <87mwyh9ia0.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Rich Rattanni <rattanni@gmail.com>, Radovan Lekanovic <lekanovic@gmail.com>

On 11/16/2012 06:37 PM, Chris Ball wrote:
> Hi Trey, thanks for the analysis,
> 
> On Fri, Nov 16 2012, Trey Ramsay wrote:
>> Good question.  In regards to the original problem were it was hung in
>> mmc_blk_err_check, the new code path will timeout after 10 minutes, log
>> an error, issue a hardware reset and abort the request. Is the hardware
>> reset enough or will that even work when the device isn't coming out of
>> program state? Should we try to refuse all new I/O?
> 
> mmc_hw_reset() only works for eMMC devices with a hooked up reset GPIO
> -- not SD cards -- and at the moment there's only one system (Intel
> Medfield) that supplies a GPIO, so that's not a general solution.
> 
> Maybe we should just merge your patch for now; we'll definitely get at
> least a pr_err() explaining what's going on, which is an improvement.
> Next time someone hits this (if anyone has an SD card that exhibits
> this problem, it'd be very valuable for testing) we can look at going
> farther, such as immediately setting host->flags |= SDHCI_DEVICE_DEAD.
> What do you think?
> 
> - Chris.
> 

Hi Chris,
Sounds good.  Thanks for the explanation. Setting host->flags |=
SDHCI_DEVICE_DEAD is a great idea.  I'll check with my team to see if we
have any hardware that exhibits this problem.  If we do, I can do some
testing on the code you suggested.

Thanks,
Trey

