From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto tuning mode.
Date: Tue, 19 Jan 2016 23:01:46 +0800
Message-ID: <CAGb2v655SF-CUbZKKTif0toHqJ61Z4P4_QzQacfQL9EN0Y0zZQ@mail.gmail.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: P L Sai Krishna <lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hao <haokexin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Emil Lenchak <emill-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Ivan T. Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Vincent Yang <vincent.yang.fujitsu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>devicetree <dev>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 19, 2016 at 10:17 PM, P L Sai Krishna
<lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> During the auto tuning mode of SDR104, a couple of transactions
> on rx_tap_value which are not incremental or decremental by 1.
> Since the DLL supports only increment/decrement by 1 during
> dynamic change, observed unexpected delays during both these
> transactions.
> The first transaction occurs when the tap value
> reached 0x1F, it will reset to 0x0 and go till 0x7. This
> transaction can be avoided by changing the corecfg_dis1p5xtuningcnt
> to 1'b1 which is currently tied to 1'b0 in the RTL.
> The second transaction occurs after the tuning is completed.
> Once the tuning is done, the tuning fsm in the host controller
> calculates the average pattern match and will write the value
> on the rx tap value. Therefore observed a transaction from 0x7 to
> the final value which need not be a increment/decrement value.
> Because of this issue DLL tuning will not be accurate and SDR50,
> SDR104 & HS200 modes may not work.
>
> This patch adds workaround to change the SD clock after
> tuning done to provide accurate DLL tuning for SDR50,
> SD104 & HS200 modes.
>
> After receiving the tuning done, program "SDCLK Frequency Select"
> of clock control register with a value different from the desired
> value. Wait for the "Internal Clock Stable" bit of the clock
> control register and program the desired frequency.

Does this series apply to any non-Arasan or non-sdhci mmc hosts?
The subject does not indicate a specific platform.

Thanks
ChenYu

> Signed-off-by: P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 18 ++++++++++++++++++
>  drivers/mmc/host/sdhci-pltfm.c     |  3 +++
>  drivers/mmc/host/sdhci.c           |  5 +++++
>  drivers/mmc/host/sdhci.h           |  4 ++++
>  4 files changed, 30 insertions(+)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
