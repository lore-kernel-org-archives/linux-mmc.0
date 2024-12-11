Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422F236F95;
	Wed, 11 Dec 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909278; cv=none; b=QaU5ZIjlqB00WGENo6ZexNRb5oIMG4MdyUwvKw+hcJ9al712b6Nz+MR8F8x2ZPesDkcgtUW1nIsL4LPvtscyPQ7kywkifKUXPJigiGtusoZLPmC+Ex6+NQDPTqFqzFlsSX5KoS2WRr2luRaeKlL3My+D2IqpetIzBNS8TuEB598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909278; c=relaxed/simple;
	bh=++8RmMYTbi+Kmf6ldH+5k2GCUXkok9XGBckOUFhE07A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0Db8TogIC3t1/4rDaw48LEG5HrqKGfnnon8XC5ffohTXZUmmpYdMluwayKcVotp4tuaeWfvdEYaSThn9kLdwAqJmSgKdiYQpxM7K48DnPuWzwXnDbHJIT492taKHGFz7Z4UzwqYVswCRMHXe+9P+7yMel7eeSkoBq2OjkCk1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+7f3g5H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+7f3g5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FDFC4CED2;
	Wed, 11 Dec 2024 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733909278;
	bh=++8RmMYTbi+Kmf6ldH+5k2GCUXkok9XGBckOUFhE07A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+7f3g5HsQurGOZz6W0tx1hKYOkAqZ/GRHhZxK8iO9W1CfbwmFp0pUGcspfkt9fNG
	 f5eqY6wPeIXcGBHwZu2a28/SQsWQU3TBaiGmOacJJEgl4P0Q275sVp9qA3QXZqtat6
	 p2q6I8UXNRXB7bnZHdtgTMpITOfwf/Sbhvc/v+wNP/GV4O+7yR7ztevW+utXBJGc/s
	 oyOZAHA40asr0A8jxiG/gMaMIn+nJJ7UftyheUQTLONvSm5wuzie4VMSomInIYe4N6
	 W04hqqo9p2lp/RzcInGTtpg6bHyWTt1Zu0hikyLxJh5YHADYvrWGtl/AK0GCTFMgYq
	 XkVxA8y9GCkzQ==
Date: Wed, 11 Dec 2024 10:27:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	Frank Wunderlich <frank-w@public-files.de>, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Document compatibles
 that need two register ranges
Message-ID: <qgsqjp6bodaiwfzpy54vgeo7pkyhfpdalvt7qjkodosnec4v3w@34446achvtve>
References: <20241210073212.3917912-1-wenst@chromium.org>
 <20241210073212.3917912-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210073212.3917912-2-wenst@chromium.org>

On Tue, Dec 10, 2024 at 03:32:10PM +0800, Chen-Yu Tsai wrote:
> Besides the MT8183's MMC controller and all its compatible derivatives,
> the recently added MT7986 and MT8196 also require two register ranges.
> This is based on the actual device trees.
> 
> Properly enforce this in the binding.
> 
> Fixes: 4a8bd2b07d88 ("dt-bindings: mmc: mtk-sd: Add mt7988 SoC")
> Fixes: 58927c9dc4ab ("dt-bindings: mmc: mtk-sd: Add support for MT8196")
> Cc: Frank Wunderlich <frank-w@public-files.de>
> Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

