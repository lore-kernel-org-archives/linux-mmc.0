From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation for
 32-bit systems
Date: Mon, 26 Feb 2018 16:39:55 +0200
Message-ID: <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com> <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: linux-mmc@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-snps-arc@lists.infradead.org, Stable <stable@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 26, 2018 at 4:34 PM, Evgeniy Didin
<Evgeniy.Didin@synopsys.com> wrote:
> In commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> have been made changes which can cause multiply overflow for 32-bit systems.
> The value of cto_ms is lower the drto_ms, but nevertheless overflow can occur.
> Lets cast this multiply to u64 type which prevents overflow.

> -       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
> +
> +       cto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);

IIRC, someone commented on this or similar, i.e.

DIV_ROUND_UP_ULL() ?

-- 
With Best Regards,
Andy Shevchenko
