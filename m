Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iOSzA8mj"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3241701;
	Thu,  7 Dec 2023 04:38:03 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C5356607394;
	Thu,  7 Dec 2023 12:38:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701952682;
	bh=hb6z2Q9CYyAeDNhwbTzdfMk0lfdKi2GgZN0PWnVEr7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iOSzA8mj3cT7Vug+lBFst481/o3Jw4y8+7P/jZnj7NAenxNxL3BmwAdje2a+4uv9L
	 hWMUqjaOmgEKfErzODvCOQSHVcJCdVsLAUyN6S+fy/KZLmkbWCD2ekUiUkeXCfB3Ez
	 +KpuytKTWzXg7P8LRckyNFogNCt59M1D95ZPEk6ukh7qvcaohEyrHdZxFOMcSCWkFI
	 KLTUaUNtGSZUgk8vhuhcOna5SYNPgBcFe+QlQfcW5b6m1aRDhPw6jWcSyB2iskUrca
	 fM3PQe0iDG9Ci5uRrS9wTzQfvNS6mLF0N6+bIHJl9LUOgyM0oFmKBRS+mDSTvVXcxw
	 GRh7d5kf70SHA==
Message-ID: <8dbd5913-8448-468e-b99d-6e3820ff0c72@collabora.com>
Date: Thu, 7 Dec 2023 13:37:58 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: mtk-sd: add tuning steps related
 property
To: Axe Yang <axe.yang@mediatek.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Wenbin Mei <wenbin.mei@mediatek.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231207063535.29546-1-axe.yang@mediatek.com>
 <20231207063535.29546-2-axe.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231207063535.29546-2-axe.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/12/23 07:35, Axe Yang ha scritto:
> Add 'mediatek,tuning-steps' setting. This property will give MSDC
> a chance to extend tuning steps up to 64. With more tuning steps,
> MSDC may achieve a more optimal calibration result, thus avoiding
> potential CRC issues.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


