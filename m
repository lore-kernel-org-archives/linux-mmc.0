From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH 0/2 v3] mmc: dw_mmc: Fix DTO/STO timeout overflow
 calculation
Date: Tue, 27 Feb 2018 11:02:45 +0800
Message-ID: <20180227110245.6d78ff23@xhacker.debian>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: linux-mmc@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 26 Feb 2018 17:34:11 +0300 Evgeniy Didin  wrote:

> For some 32-bit architectures calculation of DTO and STO timeout can be incorrect
> due to multiply overflow. Lets prevent this by casting multiply and result to u64.
> 
> Suggested by Jisheng Zhang.
> Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL is not reasonable
> because overflow happens on multiply and DIV_ROUND_UP_ULL helps
> with sum overflow.

hmmm, I mean something as below:

-cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
+cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);

This could avoid build error in arm case.

> 
> ---
> Changes since v2:
> -add fix for cto_ms
> 
> Evgeniy Didin (2):
>   mmc: dw_mmc: Fix the DTO timeout overflow calculation for 32-bit
>     systems
>   mmc: dw_mmc: Fix the CTO overflow calculation for 32-bit systems

These two patches could be folded into one patch?

Thanks
