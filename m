From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning
Date: Thu, 08 Nov 2012 20:46:54 -0500
Message-ID: <87zk2reeep.fsf@octavius.laptop.org>
References: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
	<87wqxzal6b.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:32895 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422644Ab2KIBrD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Nov 2012 20:47:03 -0500
In-Reply-To: <87wqxzal6b.fsf@octavius.laptop.org> (Chris Ball's message of
	"Mon, 05 Nov 2012 14:45:16 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Subhash Jadavani <subhashj@codeaurora.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi Aaron,

On Mon, Nov 05 2012, Chris Ball wrote:
> On Tue, Jul 03 2012, Aaron Lu wrote:
>>  		 */
>>  		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
>>  		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
>> +			/* eMMC uses cmd21 while sd and sdio use cmd19 */
>> +			tuning_opcode = mmc->card->type == MMC_TYPE_MMC ?
>> +				MMC_SEND_TUNING_BLOCK_HS200 :
>> +				MMC_SEND_TUNING_BLOCK;
>
> This is causing a NULL deref crash here when run on host controllers
> with no card inserted -- mmc->card is NULL, as you'd expect, yet it's
> dereferenced anyway.  Maybe the system you tested it on only has an
> eMMC, so you never noticed that it crashes if there's no card present?
> Or maybe it's abnormal for host controllers to set SDHCI_NEEDS_RETUNING
> when there's no card present?

I'm going to send my fix to Linus (and hence stable@) tomorrow morning,
since it's important to remove this crash.  Let me know what you think
when you get a chance.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
