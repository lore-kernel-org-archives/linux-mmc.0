From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH] sdhci-of-arasan: card initialization failure -84
Date: Thu, 14 Jun 2018 10:14:34 +0300
Message-ID: <658c1c31-9193-990b-e6d0-944958aa7b1f@intel.com>
References: <20180604064211.q2thyftgpffuaer2@laureti-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180604064211.q2thyftgpffuaer2@laureti-dev>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Helmut Grohne <h.grohne@intenta.de>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Atul Garg <agarg@arasan.co>
List-Id: linux-mmc@vger.kernel.org

On 04/06/18 09:42, Helmut Grohne wrote:
> Work around repeated:
> 
>     mmc0: error -84 whilst initialising SD card
> ---
>  drivers/mmc/host/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> I'm seeing the above error -84 with a series of Kingston cards of 4GB capacity
> when used with an arasan host controller. Using the cards with other hosts or
> using other cards with the host is not problematic. The host controller has the
> following device tree:
> 
> 	ps7-sdio@e0100000 {
> 		compatible = "arasan,sdhci-8.9a";
> 		reg = <0xe0100000 0x1000>;
> 		clock-names = "clk_xin", "clk_ahb";
> 		clock-frequency = <50000000>;
> 		clocks = <&clkc 21>, <&clkc 32>;
> 		interrupt-parent = <&ps7_scugic_0>;
> 		interrupts = <0 24 4>;
> 	};
> 
> When enabling sufficient debugging (and thus slowing the kernel down), the
> problem goes away. Without debug features, the insertion of this delay suffices
> for my particular instance. Inserting the same delay before the
> SDHCI_CLOCK_CARD_EN write also makes the error go away.
> 
> While instrumenting the code I found that the loop waiting for the
> SDHCI_CLOCK_INT_STABLE would always terminate immediately (regardless of the
> card being used). Only when the card is removed, the loop would spin once. This
> hints that potentially the stable checking is broken for this host controller.
> 
> During my testing I checked 7 Kingston cards, 2 Transcend Cards, 1 Apacer card,
> 3 arasn hosts, 3 non-arasan hosts and had consistent reports for a similar
> number of devices from others.
> 
> If my hypothesis is reasonable, I can turn this patch into a new quirk that
> replaces the stable polling with msleep(20), which is the poll timeout. Is
> there anything else I should investigate before doing so?

Please avoid quirks.  Perhaps use the ->set_clock() callback.

> 
> Helmut
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 90cc1977b792..5d2809aeb4eb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1430,6 +1430,7 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  
>  	clk |= SDHCI_CLOCK_CARD_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	udelay(80);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_clk);
>  
> 
