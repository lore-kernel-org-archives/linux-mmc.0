Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFD1865FC;
	Mon,  7 Oct 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331351; cv=none; b=ovN+CuG3Z6b+XC1lI5toe9yXqNoJxbdMY2aeSfj4UUTe9i2z8eVdeSDZUj2LKhSaVGC7UYloH5AnpbX3Ay4wUrvOghHmy38qIfg4+M882u0R8WMhhfsU83/+XTCW7zb73cUZwUXI4gcHXaRivDwxWVXWscMExM4AlGjqGyUKg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331351; c=relaxed/simple;
	bh=CM6TIaoUMM1aOKZxZbqPZyH9MnAjPn5Ii/dP5/bMWUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3wFFO+1I3osqzA6yOlqerSpHQGu7Lm6EzpKW1kx80uBpdKhAibz/Jlgkun/lsY0HsUPEnKTukemollHoqTUVjRDjL3WmCLQRRHB8q8w6vsLHvi3YINY1lm87Ct5e1sn5m1/kDbNy5+6snemnfpdwxJMdzWbBIAw5BDoo4CK168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=medooyt8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="medooyt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E258CC4CEC6;
	Mon,  7 Oct 2024 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331351;
	bh=CM6TIaoUMM1aOKZxZbqPZyH9MnAjPn5Ii/dP5/bMWUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=medooyt80R852gUZikPYEgpPcGVWBjImxv3bb3hfzTcP8tUjDd/18JXVfAUnB8fEw
	 GJKjNM6r/z6sodvqOqfORnGeUs45YgO7LRIvVJcrHQEXsM1v4e+tW6B842vfLWjQRK
	 4CruZa07hTD9LWmPpXA1qQB1Vogf7OgRmUTbNyG4X0y9WuUUJ9/5op678b4C55NQ9R
	 ZbPjgDJHDHrbzlj80gq0YSqSPDzsnvqjg+jfHM25lB7vM3mzY5xi99z1pyMXIgTCbF
	 c/39uaVuK/bsv8LV0zip2XKb7heTauc3n5+00IQz94Hj/HtzuUKaIYSo0y6gJsNYSP
	 Zc/8SUq7diNxA==
Date: Mon, 7 Oct 2024 15:02:30 -0500
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: controller: move properties
 common with slot out to mmc-controller-common
Message-ID: <20241007200230.GA2301832-robh@kernel.org>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>

On Mon, Oct 07, 2024 at 04:03:37PM +0200, Neil Armstrong wrote:
> Move the common MMC "slot" properties because they are shared by the
> single-slot or multi-slot controllers, and will help defining a simple
> mmc-slot bindings document with proper slot properties and nodename.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
>  .../devicetree/bindings/mmc/mmc-controller.yaml    | 344 +-------------------
>  2 files changed, 360 insertions(+), 341 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> new file mode 100644
> index 000000000000..e02d3cbcc271
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> @@ -0,0 +1,357 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-controller-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MMC Controller & Slots Common Properties
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description: |
> +  These properties are common to multiple MMC host controllers and the
> +  possible slots or ports for multi-slot controllers.
> +
> +properties:
> +  "#address-cells":
> +    const: 1
> +    description: |
> +      The cell is the slot ID if a function subnode is used.

Actually, this comment is wrong. When slot is used, this is still the 
cell size for the mmc bus.
