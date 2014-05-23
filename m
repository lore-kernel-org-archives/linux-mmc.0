From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 00/14] Add Qualcomm SD Card Controller support
Date: Fri, 23 May 2014 09:11:54 +0100
Message-ID: <537F02CA.5070304@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>	<537EF50B.2010101@linaro.org> <CAPDyKFpTXrURM8OzNjO-RRfCFWGct4+_M4D8COdEurUhY46GWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpTXrURM8OzNjO-RRfCFWGct4+_M4D8COdEurUhY46GWg@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn@kryo.se>
List-Id: linux-mmc@vger.kernel.org



On 23/05/14 08:50, Ulf Hansson wrote:
> On 23 May 2014 09:13, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> Hi Ulf,
>> I like to get this patches for v3.16,  any chance of considering these
>> patches to v3.16 ?
>
> I promise to have them properly reviewed early next week, sorry for
> taking so long. Let's see where this leads us.
>
Thankyou.

> It seems like you had some CRC issues during read/write? Did you
> manage to resolve that issue?

Bjorn is using different SOC and board than the IFC6410 Am testing on, 
so its completely different setup.
on IFC6410 we did lot of stress testing and no issues seen. so 
suspecting the issues are very specific to that board or the eMMC Bjorn 
is using.

We are suspecting that the CRC issues are due to the fact that there is 
no code to manage regulators. My test setup uses dummy regulator, and 
the eMMC and external SD cards seems to be Ok with default voltages.

Am not sure if thats the same with Bjorn's board.

Thanks,
srini
>
> Kind regards
> Ulf Hansson
>
>
