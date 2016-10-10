From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] mmc: sdhci-of-arasan: Fix non static symbol warning
Date: Mon, 10 Oct 2016 14:37:48 +0200
Message-ID: <CAPDyKFoGM7+pzSHCTVYfi1S1uo3DRauXLhY5ZQ8gDmeBBQV47A@mail.gmail.com>
References: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, Adrian Hunter <adrian.hunter@intel.com>, Wei Yongjun <weiyongjun1@huawei.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 25 September 2016 at 17:44, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fixes the following sparse warning:
>
> drivers/mmc/host/sdhci-of-arasan.c:253:6: warning:
>  symbol 'sdhci_arasan_reset' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index da8e40a..e263671 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -250,7 +250,7 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>         writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
>  }
>
> -void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> +static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
>  {
>         u8 ctrl;
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>
>
>
