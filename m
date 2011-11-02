From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/2] arm: samsung: support the second capability for hsmmc
Date: Wed, 02 Nov 2011 21:55:37 +0900
Message-ID: <006101cc995e$b7e33c80$27a9b580$%kim@samsung.com>
References: <4EAE38F5.9060801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4EAE38F5.9060801@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Jaehoon Chung wrote:
> 
> 
Well...
Firstly, you need to add description here why this change is needed.
Secondly, you need to check latest maintainer's tree, in this case, the
dev-xxx.c are merged into plat-samsung/devs.c ago.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/dev-hsmmc.c          |    2 ++
>  arch/arm/plat-samsung/dev-hsmmc1.c         |    2 ++
>  arch/arm/plat-samsung/dev-hsmmc2.c         |    2 ++
>  arch/arm/plat-samsung/dev-hsmmc3.c         |    2 ++
>  arch/arm/plat-samsung/include/plat/sdhci.h |    1 +
>  5 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-hsmmc.c
b/arch/arm/plat-samsung/dev-
> hsmmc.c
> index db7a65c..e6b0c58 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc.c
> @@ -74,6 +74,8 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
> +	if (pd->host_caps2)
> +		set->host_caps2 |= pd->host_caps2;
>  	if (pd->clk_type)
>  		set->clk_type = pd->clk_type;
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c
b/arch/arm/plat-samsung/dev-
> hsmmc1.c
> index 2497321..79a5ff2 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc1.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc1.c
> @@ -74,6 +74,8 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
> +	if (pd->host_caps2)
> +		set->host_caps2 |= pd->host_caps2;
>  	if (pd->clk_type)
>  		set->clk_type = pd->clk_type;
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c
b/arch/arm/plat-samsung/dev-
> hsmmc2.c
> index f60aedb..a590d72 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc2.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc2.c
> @@ -75,6 +75,8 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
> +	if (pd->host_caps2)
> +		set->host_caps2 |= pd->host_caps2;
>  	if (pd->clk_type)
>  		set->clk_type = pd->clk_type;
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c
b/arch/arm/plat-samsung/dev-
> hsmmc3.c
> index ede776f..afa37c8 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc3.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc3.c
> @@ -78,6 +78,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
> +	if (pd->host_caps2)
> +		set->host_caps2 |= pd->host_caps2;
>  	if (pd->clk_type)
>  		set->clk_type = pd->clk_type;
>  }
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> samsung/include/plat/sdhci.h
> index 058e096..7b48828 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -67,6 +67,7 @@ enum clk_types {
>  struct s3c_sdhci_platdata {
>  	unsigned int	max_width;
>  	unsigned int	host_caps;
> +	unsigned int	host_caps2;
>  	enum cd_types	cd_type;
>  	enum clk_types	clk_type;
> 
