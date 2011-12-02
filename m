From: "Sujit Reddy Thumma" <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: mmc_test: align max_seg_size
Date: Fri, 2 Dec 2011 03:23:43 -0800 (PST)
Message-ID: <f813c77fffb9f624337a7ad6a2e62021.squirrel@www.codeaurora.org>
References: <1321268664-22006-1-git-send-email-per.forlin@stericsson.com>
    <87hb1kmbl5.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:35520 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab1LBLXo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 06:23:44 -0500
In-Reply-To: <87hb1kmbl5.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com, Linus Walleij <linus.walleij@linaro.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>


> Hi,
>
> On Mon, Nov 14 2011, Per Forlin wrote:
>> If max_seg_size is unaligned, mmc_test_map_sg() may create sg element
>> sizes that are not aligned with 512 byte. Fix, align max_seg_size at
>> mmc_test_area_init().
>>
>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
>> ---
>>  drivers/mmc/card/mmc_test.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
>> index b038c4a..5848998 100644
>> --- a/drivers/mmc/card/mmc_test.c
>> +++ b/drivers/mmc/card/mmc_test.c
>> @@ -1581,6 +1581,7 @@ static int mmc_test_area_init(struct mmc_test_card
>> *test, int erase, int fill)
>>
>>  	t->max_segs = test->card->host->max_segs;
>>  	t->max_seg_sz = test->card->host->max_seg_size;
>> +	t->max_seg_sz -= t->max_seg_sz % 512;
>>
>>  	t->max_tfr = t->max_sz;
>>  	if (t->max_tfr >> 9 > test->card->host->max_blk_count)
>
> Thanks, pushed to mmc-next for 3.2.  (Sujit, please let us know if you
> still have worries about aligning to host->max_blk_size.)

No issues. The change looks good.

-- 
Thanks,
Sujit

