From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv10 0/5] ARM: remove the sub-node and deprecate
 supports-highspeed property for dwmmc.
Date: Wed, 27 Aug 2014 12:11:55 +0900
Message-ID: <53FD4C7B.2030008@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <20140825112151.GA21336@amd> <53FB1DD5.3050207@samsung.com>
 <20140825113719.GA31960@amd> <53FB278B.7010509@samsung.com>
 <53FB2807.7070503@samsung.com> <20140826101923.GA13619@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20140826101923.GA13619@amd>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Pavel Machek <pavel@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, kgene.kim@samsung.com, heiko@sntech.de, tgih.jun@samsung.com, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-samsung-soc@vger.kernel.org, dinguyen@altera.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 08/26/2014 07:19 PM, Pavel Machek wrote:
> Hi!
> 
>>>> Would you elaborate?
>>>>
>>>> If I have a device like a phone, I may want to put one "slot" inside
>>>> phone for basic system, and offer second slot for user expansion
>>>> (initially empty).
>>>
>>> if multiple slot is supported, then a mmcqd should be processing for multiple slots.
>>> It's too inefficient, and affect the whole performance reduction.
>> Sorry, Discard this comment. it means dwmci, not mmcqd.
> 
> Well, that's a Linux problem, and for many applications, not even
> problem at all.
> 
> Device tree should describe hardware, and hardware can do multiple
> slots per controller, so device tree should describe multiple slots
> per controller.
> 
> Now, the configuration may be uncommon, but you are moving from good
> hardware description to bad hardware description.

Well, i don't think it's bad hardware description. And this policy is suggested by other mmc developers and maintainers.
At first time, I had also suggested same opinion with yours.
Refer to below..

https://patchwork.kernel.org/patch/4276481/

Best Regards,
Jaehoon Chung
> 
> 									Pavel
> 
