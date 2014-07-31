From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCHv9 1/5] mmc: dw_mmc: Slot quirk "disable-wp" is deprecated.
Date: Thu, 31 Jul 2014 09:02:45 -0700
Message-ID: <CAD=FV=VfXOqt1A=8-1kq5nhnMrk7PbpCWj-A-UWQN12_U8sW4g@mail.gmail.com>
References: <1406784907-26349-1-git-send-email-jh80.chung@samsung.com>
	<1406784907-26349-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406784907-26349-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dinh Nguyen <dinguyen@altera.com>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, cpgs <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Jaehoon

On Wed, Jul 30, 2014 at 10:35 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Slot quirks "disable-wp" is deprecated.
> Instead, use the host quirk "disable-wp".
> (Because the slot-node is removed in dt-file.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |   11 +++++++++--
>  include/linux/mmc/dw_mmc.h |    2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)

Thanks for taking my suggestion and making it backward compatible.
This looks great to me.  It tested this in both the backward
compatible way (with the warning) and the non-backward compatible way.
I think we should land and patch #2 ASAP and then we can land the rest
of the series as SoC maintainers see fit.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
