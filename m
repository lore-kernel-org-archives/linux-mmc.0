From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 1/6] mmc: block: Resume multi-block reads after transient
 read errors.
Date: Wed, 27 Apr 2011 11:16:23 +0300
Message-ID: <4DB7D0D7.2000402@nokia.com>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org> <1303520502-32171-2-git-send-email-john.stultz@linaro.org> <201104261519.26622.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:47695 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754513Ab1D0IRJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2011 04:17:09 -0400
In-Reply-To: <201104261519.26622.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>, linux-mmc@vger.kernel.org, David Ding <david.j.ding@motorola.com>, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>, Bentao Zou <bzou1@motorola.com>, San Mehat <san@google.com>

On 26/04/11 16:19, Arnd Bergmann wrote:
> On Saturday 23 April 2011, John Stultz wrote:
>> From: David Ding<david.j.ding@motorola.com>
>>
>> CC: Chris Ball<cjb@laptop.org>
>> CC: Arnd Bergmann<arnd@arndb.de>
>> CC: Dima Zavin<dima@android.com>
>> Signed-off-by: Bentao Zou<bzou1@motorola.com>
>> Signed-off-by: David Ding<david.j.ding@motorola.com>
>> Signed-off-by: San Mehat<san@google.com>
>> Signed-off-by: John Stultz<john.stultz@linaro.org>
>
> The disable_multi logic was introduced in 6a79e391 "mmc_block: ensure
> all sectors that do not have errors are read" by Adrian Hunter. Maybe
> he can comment on this.
>
> My impression is that the code makes more sense without this
> add-on patch, because the flag is set for exactly one request
> and makes mmc_blk_issue_rw_rq issue all blocks in that request
> one by one up to the first error, while after the patch,
> we would read one sector, then read the remaining request at
> once, fail, and read the next sector, and so on.
>
> If the problem is transient read errors, a better solution might
> be to retry the entire request before doing it one sector at a time.

Having to guess what the patch is for is pretty sad.  Is writing
commit messages so hard.

The word "transient" suggests the errors might disappear, in which case
the entire read should be retried some number of times.

The big problem with reading 1 sector at a time is that it
can be quite slow (orders of magnitude slower).  Possibly
this patch is aimed at that.  Somewhere there is a patch to
change the retries from 1 sector at a time to 1 segment
at a time, which helps a bit.  Possibly it would help to bisect
the number sectors/segments. i.e.

	read error
		read half of the number of sectors/segments
		that were read last time (but always read at
		least 1)
	no read error
		read all the remaining sectors/segments

This patch does the second half of that approach.

>
>>   drivers/mmc/card/block.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 61d233a..edac9ac 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -440,6 +440,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
>>   				continue;
>>   			}
>>   			status = get_card_status(card, req);
>> +		} else if (disable_multi == 1) {
>> +			disable_multi = 0;
>>   		}
>>
>>   		if (brq.cmd.error) {
>> --
>> 1.7.3.2.146.gca209
>>
>>
>
>

