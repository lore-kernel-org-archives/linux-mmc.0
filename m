From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Date: Thu, 15 May 2014 23:31:55 +0400
Message-ID: <5375162B.7050104@cogentembedded.com>
References: <201405040219.30018.sergei.shtylyov@cogentembedded.com> <20140513013820.GC10973@verge.net.au> <53720B95.401@cogentembedded.com> <20140513214723.GC6784@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140513214723.GC6784@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk, linux-sh@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hello.

On 05/14/2014 01:47 AM, Simon Horman wrote:

>>>> I've spent a couple of days with the driver just hanging due to me forgetting
>>>> to specify the external crystal frequency, so that clk_get_rate() returned 0
>>>> and thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
>>>> acceptable behavior, so I suggest that the minimum frequency is checked for 0
>>>> in tmio_mmc_host_probe().

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>> My suggestion is to update tmio_mmc_host_probe() so that it always exits,
>>> perhaps returning an error if appropriate.

>>     Did you mean tmio_mmc_set_clock()?

> Sorry for the cut-and-paste error. Yes, that is what I meant.

    Not sure about that, really (there's no documentation). That's why I went 
for the probe time check.

WBR, Sergei

