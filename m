From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: Turn SDIO interrupts on
Date: Tue, 16 Apr 2013 07:55:48 -0700
Message-ID: <CAD=FV=U_n7sma6NMbQ=FySEV7nocubCmBSYEJ_R-q=dtuFLaFA@mail.gmail.com>
References: <1365698338-27503-1-git-send-email-dianders@chromium.org>
	<001701ce39d2$c0dbf8c0$4293ea40$%jun@samsung.com>
	<CAD=FV=XqmLRjQPwWCZfw0Nfu_uK16SOP=OgJcrbziWs4e__h7A@mail.gmail.com>
	<001601ce3a85$16087f00$42197d00$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001601ce3a85$16087f00$42197d00$%jun@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Thomas Abraham <thomas.abraham@linaro.org>, Bing Zhao <bzhao@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Seungwon,

On Tue, Apr 16, 2013 at 2:30 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> If needed for specific channel, it can be got from dts as property.
> if (of_find_property(np, "cap-sdio-irq", NULL))
>         pdata->caps |= MMC_CAP_SDIO_IRQ;

Oh!  I missed that these new properties had gone in.  That is a much
better way to do it.  Let's abandon this patch and I'll post up a
device tree change that turns interrupts for the right ports on the
exynos5250-snow and we can call it done.

Thanks for the review and for pointing me to the new properties!

-Doug
