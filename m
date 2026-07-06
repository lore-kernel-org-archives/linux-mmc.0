Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938E424676;
	Mon,  6 Jul 2026 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340074; cv=none; b=qvaONZx0rx1U58nJXfLJD/VSUc/JHxrq8/tUPUfqG7GvLX8ANn8WwL+KlsZmvYjPHOXzQVuYlFMmYZz0cuiSvS3SvXNXWyjGEnlJdeu5VKlN8LvOcVLbX0kl3OH4E0BOoVRjuBKUQ1Ad4Qp72bV0H1S4zrQNMktS0kONrmW57ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340074; c=relaxed/simple;
	bh=JP+dwK2+wbSyrHCmqviCaHk1vIzaoSh3lHrjMAaH/YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEebPpLilwBYQlouMSOXyFi/faKXrFFlrA9j+2FFnh/sE4Pn1l3DIuMexC+k0Hy5xsCt/1SgfWbjPoLf0qJLPJs31cSLUmJN7xWANZra8rwWw0aQNIWrgZgDOdUqvZBr/2I9ZixXf0IZ7jrQuGLKuoTKZENeDp3WQEM2+j7RRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPmtO7uN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPmtO7uN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121871F000E9;
	Mon,  6 Jul 2026 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783340071;
	bh=UfZEhOmUAtYb9FNfwIrhuWbkBWwbFTNpgJ24RGae3QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bPmtO7uNl48Q6bs+krcLQuw/tGKsl/JnxFHgbLFLkbFx148tTkkA7+0+myQHEaGRx
	 umK1+gemSQ381e4T0ydJrpe5m50O2llJQVDfxhEPEtVvjgabuo/BR5Ho6mleocrkpE
	 fTxcf+KK6Dpfmp5M9B1Dl5PVW39xYP/4cksVqp5fVQ5O4WWUR3U4zCxV6tksNIYDNJ
	 3bY+xwqwO8IC0rw+2yC2rczkDRpdu3Xv940Wc8aK8I3AlcbIjJHmDU4JiesBKEXqny
	 SHdPswcAheebzOd/3vvQV+K23MtLsBdoa4ItivVZCf7TP91cWgJ6w8JjpA1/pDNXqP
	 IZRI1tts3WtBQ==
Date: Mon, 6 Jul 2026 13:14:13 +0100
From: Mark Brown <broonie@kernel.org>
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
	Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
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
	imx@lists.linux.dev, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 00/42] of: reserved_mem: Introduce devres helpers and
 convert drivers
Message-ID: <ceeca378-3c76-4b2c-81b4-0ff1bb1e99be@sirena.org.uk>
Mail-Followup-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
	Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
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
	imx@lists.linux.dev, sound-open-firmware@alsa-project.org
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wOAp0AJHJvNt3tz3"
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
X-Cookie: Did I do an INCORRECT THING??


--wOAp0AJHJvNt3tz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 04, 2026 at 01:08:13AM +0530, Mukesh Ojha wrote:
> Drivers using of_reserved_mem_device_init() and its variants must
> manually call of_reserved_mem_device_release() in their remove and
> error-unwind paths. This is repetitive boilerplate that is easy to
> get wrong, and several drivers have open-coded the teardown
> inconsistently or skipped it entirely, leading to dangling reserved
> memory references.

Just as a general thing, rather than sending a huge cross subsystem
series for something like this it's probably better to just send a
couple of examples, then once the new API is introduced and either has a
pullable tag or has made it to mainline go and do the conversion.  This
avoids clogging everyone's inbox with very big serieses.

--wOAp0AJHJvNt3tz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpLnBQACgkQJNaLcl1U
h9CmKwf9F2YIGBkVeulsWbi5D2t0CnJR/02sSOVl3kzxHiLVhiwWDuHChe6nJcf/
B22JeTRk3geytCtoi5VvvmmNuN+5GmfWxtqo+bJgCYojxOFKt1bde4RkYg1O+aIO
0JEs896VePybnfaXzCbeT2n3+gnqC/RMKL+WfvNsfpZqVXUb+QNc6jdCba+Jhlc6
kJV1YxYgK0VXXLsuZ1ziJ+d22nU5afgm5JQX8CTrl+8EVCL+rbnDtnNmClMg8C6b
RFN0y9e3hN+0tUEYxGm+VotHPeBuzmgBQucRkMCypqkAEegoWehkdUWzi41bhUBF
sBJ4nhpfaNf7OXkA6cTOGSwuEFc7yA==
=BASk
-----END PGP SIGNATURE-----

--wOAp0AJHJvNt3tz3--
