From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Increase MMCIF clock rate to 97.5MHz
Date: Wed, 12 Nov 2014 16:40:58 +0300
Message-ID: <5463636A.1060608@cogentembedded.com>
References: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello.

On 11/11/2014 9:42 AM, Yoshihiro Kaneko wrote:

> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---

> This patch is based on mmc-next branch of Chris Ball's mmc tree.

>   drivers/mmc/host/sh_mmcif.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 656fbba..fe9a8b7 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
[...]
> @@ -1371,6 +1373,8 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>   	struct resource *res;
>   	void __iomem *reg;
>   	const char *name;
> +	struct device_node *np = pdev->dev.of_node;
> +	int clk_rate;

    'u32'.

>
>   	irq[0] = platform_get_irq(pdev, 0);
>   	irq[1] = platform_get_irq(pdev, 1);
> @@ -1433,6 +1437,16 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
>   		goto eclkget;
>   	}
> +
> +	if (np && !of_property_read_u32(np, "renesas,clk-rate", &clk_rate)) {

    Doesn't the standard "clock-frequency" prop fit here?

WBR, Sergei

