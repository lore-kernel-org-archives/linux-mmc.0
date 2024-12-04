Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E3205E3B;
	Wed,  4 Dec 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321740; cv=none; b=BTxkc8sUOhGjsVOljAUEcCdpoIO1kZm487NwPw7UOajzskmxHxp/LOfkjLbZg4E3gUvqYwA9ARdRbpbk0cL0F4tI3/xtJQZxyAl+JLW3U49qfNNYpj2Tl/gcZWRZpWTAyA9wtxq3n0lUIPdDzBxHoEU3BBjZIl+a8zOpziMziP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321740; c=relaxed/simple;
	bh=dkmyXph1LZLtubmC+Y3gSWPwY6XxfO8QFNuBW9+XxDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/5ccO199/0pGiWT5LACLQNWSDBC+ndPq1KJ7j4VE3eiOx1kMkL9wIi8pQljeds+uKl5jYbUsmZV9tg0NOqaynSkuiPLJbdv+tp2tmdIWg9/MAMPH2cAjBfZ78OPOPwxCYizBF94SC5wxOz9h1FYR0VBzViDrKeDmdqBGP+//uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+zJ5Drg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+zJ5Drg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EEAC4CECD;
	Wed,  4 Dec 2024 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733321739;
	bh=dkmyXph1LZLtubmC+Y3gSWPwY6XxfO8QFNuBW9+XxDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+zJ5Drg3iDsdHi1dyoEx3Gj47WWJNUMH1/tSQdHxH2wJ5ilJeW81PK0917pSkpng
	 jKbllMC7sTZRpYu9Ss86d0dz38y4qKFvzEID45Tt8TQL3jtE0Xe3zVNFqmYS4SW/L+
	 uuYaDcrY0mS7QqpDmpU+cwd6CJJpBoL5ITmT7wyAaDtAGlnl+tyDlEmSHQJULB4Fyl
	 gB6a0Q+eni1l934lXTKsFTSpXVuWpjEkE7Z8qobKhiRSFV5biMmUKKWUOI/kBa7qsr
	 6S6OT9viflvMwzEjCJyfoa/FPKpg8l+5b/ZzxYVaXYs1fR9d2s8hZj7J2mDj1ZrFgu
	 g4ajx28u8d9XQ==
Date: Wed, 4 Dec 2024 08:15:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 3/5] dt-bindings: mmc: controller: remove '|' when not
 needed
Message-ID: <173332173692.169425.77201239393030979.robh@kernel.org>
References: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
 <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-3-11d9f9200a59@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-3-11d9f9200a59@linaro.org>


On Thu, 28 Nov 2024 16:16:43 +0100, Neil Armstrong wrote:
> Adding "|" is used to keep the description format, remove it when
> not needed after the split into mmc-controller.yaml and
> mmc-controller-common.yaml files.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 6 +++---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml        | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

