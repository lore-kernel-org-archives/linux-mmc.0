From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: MMC_SWITCH command doesn't update the ext_csd data structure
Date: Tue, 3 Sep 2013 13:34:26 +0200
Message-ID: <5225C942.3060203@de.bosch.com>
References: <5225C24B.9020705@de.bosch.com> <86mwnub0yb.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:58818 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595Ab3ICLec (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 07:34:32 -0400
In-Reply-To: <86mwnub0yb.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 03.09.2013 13:26, Chris Ball wrote:
> Hi,
>
> On Tue, Sep 03 2013, Dirk Behme wrote:
>> +       if ((cmd.opcode == MMC_SWITCH) && ((cmd.arg >> 24) & 0x3)) {
>> +               /* In case the IOCTL has modified the EXT_CSD, update
>> it, i.e. re-read the EXT_CSD */
>> +		mmc_update_ext_csd(card->ext_csd);
>> +       }
>> +
>
> Your analysis looks good, please go ahead and submit a full patch.

The issue here is that something like mmc_update_ext_csd() doesn't 
exist, yet?

So we have to implement a mmc_update_ext_csd() in core/mmc.c and call it 
from mmc_blk_ioctl_cmd() in card/block.c?

Or any better proposal?

Thanks

Dirk
