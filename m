Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BD1C2DD5;
	Thu, 10 Oct 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562719; cv=none; b=tPAetbckz17xpL+SyRpcacZLJQyMuBV7+OAG/xyLNXFg7FucWYvNA73fn310a4KIGCJI5ic82fvZZrF3dDwu0VVO8O2d5NV9gAWHlP4QuKbHElmGvZRVFCqhris2CXcQJAQJvL+fT1Td5GEgtxvwO/4CVzqBfybzI2LUoxtGLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562719; c=relaxed/simple;
	bh=7mVO+Q2NM9BxO0G+EAB/pC5UV/aXW0JAPRm6LLt+jx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kom7nkJZJ7WRgzjLLrBzTkTlTGY0nwFU2zP0fRCD8II03NeZPnJhCLeuyHSwID/E942Cakvs9w/jdLy6A2aQnWw+rx0FtDIdvTPGuhk+V79/XD/yx++W6pNR/RV454mBOnD4xRjn2hzn77YUi6PXWxt6kXufzA2GbwGh1sDQ2yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qTsGLx+o; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qTsGLx+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728562710;
	bh=7mVO+Q2NM9BxO0G+EAB/pC5UV/aXW0JAPRm6LLt+jx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qTsGLx+opuXFKj12eQzsHTxyIP/LLgguivGFKkljRYfcyxWwI5bPbNOBwoxYeRSD4
	 2u6yHV/MV3hYCVkwNMZKKptu8m4G4GECdGHK6OxandnKl78maabQmsR4fTzalhvf1d
	 2lwsp1aAGS9A9J9FTzg9Gtf/kuosiFgKLpG0YNaxRrWBTini2UIVWbJqEVTsKMG+5/
	 y2l2DAFRzCp4nTXgO+ZBRtyYck3PYNhkUnIZDCnoyLovURRtDuQEiMRk8QFuGgAoIT
	 CPE7SKv7AiJr6Cy7q2VRHQzXI+Poj01ot7B+5GtqOodR6c2TbWcElv4xnfwiUmf3g9
	 u1KXVaTauprzw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1E92117E35D9;
	Thu, 10 Oct 2024 14:18:30 +0200 (CEST)
Message-ID: <c18f8d23-ac54-4660-adce-0e8f7ab53fba@collabora.com>
Date: Thu, 10 Oct 2024 14:18:30 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mmc: mtk-sd: Add two settings in platdata
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
 wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241009120203.14913-1-andy-ld.lu@mediatek.com>
 <20241009120203.14913-3-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241009120203.14913-3-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/10/24 14:01, Andy-ld Lu ha scritto:
> There are modified register settings for STOP_DLY_SEL and POP_EN_CNT,
> with two new fields added to the compatibility structure to reflect
> the modifications.
> 
> For legacy SoCs, also add the original value of 'stop_dly_sel' to the
> platdata, for unified code setting.
> 

mmc: mtk-sd: Add stop_dly_sel and pop_en_cnt to platform data

that's a better title; then, in the commit description, you should describe
why stop_dly_sel/pop_en_cnt is overridden (so, why some SoCs need a different
value for those registers).

Also, this commit should come *before* adding support for MT8196: you first
add the two settings in platdata explaining that this is also done in
preparation for adding support for the SD/MMC controller found in MT8196,
then you add the acutal MT8196 support.

For this commit, anyway, the code itself looks good.

Cheers,
Angelo


