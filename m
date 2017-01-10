From: Ziyuan <xzy.xu@rock-chips.com>
Subject: Re: [BUG] Boot failure since df9bcc2bc on veyron_speedy
Date: Tue, 10 Jan 2017 15:20:17 +0800
Message-ID: <58748B31.7040307@rock-chips.com>
References: <20170109141955.GB13205@number18.npnth.net>
 <20170109144937.GC13205@number18.npnth.net>
 <f30b97b0-d0e2-b6dd-e11e-ca4ea592b18d@rock-chips.com>
 <20170110010434.GE13205@number18.npnth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110010434.GE13205@number18.npnth.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "S. Gilles" <sgilles@math.umd.edu>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 01/10/2017 09:04 AM, S. Gilles wrote:
> On 2017-01-10T08:47:16+0800, Shawn Lin wrote:
>> Hi
>>
>> On 2017/1/9 22:49, S. Gilles wrote:
>>> On 2017-01-09T09:19:55-0500, S. Gilles wrote:
>>>> Hi,
>>>>
>>>> I have a C201, a veyron_speedy device (which uses rk3288) running vanilla
>>>> kernels. With recent kernels it will fail to boot (screen is on, with
>>>> blinking cursor, but no login prompt and the machine does not respond
>>>> over ssh).
>>>>
>>>> I've bisected this to df9bcc2bc0a1f8d2963bd916698268fb2470713b, and
>>>> reverting that commit on -mainline gives me a bootable kernel. I can
>>>> provide more information as needed.
>> The fix is on the way,
>>
>> https://patchwork.kernel.org/patch/9498527/
> Great - thanks for letting me know.

Can you share the result ?

BR
Ziyuan Xu

>
> Thanks,
> S. Gilles
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
