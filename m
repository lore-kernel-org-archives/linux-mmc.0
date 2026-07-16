Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951A29E117;
	Thu, 16 Jul 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232050; cv=none; b=aT/WXnQ166OIvQJ5rfJoN5RoJfOazThOutuoovOZ5G+hCANkel4fM4Oh3rW8mdHSEwxqZNo1HQBaXEziy6wzwSFOtFa3zk8wePm9w8uykAyGQMBfpSMAWkjIS+JGiD5sTLZN3Dnk3heoXLgViW6WO/xdRlSMh+rnWXSUdnHpcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232050; c=relaxed/simple;
	bh=B4VshDhGQfD/1AyTCWO9i4wlJk3e/ooqPZauVlVVDnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW2rTdxnEkC/qAYXeHZdmvsyeEBDxkhePjj4SPvTZWAi6sEdXpjFIAHbqkj7ML4/AkVWigtnIPaEabzrPkve3rILdb1PYM5U5zb54mu0qiw1nr63Ot0HS1PwsCF9VtmF4ItmHSCqrTvaSD+zWcvuMAoLyKUgfzyax1dQZ9XHEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5qGtpAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5qGtpAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5241F000E9;
	Thu, 16 Jul 2026 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784232049;
	bh=SkbdCLvPFiAZcCyqV3OjTuTi5o9qsDoHdIygT4AGL4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a5qGtpAkwNEV9jsxYeN/Q7n89zdNsN11G1zMfSI/etA7Yi8LAH8wgTwX8UoL8G6L3
	 QtafStp+dmSt5fFR0M7Ai+HhZRfgGrSBdmRSVU1fjHDIuAp1dKdasuz9jt0aJrxD3/
	 m0tYK1IMkzPighZh3SmtIb3LTdl0mWbQQGJdURYx9sNiNa31kAqFcPx603ZWrA8Z5J
	 JfUlu+YJIGtuoeaFb2374D//LRjheitSmsxEZ9JXEZaPg3WYZES56yqM6EQ9jdxYlv
	 mgAQgo5RIr1XNkCB+v1k0eQV6pruyKIOj7Rs+S8wE73+oNZNKsm6QaBr6/beqAO5pH
	 tJpkEALlcnrlg==
Date: Thu, 16 Jul 2026 15:00:48 -0500
From: Rob Herring <robh@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Cercueil <paul@crapouillou.net>,
	Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ge Gordon <gordon.ge@bst.ai>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
	kernel@collabora.com, linux-tegra@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 01/42] of: reserved_mem: Introduce devres-managed
 initialization functions
Message-ID: <20260716200048.GA1183026-robh@kernel.org>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-2-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-2-mukesh.ojha@oss.qualcomm.com>

On Sat, Jul 04, 2026 at 01:08:14AM +0530, Mukesh Ojha wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Introduce devres-based helpers for of_reserved_mem_device_init(_by_idx)
> to help fight dangling references and ever so slightly reduce the
> number of boilerplate deinitialization calls.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/of/of_reserved_mem.c    | 41 +++++++++++++++++++++++++++++++++
>  include/linux/of_reserved_mem.h | 25 ++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 82222bd45ac6..b35541e9fbe8 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -787,6 +787,47 @@ void of_reserved_mem_device_release(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(of_reserved_mem_device_release);
>  
> +static void devm_of_reserved_mem_device_release(struct device *dev, void *res)
> +{
> +	of_reserved_mem_device_release(*(struct device **)res);
> +}
> +
> +/**
> + * devm_of_reserved_mem_device_init_by_idx() - Resource managed of_reserved_mem_device_init_by_idx()
> + * @dev: Pointer to the device to configure
> + * @np: Pointer to the device node with 'memory-region' property
> + * @idx: Index of selected region
> + *
> + * This is a resource managed version of of_reserved_mem_device_init_by_idx().
> + * The reserved memory region will be released automatically when the device
> + * is unbound.
> + *
> + * Returns: Negative errno on failure or zero on success.
> + */
> +int devm_of_reserved_mem_device_init_by_idx(struct device *dev,
> +					    struct device_node *np, int idx)

It looks to me like the only 2? users of this could be converted to 
devm_of_reserved_mem_device_init() instead. The mmc one obviously can. 
The imx one depends if np is dev->of_node. I'm not a fan of APIs with 
only a few users.

Rob
