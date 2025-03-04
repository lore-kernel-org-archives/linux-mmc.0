Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299FF8472;
	Tue,  4 Mar 2025 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091462; cv=none; b=IhuHOvqBJa/GYuVicifJEY1yrslbjBRqZU8K68QHurTipGQj6LuPnJG13k2zw/aiz+GoqNA47d2AmjsisIiWX2ngMErR5E1yX6sFJ878hEp4HabzfJc8MrZGYPAbXPcAIfds9g/9dF2JtCW4GtoiI6fUESHZf7wgWb1flOKEE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091462; c=relaxed/simple;
	bh=rYlHgkTpoEM6pxnQ8HCOUgXk8SpwcrCOoqmJPZDKZsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDdgPSJMyJsIt/6+Bxc3GKqhV2x8h/Pk9HQPjTvO4G3gzIiCwVfVTkrFXMasnFkBb2LW/68s5cAcC1BiXgzWn+kFm05lEDWEAPiM7KvblEwHIIsLclYifn8ZboagV7YZEp3vm8rbNt3F+Mqt0TJ7glnbSaroJRKLBLhtIU5uICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c02:1dd0:e9f1:cb9a:640c:3ba3])
	by smtp.qiye.163.com (Hmail) with ESMTP id ce62fafc;
	Tue, 4 Mar 2025 20:15:38 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: ziyao@disroot.org
Cc: conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	frank.wang@rock-chips.com,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Enable SD-card interface on Radxa E20C
Date: Tue,  4 Mar 2025 20:10:36 +0800
Message-Id: <20250304121036.1453284-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250301104835.36439-1-ziyao@disroot.org>
References: <20250301104835.36439-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkpJVh5CThgfT0lMTR4aSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtJQUofH0tBHkIdSkEYGUIaQU1PSxhBSBkaSFlXWRYaDx
	IVHRRZQVlPS0hVSktISk5MTlVKS0tVSkJLS1kG
X-HM-Tid: 0a95611544ad03a2kunmce62fafc
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06KDo6SDIOI0IQAzEUDwxK
	HEoKFCpVSlVKTE9KS0JLTkhCT05MVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0lBSh8fS0EeQh1KQRgZQhpBTU9LGEFIGRpIWVdZCAFZQUxLSjcG

Hi,

> +	aliases {
> +		mmc0 = &sdmmc;

s/mmc0/mmc1

> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;

I think for sdcard, only cap-sd-highspeed
is needed, not cap-mmc-highspeed?

> +	disable-wp;

Missing pinctrl.

> +	rockchip,default-sample-phase = <90>;

It seems that all rk3528 devices need to set this
default phase, so maybe this can be placed in dtsi?

> +	sd-uhs-sdr104;

The rk3528 devices uses gpio to switch IO voltage, maybe
more modes should be added here like vendor kernel?
And these devices use 3.3V IO voltage by default.

	sd-uhs-sdr12;
	sd-uhs-sdr25;
	sd-uhs-sdr50;
	sd-uhs-sdr104;

Thanks,
Chukun

-- 
2.25.1

