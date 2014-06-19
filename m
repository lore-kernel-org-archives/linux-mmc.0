From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: MMC regression with linux-next on Exynos5250
Date: Thu, 19 Jun 2014 11:29:08 +0900
Message-ID: <53A24AF4.5080503@samsung.com>
References: <CAK5sBcEVEWwyHLj_y1=eTqWNELuahMUwrtyX2W_YzLe70Dsa4A@mail.gmail.com>
 <53A167DB.2000701@samsung.com>
 <CAK5sBcHwteYZBf4S=m8WvL68_qkPqO=BVC6yWMfK3x17a9p5-A@mail.gmail.com>
 <CAPDyKFp2c8mtCZHHDTgpAHt6t0bh-7O8ugbMxN30L2hfh6-kXA@mail.gmail.com>
 <CAK5sBcFKwCTU+Z-t=BXzd69fY6b9Sr0SkxgXrs9Y8DCP6EonWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAK5sBcFKwCTU+Z-t=BXzd69fY6b9Sr0SkxgXrs9Y8DCP6EonWQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi, all.

On 06/18/2014 08:22 PM, Sachin Kamat wrote:
> Hi Ulf,
> 
> On Wed, Jun 18, 2014 at 4:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 18 June 2014 13:10, Sachin Kamat <sachin.kamat@samsung.com> wrote:
>>> Hi Jaehoon,
>>>
>>> On Wed, Jun 18, 2014 at 3:50 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> Hi, Sachin.
>>>>
>>>> Did you check the below patch?
>>>> https://patchwork.kernel.org/patch/4346781/
>>>
>>> Thanks for the patch. But even with this patch, I continue to get the
>>> aforementioned crash.
>>
>> Hi Sachin / Jaehoon,
>>
>> Until we sorted out the problem, I will drop the related patch from my mmc tree.
> 
> OK.
> Also, I feel the mmc patch and the corresponding DT changes should go through
> single tree to avoid dependency issues.

Thanks, I will send the patch on today. Sorry for late.

Best Regards,
Jaehoon Chung
> 
> Regards,
> Sachin.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
