From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3] mmc: allow upper layers to determine immediately if
 a card has been removed
Date: Mon, 28 Nov 2011 16:22:43 +0200
Message-ID: <4ED39933.4020306@intel.com>
References: <1322485335-17922-1-git-send-email-adrian.hunter@intel.com> <c879641273f32677cf926c10eeee0220.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <c879641273f32677cf926c10eeee0220.squirrel@www.codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: Chris Ball <cjb@laptop.org>, per.lkml@gmail.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 28/11/11 15:32, Sujit Reddy Thumma wrote:
> 
>> Add a function mmc_detect_card_removed() which upper layers
>> can use to determine immediately if a card has been removed.
>> This function should be called after an I/O request fails so
>> that all queued I/O requests can be errored out immediately
>> instead of waiting for the card device to be removed.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/core.c  |   51
>> +++++++++++++++++++++++++++++++++++++++++++--
>>  drivers/mmc/core/core.h  |    3 ++
>>  drivers/mmc/core/mmc.c   |   12 ++++++++++-
>>  drivers/mmc/core/sd.c    |   12 ++++++++++-
>>  drivers/mmc/core/sdio.c  |   11 +++++++++-
>>  include/linux/mmc/card.h |    3 ++
>>  include/linux/mmc/core.h |    2 +
>>  include/linux/mmc/host.h |    1 +
>>  8 files changed, 89 insertions(+), 6 deletions(-)
>>
> ...
> 
>> +int _mmc_detect_card_removed(struct mmc_host *host)
>> +{
>> +	int ret;
>> +
>> +	if (!(host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
> 
> This should be just "if ((host->caps & MMC_CAP_NONREMOVABLE) || ...)"
> 
> Otherwise, Acked-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

Fixed in V4

> 
>> +		return 0;
>> +
>> +	if (!host->card || mmc_card_removed(host->card))
>> +		return 1;
>> +
>> +	ret = host->bus_ops->alive(host);
>> +	if (ret) {
>> +		mmc_card_set_removed(host->card);
>> +		pr_info("%s: card removed\n", mmc_hostname(host));
>> +	}
>> +
>> +	return ret;
>> +}
>> +
> 
> 
