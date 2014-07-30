From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCHv8 1/5] mmc: dw_mmc: modify the dt-binding for removing
 slot-node and supports-highspeed
Date: Wed, 30 Jul 2014 08:58:53 -0700
Message-ID: <CAD=FV=UE38OaZurcNXnoh2SdKVz=xXGA83+FFDQKW+rP-HqMpQ@mail.gmail.com>
References: <1406718310-32078-1-git-send-email-jh80.chung@samsung.com>
	<1406718310-32078-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406718310-32078-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dinh Nguyen <dinguyen@altera.com>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpgs ." <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Jaehoon,

On Wed, Jul 30, 2014 at 4:05 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Almost SoCs use one slot per host controller.
> (Even if controller can support the multiple slot, Recommend to use one slot per host controller.)
> Don't use the slot-node and deprecate the "supports-highspeed" property.
> Instead, use the cap-mmc/sd-highspeed.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Reviewed-by: Doug Anderson <dianders@chromium.org>
