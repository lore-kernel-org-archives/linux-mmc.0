Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1B1C5799;
	Fri,  3 Jan 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893439; cv=none; b=sygT3mVJxoRPOP2X1orbM0bQmXMWKfAVx4ocOi3bfyukmrJ8Y1EAVPIDUwIdMDpdJzVSVuF/o8D7G3L7DfLsPlDUKBt2SpUcvj17wk9e0JdswJTpqNJl7mhtQITKMWU92DhFsugi0r3IlIQC2DgjAA3oENikZxgl9SXktKEsyjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893439; c=relaxed/simple;
	bh=H/j1VVG5p6FV3q6JjSpoYf2uLqB9DXS2WeYg4giuiz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGSQSCb1h+kHgIaMErKA2KjKdbWZ1ZR8a1t8W800GxxJdqR6URVOlMZAw6DGxUp8WUPyal1Djayi5Gl2xFX8aF0ie8hbKL80Tt+F6Q1QUfPqkcuzSlKOUYKyuaIy6NxcU39Yg8ZZkSmuGfgl4mRvt5WnSwPuQu5lH4mmSI3jTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvjCmMtN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvjCmMtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A4AC4CECE;
	Fri,  3 Jan 2025 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735893438;
	bh=H/j1VVG5p6FV3q6JjSpoYf2uLqB9DXS2WeYg4giuiz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvjCmMtNIU/R8T4CoVEsxCa/klrPzI+Iwi7CcTroCwKMPPBadxyW25yIGpcUrJrM5
	 wjeWHu1TsoSoqPNv/5rpCbw58H0y8OH8OLbXHDUqyfAxB4/7mznh+11VjGBQN/u3jf
	 Ifo2wP5EtzfznYTwha70f/Yb0vjRVpyfhwPU5SzvNa8WpJciTNRorzQpox8OSNgqsq
	 mQeUAOvxh0qsb6O92uhrd4q8lGQEAYeqoTssEJdw81A4YglwYJRfwvqCJ69H9Xs1+n
	 WkZEklTQGcsiyuFDbzdWTJDTOzmvnUv71jNsXQ+naqkuprdCd31A+GFS7yoAiN53Sw
	 Tv5ZKPImv8MIw==
Date: Fri, 3 Jan 2025 09:37:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: mmc: samsung,exynos-dw-mshc: add
 specific compatible for exynos8895
Message-ID: <dykofnfflmcdcmtq65y77aginsx27sx3qwhaofyljnc2uo7ibr@pyp7po2hsabm>
References: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
 <20250102205846.223955-2-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102205846.223955-2-ivo.ivanov.ivanov1@gmail.com>

On Thu, Jan 02, 2025 at 10:58:42PM +0200, Ivaylo Ivanov wrote:
> Add samsung,exynos8895-dw-mshc-smu specific compatible to the bindings
> documentation. Since Samsung, as usual, likes reusing devices from older
> designs, use the samsung,exynos7-dw-mshc-smu compatible.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

