Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B1149DE8;
	Mon, 21 Apr 2025 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271564; cv=none; b=GstvfhGUIYNVnnNGCPSTc0n3M3JAK21q6o9izAdJ7Dzw+5lbRwXbIlx8hfdMW/W8SAuM1J6JJxjiitrEqg99qMkfRdUNl8U7FKQcDkUS6iL2m9GRpjuOnXVZW+e+tpGhA7iwMFFipz23MRoadcGvrt6rU5cUkUhBQlPjkQszf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271564; c=relaxed/simple;
	bh=BNmQHNDxjQ4r1bN5ceeqHglF2FJStQxb5I0K3hD/Yjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTN2eafNPBSxGWHZAUFquEl0Nz9WGrz2uU20AZppYulUShDDh9J0o+DJcL6XUw3zjmomw8oWzvmKIucMU1xRz3SkfghQccWHRIzLLAEZ7M4SS5H/IeaMvVNk2dR3JfM+kNMJzcxhpte/v5/L95PpQ63e0DXdIgEaS5iW07HSggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygxy/+f+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygxy/+f+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933B4C4CEE4;
	Mon, 21 Apr 2025 21:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271563;
	bh=BNmQHNDxjQ4r1bN5ceeqHglF2FJStQxb5I0K3hD/Yjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ygxy/+f+us2VIsWP5tF9hAopq+MBToFgYbuJXY+9OAZ62xLdfcy7CogW4t/3P3/uB
	 4m7zb54u10G2RTiafk68fn/9UwSKh14QcJog8q5fXdB4I21oWXjA1+3dzp46w/r1lU
	 EJItI4Ybm8C7VrX6OecBOw59BfGYJxb9gYd9DlujkGOBZJS8xz3HcvIwteBJIr5wR2
	 Y9ZDxE08Ypi5UF2LR9OXjS6nyc2Q3Kzdrx90GgNl2P16I0FWFLW7UT5BVVKvJVq6+K
	 wa0QoKr5syaYHq+XlqaRr7gd+daNYusEJ1rqynMcR0+84luepNLMrED81T4vAFPGBy
	 GkSexJUmmlxmw==
Date: Mon, 21 Apr 2025 16:39:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: wenbin.mei@mediatek.com, chaotian.jing@mediatek.com,
	linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: mtk-sd: Add support for Dimensity 1200
 MT6893
Message-ID: <174527156151.2973998.9852318001986778818.robh@kernel.org>
References: <20250416120245.147951-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416120245.147951-1-angelogioacchino.delregno@collabora.com>


On Wed, 16 Apr 2025 14:02:45 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible for the MediaTek Dimensity 1200 (MT6893) SoC.
> All of the MMC/SD controllers in this chip are compatible with
> the ones found in MT8183, but do also make use of an optional
> crypto clock when enabling HW disk encryption.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

