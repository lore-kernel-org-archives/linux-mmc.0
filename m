From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: host: add slot argument to mmc_of_parse
Date: Mon, 26 May 2014 18:11:01 +0900
Message-ID: <53830525.3090902@samsung.com>
References: <1400840721-11050-1-git-send-email-jh80.chung@samsung.com>
 <1400840721-11050-2-git-send-email-jh80.chung@samsung.com>
 <20140526080916.GE12777@ldesroches-Latitude-E6320>
 <5382FD78.3060402@gmail.com>
 <CAPDyKFrZXd30wXJNsO64-Np129_53D=TVv2yBmBhsOxJa0Sm6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAPDyKFrZXd30wXJNsO64-Np129_53D=TVv2yBmBhsOxJa0Sm6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Tushar Behera <tushar.behera@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi, Ulf.

On 05/26/2014 05:44 PM, Ulf Hansson wrote:
> On 26 May 2014 10:38, Jaehoon Chung <jh80.chung@gmail.com> wrote:
>> Hi,
>>
>> On 05/26/2014 05:09 PM, Ludovic Desroches wrote:
>>> On Fri, May 23, 2014 at 07:25:19PM +0900, Jaehoon Chung wrote:
>>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>>
>>>> Some hosts manage several slots. In these case information such as the
>>>> bus width, chi detect and others are into the slot node. So we have to
>>>
>>> /s/chi detect/chip detect
>> Will fix.
>>
>> Tushar have suggested the rename mmc_of_parse_slot() instead of __mmc_of_parse().
>> I'm not sure which name is better. How about?
>>
>> If never mind, i will change to mmc_of_parse_slot(), then send patch-v2.
> 
> I would prefer to keep it as is, but just because that's my taste. :-)
Ok. I think so.
I want to merge this patch-set for fixing the dw-mmc problem, before release the 3.16.

dw-mmc controller also used the slot concept, so some property didn't parse with mmc_of_parse().

Best Regards,
Jaehoon Chung
 
> 
> Kind regards
> Ulf Hansson
> 
