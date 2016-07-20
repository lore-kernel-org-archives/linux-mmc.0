From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND RFC v2] mmc: Change the max discard sectors and erase
 response if mmc host supports busy signalling
Date: Wed, 20 Jul 2016 14:07:06 +0300
Message-ID: <578F5B5A.3060702@intel.com>
References: <54f75bccac6e6e49d87a5122ea670038b508b33c.1465808036.git.baolin.wang@linaro.org>
 <CAPDyKFoxMtMjzc4nXnhOvribUBAfzNjm+LbruSVkXgQW_bxgUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61864 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbcGTLL3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jul 2016 07:11:29 -0400
In-Reply-To: <CAPDyKFoxMtMjzc4nXnhOvribUBAfzNjm+LbruSVkXgQW_bxgUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Baolin Wang <baolin.wang@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On 19/07/16 14:57, Ulf Hansson wrote:
> On 13 June 2016 at 10:54, Baolin Wang <baolin.wang@linaro.org> wrote:
>> When mmc host HW supports busy signalling (using R1B as response), We
>> shouldn't use 'host->max_busy_timeout' as the limitation when deciding
>> the max discard sectors that we tell the generic BLOCK layer about.
>> Instead, we should pick one preferred erase size as the max discard
>> sectors.
>>
>> If the host controller supports busy signalling and the timeout for
>> the erase operation does not exceed the max_busy_timeout, we should
>> use R1B response. Or we need to prevent the host from doing hw busy
>> detection, which is done by converting to a R1 response instead.
>>
>> Changes since v1:
>>   - Remove the 'MMC_CAP_WAIT_WHILE_BUSY' flag checking when deciding
>>     the max discard sectors.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/mmc/core/core.c |   47 +++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 39 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 8b4dfd4..edd43b1 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2060,7 +2060,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>>                         unsigned int to, unsigned int arg)
>>  {
>>         struct mmc_command cmd = {0};
>> -       unsigned int qty = 0;
>> +       unsigned int qty = 0, busy_timeout = 0;
>>         unsigned long timeout;
>>         int err;
>>
>> @@ -2128,8 +2128,23 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>>         memset(&cmd, 0, sizeof(struct mmc_command));
>>         cmd.opcode = MMC_ERASE;
>>         cmd.arg = arg;
>> -       cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>> -       cmd.busy_timeout = mmc_erase_timeout(card, arg, qty);
>> +       busy_timeout = mmc_erase_timeout(card, arg, qty);
>> +       /*
>> +        * If the host controller supports busy signalling and the timeout for
>> +        * the erase operation does not exceed the max_busy_timeout, we should
>> +        * use R1B response. Or we need to prevent the host from doing hw busy
>> +        * detection, which is done by converting to a R1 response instead.
>> +        */
>> +       if ((card->host->max_busy_timeout &&
>> +           busy_timeout > card->host->max_busy_timeout) ||
>> +           !(card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)) {
> 
> sdhci uses the max_busy_timeout, but doesn't always use MMC_CAP_WAIT_WHILE_BUSY.
> I have probably asked Adrian about this before, but right now I can't
> recall why this is the case.

Unfortunately, just because a driver does not set MMC_CAP_WAIT_WHILE_BUSY
does not mean it does not have the capability.  So we still want to set the
correct timeout and maximum timeout.

