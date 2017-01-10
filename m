From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [BUG] Boot failure since df9bcc2bc on veyron_speedy
Date: Tue, 10 Jan 2017 16:23:11 +0900
Message-ID: <d8e83301-f7c5-ad0a-932c-6ccdd51b8c3f@samsung.com>
References: <20170109141955.GB13205@number18.npnth.net>
 <20170109144937.GC13205@number18.npnth.net>
 <f30b97b0-d0e2-b6dd-e11e-ca4ea592b18d@rock-chips.com>
 <20170110010434.GE13205@number18.npnth.net>
 <CGME20170110072114epcas2p3418c5dd1d9e7ec449b027e2543167497@epcas2p3.samsung.com>
 <58748B31.7040307@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <58748B31.7040307@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ziyuan <xzy.xu@rock-chips.com>, "S. Gilles" <sgilles@math.umd.edu>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi 

On 01/10/2017 04:20 PM, Ziyuan wrote:
> Hi,
> 
> On 01/10/2017 09:04 AM, S. Gilles wrote:
>> On 2017-01-10T08:47:16+0800, Shawn Lin wrote:
>>> Hi
>>>
>>> On 2017/1/9 22:49, S. Gilles wrote:
>>>> On 2017-01-09T09:19:55-0500, S. Gilles wrote:
>>>>> Hi,
>>>>>
>>>>> I have a C201, a veyron_speedy device (which uses rk3288) running vanilla
>>>>> kernels. With recent kernels it will fail to boot (screen is on, with
>>>>> blinking cursor, but no login prompt and the machine does not respond
>>>>> over ssh).
>>>>>
>>>>> I've bisected this to df9bcc2bc0a1f8d2963bd916698268fb2470713b, and
>>>>> reverting that commit on -mainline gives me a bootable kernel. I can
>>>>> provide more information as needed.
>>> The fix is on the way,
>>>
>>> https://patchwork.kernel.org/patch/9498527/
>> Great - thanks for letting me know.
> 
> Can you share the result ?

Sorry for late. If it's working fine, I will apply it on fixes.

Best Regards,
Jaehoon Chung

> 
> BR
> Ziyuan Xu
> 
>>
>> Thanks,
>> S. Gilles
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
> 
> 
> 
> 
