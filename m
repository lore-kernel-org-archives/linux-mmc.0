Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A468200B93;
	Thu,  7 Nov 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982602; cv=none; b=YWLBRD/T+G4Ct8FZ6/QHgHYMAw2elxemVIkGopcIcn4tcMNKp7wuwUfKxw5RdnCy/czaUI0rFv7roEZX6fRS0971wfzFVltxR6Uq6T5Jd2n0dYrybSAQOV4sYhobC8nkfCcw1gVSKYzexFbxkCPIUnzO6CKlsVOqKCQ035TKwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982602; c=relaxed/simple;
	bh=9UJ51zCp7wFqF/ltQGzkqv1QEUcQEdNvnUFBhAv+OvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF+IDDEFB9bCDVej/rNWdQt4BD37qA/5KE5DgGaWsw55IuwhRkw44PuC87KK2sChIHeiN8irWRwUsJ9JD6vEJcCFdYrFfL3KcVOZyj7NLSBiI1Ggb6eB2BH5ocnMAzGUHQNjVvNXdLYSY0b3vLHfd+Q8iJRhHXRdLkikkxoPLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TseUTXg8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TseUTXg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730982597;
	bh=9UJ51zCp7wFqF/ltQGzkqv1QEUcQEdNvnUFBhAv+OvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TseUTXg8aYui9PetXY++xfEKHvzIkL108Spbu+2pRgYESsPB/z0XT192r4r4XDDUG
	 rOUVEV1tCflaYxFHUPx+wvBjqjZxpUk0IKChZYjccyrOeotMc9cmfDWUxqci8YJvMx
	 vqFKvpllM0rdm9ifsMTTvx6aTwMtLaM9hq+oD3QKT9zmR+ppNy1PGoTlsNSRNwwbT6
	 CVhADPi8Gn4iN841t9T/o6qQyUmta5PCBOOpkzSnI0q8MKE8pVJhfGOEK0QCJ/hUu2
	 TSBxGbMOfWkHu0fAwbIja2WifkwbFep/f+HvocZcJHpEoaPjsqq5DTWLn0z5lVjvwB
	 IzUovG/SKhmcQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5ADE217E3624;
	Thu,  7 Nov 2024 13:29:57 +0100 (CET)
Message-ID: <451c8f42-f8eb-4734-a19a-1e9a2694ce34@collabora.com>
Date: Thu, 7 Nov 2024 13:29:56 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: mtk-sd: Fix error handle of probe function
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241107121215.5201-1-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241107121215.5201-1-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/11/24 13:11, Andy-ld Lu ha scritto:
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
> Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
> Fixes: 7a2fa8eed936 ("mmc: mtk-sd: use devm_mmc_alloc_host")
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


