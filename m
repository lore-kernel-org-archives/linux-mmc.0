Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198A3A1D02;
	Tue, 20 Jan 2026 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895627; cv=none; b=HVVK8CC/dsbAFhaMdCzdIoOl9n1/rwrjMMiGJnEkj0wbrOMUGQ8VM3aK1/+3kKIpNyGkChI95yTBYpFU4/+W9R5m7TfYud5IgqazvUL7hszVCFatuyA94fCR3/DRUh2oI/AgjdEq5AOk2dxefpHIeAn2Zs15PjmP958RP5cvDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895627; c=relaxed/simple;
	bh=jawjcMTbSVmwJ2HxhLt+FZlyw8lPGMOhDCMkljwxaR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snq5sfrxry9D+4yhMjwWE8KupwqBXqpXHTFtfjtlvSX7eVR5+tm1fYDpHwY6Ols9cNDGCM3SoleGrswejRvBtdmnTK5NyrwFkDF8MWJN6vj2m72lp1+6cGpCXo8ItF9npJYlHzgNWxKQqHLiS2C/olnT9LXhF/Rk5/YcCL4TY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aspxxCVT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aspxxCVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5C8C16AAE;
	Tue, 20 Jan 2026 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768895626;
	bh=jawjcMTbSVmwJ2HxhLt+FZlyw8lPGMOhDCMkljwxaR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aspxxCVT3j09FEP1o7wk4VAcsVG6fm9kEh29DMYFoCJA8qZpehEtp0C5a6LUC9BrN
	 VpEf5P72UYKNeO9Ntnz4HX9AX8L+uqaRnjbp155D6UwknzaPO5qleSnZbCI+HmfIta
	 /y+CyjhMEqIYLTiSlGP6Y464a9dd4IPUdL65qo1+2l667nRoNAfAneNewa0+6mVpwo
	 CmNWKuaLizwjt09fSofv3Qcuk6Wos/qn6Vy2n/kcFjkDZsJsThpSQdoOwhEzG3u6HF
	 7FBU27HSBh+oHzRtywakgATLLRbPlFCilS95OMMij8K9JySy3SJgoXQ0aYccaHpfV+
	 U2ZtGiqaML6xQ==
Date: Tue, 20 Jan 2026 08:53:44 +0100
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
Subject: Re: [PATCH v2 09/10] dt-bindings: mtd: partitions: Convert brcm,trx
 to DT schema
Message-ID: <20260120-meaty-carrot-koel-edb795@quoll>
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
 <20260119-dt-mtd-partitions-v2-9-77ebb958a312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-dt-mtd-partitions-v2-9-77ebb958a312@kernel.org>

On Mon, Jan 19, 2026 at 07:48:30PM -0600, Rob Herring (Arm) wrote:
> Convert the brcm,trx partition binding to DT schema format.
> 
> As the "linksys,ns-firmware" compatible also uses "brcm,trx" as a
> fallback, move it to the converted binding.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/mtd/partitions/brcm,trx.txt           | 42 --------------
>  .../bindings/mtd/partitions/brcm,trx.yaml          | 65 ++++++++++++++++++++++
>  .../mtd/partitions/linksys,ns-partitions.yaml      |  8 +--
>  3 files changed, 66 insertions(+), 49 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

