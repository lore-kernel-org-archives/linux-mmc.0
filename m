Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4660359F93;
	Fri,  9 Jan 2026 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958149; cv=none; b=qB7Wte012bKE2WqCNxyMQJ/W0rgVFN8qm3QixLknpU7aKb+wIvG17pzQbYKpkceloTdJ+ByILsxh/5c8QBdJNJPCDPM09U2blx2RGICTebT5bIP5k0iN4xp/JTAxxgOPRVYSoF10XNpb2TABjWLb1Oh8SEsF9pAddaKWAfFC3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958149; c=relaxed/simple;
	bh=uuvtHWXbur4b3UNiVol3kfUJOuEa5Q/2AL1FzGgXs48=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=skO0gjwycsZy9zjzwqr4GVHOMUOzz+BUjHJHcrp9DzFGp1TCp3Qc1NndwU4VGKm/Dise8wyhPT/kcLR+LCxqGNDLn7lijrXshEkUxSEW6IvwkrIWiGVmj9xut9oUFo2vmOaT194ayBeFHbCWJ3Wr+jnvzIk4MZuqMDt/lXaRcpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW5xbNLB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW5xbNLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BE8C4AF0C;
	Fri,  9 Jan 2026 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767958149;
	bh=uuvtHWXbur4b3UNiVol3kfUJOuEa5Q/2AL1FzGgXs48=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FW5xbNLBDmErOr6Ze5BAvusMexofgauPk70Ccu8+L6xSAvXOW+UrTddAEucxw7/zs
	 R57upHBxrHYe9aOFaKroXtLzUFVkA1gKnzwmfTJqY0/PcPMvx7e9AKBgv/edAkRE2W
	 M0IIBjbS5dhEwRW2VyAHJkXK+6b78O2VNuIZqSKeRCS05kNuGf0rYbF6cyxug0JClw
	 OoHOzvoVA3aHcZb1jtfd4DweYlUgKNphNreAzyBzb4+gKHuG1PE0O+K/J+/eN6g4za
	 j93/js3oFH7PvoyxwCFzN7VLQ06ZRkH8hACeikn0xmkOW/W+Swr2K60xQt9xWUczXP
	 3FclL3Mu64/fQ==
Date: Fri, 09 Jan 2026 05:29:07 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: SriNavmani A <srinavmani@axiado.com>, Vinod Koul <vkoul@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, openbmc@lists.ozlabs.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Michal Simek <michal.simek@amd.com>, linux-mmc@vger.kernel.org
To: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20260109-axiado-ax3000-add-emmc-host-driver-support-v2-1-934f1a61f7c0@axiado.com>
References: <20260109-axiado-ax3000-add-emmc-host-driver-support-v2-0-934f1a61f7c0@axiado.com>
 <20260109-axiado-ax3000-add-emmc-host-driver-support-v2-1-934f1a61f7c0@axiado.com>
Message-Id: <176795814783.2967277.2609413382098901076.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: arasan,sdhci: Add Axiado
 AX3000 SoC


On Fri, 09 Jan 2026 17:46:25 +0800, Tzu-Hao Wei wrote:
> From: SriNavmani A <srinavmani@axiado.com>
> 
> Add compatible strings for Axiado AX3000 SoC eMMC controller which
> is based on Arasan eMMC controller.
> 
> Signed-off-by: SriNavmani A <srinavmani@axiado.com>
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml: properties:compatible:const: ['axiado,ax3000-emmc-phy'] is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml: properties:compatible:const: ['axiado,ax3000-emmc-phy'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.example.dtb: /example-0/phy@80801c00: failed to match any schema with compatible: ['axiado,ax3000-emmc-phy']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260109-axiado-ax3000-add-emmc-host-driver-support-v2-1-934f1a61f7c0@axiado.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

