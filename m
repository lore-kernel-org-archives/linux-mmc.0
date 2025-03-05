Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E71FC7FA;
	Wed,  5 Mar 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168827; cv=none; b=up39YMGlV0Z2zJW09rT6dBPUiTZLMoJzmrjGI59NLLBbRl7lJFYRE1iD8Rwyrbel400eG/QnJIQez3X9ZvlXAOLy3UXX4iP+FNnqlT0Ovj2pVDbLSoq2MhIzgZ2yQBcbRc+RYjuHSR2zuMu3xIfOSLLw0ZiOLZmueTlkz2+ISt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168827; c=relaxed/simple;
	bh=RnAp8NybBTwcpa0tW1tirFA2zgXjPhyRvEErVdTWaQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A19JXe7qRHdQ5nChL9BSXZw1/E+jF0qSjO1vjo3tqhs7hoVWDvAW34zEZz5rRewWZGCgpFUiwT9Kf8X9XQJGlt4APFh0B82owygQryaq3xgvw1UMWQ2lQj3ImVBSV/tYIajPzUGQ7djfV+VitYIEHU8I9L3ekM5xyWClERJCiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c02:1dd0:9019:911e:6b73:1fea])
	by smtp.qiye.163.com (Hmail) with ESMTP id d05d5703;
	Wed, 5 Mar 2025 18:00:17 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: ziyao@disroot.org
Cc: conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 6/8] clk: rockchip: rk3528: Add SD/SDIO tuning clocks in GRF region
Date: Wed,  5 Mar 2025 18:00:15 +0800
Message-Id: <20250305100015.1353849-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250301104724.36399-1-ziyao@disroot.org>
References: <20250301104724.36399-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQk9OVkhKGk5KHUtDSRoZQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtJQUofH0tBQktKQkFCSkoeQU0ZTEhBSh0eGllXWRYaDx
	IVHRRZQVlPS0hVSktISk5MTlVKS0tVSkJLS1kG
X-HM-Tid: 0a9565bfb64d03a2kunmd05d5703
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6Pyo4FTIBFDg2NC4pMhIS
	SxAaCR1VSlVKTE9KSk1DQ0pDTE1KVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0lBSh8fS0FCS0pCQUJKSh5BTRlMSEFKHR4aWVdZCAFZQUxNTzcG

Hi,

> +	nr_clks = rockchip_clk_find_max_clk_id(rk3528_clk_branches,
> +					       nr_branches) + 1;
> +
> +	vo_grf = syscon_regmap_lookup_by_compatible("rockchip,rk3528-vo-grf");
> +	if (!IS_ERR(vo_grf))
> +		nr_clks = MAX(rockchip_clk_find_max_clk_id(rk3528_vo_clk_branches,
> +							   nr_vo_branches) + 1,

drivers/clk/rockchip/clk-rk3528.c: In function 'clk_rk3528_probe':
drivers/clk/rockchip/clk-rk3528.c:1105:27: error: implicit declaration of function 'MAX'; did you mean 'MUX'?
 1105 |                 nr_clks = MAX(rockchip_clk_find_max_clk_id(rk3528_vo_clk_branches,
      |                           ^~~
      |                           MUX

It seems that missing definition with older kernels.

Thanks,
Chukun

-- 
2.25.1

