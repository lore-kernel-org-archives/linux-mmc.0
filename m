Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BE236430;
	Fri, 25 Jul 2025 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486555; cv=none; b=SAoWvIz1+sfUqdowJc1fMJD3gC3o3D68aqqf3ue/2Hcm+nrt/zPW67NxYnJOSbuEVLH/DzQrWV4W7AjRwBxEVdTJnZC/tHAhN7G/wGgJiNqU22o9E7VsV+C79yTvDUhS85jelLn8tAHEFhxn7ZD7EVWt/ur7A5VrXyWR1Xro5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486555; c=relaxed/simple;
	bh=Z2ML6z3GECKPol1IXrz6zBSrJw03TCZ07Q4UlyVizNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxn8mYRszLP4qcjttPX4fhORi67wDGjsm7fnkmDOvOQD4AMjtn2G/0fDg8dIXc67dsQNAzgCoA3Z2JWm8w27pPMQF2jJV9zdcazBt9NgSga9MEP622kQm9ZpNdhKkDKg4vyexjVXdsZGbe5EpfdXQONnuwx7voInu6tGueuz/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7FsWj76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7FsWj76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1414C4CEE7;
	Fri, 25 Jul 2025 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753486554;
	bh=Z2ML6z3GECKPol1IXrz6zBSrJw03TCZ07Q4UlyVizNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7FsWj76SMCHaskzmoX/r6i35XPPGoRN1Kl8VCcllEJ8ZDz+29HKpg5wcaKToXT4P
	 r3UQ6rUnBHLBPuJCxe27pGUpmz7ufMWGbN+XCXmOljnJJ7S40D09/0nwcM7+AnA3zL
	 zKzB34v5F/HvtPK6gNi+X8r63GsMGa8LwTrsm+/ekWDGTlnfMd47mF6sNLPYoMB7Iu
	 tFpITXxs1OlCgHcHmGLtR2+0gvGz1KPfX2KpBm4cqnBp0RVpl11a7VHGWBzrYMn1PD
	 rt2h+RuwB2NVAKflq36KVuJmipJlDNlnu7nWfcZqj5KdazGqCr8qMpnnkffJ/sh5LT
	 Y5s/LHZUNEYUg==
Date: Fri, 25 Jul 2025 18:35:54 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: mmc: fsl,esdhc: Add explicit reference
 to mmc-controller-common
Message-ID: <20250725233554.GA2028042-robh@kernel.org>
References: <20250725060152.262094-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725060152.262094-1-alexander.stein@ew.tq-group.com>

On Fri, Jul 25, 2025 at 08:01:51AM +0200, Alexander Stein wrote:
> Even though it is referenced by mmc/mmc-controller.yaml it still raises
> the warning:
>   esdhc@1560000 (fsl,ls1021a-esdhc): Unevaluated properties are not allowed ('bus-width' was unexpected)
> 
> Adding an explicit reference fixes this.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> I don't know if this is a tooling problem or whatever. I would have
> expected that mmc-controller-common.yaml is added via
> mmc-controller.yaml. But apparently this is missing resulting in the
> given warning. Hence adding the reference

The issue is the nodename. Since validation of it fails, the whole 
referenced schema is not 'evaluated' and bus-width is unevaluated. Best 
I can tell, that's correct behavior for json-schema.

I guess this is an adequate work-around.

Acked-by: Rob Herring (Arm) <robh@kernel.org>

> 
>  Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> index 62087cf920df8..f45e592901e24 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> @@ -90,6 +90,7 @@ required:
>  
>  allOf:
>    - $ref: sdhci-common.yaml#
> +  - $ref: mmc-controller-common.yaml#
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.43.0
> 
