From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 0/3] mmc: block: Fix tuning (by avoiding it) for RPMB
Date: Thu, 28 Apr 2016 10:21:27 +0300
Message-ID: <5721B9F7.509@intel.com>
References: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22264 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbcD1HZT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2016 03:25:19 -0400
In-Reply-To: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>, Roman Pen <r.peniaev@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>

cc a couple more people

On 21/04/16 16:28, Adrian Hunter wrote:
> Hi
> 
> The RPMB partition only allows certain commands.  In particular,
> the tuning command (CMD21) is not allowed -  refer JEDEC eMMC
> standard v5.1 section 6.2.2 Command restrictions.
> 
> That means commands will begin failing if re-tuning is needed
> while switched to the RPMB partition.
> 
> Here are 4 options to fix the problem:
> 
> 
> 1. The approach taken by this patch set:
> 
> To avoid tuning for RPMB, switch to High Speed mode from HS200
> or HS400 mode if re-tuning has been enabled.  And switch back
> when leaving RPMB.
> 
> Advantages: Directly does what needs to be done.
> 
> Disadvantages: Assumes the mode switching will work.
> 
> 
> 2. Same as 1 but disable the tuning modes by removing them from
> card->mmc_avail_type and doing a full mmc_reset().
> 
> Advantages: Simpler to program
> 
> Disadvantages: Doing a full reset is slower.  Doing a full reset
> is not an expected consequence of accessing RPMB.
> 
> 
> 3. Simply disable re-tuning and attempt to recover from any errors.
> 
> Disadvantages: Due to the interdependent nature of RPMB reads/writes
> it might not be possible to recover without returning an error to the
> RPMB user.  Also it would be difficult to test if the recovery actually
> worked in all cases.
> 
> 
> 4. Do a partiton switch as part of re-tuning.
> 
> Disadvantages: Makes re-tuning more complicated.  Would require moving
> the control of partition switching into the core.  CRC errors arising
> from the need to re-tune might break the interdependent nature of RPMB
> operations.
> 
> 
> As a final note, if a solution is found then we might be able to revert
> commit 4e93b9a6abc0 ("mmc: card: Don't access RPMB partitions for normal
> read/write").
> 
> 
> Adrian Hunter (3):
>       mmc: mmc: Factor out mmc_hs200_to_hs()
>       mmc: mmc: Factor out mmc_hs400_to_hs() and __mmc_hs_to_hs200()
>       mmc: block: Fix tuning (by avoiding it) for RPMB
> 
>  drivers/mmc/card/block.c |  36 +++++++++++
>  drivers/mmc/core/mmc.c   | 156 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/mmc/card.h |   2 +-
>  include/linux/mmc/core.h |   3 +
>  include/linux/mmc/host.h |   5 ++
>  5 files changed, 186 insertions(+), 16 deletions(-)
> 
> 
> Regards
> Adrian
> 

