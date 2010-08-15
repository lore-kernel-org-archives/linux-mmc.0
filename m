From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: Bug in mmc_test or host driver?
Date: Sun, 15 Aug 2010 21:12:46 +0200
Message-ID: <4C683C2E.7020206@arndnet.de>
References: <4C657FA1.9090705@arndnet.de> <4C67FC00.8080207@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:36860 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751187Ab0HOTMu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 15 Aug 2010 15:12:50 -0400
In-Reply-To: <4C67FC00.8080207@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Am 15.08.2010 16:38, schrieb Adrian Hunter:
> Arnd Hannemann wrote:
>> Hi,
>>
>> if I peform the test 23 mmc_test_best_read_performance() with tmio_mmc
>> on Linus tree, I hit the following BUG:
>>
>>  [  152.625000] mmc0: Starting tests of card mmc0:2daf...
>>  [  152.625000] mmc0: Test case 23. Best-case read performance...
>>  [  152.632812] mmc0: starting CMD16 arg 00000200 flags 00000015
>>  [  152.632812] MMC IRQ begin
>>  [  152.632812] status: 208007a1 =
>> SIGSTATEWRPROTECTCARD_REMOVE_ACARD_INSERT_ASIGSTATE_AILL_FUNCCMDRESPEND
>>  [  152.632812] status: 00000001 = CMDRESPEND
>>  [  152.632812] mmc0: req done (CMD16): 0: 00000900 00000900 00000b00
>> 00000900
>>  [  152.632812] Status at end of loop: 208007a0
>>  [  152.632812] status: 208007a0 =
>> SIGSTATEWRPROTECTCARD_REMOVE_ACARD_INSERT_ASIGSTATE_AILL_FUNC
>>  [  152.632812] MMC IRQ end
>>  [  152.632812] mmc0: starting CMD25 arg 003b0000 flags 00000035
>>  [  152.632812] mmc0:     blksz 512 blocks 8192 flags 00000100 tsac 300
>> ms nsac 0
>>  [  152.632812] mmc0:     CMD12 arg 00000000 flags 0000001d
>>  [  152.632812] kernel BUG at drivers/mmc/core/core.c:172!
>>
>>
>> core.c:  172         BUG_ON(mrq->data->blocks > host->max_blk_count);
>>
>> The host's max_blk_count is 512, but mmc_test does not check and issues
>> a request with 8192 blocks.
>> So I believe the test is wrong here?
>
> Yes.  Try this:
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index 5dd8576..4fb8b10 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -1328,6 +1328,10 @@ static int mmc_test_area_init(struct
> mmc_test_card *test, int erase, int fill)
>         t->max_sz = TEST_AREA_MAX_SIZE;
>     else
>         t->max_sz = (unsigned long)test->card->pref_erase << 9;
> +    if (t->max_sz >> 9 > test->card->host->max_blk_count)
> +        t->max_sz = test->card->host->max_blk_count << 9;
> +    if (min_sz > t->max_sz)
> +        min_sz = t->max_sz;
>     /*
>      * Try to allocate enough memory for the whole area.  Less is OK
>      * because the same memory can be mapped into the scatterlist more
> than
>
>
> and if it works send a patch.

Thanks, it works.

Best regards,
Arnd
