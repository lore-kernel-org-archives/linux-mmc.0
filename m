From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Quirk for long data read time
Date: Mon, 14 Nov 2011 10:05:47 +0100
Message-ID: <4EC0D9EB.7030106@stericsson.com>
References: <1320309852-21893-1-git-send-email-stefan.xk.nilsson@stericsson.com> <87obwihxlx.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:44436 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752723Ab1KNJGq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2011 04:06:46 -0500
In-Reply-To: <87obwihxlx.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Stefan NILSSON9 <stefan.xk.nilsson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Per FORLIN <per.forlin@stericsson.com>

Chris Ball wrote:
> Hi,
> 
> On Thu, Nov 03 2011, Stefan Nilsson XK wrote:
>> Adds a quirk that sets the data read timeout to a fixed value instead
>> of relying on the information in the CSD. The timeout value choosen
>> is 300ms since that has proven enough for the problematic cards found,
>> but could be increased if other cards require this.
>>
>> This patch also enables this quirk for certain Micron cards known to
>> have this problem.
>>
>> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> ---
>>  drivers/mmc/card/block.c |    7 +++++++
>>  drivers/mmc/core/core.c  |   12 ++++++++++++
>>  include/linux/mmc/card.h |    6 ++++++
>>  3 files changed, 25 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 4fd5723..04af5e5 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1603,6 +1603,13 @@ static const struct mmc_fixup blk_fixups[] =
>>  		  MMC_QUIRK_BLK_NO_CMD23),
>>  	MMC_FIXUP("MMC32G", 0x11, CID_OEMID_ANY, add_quirk_mmc,
>>  		  MMC_QUIRK_BLK_NO_CMD23),
>> +
>> +	/*
>> +	 * Some Micron MMC cards needs longer data read timeout than
>> +	 * indicated in CSD.
>> +	 */
>> +	MMC_FIXUP("", 0x13, 0x200, add_quirk_mmc, MMC_QUIRK_LONG_READ_TIME),
> 
> I think we should use CID_NAME_ANY instead of "", so I'll push that
> change unless you object.  Thanks!

No objections, that will work as well!


BR
Ulf Hansson
