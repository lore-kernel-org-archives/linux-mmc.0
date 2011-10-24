From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH V5 1/3] SDHCI: S3C: Use generic clock names for sdhci
	bus clock options
Date: Mon, 24 Oct 2011 17:16:49 +0200
Message-ID: <4EA58161.30603@samsung.com>
References: <1318588126-19167-1-git-send-email-rajeshwari.s@samsung.com>
	<1318588126-19167-2-git-send-email-rajeshwari.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1318588126-19167-2-git-send-email-rajeshwari.s@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Cc: kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 10/14/11 12:28, Rajeshwari Shinde wrote:
> This patch modifies the driver to stop depending on the clock names
> being passed from the platform and switch over to bus clock lookup
> using generic clock names.
>
> Signed-off-by: Rajeshwari Shinde<rajeshwari.s@samsung.com>
> ---
>   drivers/mmc/host/sdhci-s3c.c |    6 ++----
>   1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 82709b6..a5fde87 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -435,14 +435,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>
>   	for (clks = 0, ptr = 0; ptr<  MAX_BUS_CLK; ptr++) {
>   		struct clk *clk;
> -		char *name = pdata->clocks[ptr];
> +		char name[14];
>
> -		if (name == NULL)
> -			continue;
> +		sprintf(name, "mmc_busclk.%d", ptr);
>
>   		clk = clk_get(dev, name);
>   		if (IS_ERR(clk)) {
> -			dev_err(dev, "failed to get clock %s\n", name);
>   			continue;
>   		}
>

Looks ok for me.

Chris, if you're ok on this, could you please add this in your tree for 
this merge window? or if you want, I will apply this to Samsung tree 
with other Rajeshwari's patches. I'm ok either...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
