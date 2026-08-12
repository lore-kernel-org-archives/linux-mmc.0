Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931C133F8C4;
	Wed, 12 Aug 2026 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530563; cv=none; b=E6aQzAyJVvp4PbD8LygVHjSTVJwf3iM9bEvjNPPl1YUMwW4lJ9ByFM6v802kLGkPsREOWDtGywsx4ogdXXsARNZmDtigwhw8Ny3yQ1T8He2cNuCfSpxiEDY4pwTMcMTVPStvM4SrOf1C3d1Bll5ZLkpZ8Zfh1DvSDlHRnbIPEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530563; c=relaxed/simple;
	bh=W++XKmRDlfL118+66MRChzezv9x6HfdckdxO5ew8bXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf6fzrHqCKg5+HM/e/pa4FiJR4Nv5BOvL6nPHOootuANn7XriPq3/nZCYSSiutFiuk0254Pb/lnH4jsdK5vCzRn5zJvjJ0zTFR+j/66+cJXnu54b6iUwe8LXqHc7CjkMJVK0ydSDzDpoxjaNCqAJXEzJMf1SZRta+GptMdnc75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggLTKBQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggLTKBQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45DB1F000E9;
	Wed, 12 Aug 2026 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530562;
	bh=DuTfkxEBzJ7sk5H89IXw29P7apayWdcm/p2JKMv6ng4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ggLTKBQdDOifTkJ0ew88ZFC2P9Ple5HBkiaRLj1ox0pXDhdCf6ZzqI6pNS548QK3x
	 bV0ehE5TxLZQtVAq/+FXNI2DqckD9SpS533GZb7r3YnNvW1Z9+7s6QIh/0ftn+tCoY
	 T609wl5RvVGr7JvCmU9CP69o3JXvlvRO8Rz0sQALzF4HgsBtlyNaAgQdrE0AHZunD4
	 S1Pn2n0ybaO/+vqzQlmDFSNo4UTYh0cwYYsS0Jw4ZIYF9RiD2H9vw5MpBjcuWaxvzc
	 uLcPbKVTEkvDDiVVUjVFBJUEwFjgr8lRe1LLmL1XAX8cg2SmCp+rHq5gLeJupUZOLx
	 5V6QXzFqkfogQ==
Date: Wed, 12 Aug 2026 12:29:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, adrian.hunter@intel.com, 
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: mmc: add Cadence SD6HC binding
Message-ID: <20260812-quick-determined-eagle-49eed9@quoll>
References: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
 <20260810190025.25045-2-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810190025.25045-2-tanmay.kathpalia@altera.com>

On Mon, Aug 10, 2026 at 12:00:15PM -0700, Tanmay Kathpalia wrote:
> +  cdns,iocell-input-delay-ps:
> +    description:
> +      Input delay across the IO cells, used for SD6HC PHY timing calculations.
> +    minimum: 0
> +    maximum: 20000
> +
> +  cdns,iocell-output-delay-ps:
> +    description:
> +      Output delay across the IO cells, used for SD6HC PHY timing calculations.
> +    minimum: 0
> +    maximum: 20000
> +
> +  cdns,delay-element-ps:
> +    description:
> +      DLL delay element size, used for SD6HC PHY timing calculations.
> +    minimum: 1
> +    maximum: 1000

I missed this in previous reviews:

It seems you have defaults for these three, so "default: xyz"

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

