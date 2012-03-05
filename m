From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move the
 header file
Date: Mon, 05 Mar 2012 19:59:55 +0900
Message-ID: <4F549CAB.5030305@samsung.com>
References: <4F4B378E.1050209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4F4B378E.1050209@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris.

I want to reduce the least arch dependency.
Now, we are working the twice for sdhci-s3c.c.(Samsung-SoC tree and mmc-tree)
It's very inefficiency.
There is no reason that the generic platdata & regs-sdhci.h can't move into mmc driver.
(In other device driver's case, have maintained in mmc-driver)
If will move into mmc-driver, we can maintain the efficient more than before.
I want to know your opinion.

Best Regards,
Jaehoon Chung

On 02/27/2012 04:58 PM, Jaehoon Chung wrote:

> This patchset is the purpose for using sdhci-pltfm.c and 
> removing the arch dependency.
> The sdhci-s3c has too heavy arch dependency.
> For example, if work for sdhci-s3c.c at mmc-tree, sometime need to change sdhci.h for Samsung-Soc.
> But now we need to work at both mmc-next tree and Samsung-SoC tree.
> I think this is very inefficient and can conflict to merge.
> So remained at least dependency and moved the header file to mmc folder.
> 
> And sdhci-s3c changed to use the sdhci-pltfm.c.
> There is no reason that didn't use the sdhci-pltfm.c.
> If we use the sdhci-pltfm.c,we can easily maintain the common part.
> 
> In future, i will work more removing the arch dependency.
> 
> This patchset based on mmc-next tree.
> 
> Changlog V2:
> 	- modified driver/mmc/host/Kconfig
> 	- Add the comments for s3c64xx
> 	- based-on latest mmc-tree. 
> 
> Jaehoon Chung (4):
>   mmc: sdhci-s3c: use the sdhci-pltfm for Samsung-SoC
>   ARM: SAMSUNG: move the header file to driver directory
>   mmc: sdhci-s3c: use the sdhci-s3c.h instead of regs-sdhci.h
>   ARM: SAMSUNG: move the mmc platdata header file to linux/mmc/
> 
>  arch/arm/mach-exynos/setup-sdhci-gpio.c         |    1 -
>  arch/arm/mach-s5pc100/setup-sdhci-gpio.c        |    1 -
>  arch/arm/mach-s5pv210/setup-sdhci-gpio.c        |    1 -
>  arch/arm/plat-samsung/include/plat/regs-sdhci.h |   87 --------
>  arch/arm/plat-samsung/include/plat/sdhci.h      |   53 +-----
>  drivers/mmc/host/Kconfig                        |   20 +-
>  drivers/mmc/host/sdhci-s3c.c                    |  266 ++++++++---------------
>  drivers/mmc/host/sdhci-s3c.h                    |   90 ++++++++
>  include/linux/mmc/sdhci-s3c.h                   |   84 +++++++
>  9 files changed, 275 insertions(+), 328 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-sdhci.h
>  create mode 100644 drivers/mmc/host/sdhci-s3c.h
>  create mode 100644 include/linux/mmc/sdhci-s3c.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
