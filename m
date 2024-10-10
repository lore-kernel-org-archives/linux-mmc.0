Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDD1BD00C;
	Thu, 10 Oct 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562719; cv=none; b=bLGaRuDaAik3YdV08j39R8QyAcuGQ0zHSC3NjkskVQ/O33INVhTtzCpQMRMNxrK+TVyUaBfO6/A6sClmg4PGFU7qdfg7OdjGYkrZ+ZLhgKDV7jy/6+7HPgMFbOO8orlcN+eJeCbC0cwHR67Vivo+DfdSQ/qvcgusXr3+qi3sAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562719; c=relaxed/simple;
	bh=dlS3N4sm++HwgM8cy2oVxD0eJfj9FmIbLmXxqAwARvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqSvq6PQRFfb9d7UgLHtnVeAW4KT6lGPWnDAZEvkgp2RffBWjHHxl/g8Ci2Yd6cxANmtsJrdwFrt9dx6pmk5cD1pGmbG0S1YI+yXaLtHoi3EjpK9Af+UojMRV8C9uBZq+Atj/VwxH9pj3YtaqAiqqU0/sfZBNw4wPObfWLaI8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R91QULgP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R91QULgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728562709;
	bh=dlS3N4sm++HwgM8cy2oVxD0eJfj9FmIbLmXxqAwARvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R91QULgPXsDhyiRfM1K/PAXASKH9sdmcb65nBDT9aISs/ga5uLJncc+1DekiMjGyu
	 nJUejQZ3cqCzIN34crh11UZ4E/MiNohj1AVlGeu6bt2l83x/tYRvs+rvYJhKYzNM6T
	 YTGhXTiuLmygfuBBLx/EFCV40A11dIbQTP1+qkHJpH0jrWMdfy12EGHU8j1KZOs7pW
	 2kNNwKwL5OjqNmrLzcQdKom1I2dd/BOHHFeVD4AP2+5nBwyx35QEDwTl6ktufcJeyC
	 hDUhCzabtoqCTp7L0Ox3Fo/uNkPz7jWn1ScnBaAHDkiu+c4Nb6d4eHuImewc/o0eqf
	 1UJJVmgosTDjw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3B8BF17E35D3;
	Thu, 10 Oct 2024 14:18:29 +0200 (CEST)
Message-ID: <3c8eac47-2baa-490d-aaae-b36a873ea5ee@collabora.com>
Date: Thu, 10 Oct 2024 14:18:28 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mmc: mtk-sd: Add support for MT8196
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
 wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241009120203.14913-1-andy-ld.lu@mediatek.com>
 <20241009120203.14913-2-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241009120203.14913-2-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/10/24 14:01, Andy-ld Lu ha scritto:
> Mediatek SoC MT8196 features a new design for tx/rx path. The new tx
> path incorporates register settings that are closely associated with
> bus timing. And the difference between new rx path and older versions
> is the usage of distinct register bits when setting the data sampling
> edge as part of the tuning process.
> 
> For the changes mentioned in relation to the MT8196, the new compatible
> string 'mediatek,mt8196-mmc' is introduced. This is to accommodate
> different settings and workflows specific to the MT8196.
> 
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

After reordering the commits with settings addition as [1/3], this one as [2/3],

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


