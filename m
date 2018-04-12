From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/3] mmc: wbsd: Replace mdelay with usleep_range in
 wbsd_init
Date: Thu, 12 Apr 2018 09:34:15 +0800
Message-ID: <13f0f859-0331-c770-80ba-bc332b32582f@gmail.com>
References: <1523414803-2626-1-git-send-email-baijiaju1990@gmail.com>
 <CAPDyKFq4hL6TRaovv9O1NLXBmd7QJQcuVGmc5kSO3Na-2gcT1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq4hL6TRaovv9O1NLXBmd7QJQcuVGmc5kSO3Na-2gcT1g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pierre Ossman <pierre@ossman.eu>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 2018/4/11 23:04, Ulf Hansson wrote:
> On 11 April 2018 at 04:46, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> wbsd_init() is never called in atomic context.
>>
>> The call chains ending up at wbsd_init() are:
>> [1] wbsd_init() <- wbsd_probe()
>> [2] wbsd_init() <- wbsd_pnp_probe()
>>
>> wbsd_probe() is set as ".probe" in struct platform_driver.
>> wbsd_pnp_probe() is set as ".probe" in struct pnp_driver.
>> These functions are not called in atomic context.
>>
>> Despite never getting called from atomic context, wbsd_init()
>> calls mdelay() to busily wait.
>> This is not necessary and can be replaced with usleep_range() to
>> avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> The patch is good, however I think you should squash all three in this
> series into one. For obvious reasons.

Hello, Ulf.
Thanks for your reply and advice :)
I will follow it in my future patches.


Best wishes,
Jia-Ju Bai
