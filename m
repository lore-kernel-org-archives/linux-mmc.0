Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85817CA17;
	Fri, 21 Feb 2025 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180159; cv=none; b=Vn8CkfZZ1Miag0YuCy4/rMzibFqqiDSlUUNlmgnCwC5fbdBL1rkip/PTvHAzEg/23LZYbQu3Dms5cUXGPZ/0mIY+BIXmMb4QmTwbIoNe++Sl4qXR3ZqLQ8l7Vu8kWsfj1ykRP6oBOFqWy6jEu9UQA2o54CDrKpx1Ng9tOsk+5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180159; c=relaxed/simple;
	bh=Ls0VCPw6WU0TZlYM1OzIs+8Ykkrhg7H9NnWWEP0Xyag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqsPaREAGIiThaEQCLX+3LfNSiLDObigPfZf4aOhYukvxerV4XjwE1aLdEj277gwQlovQkHRejmQ1YDuryNuYvh2/at80xstvpQLFCvVHP8X6gGSYp9P6oT8zGNFoAeRLFPd1syMLXqkOf5eN4YubLMrHZe3bDN9sYwmpqL4q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+QH+5ZO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+QH+5ZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E127C4CED6;
	Fri, 21 Feb 2025 23:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740180158;
	bh=Ls0VCPw6WU0TZlYM1OzIs+8Ykkrhg7H9NnWWEP0Xyag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+QH+5ZOCv6QtchBXY4LSMTLw34S1JpQ6P9gQlbei4rCZyikzFjCp4zGa9tiR3rw7
	 oxnhEEX3VnIscRnIxVyyZ+Ugc70bKpfYIERv4tcbaUWJmmmd9TOlvP5ZQVd/5w8kdQ
	 bXGM7TaOr8kherzsfbexPxyr+VA9L022UbN9VtkOCjVF/zqr8rCh3qDJuz9bczSiXn
	 YMH6UqUQmJRyWAZy3YgxSW2Sw1LNAYmE9uYwbnnqbU71dhHd2IXFd1/olVfeMWII2k
	 VgUjRCwfvLXCiAGevJn01LMXG027BsxtTQC1uoRCSA5lT5+Bzp8/1YJdYFW+1/zUB4
	 5d9lFcR9ZSmmQ==
Date: Fri, 21 Feb 2025 17:22:36 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, shawnguo@kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: Change to additionalProperties to
 fix fail detect Unevaluated property
Message-ID: <174018015606.370492.13150603004835486045.robh@kernel.org>
References: <20250220164655.2081224-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220164655.2081224-1-Frank.Li@nxp.com>


On Thu, 20 Feb 2025 11:46:54 -0500, Frank Li wrote:
> mmc-controller.yaml is common schema file. According to writing-schema.rst,
> 
> * additionalProperties: true
>    Rare case, used for schemas implementing common set of properties. Such
>    schemas are supposed to be referenced by other schemas, which then use
>    'unevaluatedProperties: false'.  Typically bus or common-part schemas.
> 
> Reproduce steps:
> 1. Add unevaluated property 'abc' at example of fsl-imx-esdhc.yaml
> 2. Run make dt_binding_check DT_SCHEMA_FILES=fsl-imx-esdhc.yaml
> 
> No any warning report. But suppose report below warning:
> mmc@70004000: Unevaluated properties are not allowed ('abc' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

