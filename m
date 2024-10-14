Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7414B965;
	Mon, 14 Oct 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893848; cv=none; b=Vxhn+3HJVGIXUiof5p60SM9wYUdxEqno8n1db2b4+9LQffeLnGqsTFRBQpbj4BFpgrGoKf+rgoLP4DnBSohoIfGbqDGMu2Sb4DiE/sInTnbL9EhhrZtipvxSZX8h0bkKQHvg28j8EoQIBMdy/Dd5C5b5dPSwXGpaLavcBMMtqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893848; c=relaxed/simple;
	bh=f13sm+4uAzEq1nYOwS44NWG9Bv7vNyYaIcfkBEEaAh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdT1gdsBjEsUdmc1lxvW5gMPJwo8GqM9+aDgbpA/cEYpMHWG16q1HPID5Q3Usw4/OrWjzekJveYt2QuhYtKHrnoVJMq9+fOcHDED94jQN8lykUfkF/1UzyJK6OB36euIOiQdH4wVc47qzx/3w2sR130Ew3IYN/ZF2SXxyv4l9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A+XkYBCx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A+XkYBCx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728893845;
	bh=f13sm+4uAzEq1nYOwS44NWG9Bv7vNyYaIcfkBEEaAh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A+XkYBCx33szv8j7fB/jBYhcRPUdNnN7j/bnNgbTpJu8toCYyTsSN1fRTYXL4VJZQ
	 89LlFbZDdwlLiDMP8xmdLZyOwNorGH9hKzarNujhojYpta23Rsx5Aqz+SUquvpkinS
	 iAxqRgzjjZcoBtwKoWP68L4nKydG9GZSNxDRx+z6NXMOmIZmqJvVLWHyXfopRGVUnv
	 XCGoGmz2Z4N4U45tPsWhvDIqUCU0HVprNAX+W9VKxz91yp3xkZG84PBEtK3gaZSdsU
	 FArlb9AWvrhm8WO9eRxEFimmjAtZYNK4hicFHY9qtg87upLOIoJor00O7j6Qdk6rl5
	 VrSA49AN5Dsfg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6621F17E10A0;
	Mon, 14 Oct 2024 10:17:24 +0200 (CEST)
Message-ID: <ebc3b026-2ab5-4c78-9bb9-b8e7dc2c4731@collabora.com>
Date: Mon, 14 Oct 2024 10:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
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
 <20241012143826.7690-2-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241012143826.7690-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/10/24 16:38, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add binding definitions for mmc on MT7988 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


