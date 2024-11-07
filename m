Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70131F4290;
	Thu,  7 Nov 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977359; cv=none; b=mDmHfYpQ8EO9pCXElvYlpx2ltuxjo1HyC8CtdfXrIaGEbQvauGHrQ/zIaEcystmA15Xypq/WHnkfXNBpareRRWpyvF7sl1zT8P+bfUMTQbnVpHunmufnkiOXgEXr2GjNvQYDpEvOgCuUND0qklmFo1CNq6PTc5AmBy9UhhdkbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977359; c=relaxed/simple;
	bh=b0bTy290Gv4Pae9BlhjI0SkrHyDgzfB15dcSYgwkuhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JF1toiCcvt32z/TsLIiO6QUY6wJveq92gglRI8g+mKsI7dsXvgWfWsWmansix02yP77sQkoTf5ffn4BYAltEQ0Q9AiYXh7Mr0bHlui4HwhTy4VQtgceH5omefX5G9QdMFlSihXx1aRTxhC93eyH4ukamjQ6QgGihJV4joWfYZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lNkq8uuX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lNkq8uuX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730977355;
	bh=b0bTy290Gv4Pae9BlhjI0SkrHyDgzfB15dcSYgwkuhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lNkq8uuXecRWDRa2Ptic2EWcNh7IFeOscAVOFNFIJqBbRh2VZA7NRdn8eMKeWcNi1
	 Ch4B7WgNl2Ca8+xjNc/v0fkK3lmS7xMhwYpv805KcoNyP3Kx63SEl5wjQwqpIA3y+l
	 7dwTqO65OjBxvK4hHyrvRCsdRUtGLi9wqvCbSgMORdMPXWdmOUIVMWhupR+GZMMV5S
	 8jiS89xYjKKHPeSi9/ywpl0QRo4jrheiYLoz2MT83m4kmOl6tIEmULpnmOcP75EUSw
	 +oqsWtWHizEu8JVgRGWYtFPhMH8nUaUlEG2vNvExmV/+FX67SVQkmFWYNCplxSvD+n
	 saI9kp/FNePFg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6B71F17E35E3;
	Thu,  7 Nov 2024 12:02:35 +0100 (CET)
Message-ID: <900eb529-9868-4455-8f13-3e6ce6c99983@collabora.com>
Date: Thu, 7 Nov 2024 12:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mtk-sd: Fix error handle of probe function
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241107014714.24981-1-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241107014714.24981-1-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/11/24 02:47, Andy-ld Lu ha scritto:
> In the probe function, it goes to 'release_mem' label and returns after
> some procedure failure. But if the clocks (partial or all) have been
> enabled previously, they would not be disabled in msdc_runtime_suspend,
> since runtime PM is not yet enabled for this case.
> 
> That cause mmc related clocks always on during system suspend and block
> suspend flow. Below log is from a SDCard issue of MT8196 chromebook, it
> returns -ETIMEOUT while polling clock stable in the msdc_ungate_clock()
> and probe failed, but the enabled clocks could not be disabled anyway.
> 
> [  129.059253] clk_chk_dev_pm_suspend()
> [  129.350119] suspend warning: msdcpll is on
> [  129.354494] [ck_msdc30_1_sel : enabled, 1, 1, 191999939,   ck_msdcpll_d2]
> [  129.362787] [ck_msdcpll_d2   : enabled, 1, 1, 191999939,         msdcpll]
> [  129.371041] [ck_msdc30_1_ck  : enabled, 1, 1, 191999939, ck_msdc30_1_sel]
> [  129.379295] [msdcpll         : enabled, 1, 1, 383999878,          clk26m]
> 
> Add a new 'release_clk' label and reorder the error handle functions to
> make sure the clocks be disabled after probe failure.
> 
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

Please add the relevant Fixes tag, as this is a fix and should be backported.

After which, I'll give you my R-b.

Cheers,
Angelo

