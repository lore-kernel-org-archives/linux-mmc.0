From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3] mmc: dw_mmc: add quirk for broken data transfer over scheme
Date: Tue, 2 Dec 2014 21:08:57 -0800
Message-ID: <CAD=FV=Vfe_UUT=fTdQESEyrE56Jy4p9NtKh80PkR+C4mDCHDxA@mail.gmail.com>
References: <1415970338-2637-1-git-send-email-addy.ke@rock-chips.com>
	<1417576563-5033-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417576563-5033-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Addy,

On Tue, Dec 2, 2014 at 7:16 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> This patch add a new quirk to add a s/w timer to notify the driver
> to terminate current transfer and report a data timeout to the core,
> if DTO interrupt does NOT come within the given time.
>
> dw_mmc call mmc_request_done func to finish transfer depends on
> DTO interrupt. If DTO interrupt does not come in sending data state,
> the current transfer will be blocked.
>
> But this case really exists, when driver reads tuning data from
> card on RK3288-pink2 board. I measured waveforms by oscilloscope
> and found that card clock was always on and data lines were always
> holded high level in sending data state.
>
> We got the reply from synopsys:
> There are two counters but both use the same value of [31:8] bits.
> Data timeout counter doesn't wait for stop clock and you should get
> DRTO even when the clock is not stopped.
> Host Starvation timeout counter is triggered with stop clock condition.
>
> This means that host should get DRTO and DTO interrupt.
>
> But we really don't get any data-related interrupt in RK3X SoCs.
> And driver can't get data transfer state, it can do nothing but wait for.
>
> We don't know why we have this problem, but we need it to fix this problem now.
> And I will post a follow up change when we find the root cause.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> Changes in v2:
> - fix some typo.
> - remove extra timeout value (250ms).
> - remove dw_mci_dto_start_monitor func.
> - use "broken-dto" for new quirk and change Subject for it.
>
> Changes in v3:
> - Remove dts for broken-dto, just add this quirk in dw_mci_rockchip_init
>
>  drivers/mmc/host/dw_mmc-rockchip.c |  3 +++
>  drivers/mmc/host/dw_mmc.c          | 41 +++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/dw_mmc.h         |  5 +++++
>  3 files changed, 48 insertions(+), 1 deletion(-)

This seems reasonable to me.  I do hope that you can get to a root
cause, but I don't think this is a terrible bit of code to carry.
Obviously it's up to the folks who maintain dw_mmc and the mmc
subsystem, but:

Reviewed-by: Doug Anderson <dianders@chromium.org>
