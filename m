Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D718D64B;
	Mon, 25 Nov 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525958; cv=none; b=kWwCxgEYZf9iyowu5eppKZcIPDVDilpXTRdGswsPNXE1V2dVZDtQDkAJ2BZNr/UTC/AHRc2IMpFk7GtlgEgXvStSX77RK7TYP7Tto5ys9U/afTaYf9rTdC/hspVfoOQshiv1A1DQvdXiymRurz1U8yQ7UUmCcr9Q/Da5wVC5wlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525958; c=relaxed/simple;
	bh=FxMn6TL+VYIg036551yfzlt+21LR1IpuCjYwCyQ2h9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2ZtTUZqNHWuF2y1f+xZocHv/cm1FUcE/tchjO/G/cMt/jtACjTmp0wCCWmKxF0JNJeOPit5rXN+aBt4/HaXRAkQ7Zzq0Le3Dt8+X5tT+qusnmaXia5DOpipUzn9L8On7bT0lZcBVSrA/nEfVkDt5JHg65eJEtwd9uzI/fq/DCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VS3Yg2Fy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VS3Yg2Fy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732525955;
	bh=FxMn6TL+VYIg036551yfzlt+21LR1IpuCjYwCyQ2h9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VS3Yg2FyjgBl7sASXqV9u0a+4D4FICUlGvzEpmRjmjbwo05VWxWYv+t9ccs2ICdR/
	 l0ZVW1vwHn+knU1q3ebm0PO2LclYUeJIcK4dgYt4JnEQ09Fvq5tDP5xfVkmy3BmZmB
	 EKo4a1d5yVGuGfv46sr6jcBj6+qtJsgDyaw+WeSvH+s2Z37zjHODfb9R2E9a3HBUFg
	 QmuWz07c7o7KRDO84D1aa1/kNuw1In5aaCfFdD5glmbrcc5w0+UgbbmWf5pglrctMO
	 XcogWUjiGrRSxBgwgFtLLrut0PLr8h0VORSZi3bRIJXje5Z4YtDHqUhGicRAa0SsCK
	 100VXAqn890Wg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B68B917E1330;
	Mon, 25 Nov 2024 10:12:34 +0100 (CET)
Message-ID: <8b6657df-7813-4964-92c1-1a85b8390eed@collabora.com>
Date: Mon, 25 Nov 2024 10:12:34 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mtk-sd: Add support for ignoring cmd response CRC
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241123071006.14294-1-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241123071006.14294-1-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/11/24 08:09, Andy-ld Lu ha scritto:
> The current process flow does not handle MMC requests that are indicated
> to ignore the command response CRC. For instance, cmd12 and cmd48 from
> mmc_cqe_recovery() are marked to ignore CRC, but they are not matched to
> the appropriate response type in msdc_cmd_find_resp(). As a result, they
> are defaulted to 'MMC_RSP_NONE', which means no response is expected.
> 
> This commit adds a new flag 'MMC_RSP_R1B_NO_CRC' to work alongside the
> existing 'MMC_RSP_R1_NO_CRC' for the following process flow. It fixes the
> response type setting in msdc_cmd_find_resp() and adds the logic to ignore
> CRC in msdc_cmd_done().
> 
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


