From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_mmc=3a_dw=5fmmc=3a_Fix_to_avoid_potenti?=
 =?UTF-8?B?YWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl44CQ6K+35rOo5oSP77yM6YKu5Lu2?=
 =?UTF-8?B?55SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
Date: Tue, 19 Mar 2019 08:43:13 +0800
Message-ID: <74f8916b-72ce-fc8c-a1c2-0f38ea99ab6d@rock-chips.com>
References: <20190319001918.12042-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319001918.12042-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: shawn.lin@rock-chips.com, kjlu@umn.edu, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2019/3/19 8:19, Aditya Pakki wrote:
> of_match_node can fail and return NULL in case no matching structure.
> The patches checks for such a scenario and returns -ENXIO.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/mmc/host/dw_mmc-exynos.c | 2 ++
>   drivers/mmc/host/dw_mmc-k3.c     | 2 ++
>   drivers/mmc/host/dw_mmc-pltfm.c  | 2 ++
>   3 files changed, 6 insertions(+)
> 

Could you check dw_mmc-zx.c and dw_mmc-rockchip.c as well?

> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index d46c3439b508..8a75d7314606 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -554,6 +554,8 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>   	drv_data = match->data;
>   
>   	pm_runtime_get_noresume(&pdev->dev);
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 89cdb3d533bb..cc50b7546a20 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -459,6 +459,8 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
>   	const struct of_device_id *match;
>   
>   	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>   	drv_data = match->data;
>   
>   	return dw_mci_pltfm_register(pdev, drv_data);
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 58c13e21bd5a..b1948989f617 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -82,6 +82,8 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
>   
>   	if (pdev->dev.of_node) {
>   		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
> +		if (!match)
> +			return -ENXIO;
>   		drv_data = match->data;
>   	}
>   
> 
