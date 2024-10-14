Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD13149E17;
	Mon, 14 Oct 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893848; cv=none; b=dIraeVgaaZ/xpMrHRfCIbPo5Xip0YkmSQWMc52wX/xFuzZ0JEVrIANtFCflOSFeSs21ioj5cCwl5UK/xjT0S2VkcxqLZ6ugvErEPcV3YtIpb478WCdcPirCIFJvFvYOmFV5ZLRHsGL1G12bsXZLgZ7bX1Qml2oCkogdkpw8vpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893848; c=relaxed/simple;
	bh=sNFeqUVKvAjl1nESjRTycC/DuOWjM4Q2qbImXt7rNCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnKUFkwIVEkhbiCDgpMX0o040tCKn5Fyqo7fRGISkSJjPRoaDQB4t7oJ4m2GC4PLjuzdBtK/UkKKKz+JlqF108vsUKOzX6peq4gPG5pNDaz+exUgmpNjdTkxAwlMZyaH5+PSZiF539PbVJ/mrZgL6cohpn9KQtPU5RPtnliDRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KOjr0eIT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KOjr0eIT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728893844;
	bh=sNFeqUVKvAjl1nESjRTycC/DuOWjM4Q2qbImXt7rNCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KOjr0eITABWUjH4C6qb6iXh8oG6INzI09Y6lJ+qV6b26YfZ7cqx41r/nA+IVIozK9
	 Sk0Ho0XJ7O3gbCCDp6q0s5uuHGW1+g0i11jL369gzd3WZSKUmdKfjTQUq40b6OV72g
	 t3H+Z/qrWlI1KhDTCoGISW3V43/1nFSNl2d/XPko9jB2LJVLAaN+8NG0t0cYgNyxhF
	 vdtGWqfXYPCuONs9k/CNm0j1dJsCPkH7VR1HTkK/eqGoUKuDf/sC20V8v55wmaw/AK
	 g2ubMXfEJg4lfBvRa+PloOH4A+nzybIdZlbJMY8tf5MlpMlWp9CQJEQqjzFGPju1eR
	 Qu2mRNvCM/oow==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 79FFD17E0805;
	Mon, 14 Oct 2024 10:17:23 +0200 (CEST)
Message-ID: <67f22131-d1fd-4da8-82a0-d756392cfcb9@collabora.com>
Date: Mon, 14 Oct 2024 10:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mmc: mtk-sd: add support for mt7988
To: Frank Wunderlich <linux@fw-web.de>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
References: <20241012143826.7690-1-linux@fw-web.de>
 <20241012143826.7690-3-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241012143826.7690-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/10/24 16:38, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add support for mmc on MT7988 SoC.
> 
> We can use mt7986 platform data in driver, but mt7988 needs different
> clocks so for binding we need own compatible.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


