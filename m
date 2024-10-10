Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73721BD00C;
	Thu, 10 Oct 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562734; cv=none; b=n448bDDsp3Xar17DcjBmhhVvZ7DQZDIkJX3KDEzGpujUCzECtpghg5JDZmJcPMd3sYrsMUMW2U5XAme2DEkM5XG7aoHPY415Vp7HWQocnLa+3/H7s2vq6UK0ZlNZP7VonNeuwnZVBl9WgHl8J4VTxgWYJ1rPHDw739as8UgY44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562734; c=relaxed/simple;
	bh=0SgFBZq1DXQEdllYhnVxjf6h8WU7ai6jQWuuA5GI3no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrwB47S+2ghJfbRI9ajVrvV8SthRab9zQ5lvRhhzRaiYVPjGi9OrS5Ayx9oyvM6jhKOccnssnKRw1HvGfIUIxjz77qirC+lyk1y++bAPRm7t/6Far1Yvz7cTXCk1TfftRP3qIXx+VK/u5+VZFtIKJHLNi9Ww5NJVYS14CkDzafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fCLZcSCb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fCLZcSCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728562730;
	bh=0SgFBZq1DXQEdllYhnVxjf6h8WU7ai6jQWuuA5GI3no=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fCLZcSCb8qYWPh6Fy/5RHA/kRCTXQlgsDLGRXw+oKuwhfc9OI5zJVIAUu52Q9NsN/
	 UI4iDHNOWHyk0+wocC+N1fYx+6Hk0Gkhx2GAyvJtRrXsavPwTwtH6cUJifgNvmkz1k
	 4dT/vdW1RDvyJ+KSSlxCtCgmeMjtYEb+oV7j6t3DZ/ohzB2ikylh8eiiVbCMfGOL16
	 HX+HkCFiCOGhkmFECL3XrVBc2zh0CmLWDhXoWkPrTcCtZ+ODxXa1+7EXvDIJWfONQ8
	 Le82+W/Hhz5GcQRBZOmJKWIcU9HRhxtoQYwa6cTTBU4riIpucTRiHqO1DTpEads1i8
	 iaLvBwRZg4IlA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6863A17E35D3;
	Thu, 10 Oct 2024 14:18:50 +0200 (CEST)
Message-ID: <5ac376ca-f57e-4913-86f0-4fd2187a6952@collabora.com>
Date: Thu, 10 Oct 2024 14:18:50 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dt-bindings: mmc: mtk-sd: Add support for MT8196
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
 wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20241009120203.14913-1-andy-ld.lu@mediatek.com>
 <20241009120203.14913-4-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241009120203.14913-4-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/10/24 14:01, Andy-ld Lu ha scritto:
> Extend the devicetree bindings to include the MT8196 mmc controller,
> new tx/rx would be supported from MT8196, and the register settings
> of STOP_DLY_SEL and POP_EN_CNT would also be variant.
> 
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


