From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 02/31] ARM: amba: of: convert to use amba_device_alloc
Date: Fri, 20 Jan 2012 07:58:12 -0600
Message-ID: <4F1972F4.7080209@gmail.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk> <E1RoAga-0005EM-1q@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <E1RoAga-0005EM-1q@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On 01/20/2012 03:23 AM, Russell King - ARM Linux wrote:
> Convert DT code to use the new amba_device_alloc APIs.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  drivers/of/platform.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 63b3ec4..cae9477 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -253,7 +253,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  	if (!of_device_is_available(node))
>  		return NULL;
>  
> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	dev = amba_device_alloc(NULL, 0, 0);
>  	if (!dev)
>  		return NULL;
>  
> @@ -283,14 +283,14 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  	if (ret)
>  		goto err_free;
>  
> -	ret = amba_device_register(dev, &iomem_resource);
> +	ret = amba_device_add(dev, &iomem_resource);
>  	if (ret)
>  		goto err_free;
>  
>  	return dev;
>  
>  err_free:
> -	kfree(dev);
> +	amba_device_put(dev);
>  	return NULL;
>  }
>  #else /* CONFIG_ARM_AMBA */

