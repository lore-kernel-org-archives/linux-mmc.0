From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: Fix card detection regression
Date: Wed, 15 Jan 2014 17:43:42 +0800
Message-ID: <52D6584E.2020606@linaro.org>
References: <1389774667-18309-1-git-send-email-sachin.kamat@linaro.org>	<52D649C3.4020003@linaro.org> <CAK9yfHzZo82oN5+UiXzo47190JKiVwwEh8ikTfz_==_A1PdNLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAK9yfHzZo82oN5+UiXzo47190JKiVwwEh8ikTfz_==_A1PdNLA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, chris@printf.net, Seungwon Jeon <tgih.jun@samsung.com>, Patch Tracking <patches@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org



On 01/15/2014 05:39 PM, Sachin Kamat wrote:
>> Thanks for the patch
>> I just submitted one patch to fix the issue, in case you missed it.
>
> Yes I did as I am not subscribed to mmc list.
>
>> Also spin_lock is required for atomic accessing DW_MMC_CARD_PRESENT.
>> Otherwise sd detect may be failed sometimes.
>>
>> Could you help take a look.
>
> I looked at and tested your patch [1] (which is similar to mine except
> for the locking part).
>
> Since I do not have your patch in my mailbox, FWIW,
>
> Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>

Thanks Sachin,  that's great it works, all my mistake.
Then I resumit the patch with this and cc you.

Thanks
