From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2 v3] mmc: dw_mmc: Fix the DTO timeout overflow
 calculation for 32-bit systems
Date: Tue, 27 Feb 2018 09:14:23 +0800
Message-ID: <d955cc19-1398-3c05-4742-32664480d07d@rock-chips.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-2-Evgeniy.Didin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180226143413.44134-2-Evgeniy.Didin@synopsys.com>
Sender: stable-owner@vger.kernel.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-mmc@vger.kernel.org


> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Fixes: ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> 
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> 
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org> #  9d9491a7da2a mmc: dw_mmc: Fix the DTO timeout calculation

As I said, the correct tag may be:

Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 
9001306872 HSDK, sdio: board crashes when copying big files
Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
...
...


> ---
> Nothing changed since v2.
>   drivers/mmc/host/dw_mmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

> -	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> +
> +	drto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * drto_clks * drto_div,
>   			       host->bus_hz);
>   

Hmm?

#define DIV_ROUND_DOWN_ULL(ll, d) \
	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })

#define DIV_ROUND_UP_ULL(ll, d)		DIV_ROUND_DOWN_ULL((ll) + (d) - 1, (d))


It uses intermediate unsigned long long _tmp for your "multiply", namely
MSEC_PER_SEC * drto_clks * drto_div, which could solves the problem.
So I don't see why DIV_ROUND_UP_ULL can't work for you?


>   	/* add a bit spare time */
> 
