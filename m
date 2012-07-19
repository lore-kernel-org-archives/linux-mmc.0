From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 0/6] mmc: dw_mmc: add support for device tree based
 instantiation
Date: Fri, 20 Jul 2012 00:28:27 +0900
Message-ID: <5008279B.4000001@samsung.com>
References: <1342097668-25243-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1342097668-25243-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,

I think not good that added the samsung specific code into dw_mmc-pltfm.c
How about separating to dw-mmc-exynos.c?

Best Regards,
Jaehoon Chung

On 07/12/2012 09:54 PM, Thomas Abraham wrote:
> This patch series adds device tree support for Synopsis Designware Mobile
> Storage Host Controller.
> 
> The first patch converts the copy of controller device instance into a
> reference. This is need to allow device resource management api to correctly
> manage the resources allocated by the driver. The second patch fixes the
> incorrect abort of the probe in case a slot initialization fails. This is
> fixed by allowing as many slots to be initialized successfully and failing
> only if there are no slots that were initialized.
> 
> The third patch adds clock lookup in the driver and this is optional. Platforms
> that do not need any clock gating and control for the dw_mmc controllers will
> not be affected with this change. The fourth patch adds a quirk to notify the
> controller about the absence of the write protect line.
> 
> The fifth patch adds device tree based discovery support for the dw_mmc driver.
> The sixth patch add Samsung Exynos5250 specific extentions to the driver.
> 
> This patchset is based on Samsung kernel tree's for-next branch with the
> mmc tree's mmc-next branch merged.
> 
> Thomas Abraham (6):
>   mmc: dw_mmc: convert copy of struct device in struct dw_mci to a reference
>   mmc: dw_mmc: allow probe to succeed even if one slot is initialized
>   mmc: dw_mmc: lookup for optional biu and ciu clocks
>   mmc: dw_mmc: add quirk to indicate missing write protect line
>   mmc: dw_mmc: add device tree support
>   mmc: dw_mmc: add samsung exynos5250 specific extentions
> 
>  .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |  144 ++++++++
>  drivers/mmc/host/dw_mmc-pci.c                      |    2 +-
>  drivers/mmc/host/dw_mmc-pltfm.c                    |   41 +++-
>  drivers/mmc/host/dw_mmc.c                          |  364 +++++++++++++++++---
>  drivers/mmc/host/dw_mmc.h                          |   23 ++
>  include/linux/mmc/dw_mmc.h                         |   17 +-
>  6 files changed, 538 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
