From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Subject: Re: [PATCH] mmc: mmc_test: align max_seg_size
Date: Fri, 18 Nov 2011 10:25:20 +0100
Message-ID: <4EC62480.2000308@stericsson.com>
References: <1321268664-22006-1-git-send-email-per.forlin@stericsson.com> <4EC485E8.4040706@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:48757 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754292Ab1KRJ0U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 04:26:20 -0500
In-Reply-To: <4EC485E8.4040706@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf HANSSON <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>

On 11/17/2011 04:56 AM, Sujit Reddy Thumma wrote:
> On 11/14/2011 4:34 PM, Per Forlin wrote:
>> If max_seg_size is unaligned, mmc_test_map_sg() may create sg element
>> sizes that are not aligned with 512 byte. Fix, align max_seg_size at
>> mmc_test_area_init().
>>
>> Signed-off-by: Per Forlin<per.forlin@stericsson.com>
>> ---
>>   drivers/mmc/card/mmc_test.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
>> index b038c4a..5848998 100644
>> --- a/drivers/mmc/card/mmc_test.c
>> +++ b/drivers/mmc/card/mmc_test.c
>> @@ -1581,6 +1581,7 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
>>
>>   	t->max_segs = test->card->host->max_segs;
>>   	t->max_seg_sz = test->card->host->max_seg_size;
>> +	t->max_seg_sz -= t->max_seg_sz % 512;
> 
> Shouldn't we align this to host->max_blk_size supported by controller?
It's up to each test case to set the test transfer size.  It's not necessary to align max_size but it wouldn't make any harm either. All tests use a multiple of 512 blocks, but this may be changed of course in the future to support large blocks.
The max_seg_sz must be aligned otherwise the host driver may get sg-elements that are hard to handle, aligned to 1 byte in the worst case. The test case don't control how the transfer is sg-mapped.

/Per
