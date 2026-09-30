Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50924D1787;
	Wed, 30 Sep 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783913; cv=none; b=FCX+nABzNWKSO2+2YQH2ZQikHMzBBQd7YMGvYTjVdjZsAT6QXP4uyUCK1SQJvxRzMptVsAaBc+YWK3AgYdhUK40cTkWcNzz2imYz05O6g+wt0aVjS1HdzK7R5jy1NtZnNtnnA00HRnhL2gJb8ni2rSIUk/2T/q0sJqleCD+NjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783913; c=relaxed/simple;
	bh=7+uOAdwvRA5Phs71HOWvHd2WnABdLy2EzB8eI2nyFFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqTI12H6q0H84KMyhlgT9gmEZn/iqjp61tDA5rFSJatvq8zU0nlK0U8uiX3Q5xqHh6PlSUnk8h6Yg1SDGRU91+5rrANOAeMjKSzexzdFe/2YegbpPcA8IjjdKnpkSeUCO9jwVR434AzJdX/lZ+enO2qW0fa6M9fnzZw9tD7hgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=L2tfF9HC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L2tfF9HC"
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 34D4C34;
	Wed, 30 Sep 2026 17:56:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790783786;
	bh=7+uOAdwvRA5Phs71HOWvHd2WnABdLy2EzB8eI2nyFFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2tfF9HC3qurjOKRXYDMqOKASmD+Fr11uViI6pruu4IK+X2gjb+Qrc0LPbo2ClC/i
	 pQ50KvP2bVEDVqeebyd/BBPmVqkW68rD+oEjTdYgMuso89FKaU5zYqVN2gKEIaX8Kh
	 049B+Gb1N/HvapsKch/NcZ4isnk/qWbGR2u6qN6Y=
Date: Wed, 30 Sep 2026 17:58:14 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Paul Cercueil <paul@crapouillou.net>, 
	Anitha Chrisanthus <anitha.chrisanthus@intel.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Alexey Brodkin <abrodkin@synopsys.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Eddie James <eajames@linux.ibm.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Minghsiu Tsai <minghsiu.tsai@mediatek.com>, 
	Houlong Wei <houlong.wei@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ge Gordon <gordon.ge@bst.ai>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Peter Chen <peter.chen@cixtech.com>, Fugang Duan <fugang.duan@cixtech.com>, 
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, 
	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-media@vger.kernel.org, openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com, linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 21/42] media: arm: mali-c55: Use
 devm_of_reserved_mem_device_init()
Message-ID: <ar0xb9md8E76G5VI@zed>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-22-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-22-mukesh.ojha@oss.qualcomm.com>

Hi Mukesh

On Sat, Jul 04, 2026 at 01:08:34AM +0530, Mukesh Ojha wrote:
> Use the devres-managed devm_of_reserved_mem_device_init() instead of
> the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
> pair, letting the device resource manager handle cleanup automatically.
>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

I'll collect this single patch for the Mali-C55 PR for v7.4

> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-core.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> index 94a389b3f833..afbec11f69f8 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> @@ -801,14 +801,12 @@ static int mali_c55_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to acquire resets\n");
>
> -	of_reserved_mem_device_init(dev);
> +	devm_of_reserved_mem_device_init(dev);
>  	vb2_dma_contig_set_max_seg_size(dev, UINT_MAX);
>
>  	ret = __mali_c55_power_on(mali_c55);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "failed to power on\n");
> -		goto err_release_mem;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to power on\n");
>
>  	ret = mali_c55_check_hwcfg(mali_c55);
>  	if (ret)
> @@ -847,9 +845,6 @@ static int mali_c55_probe(struct platform_device *pdev)
>  	kfree(mali_c55->context.registers);
>  err_power_off:
>  	__mali_c55_power_off(mali_c55);
> -err_release_mem:
> -	of_reserved_mem_device_release(dev);
> -
>  	return ret;
>  }
>
> @@ -864,7 +859,6 @@ static void mali_c55_remove(struct platform_device *pdev)
>  	}
>  	pm_runtime_disable(&pdev->dev);
>  	kfree(mali_c55->context.registers);
> -	of_reserved_mem_device_release(&pdev->dev);
>  }
>
>  static const struct of_device_id mali_c55_of_match[] = {
> --
> 2.53.0
>
