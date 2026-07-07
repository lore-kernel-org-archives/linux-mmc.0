Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E143C7B2;
	Tue,  7 Jul 2026 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448028; cv=none; b=VWJtBq39TMPs1U8FCOoH5RVO3FvzPaSn93P2ya5ej91RqJp5Y1giXsAO84QswwdjhC/R9aYvgjikRbGv+hv0Y7GxVHeIOA7JRRW9sXbpOJHkLBSzhJG7U4JCoI1pLbqKRbwPKg6+My1sNGgYrFhg2WZBo2uOkpLitpy5Yb3121o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448028; c=relaxed/simple;
	bh=jSZnB0sLqjEJbBoqe7AZJRMFNCZugWpISC+yCdraaOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=frXj8u/839yhSKbijrBsY45eh/YecaIYEcb3lt+rF7vjNiWuCgP2FadWmL19LbWh+OlmwcE8eUo4tzOTkynIrRukrigIlN8RVfiJLvAQxEugqzz6u71ei4HjlUyZV9dWvZZBsoXfoogdetJIXKIYDvULo79KwgE+/yZk9WIT714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=taLqIYWA; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="taLqIYWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1783447618;
	bh=jSZnB0sLqjEJbBoqe7AZJRMFNCZugWpISC+yCdraaOk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=taLqIYWARPanxMePLjn0T7clMcda7af2pvmrr0dQzpeuwc0nctWzpeP7MFrEdwHD3
	 wFNI1Cev/uBH+lstwttbgnjYpRUlRSvuTptlXHNnBzTOSCT1/sAyy72NlnTqVPq0M/
	 E7dkR8V01XIjaryuVKTvkbf8yDy1RmuISroVos5g=
Message-ID: <f46dfcfe04c5f8270b2ea1a947ddc0a0eeda7dbc.camel@crapouillou.net>
Subject: Re: [PATCH 17/42] drm: ingenic: Use
 devm_of_reserved_mem_device_init()
From: Paul Cercueil <paul@crapouillou.net>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Bjorn Andersson	
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Liviu Dudau
	 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Anitha Chrisanthus
 <anitha.chrisanthus@intel.com>, Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij	 <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec	 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Michal Simek <michal.simek@amd.com>,
 Daniel Scally	 <dan.scally@ideasonboard.com>, Jacopo Mondi
 <jacopo.mondi@ideasonboard.com>,  Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Eddie James <eajames@linux.ibm.com>, Tiffany Lin	
 <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, Minghsiu Tsai
 <minghsiu.tsai@mediatek.com>, Houlong Wei	 <houlong.wei@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Joseph Liu <kwliu@nuvoton.com>,
 Marvin Lin <kflin@nuvoton.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding	 <thierry.reding@kernel.org>, Jonathan Hunter
 <jonathanh@nvidia.com>,  Srinivas Kandagatla	 <srini@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>,
 Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter	 <adrian.hunter@intel.com>, Ulf
 Hansson <ulfh@kernel.org>, Rob Herring	 <robh@kernel.org>, Saravana Kannan
 <saravanak@kernel.org>, Mathieu Poirier	 <mathieu.poirier@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai	 <tiwai@suse.com>, Shengjiu
 Wang <shengjiu.wang@gmail.com>, Xiubo Li	 <Xiubo.Lee@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer	 <s.hauer@pengutronix.de>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>,  Bard Liao
 <yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Orson Zhai	 <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Peter Chen	 <peter.chen@cixtech.com>,
 Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, BST Linux Kernel Upstream
 Group <bst-upstream@bstai.top>, Fabio Estevam <festevam@gmail.com>, Nicolin
 Chen <nicoleotsuka@gmail.com>,  Pengutronix Kernel Team	
 <kernel@pengutronix.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Vijendar Mukunda
 <Vijendar.Mukunda@amd.com>, Chunyan Zhang	 <zhang.lyra@gmail.com>, CIX
 Linux Kernel Upstream Group	 <cix-kernel-upstream@cixtech.com>,
 linux-arm-msm@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, 	linux-mips@vger.kernel.org,
 linux-sunxi@lists.linux.dev, 	linux-media@vger.kernel.org,
 openbmc@lists.ozlabs.org, 	linux-mediatek@lists.infradead.org,
 kernel@collabora.com, 	linux-tegra@vger.kernel.org,
 linux-mmc@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, 	linux-staging@lists.linux.dev,
 linux-sound@vger.kernel.org, 	linuxppc-dev@lists.ozlabs.org,
 imx@lists.linux.dev, 	sound-open-firmware@alsa-project.org
Date: Tue, 07 Jul 2026 20:06:50 +0200
In-Reply-To: <20260703193855.110619-18-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
	 <20260703193855.110619-18-mukesh.ojha@oss.qualcomm.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le samedi 04 juillet 2026 =C3=A0 01:08 +0530, Mukesh Ojha a =C3=A9crit=C2=
=A0:
> Replace the hand-rolled devm wrapper (ingenic_drm_release_rmem +
> devm_add_action_or_reset) with the standard
> devm_of_reserved_mem_device_init(), letting the device resource
> manager handle cleanup automatically.
>=20
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 13 +------------
> =C2=A01 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 7e569af22391..990c3b4625fa 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1060,11 +1060,6 @@ static void ingenic_drm_unbind_all(void *d)
> =C2=A0	component_unbind_all(priv->dev, &priv->drm);
> =C2=A0}
> =C2=A0
> -static void __maybe_unused ingenic_drm_release_rmem(void *d)
> -{
> -	of_reserved_mem_device_release(d);
> -}
> -
> =C2=A0static void ingenic_drm_configure_hwdesc(struct ingenic_drm *priv,
> =C2=A0					 unsigned int hwdesc,
> =C2=A0					 unsigned int next_hwdesc,
> u32 id)
> @@ -1127,16 +1122,10 @@ static int ingenic_drm_bind(struct device
> *dev, bool has_components)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
> -		ret =3D of_reserved_mem_device_init(dev);
> +		ret =3D devm_of_reserved_mem_device_init(dev);
> =C2=A0
> =C2=A0		if (ret && ret !=3D -ENODEV)
> =C2=A0			dev_warn(dev, "Failed to get reserved
> memory: %d\n", ret);
> -
> -		if (!ret) {
> -			ret =3D devm_add_action_or_reset(dev,
> ingenic_drm_release_rmem, dev);
> -			if (ret)
> -				return ret;
> -		}
> =C2=A0	}
> =C2=A0
> =C2=A0	priv =3D devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,
