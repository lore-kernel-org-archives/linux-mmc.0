Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542DC3590CA;
	Fri,  9 Jan 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950805; cv=none; b=KJq2+2+1WPSunkr+6XjX368r0Z17U4CldsuHLLZ8vbrp/tA2QRv3G7sAnYmkmDNM1U3cjbHSzcKMAoz1w5QEcL+InTD/i3NZCrEYv3wL+LL3nwirlgNz/lBRnGSwV5aERxLf3RWhcz/VrK4MvADxtV0Kci2Iml6HO777aNDaCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950805; c=relaxed/simple;
	bh=MzYqxXAR0YnAQN8V09hkcDEqeFx8HQEr/YloebQ5JfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksfue7hROG45YN4FVHWOcrrpRyNjgdMuOl3lHY+KcVqLyG3Y3vZ+uQ86KjjzBIbDbqdMSpH3siBU19rFzJaR8UXoMCqyO+QVK24VZ72DYrifmguD+ZSAmtdMglfc74MFHOSuW4Zka8wD7ny3rEhxLlsZKlIsKhYfUFYGQ34xwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/JbyQIJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/JbyQIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5867AC4CEF1;
	Fri,  9 Jan 2026 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767950804;
	bh=MzYqxXAR0YnAQN8V09hkcDEqeFx8HQEr/YloebQ5JfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/JbyQIJ7mBtds2VexrnqQjOeuPZV/cVXNT3q0k7EpWkV8tq3qEaB3vXo3afwlZUj
	 EPHWUZi1je0YEteTDgknSnVYHtur+xG74I4ZOXaYAE0aRowHKXDRmHue6xQvBhKlGS
	 IwKdtzTsPYKNyEFhP43lhXzhxHca5Kc0xZFNLRuEGaOgUhOsSxzTgUM46Xij6ahFhj
	 vwAtlzTBsiSJVLN3ZfJpNZpLsjeVQsX7pqy5nkCcbDSWpVV4uLJHCSRiBdzJdG7Two
	 7CbWc7HHG38repR4Z6wFWxFSc5dIxkNBLD905ev0U8uQd5EiLXEUSHgiw4com4qSXD
	 jyuFi2gzrzKXw==
Date: Fri, 9 Jan 2026 10:26:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Simon Glass <sjg@chromium.org>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: mtd: partitions: Allow "nvmem-layout"
 in generic partition nodes
Message-ID: <20260109-adorable-adaptable-bonobo-383d72@quoll>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-4-124a53ce6279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-dt-mtd-partitions-v1-4-124a53ce6279@kernel.org>

On Thu, Jan 08, 2026 at 11:53:13AM -0600, Rob Herring (Arm) wrote:
> An "nvmem-layout" node can be used in any partition node, so add it.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/partitions/partition.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

