From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 17/18] arm64: dts: broadcom: Add reference to RPi 4 B
Date: Tue, 23 Jul 2019 07:20:29 +0000
Message-ID: <7dc61967-cf76-f898-e28f-97d3d7df0506@suse.com>
References: <1563815257-2648-1-git-send-email-wahrenst@gmx.net>
 <1563815257-2648-5-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563815257-2648-5-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
Content-ID: <ED339DE5CBE7E5458891B23E9F5588BB@namprd18.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>, Mark
 Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On 22/07/2019 19:07, Stefan Wahren wrote:
> This adds a reference to the dts of the Raspberry Pi 4 B,
> so we don't need to maintain the content in arm64.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

AFAIK arm64 doesn't boot without the DMA RFC patch series from Nicolas. So maybe
we should wait until this is fixed before adding a for now broken device.

Regards,
Matthias

> ---
>  arch/arm64/boot/dts/broadcom/Makefile            | 3 ++-
>  arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> 
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index d1d31cc..cb7de8d 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-a-plus.dtb \
> +dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-4-b.dtb \
> +			      bcm2837-rpi-3-a-plus.dtb \
>  			      bcm2837-rpi-3-b.dtb \
>  			      bcm2837-rpi-3-b-plus.dtb \
>  			      bcm2837-rpi-cm3-io3.dtb
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> new file mode 100644
> index 0000000..d24c536
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "arm/bcm2711-rpi-4-b.dts"
> --
> 2.7.4
> 
> 
