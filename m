Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25101D47C0;
	Tue,  3 Sep 2024 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345724; cv=none; b=G4kHAIFTWS/oISXZFsWY1+2dNAAMmKUquVirvQIq+6zc/EGUd3NogEGsC0IodFG3cEx8d5iavhOc+WfXCAmgs8tcNTnjblj55hkD+ntiqlB6sc0G8FSiVmYyAd+dvbdQBAc8M8wca31MNhzkdCRw6fZhBaHh17WGZK0co9QhtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345724; c=relaxed/simple;
	bh=v5Mkeh5XuM/WtcNCeVglJVrRSD/xcF/Bp43vNtWY7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKxYZy3vzbepg1hh6RCJrsIdsLZGdc4Uv3JMJZm1EzFGVijqVDxr9f8RTAP6W9/iaxPasNR98MQPDDoMJfkU2elYcdQ4IfOc/2LdQZFght51XgmG/U915nLueX8OSbRsG2bwzPWAeF6W/jefV4wwyHA82m3IPCWEmYYf/V75tfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBkUiCeI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBkUiCeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69238C4CEC5;
	Tue,  3 Sep 2024 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725345723;
	bh=v5Mkeh5XuM/WtcNCeVglJVrRSD/xcF/Bp43vNtWY7UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBkUiCeIhWgNRp/VtK3XO9SMZXUDuPwyQaWRblQcZRjY+OrbmaiuUmsbteF/AmU2f
	 VCC73aqiug320bdUwgtg9rI5UbAQ7j+UI+KIVSuiTOwkB8q2HUsyC81LmO1u21tWQq
	 9nGbJNKu8Jj1kUbqTKrIX7kI76s/YUKvuIQENBdhNnaadupRHSzFD+c7OGNyZr7RmT
	 X3m5uIiZlA5vN0O3gUkJGBaRYIot5bzWkwOgZ0LPbsqiZjk/FAxT8pop/NqeMFa5lj
	 KN6qiUIf2dC/zVSuHfEtqaSW/MYh8Mk4hkg6mkbiZEEKG0kLu6pmCu/TDeEtq22/2M
	 ptn8s2AXVgHjQ==
Date: Tue, 3 Sep 2024 08:41:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Aubin Constans <aubin.constans@microchip.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mmc: sdhci-atmel: Convert to json schema
Message-ID: <wquehk3mm3izuqfxfyjovy7lqmtxycdj5sy5s3jzcjlgcdaptx@ybwlfp34qdpb>
References: <20240902-atmel-sdhci-v4-1-96912fab6b2d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902-atmel-sdhci-v4-1-96912fab6b2d@microchip.com>

On Mon, Sep 02, 2024 at 04:27:09PM +0530, Dharma Balasubiramani wrote:
> Convert sdhci-atmel documentation to yaml format. The new file will inherit
> from sdhci-common.yaml.
> 
> Note: Add microchip,sama7g5-sdhci to compatible list as we already use it
> in the DT.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> This patch series converts the sdhci-atmel dt-binding to yaml format and adds
> the sama7d65,sama7g5 compatibles to the list.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

