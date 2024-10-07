Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE51865FC;
	Mon,  7 Oct 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331407; cv=none; b=eCKuaBQlCfq9EtpsDZJrlTDEagYmc9K2qFpKCLJgROmFMDaIKMV4No6nH9HvUz5sH/UWyxmyfjfUZL5guR0nfQ+rQh7e8/fe20WLae+7u24u3CLcaCaq6WEyW5F3I9r1sMVJOy9p8NOQ7KBCwZuOpcj5Goft7C5DrQFeEC058mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331407; c=relaxed/simple;
	bh=j5O+U2Wf5jb18mZI8EbjFq9ouQqcd6aUxhkEQ1mPLDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWaH1Lde8WSp2RFR6ij82YGaUz2bapbW8QYnjvK8YQxDUpOAuQ5vvJ1XiMONFU7VEi1TPEoe0DPvN31Sg3IHzOkHV1PAN0m5vRXKFqjBNywt/L9JnWoibPYc5ZFCS6605H9vUWI8voiw3VyL48jSOCUTgN6qbv6fDKrCQQ70fZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snclByLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snclByLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749E8C4CEC6;
	Mon,  7 Oct 2024 20:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331406;
	bh=j5O+U2Wf5jb18mZI8EbjFq9ouQqcd6aUxhkEQ1mPLDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snclByLytfWbUTtVvS7VlGB15vrmKyC+mg7Mm32cZ9vXSOHnJVdxe2a8Frq/zG5Vj
	 mVrR1Zey10eEIIIcXd5/WqxLH9QYCnzzUVriJ2pvxBOpECGNXzranBZnsGKr7e5kBD
	 pUWSTqwBgft79zEkhsMOjObRG/N58SdvEeCUkaW6AnqNXwkBq6dK1CcqjzcBhfgyBT
	 eMoWSydyHOiVQtrogPa0f1QUNVuQS8MKaigAFf/EjEEg3apjBCweUC8i+C5gz+QTtV
	 UqwGAZTSZy8L0GO73ebySTxNQ6R4/rUnTHi3lM5c7tnqhVRVpRXljEYSXRJu10y94l
	 +KowO5EZ5ceTg==
Date: Mon, 7 Oct 2024 15:03:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mmc: convert
 amlogic,meson-mx-sdio.txt to dtschema
Message-ID: <172833140518.2309838.18262028940515731701.robh@kernel.org>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-3-ad4eb22c2a8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-3-ad4eb22c2a8d@linaro.org>


On Mon, 07 Oct 2024 16:03:39 +0200, Neil Armstrong wrote:
> Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
> bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 54 -------------
>  .../bindings/mmc/amlogic,meson-mx-sdio.yaml        | 94 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 54 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

