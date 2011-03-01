From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [RFC] MMC: error handling improvements
Date: Tue, 01 Mar 2011 18:58:41 +0530
Message-ID: <1298986121.15439.16.camel@stummala-linux.in.qualcomm.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	 <8yaoc6c7tan.fsf@huya.qualcomm.com>
	 <20110219150006.GH29493@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:55295 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1CAN2s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 08:28:48 -0500
In-Reply-To: <20110219150006.GH29493@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: David Brown <davidb@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Russell King,

On Sat, 2011-02-19 at 15:00 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 15, 2011 at 03:49:04PM -0800, David Brown wrote:
> > On Tue, Feb 15 2011, Russell King - ARM Linux wrote:
> > 
> > > This patch is for RFC only; it needs splitting up somewhat.  However, I
> > > wanted to get it out there for some comment.
> > 
> > Just for kicks, I applied this and ran it on an MSM target (8x50).  It
> > seems to cause lots of:
> > 
> >   mmc0: Data timeout
> >   mmc0: Controller has been re-initialized
> >   ...
> >   mmc0: Data CRC error
> > 
> > and I can post more if you would find them interesting.  Eventually the
> > MSM mmc driver derefernces a null pointer in the interrupt code.
> 
> That doesn't look right.  If resetting the MMC controller results in all
> state being lost, it presumably means the card gets powered down too.
> If that happens, the card needs to be reinitialized from scratch again,
> and I don't see how that happens in this driver.
> 
> Nothing in this patch should cause data timeouts to appear where they
> weren't already appearing before the patch - the patch only changes
> what happens after an error occurs, so you must already be encountering
> errors on the interface before you applied this patch.

This patch sends CMD22 (mmc_sd_num_wr_blocks()) for SD cards after a
write command. This function relies on csd->tacc_ns and csd->tacc_clks
for setting timeout values. But for SDHC cards, these CSD values are not
read and will always be 0. The host driver will only use the timeout
values sent by upper layers and thus in this case we are writing 0 to
MMCIDATATIMER. This is the reason for getting data timeout error for
CMD22. Before sending CMD22 if I add mmc_set_data_timeout(), then it is
working fine for me because mmc_set_data_timeout() uses hardcoded
timeout values for SDHC cards.

All other SD read commands are also using mmc_set_data_timeout() to set
the timeout values - mmc_sd_switch(), mmc_app_sd_status()  and
mmc_app_send_scr(). I think it is a problem in mmc_sd_num_wr_blocks to
use CSD contents for timeout values for all types of SD cards. 

-- 
Thanks,
Sahitya.
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.

