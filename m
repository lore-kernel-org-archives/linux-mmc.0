Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09028850E;
	Mon, 22 Sep 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555282; cv=none; b=VMbEWtgosBhs8dlAiewhNt6ylDePrwAfVZ4a6o7cR8pS/YGBEUlrVpmb//wrekeX/VYqJ/WfCzA7aOfgUvugSFH+QIk4cs6PGyNGShcdtwQ1h2SlYPL5ALA4H01UNTVTaTz3UZ+UPuqhj8Pba3vlNAK6sQkFuZ6Mty2m9M4x65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555282; c=relaxed/simple;
	bh=R9bSzvYDP/5lyTx6wb918b5EYWwUtu/KCM4x0gs1JpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM/uzTiu0HU74Zrk76Ysc0y7tai5LAozu+CtaiEnPKnmOoHhhUM43nFAzPYmcASRlhHdS7maasmtarAP2btqMoRQQmjQRmJMFFKTlw1O85JPnVaStBfqwC/RrPF+9P03J/8VP92OlX3/t9dMaiw6H+1ET3l2MZISsdWlTo8V7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6fbJ745; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6fbJ745"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59471C4CEF0;
	Mon, 22 Sep 2025 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555281;
	bh=R9bSzvYDP/5lyTx6wb918b5EYWwUtu/KCM4x0gs1JpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6fbJ745qj2IUxkZ27opt1+vjPQ7SQFxxhmoPFVaU5jGfJjjPbPIMMlFPGBg0HZfP
	 W7jhueujEPXhnHHI/FWvdDUQiXUZ66YxhwHLaeFKreZBW/+1KBcO1gc0USMl9xCal0
	 dMmiViT5yuMPxCe7pRuOhXHtsdrS/6vfdMUvvVb5KHnKlVn8cM7JQS80f7w4ZMA+d3
	 CerhBnikDUzwRiImlW7lV3UvEKcdiYFtL744PdLDsbxaYXgGB3W3eGg37xEFNCXOyz
	 kq2vw9I2eDtXwuqO9/2XcL4FksBAu/YdCi6E4Njp3B4FJrlUDtBsUFVJPhUq6dIs/S
	 qviOBOEEnQRfQ==
Date: Mon, 22 Sep 2025 10:34:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: mmc: samsung,exynos-dw-mshc: add
 specific compatible for exynos8890
Message-ID: <175855527966.4176202.14757582451293066589.robh@kernel.org>
References: <20250914131848.2622817-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914131848.2622817-1-ivo.ivanov.ivanov1@gmail.com>


On Sun, 14 Sep 2025 16:18:48 +0300, Ivaylo Ivanov wrote:
> Add samsung,exynos8890-dw-mshc-smu specific compatible to the bindings
> documentation. Since Samsung, as usual, likes reusing devices from older
> designs, use the samsung,exynos7-dw-mshc-smu compatible.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

