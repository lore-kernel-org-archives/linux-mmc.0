From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH v3 1/5] mmc: dw_mmc: Add external dma interface support
Date: Wed, 05 Aug 2015 10:49:26 +0200
Message-ID: <8177347.dLpRuMxaEU@diego>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com> <1438762648-22202-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1438762648-22202-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, dianders@chromium.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Hao <haokexin@gmail.com>, Olof
List-Id: linux-mmc@vger.kernel.org

Am Mittwoch, 5. August 2015, 16:17:28 schrieb Shawn Lin:
> DesignWare MMC Controller can supports two types of DMA
> mode: external dma and internal dma. We get a RK312x platform
> integrated dw_mmc and ARM pl330 dma controller. This patch add
> edmac ops to support these platforms. I've tested it on RK312x
> platform with edmac mode and RK3288 platform with idmac mode.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---

[...]

> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 5be9767..6c1c7ea 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -16,6 +16,7 @@
> 
>  #include <linux/scatterlist.h>
>  #include <linux/mmc/core.h>
> +#include <linux/dmaengine.h>
> 
>  #define MAX_MCI_SLOTS	2
> 
> @@ -40,6 +41,17 @@ enum {
> 
>  struct mmc_data;
> 
> +enum {
> +	TRANS_MODE_PIO = 0,
> +	TRANS_MODE_IDMAC,
> +	TRANS_MODE_EDMAC
> +};
> +
> +struct dw_mci_dma_slave {
> +	struct dma_chan *ch;
> +	enum dma_transfer_direction direction;
> +};
> +
>  /**
>   * struct dw_mci - MMC controller state shared between all slots
>   * @lock: Spinlock protecting the queue and associated data.
> @@ -147,17 +159,23 @@ struct dw_mci {
> 
>  	/* DMA interface members*/
>  	int			use_dma;
> +	int			trans_mode;

you're introducing this new trans_mode, but we have "use_dma" already.

So you could just define

enum {
	TRANS_DMA_PIO = 0,
	TRANS_DMA_IDMAC,
	TRANS_DMA_EDMAC
};

and fill use_dma appropriately. "0" is meaning PIO already, which I also did fix 
up some days ago in "[PATCH] mmc: dw_mmc: fix pio mode when internal dmac is 
enabled" [0].


Heiko

[0] https://lkml.org/lkml/2015/8/3/407
