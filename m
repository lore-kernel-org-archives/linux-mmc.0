Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB652D3749;
	Tue, 14 Oct 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478461; cv=none; b=P8BSEhRw7KrxOMqIAAJKvIrNiFEmbUjOfZ+1ExOCx1N1N+fqeACKYONYK1kYB7nw65wgtGov8h4xAg4IK+QuYfYIQOBrQE3mPnHQb/rYrYZ8Jli7a0ZF792DHMQTv9CPtam0Lwf9eQ1F4H68psFM8RJXEy6hFyqqaiKmz/8o6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478461; c=relaxed/simple;
	bh=wEi7nhCjw+nkfoQaFqUoqOh5Kh5E11LLBYNyxU9hjas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=seBBP/kr2hpynUJ5oKfb6pntYuNJSuF+Ipfzcm8cd043anSkfrhnvwz1T8f/DNK5CXdxFtVKTv8OyqflIun40b0ALR4NcYv4cmFm06i/y5HORM9xOU1ZsQuj/n+LCx9ubzi3xRXOaJ2Te60b06D0VxNkJkjxE8UU660iuxZSURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Zq3E+YZP; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Zq3E+YZP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBA46409EE;
	Tue, 14 Oct 2025 23:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760478450; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dydcnTVUuAbLmXZJFV5DtuO7kXIF77fhzGOLPlAWyaI=;
	b=Zq3E+YZPHxSvcaUf0pyIY0MmoHAwXtzp+UYrMz/b0n04QRPnG6zO3E0NK82UYfjichERrz
	iIRKOvG63PF8RnP8LaGhOuuEIz/dtjexVU+2aHF2z8sPMtUvC+4rNa/gJW0AWV/jBjqsDH
	m1wU35zgZfmWn9FPHJDQ7aiJ8dgYd/PnI8qUsB4H7+fHDDWVbDAIR7oAZNUxkEZrLrI4+d
	7RUaXh9L2LZD+HJbMgVG6zcnhGFelmF8JZFQXxgAGjlfKlS3ESDKmje+tICp0DUZDM0mhD
	5wmbpknpThcyq/GwtRQuNFHV5rLGt/243H2sBhMX20xN8yhesBU1/iCz88iBnQ==
From: Dragan Simic <dsimic@manjaro.org>
To: sebastian.reichel@collabora.com
Cc: adrian.hunter@intel.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	yifeng.zhao@rock-chips.com
Subject: Re: [PATCH 1/2] mmc: sdhci-of-dwcmshc: Add command queue support for rockchip SOCs
Date: Tue, 14 Oct 2025 23:47:00 +0200
Message-Id: <20251014214700.4182858-1-dsimic@manjaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251014-rockchip-emmc-cqe-support-v1-1-918f03de0cb1@collabora.com>
References: <20251014-rockchip-emmc-cqe-support-v1-1-918f03de0cb1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Sebastian,

> This adds CQE support for the Rockchip RK3588 and RK3576 platform. To
> be functional, the eMMC device-tree node must have a 'supports-cqe;'
> flag property.

> As the RK3576 devicet-tree has been upstreamed with the 'supports-cqe;'
> property set by default, the kernel already tried to use CQE, which
> results in system hang during suspend. This fixes the issue.

Thanks for the patch, it's great to see this implemented!  Please,
see a small nitpick below.

> +static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
> +{
[snip]
> +}
> +
> +static void rk35xx_sdhci_cqe_disabled(struct mmc_host *mmc, bool recovery)
> +{
[snip]
> +}

The function rk35xx_sdhci_cqe_disabled() should obviously be called
rk35xx_sdhci_cqe_disable() instead, i.e. it should use the standard
imperative mood...

> +static const struct cqhci_host_ops rk35xx_cqhci_ops = {
> +	.enable		= rk35xx_sdhci_cqe_enable,
> +	.disable	= rk35xx_sdhci_cqe_disabled,
> +	.dumpregs	= dwcmshc_cqhci_dumpregs,
> +	.set_tran_desc	= dwcmshc_set_tran_desc,
> +};

... which corresponds with the struct member names.
