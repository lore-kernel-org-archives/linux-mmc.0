From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: mark expected switch fall-throughs
Date: Wed, 1 May 2019 15:29:20 -0500
Message-ID: <2f91e932-94ad-2b4e-2d85-337a84c15ea3@embeddedor.com>
References: <20190320200010.GA14527@embeddedor>
 <CAPDyKFq7Qcp+WZazg2CiB_nBV7Bsmns2aD-Na_k72Kk9sf9X2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq7Qcp+WZazg2CiB_nBV7Bsmns2aD-Na_k72Kk9sf9X2g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

Sorry for the late reply, please see my comments below...

On 3/21/19 5:46 AM, Ulf Hansson wrote:
> On Wed, 20 Mar 2019 at 21:02, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warnings:

[..]

>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/mmc/host/usdhi6rol0.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
>> index cd8b1b9d4d8a..b9712ac96be5 100644
>> --- a/drivers/mmc/host/usdhi6rol0.c
>> +++ b/drivers/mmc/host/usdhi6rol0.c
>> @@ -1339,7 +1339,7 @@ static int usdhi6_stop_cmd(struct usdhi6_host *host)
>>                         host->wait = USDHI6_WAIT_FOR_STOP;
>>                         return 0;
>>                 }
>> -               /* Unsupported STOP command */
>> +               /* fall through - Unsupported STOP command */
>>         default:
>>                 dev_err(mmc_dev(host->mmc),
>>                         "unsupported stop CMD%d for CMD%d\n",
>> @@ -1688,6 +1688,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
>>         default:
>>                 dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
>>                 /* mrq can be NULL in this actually impossible case */
>> +               /* fall through */
> 
> Please make this one comment.
> 

Sure thing. I can do it, but it will exceed the 80 characters limit.

>>         case USDHI6_WAIT_FOR_CMD:
>>                 usdhi6_error_code(host);
>>                 if (mrq)
>> @@ -1713,6 +1714,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
>>                  * If USDHI6_WAIT_FOR_DATA_END times out, we have already unmapped
>>                  * the page
>>                  */
>> +               /* fall through */
> 
> Ditto.
> 

The same here.

If you are OK with that I'll send v2, shortly.

Thanks
--
Gustavo
