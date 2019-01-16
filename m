From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH -next] mmc: sdhci-esdhc-imx: fix return value check in
 sdhci_esdhc_imx_probe()
Date: Wed, 16 Jan 2019 09:29:22 +0200
Message-ID: <14db134b-584c-b264-b992-c5de46923eb0@intel.com>
References: <1547617491-60322-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1547617491-60322-1-git-send-email-weiyongjun1@huawei.com>
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
To: Wei Yongjun <weiyongjun1@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, BOUGH CHEN <haibo.chen@nxp.com>
Cc: kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 16/01/19 7:44 AM, Wei Yongjun wrote:
> In case of error, the function devm_kzalloc() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: fadac7488064 ("mmc: sdhci-esdhc-imx: add CMDQ support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 75ad824..fad6007 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1500,8 +1500,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (imx_data->socdata->flags & ESDHC_FLAG_CQHCI) {
>  		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
>  		cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
> -		if (IS_ERR(cq_host)) {
> -			err = PTR_ERR(cq_host);
> +		if (!cq_host) {
> +			err = -ENOMEM;
>  			goto disable_ahb_clk;
>  		}
> 
> 
> 
> 
