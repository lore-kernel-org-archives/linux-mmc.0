Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096C3314BD;
	Mon, 18 Aug 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541831; cv=none; b=lg0KIp/2mFRsBXnO9TSydA/AypcjnaMI4CtnBfrGTkxTPs8Y6pty5RjLIM9JVEqeuH73A58x764lkVdz1kG1uxc4rDCk7HQFWztfUByQ0ySrYAgS6BAtPOPqaYxrKad5K1gxXghI/XSJuLETQ8yElS4e9ys92YZ396mOdB1hk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541831; c=relaxed/simple;
	bh=iwIYfibTIm+aLCgB7Yn8j8yUSxjYfjfJDjwpD7s31ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSVelbw6UNrz53p3fzin1ZnSWylVt1615/shH5COrFnz6aDQ4ddDXOdFRlxw3ClEaLm9KEN3gRl/InA3nLZHvvDDDmikhRx3QwAKsrVR1FcQoP2WfRczioCmcs/nuhKHSBzuwF6y+LQFSlc0JcqAUrlkU06ziWDnBhaBVEuu5KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMg5PChp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMg5PChp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8CFC4CEEB;
	Mon, 18 Aug 2025 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541831;
	bh=iwIYfibTIm+aLCgB7Yn8j8yUSxjYfjfJDjwpD7s31ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMg5PChpuvzfoTwd5T7hYwcWxPux/eVRJ4Uk81FP8LBlqkcXQu+dwu+NXumeSDAfc
	 qF4YcmQcywlVv4h1lCZSDPW6YJRQ2YplrOiHY0gb7XAXXDGikhAyDfTv7V6tS0Hoxm
	 La4Osm82QSl51cpIYEOopSSCx2C9a/M5afasXYJ45Zlw8gpztpE1E7R90LU0LeFkzh
	 IWFiHP6MBgLep5xnym/IA/89yFlzdwU65zs/34GyvIr8cFSFrU417uAfYRB3AxrxuI
	 RSnjQXEU15PesOZCVLtlDbWXcc9OwkI1JKJCjq5ucKCuwnwsuvQPE9wXUZs+A7IrJd
	 FZdhUMVs+fi6g==
Date: Mon, 18 Aug 2025 11:30:29 -0700
From: Drew Fustini <fustini@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/38] mmc: sdhci-of-dwcmshc: use modern PM macros
Message-ID: <aKNxRcm0JtKqCBUd@x1>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815013413.28641-3-jszhang@kernel.org>

On Fri, Aug 15, 2025 at 09:33:37AM +0800, Jisheng Zhang wrote:
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Tested-by: Drew Fustini <fustini@kernel.org> # for TH1520 on LPi4a
