From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] mmc: dw_mmc: fix bug that cause mmc_test failture
Date: Tue, 10 Feb 2015 01:34:55 -0800
Message-ID: <CAOesGMiWBjhfzWVXah2XO7=JQhriwdVgf0jmm1UjNQjB9PeGMQ@mail.gmail.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, amstan@chromium.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, zhenfu.fang@ro
List-Id: linux-mmc@vger.kernel.org

Hi Addy,

On Mon, Jan 26, 2015 at 4:04 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
> The STOP command can terminate a data transfer between a memory card and
> mmc controller.
>
> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:
> Data timeout and Data end-bit error will terminate further data transfer
> by mmc controller. So we should not send abort command to terminate a
> data transfer again if we got DRTO and EBE interrupt.
>
> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

The drawback of having so many people on your to: list on a patch is
that it's unclear who you want to review and merge it. Sometimes less
is more.

In this case, it seems appropriate to have Ulf do so. Ulf, ping? This
seems like a reasonable patch for 3.20 given that it fixes undesired
behavior.


-Olof
