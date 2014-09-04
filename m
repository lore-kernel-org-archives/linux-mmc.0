From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/7] mmc: sdhci/imx: a few clean up and fixes
Date: Thu, 4 Sep 2014 13:07:32 +0800
Message-ID: <20140904050730.GA18688@dragon>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1409745903-26550-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <b29396@freescale.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, chris@printf.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 03, 2014 at 08:04:56PM +0800, Dong Aisheng wrote:
> A few clean up and fixes.
> 
> Dong Aisheng (7):
>   mmc: sdhci-esdhc-imx: remove duplicated lines
>   mmc: sdhci-esdhc-imx: usdhc does not have missing card interrupt
>     issue
>   mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
>   mmc: sdhci: do not enable card detect interrupt for gpio cd type
>   mmc: sdhci: do not enable card cd wakeup for gpio case
>   mmc: sdhci-esdhc-imx: add imx6sx support
>   mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl

For all 7,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
