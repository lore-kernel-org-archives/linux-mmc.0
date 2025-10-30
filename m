Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD272EC55B;
	Thu, 30 Oct 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842969; cv=none; b=aLcVR2KeqU7q1yl6M1/g3NTbd+8GcOybqfASvx0xflHfP0d+Fc8i+nE2HjCyDjS7nVrutY4Et380DeHEzPvO/ujPj2JaiFdr9mP8m3Av+1YGBp6T+NB2ItLO+GrAdCR4SZWCDbdlqv2jAJEG+8zDKMFffhGCZ+lWVxPCpXgNAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842969; c=relaxed/simple;
	bh=7VQ46Vi+I3aZ0Fv1Chak1rm/T77YzQd7N0m61VOYC0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyFgvviYBO7Q+T2fydD9ChNdRJ+ZNic9m26tSIV3TzZ6DKNmiIq1fCct2inSwCHea0KjEAvks8dlvl1pmi2hwZdYUVgFxerJRfQo2LcwImwdotDmT0uRM/+HAHXOcP90+H2nLo5/PvyxAnw0QRjh7TcYBQDese//Tkmg7rtMoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtPn/Clr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtPn/Clr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DD5C4CEFB;
	Thu, 30 Oct 2025 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842969;
	bh=7VQ46Vi+I3aZ0Fv1Chak1rm/T77YzQd7N0m61VOYC0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MtPn/Clr354rV52c6Q6wMLQQdsuYH/7nPFqC6BrjTspxq/uLL5JeZd7xR95oNllUG
	 pk3MN+B9ZV8GKITZxy4a3BgKY5ykqXBlCXyB7U8dVoya5hBfO3xQPS56lHCy6O8GWl
	 FaQ9n9XKNd5as2r8qt7hlEOQ+iCADjC+7MipbNCi120NMgzi7wJbdOWpRhitS7VDBl
	 u4YpA6ghe7TjEGJekPIidK1D5ck8fpHpdN1XqQ2L/SQGRumcaIGxgjdosSZ+7DZ2b9
	 h6q2FB09k3/Ttyq5C+JehIcJ7r+6V+ZApYpAIB+JsC9nPknptFAFLEQgei2G+uFKea
	 r4gklLP0mhw1g==
Date: Thu, 30 Oct 2025 11:49:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Takao Orito <orito.takao@socionext.com>, linux-mmc@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0:
 convert to DT schema
Message-ID: <176184296394.4162219.4477625887711205247.robh@kernel.org>
References: <20251027-milbeaut-v2-1-9e1954ff7708@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-milbeaut-v2-1-9e1954ff7708@gmail.com>


On Mon, 27 Oct 2025 16:46:16 +0000, Charan Pedumuru wrote:
> Convert SOCIONEXT Milbeaut SDHCI controller binding to YAML format.
> Add a new property "voltage-ranges" to resolve dt_check errors.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
> Changes in v2:
> - Change the description for the property "voltage-ranges".
> - Link to v1: https://lore.kernel.org/r/20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com
> ---
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 --------
>  .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 30 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

