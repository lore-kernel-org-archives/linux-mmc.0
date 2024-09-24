Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D408126C0D;
	Tue, 24 Sep 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209719; cv=none; b=nSkLpQ3qKcPS5RsZQz/6lPqDldXPAK4zHlYq1wGULMFH7BIuccyKhyB+4rWJ872j8ZbGCTDbo8CG/PPiNlT+BjpqaosDa6DWjan7I8aeyohzVoxI+tIi2qPnP09vzS1r7ntvo+ax4lsSAeE0SOV9jUdf8akw8DRaiywllxkjXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209719; c=relaxed/simple;
	bh=1BbBMtvhZrJTG25V2HSyKYE2CU7TM+G7e8UL/oziNG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usq7UPvuNYxNK53MUJV0wX+3EZaYWwjpM13lyWfvFLBh4x+oksclgyVGdfm5LEkFaAiIcMOu0d8lr1LqqeG/nYl1QJjlMq6SK7pMqtOb42nAkwxqgyMxOc2VVXtFoiezA7kQiXFplIfNk8R06SLzJcbpadFP3mV1VRLTA69DNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0J9MP8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0J9MP8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045FAC4CEC4;
	Tue, 24 Sep 2024 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727209719;
	bh=1BbBMtvhZrJTG25V2HSyKYE2CU7TM+G7e8UL/oziNG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0J9MP8fuBRMumjkooK26XsHl6GDK8uJ6+UdeLVRTkFRZYZqk/W4beOIYSzjYBGq0
	 REg/eMDP6D29upQ1cpmjIGo1cwY6DwMQjuVow4QIgbL+nqw9zaoBoBfV6y6kQ4aFCK
	 QHOp5nvz94CICkKDz9oPoSkoeguhLlIGwZY5xoGZ1oo//9DsgtEFcZug4QJuaW/6AN
	 ZErcfvOBFri/V60jdyf2KMU+TZr+L6mAbU8oFEmsTzRNhxEnERJdST+svLH9eVi8bx
	 eTigUAcZa58/3lbKn1CcB/CSBlhpDBD/X8biDdDmic9s/j77VcL6Sh4TCrwond0b50
	 M1gNnys1hTCVg==
Date: Tue, 24 Sep 2024 15:28:38 -0500
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
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: controller: allow node name to
 be named slot@*
Message-ID: <20240924202838.GA276949-robh@kernel.org>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-1-5aa8bdfe01af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-1-5aa8bdfe01af@linaro.org>

On Fri, Sep 20, 2024 at 10:38:03AM +0200, Neil Armstrong wrote:
> In preparation of supporting the mmc-slot subnode, allow
> the nodename to be either mmc@ or mmc-slot@
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 58ae298cd2fc..f797c32ea688 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -20,7 +20,9 @@ description: |
>  
>  properties:
>    $nodename:
> -    pattern: "^mmc(@.*)?$"
> +    oneOf:
> +      - pattern: "^mmc(@.*)?$"
> +      - pattern: "^slot(@.*)?$"

'^(mmc|slot)(@.*)?$'

But the description says something else...

In any case, avoiding 'oneOf' when possible makes for better warnings.

Rob
