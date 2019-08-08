From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
Date: Thu, 8 Aug 2019 16:00:24 +0300
Message-ID: <6f08715f-b0e5-715c-006a-d80c0ecf2cd7@intel.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
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
To: Eugen.Hristev@microchip.com, Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, alexandre.belloni@bootlin.com, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 8/08/19 11:35 AM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> HS200 is not implemented in the driver, but the controller claims it
> through caps.
> Remove it via quirk.
> Without this quirk, the mmc core will try to enable hs200, which will fail,
> and the eMMC initialization will fail.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 57fe3b2..3a8c6d8 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -370,6 +370,9 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  
> +	/* HS200 is broken at this moment */
> +	host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> +
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto pm_runtime_disable;
> 
