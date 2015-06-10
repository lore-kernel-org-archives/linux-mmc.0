From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 3/7] mmc: mediatek: Add PM support for MMC driver
Date: Wed, 10 Jun 2015 13:59:52 +0200
Message-ID: <CAPDyKFrdw6m8C6oXRRC1cxmOPda8WqrFwwuP87rDBqEehdTaTA@mail.gmail.com>
References: <1433903088-14407-1-git-send-email-chaotian.jing@mediatek.com>
	<1433903088-14407-4-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1433903088-14407-4-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek
List-Id: linux-mmc@vger.kernel.org

On 10 June 2015 at 04:24, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Add PM support for Mediatek MMC driver
> Save/restore registers when PM
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 88 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 8de3299..62e966f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>

Add pm.h as well.

> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spinlock.h>
>

[...]

Kind regards
Uffe
