Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3D15748D;
	Mon, 17 Jun 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634742; cv=none; b=CxBrnBrT+4p3KZ6UPceSGlplmpkGRMxA/dIRhoRkXX5r6Wd07o6Q3MXefQ7pyfcg71UPOVC+nMr/ewPXELUZtXarmqiPjiGZFZo+07MsF82PLRooF1MmZHaMFJYFkGTwI0PEmA9fhbVk2FkeK4vQxOshcAA2kExGTzFrMiposIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634742; c=relaxed/simple;
	bh=gLXE3+lPQjbeBTc+GUg/l5/TPa+GNhUhCX0x5f7GZWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyzDU/mfvO0Jt2M5sFRoU1IVpCdlBPBnhJHQpjvK3wgxoRH1GI7D0mSqgJrLMEVvDS35ChLipFNrGXWB4HtGlOd3GScBCOVWsAAw/J/bn5l9sKanKbeiEXDUCfFglzfNvcPzsWZeQhH45ju3iIp8HWw10RNSL84nq1HK08EqMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsGQpmWo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsGQpmWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C651C4AF1C;
	Mon, 17 Jun 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718634742;
	bh=gLXE3+lPQjbeBTc+GUg/l5/TPa+GNhUhCX0x5f7GZWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsGQpmWoJOeijUJ2GdaW1BOBW6bNghotr0Dr7d6nqPK6BKWHwJxZg02hW2/zB0ETC
	 byJ7yfj+xKW8q7rsfDU4HIyUs4Yz7XWKS5PvxAz/++rauK1GoJFOdbTbmnuIvIMdAo
	 5+lZqCnhyjB/kUiHjm/8ATNMz8Ot5/W5ZALJOSk48WyiJ4zGHyM9TbuaBPXBfT363e
	 ez+F8bD1Mok8bCZsTaLnTl0pcHuWs/6saz1CK/zyAuN481ptKq9fKPCqUW2USdk20D
	 LsCzsaCm/scCAtXgQ4Sf1kr9bzgP9GpSme2D56pISr7i4UiSeZsQNgQLqDaGGPB5sa
	 x165+uXc80V2g==
Date: Mon, 17 Jun 2024 22:18:24 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-of-dwcmshc: enhance framework
Message-ID: <ZnBFsLFJdi5TMA2e@xhacker>
References: <cover.1718241495.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718241495.git.unicorn_wang@outlook.com>

On Thu, Jun 13, 2024 at 09:42:03AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
> existing driver code could be optimized to facilitate expansion for
> the new soc. You can see another patch [sg2042-dwcmshc], which I am
> working on to add SG2042 to sdhci-of-dwcmshc.

Hi Chen,

IMHO, you'd better put the sg2042 support as the last patch of this
series, we want to see why the enhancement is necessary and how does
it help sg2042 upstreaming.

thanks

> 
> By the way, although I believe this patch only optimizes the framework
> of the code and does not change the specific logic, simple verification
> is certainly better. Since I don't have rk35xx/th1520 related hardware,
> it would be greatly appreciated if someone could help verify it.
> 
> ---
> 
> Changes in v3:
>   
>   The patch series is based on latest 'next' branch of [mmc-git].
> 
>   Improved the dirvier code as per comments from Adrian Hunter.
>   Define new structure for dwcmshc platform data/ops. In addition, I organized
>   the code and classified the helper functions.
> 
>   Since the file changes were relatively large (though the functional logic did
>   not change much), I split the original patch into four for the convenience of
>   review.
> 
> Changes in v2:
> 
>   Rebased on latest 'next' branch of [mmc-git]. You can simply review or test the
>   patches at the link [2].
> 
> Changes in v1:
> 
>   The patch series is based on v6.9-rc1. You can simply review or test the
>   patches at the link [1].
> 
> Link: https://lore.kernel.org/linux-mmc/cover.1713258948.git.unicorn_wang@outlook.com/ [sg2042-dwcmshc]
> Link: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git [mmc-git]
> Link: https://lore.kernel.org/linux-mmc/cover.1713257181.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-mmc/cover.1714270290.git.unicorn_wang@outlook.com/ [2]
> 
> ---
> 
> Chen Wang (4):
>   mmc: sdhci-of-dwcmshc: adjust positions of helper routines
>   mmc: sdhci-of-dwcmshc: unify the naming of soc helper functions
>   mmc: sdhci-of-dwcmshc: extract init function for rk35xx/th1520
>   mmc: sdhci-of-dwcmshc: add callback functions for dwcmshc
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 598 ++++++++++++++++------------
>  1 file changed, 339 insertions(+), 259 deletions(-)
> 
> 
> base-commit: d6cd1206ffaaa890e81f5d1134856d9edd406ec6
> -- 
> 2.25.1
> 
