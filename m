Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE82580ED;
	Wed, 19 Feb 2025 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001797; cv=none; b=Xkm4et2/Ngnsdzgmm3fH0AMp5RBFEpOvFvrCpG86rkNaATHtEaPBj3xTcEzD1qjhDkUqElWh/itDGsEvrEBagYQnufaAqn6n6neQbYR35fL5k+aZ+s9rntdGOcyKnhmq5rD8Yp1CHuNGgJ+itOAhEY0oz7SjlFsqPZfjY4E3XsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001797; c=relaxed/simple;
	bh=V1p1tT7UNLn3zJwu+41I707JUQAwN9RLXALKhZOBi0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S84hYeQ2yA7eiXzhbyFxDR6yJjNln26DSbbio91qYgwR42GfBISFB1mQtP/tzKeCktszqw79xlVnqpMIvUlm1dJK4QF8JxxwqIVMp9yBZsJr/mqA6bY36Pq881nY4dnoyNU70W4xDTcp/nFQ6vL/OfonO/qJ9E+FNdp06MLAMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSwWSClU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSwWSClU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A79EC4CEE6;
	Wed, 19 Feb 2025 21:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740001796;
	bh=V1p1tT7UNLn3zJwu+41I707JUQAwN9RLXALKhZOBi0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSwWSClUsLcb50H6wcw8uNxRz4rkMZZ7OBldjZF6ML75IG6C4tywp6GErrMbtAl46
	 yzRrDVY0v2WqoYCpEpicEw6QkYa7Lu7gbSIX0Is6cqSJSAkfEGvdEc1g4So+PjNm+b
	 pTADXkCwNmoRm7Y1qGn2AxsxIKxD4V9pv9Y6uDZmTq6WulZMyKUrDj0VDjYo0zGwA4
	 P8KLsiBrGvobF2g4LZP8mjqO5JhzeQVm3RTid+v+xbTgjaM2+6ek2UCfJHpfK/i/55
	 zKPVWsQ7+8W9GeXj9Zr2I3xG2d7DNmASWyAkIFH9wenBhfe47IqR02i0uLT2sTmMSo
	 qrw2tmgYHvCAQ==
Date: Wed, 19 Feb 2025 15:49:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: mmc-slot: Make compatible
 property optional
Message-ID: <174000172538.3013190.16324788737757814573.robh@kernel.org>
References: <20250212-mmc-slot-v3-0-2bf288207040@microchip.com>
 <20250212-mmc-slot-v3-1-2bf288207040@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-mmc-slot-v3-1-2bf288207040@microchip.com>


On Wed, 12 Feb 2025 14:52:10 +0530, Dharma Balasubiramani wrote:
> The compatible property is required for some vendor-specific device trees, such
> as Amlogic's meson-mx-sdio, but is unnecessary for others, like Microchip's
> DTS. To resolve unintended warnings for configurations that do not require it,
> remove compatible from the required properties in mmc-slot.yaml.

Please rewrap your commit message at the right length. checkpatch.pl 
will tell you this so I don't have to.

> 
> Since meson-mx-sdio still requires compatible, explicitly add it to its
> required list in amlogic,meson-mx-sdio.yaml.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml | 3 +++
>  Documentation/devicetree/bindings/mmc/mmc-slot.yaml              | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

