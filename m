Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E941537A8;
	Mon, 14 Oct 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891542; cv=none; b=eNOhnDKKhsjRbNx8B7OGjnS6o0+SLRxjgGr7iPKq5hsLrqsOuo4jIWflE2I9x38A2dGApJKh5ZVxJ7iRyzW1dGjleq2eW+j51rBVRHEwIK8mXU4+DbBy11/l7NFNIUFyvoNdbHyfGdbjZJBmcaTAkdlzlOtQ9J5mpy8zHuoV1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891542; c=relaxed/simple;
	bh=qoOrVX2qlw+79bRxKaouwZTrx5lgcm9sOHSXhAzeJKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhG3eQueXgX6FqI+uC4yXgs404KeBdssz1eCe1z22BpkkC+9/VP17ep+VsZ7q231MKpBxigWEAsmyID8uGBQMlRYHyY7rKa2KZs2/R3P8AdLlKOuZdoQTfbHgYwy+rOkkwAOCgt8Soxw7dGJwap7vK4lbJ9iR/9PgkNsy7UnN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ejGa/cLb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ejGa/cLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728891538;
	bh=qoOrVX2qlw+79bRxKaouwZTrx5lgcm9sOHSXhAzeJKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ejGa/cLbWqqWq/E+ZM31pk65ouQRFNTSnqIPWaJwU59j5v1u30Bph0gokY34TNmEM
	 UvBG+o0bzs8ZsQAqE5EMv0i+znaygkKwvclJTW+QktPNwOhhEMfceYVC9y2ANlA8/g
	 zidhz2H6OkWv7ub/SgJt2Zj2l9HXaZ2VK2gUOMgQD89bElPt4nVsa8ckN1rRbHH7fM
	 /GtPOSSZ3i6R1Ma+L9ExJsDnUfHwpKW4ZbxphBibCJc36uqYKTOsIToz73fRn0Mx3N
	 vClKUVYG6xAxH8y1y3Bs1fOGbmfQ75clwoF8Tw+O0LTqKqyguBLgf4haPLNgi56VRM
	 p7qGYANu2xWkw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 366C017E10AC;
	Mon, 14 Oct 2024 09:38:58 +0200 (CEST)
Message-ID: <1a29be6e-fb36-4ee2-9cc6-906f82159b9f@collabora.com>
Date: Mon, 14 Oct 2024 09:38:57 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] mmc: mtk-sd: Add stop_dly_sel and pop_en_cnt to
 platform data
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
 wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241011024906.8173-1-andy-ld.lu@mediatek.com>
 <20241011024906.8173-2-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241011024906.8173-2-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/10/24 04:48, Andy-ld Lu ha scritto:
> There are modified register settings for STOP_DLY_SEL and POP_EN_CNT
> from our next generation SoCs, due to the advanced chip manufacturing
> process and the resulting changes in the internal signal timing.
> 
> Add two new fields to the compatibility structure to reflect the
> modifications. For legacy SoCs, also add the original value of
> 'stop_dly_sel' to the platform data, for unified code setting.
> 
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


