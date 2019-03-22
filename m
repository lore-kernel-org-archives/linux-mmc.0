From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH -next] mmc: sdhci-omap: Make sdhci_omap_reset static
Date: Fri, 22 Mar 2019 19:49:41 +0530
Message-ID: <95463a45-6069-a186-dca0-28a1ab3f8e35@ti.com>
References: <20190322141138.19244-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322141138.19244-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>, adrian.hunter@intel.com, kishon@ti.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 22/03/19 7:41 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/mmc/host/sdhci-omap.c:788:6: warning:
>  symbol 'sdhci_omap_reset' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Faiz Abbas <faiz_abbas@ti.com>

Thanks,
Faiz
