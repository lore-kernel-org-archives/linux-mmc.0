Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70819CC11;
	Thu,  5 Jun 2025 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103019; cv=none; b=BeqpkuCDliDIhedoXmJ+28wP6KoH7yDADLELb8m3iMUZt03WjvnEtNJCeWFiwm2iioDrDrplijRKOvch5MpLMPL+Yt0MxaA6PpQN+AFF1f2d+hnRByaBIzIT/GVxuwhrNQQSpmf3graf3UPg/4C08H56z/P9CuxgMc5FGxFpBE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103019; c=relaxed/simple;
	bh=WkkGM08VMW5SFQ/+XIX9f/SVjIxnmSZqqyIBTfQ8hC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3l67iWc/u0iMGyVQ3OxZzKSedLr53TN/rEfqx3cxp2tl/2QPQpFd4t1VWh5RWrpH/rTFeQF0BHODJMM+Cs3IcCFpPJ0CerYgWQW9Hg+ouhENnFkNeSXcnwN0NAmr2anib7HaqwSUJZ1f6zb8HGm54IlUI3PKs1lp1rLpoxAwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D96Hid6K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D96Hid6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749103015;
	bh=WkkGM08VMW5SFQ/+XIX9f/SVjIxnmSZqqyIBTfQ8hC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D96Hid6Kq7JQS22naS6+/J1Gkoyyed/yJCJAXYhRomHGd88EpOq8yAz7u5mfEQb7N
	 E6YbQBMT0iTOrL4EVumEKOOji6CTok4mZqPDP1Ng0VI5rUrFjAgJ1FdmRLew5Z5cYP
	 drDyKTf5/1/E6r5vN5DdOTy/6j6u9gvjN/Wz0kqi4JcYht0PmSodjHV+VHtL4zzrCU
	 y0m40domMY+T8E2H6i9A+vL/zZzBAHhbe7og8/uKCDp6xCEWqFChcU9AmZamASRHVJ
	 BpvccimnTvVV3IyLv69tOEsAQQ8zjG13PPnHoW3Pb4opcT16e9DoQo5m/qUE0/Y24S
	 NPbKP/DBp/fYQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0361C17E010B;
	Thu,  5 Jun 2025 07:56:54 +0200 (CEST)
Message-ID: <f40e7b31-5bb2-4d1d-8687-6f728ea255be@collabora.com>
Date: Thu, 5 Jun 2025 07:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtk-sd: Fix a pagefault in dma_unmap_sg() for not
 prepared data
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <174908565814.4056588.769599127120955383.stgit@mhiramat.tok.corp.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <174908565814.4056588.769599127120955383.stgit@mhiramat.tok.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/06/25 03:07, Masami Hiramatsu (Google) ha scritto:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> mtk-msdc driver causes a kernel crash after swiotlb buffer is full.
> 
> ---
> mtk-msdc 11240000.mmc: swiotlb buffer is full (sz: 16384 bytes), total 32768 (slots), used 32732 (slots)
> mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=18 arg=0397A6F8; host->error=0x00000004
> Unable to handle kernel paging request at virtual address ffffffffc0001fc0
> ---
> 
> When swiotlb buffer is full, the dma_map_sg() returns 0 to
> msdc_prepare_data(), but it does not check it and sets the
> MSDC_PREPARE_FLAG.
> 
> swiotlb_tbl_map_single() /* prints "swiotlb buffer is full" */
>    <-swiotlb_map()
>      <-dma_direct_map_page()
>        <-dma_direct_map_sg()
>          <-__dma_map_sg_attrs()
>            <-dma_map_sg_attrs()
>              <-dma_map_sg()  /* returns 0 (pages mapped) */
>                <-msdc_prepare_data()
> 
> Then, the msdc_unprepare_data() checks MSDC_PREPARE_FLAG and calls
> dma_unmap_sg() with unmapped pages. It causes a page fault.
> 
> To fix this problem, Do not set MSDC_PREPARE_FLAG if dma_map_sg()
> fails because this is not prepared.
> 
> Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

