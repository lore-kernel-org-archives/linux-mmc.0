Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D83329E69;
	Thu, 13 Nov 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076778; cv=none; b=Yf+swlgYX9DRvKXz5ATuvkXLOqu7SMiaC6fpnTvfrUp84xqwcnal4sYSc9S6p0D2AjpHiRXjxi9lT8fHV1aO7EWY1GTswMFf/kQZFgPf+B0f0L88ugzvKUqwKjq5FxO0/OwsEG8QZDd5gy8KjtTgShBjIhKaMyyIYXLsSnS4UOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076778; c=relaxed/simple;
	bh=2NSFCeoijNJWf4COT/RA6eLKsrXnLBFu4ii7q3TrtqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=De9mUiQ+PcMEn/yDAoB8HDb5qeYQq5zF2r2SbparTo9AO8NZboQhOrHVlkmZfAd7DuhC4fyWebIWg5SNBZZZiO+RvsQ4EmwExZTAtqvJdRNgrJ3jDpn7p9slwae2MRA1SrLGgviSEkzJsW/yz61NOflj87KgiiFDTS40q7jULKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZcYGorMN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZcYGorMN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MUCMochQrd1DfpxoWgDSOw9hEbqaoIKOIax/Q5hH7zc=; b=ZcYGorMNWg76feS0WkFebEWWBD
	5+O15+6zARcwgBU5PFgKNaa26YsM3I3KpNdoxD5q63B+VcCP4IuPBerOFMBNaycsw5EQ1XzgHEX0c
	ZsL/0S+TYlH/9ExSzvbiLIUilpONtVlzCmcYrVztzOsfDJ4RJ070JN0kl48S65aXpVmmqB1xzzhmp
	Q0OCqc8k2QYfujjoLQm2Zbu4X/ds4tyfAmcDb23WlG3Gc7YQssL82ZxrzL+YfxnzbYXIlCw+65LVd
	4JZovfi7ZbNx4MjCztROy7DLsmoAWgVZKZNzIYec/x/Eu8HE0r+AtRlK9nRzcEi9tvY/XgnM7t0i7
	yeuxXXiw==;
Received: from i53875a11.versanet.de ([83.135.90.17] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJgMo-0005bo-3A; Fri, 14 Nov 2025 00:04:38 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: Re: (subset) [PATCH v2 0/2] mmc: sdhci-of-dwcmshc: Add command queue support for Rockchip SOCs
Date: Fri, 14 Nov 2025 00:04:30 +0100
Message-ID: <176307502900.495066.12322233848584561595.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
References: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 31 Oct 2025 16:58:22 +0100, Sebastian Reichel wrote:
> Right now at least the recent Rockchip SoCs do not support system
> suspend with the mainline kernel. I'm currently looking into
> improving support for the RK3576 platform.
> 
> On the Sige5 one of the issues is the eMMC controller, which fails
> to suspend when trying to disable CQE support. While investigating
> I found a missing Rockchip quirk in the Rockchip kernel, which is
> needed for CQE. Since the RK3576 DT has been upstreamed with the
> 'supports-cqe' property (RK3588 does not yet have it), we run into
> this problem for that platform.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: add eMMC CQE support for rk3588
      commit: 9d856aa1c81930a5d8df0e29d6cb0faa3fa87206

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
