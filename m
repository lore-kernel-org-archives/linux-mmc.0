Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037F3469E3;
	Thu, 22 Jan 2026 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068586; cv=none; b=pXeYpyT97oFKX2Nu9wLkwvHuPG4p4RmJV8VpWFTxgRQ/Zp4OawecqRkFKnV53lP21ySiVXUhrO7jvHHkkODNmG82rsUrG5Azctk81gkSU9dy1CuDofrXrjE0wRwOuEoXwuF5x/nyRv+gl3t/njm4LX9LxlsZN86CMem0G6Pc+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068586; c=relaxed/simple;
	bh=IzFXMPrtJxAcEF7nLRo09OSi9EH876SkVdkEi0zSv7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eub7rezaabHRPHxh0xnYhjm+2bhjLzAGlBjLWpKIQIBluhuls9VAcdan9Af0sqZRIisKSpU8fR8dyeMelKsiNzNSuPKHUSPpRBO9iDa7ypGK9i+D2HBtKb+j6H+MRe1A4Y/T/ellziWY0s0bpc8+a3t2S0yUQ+76Ilme4nTNDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+jgzZLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+jgzZLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA8FC116C6;
	Thu, 22 Jan 2026 07:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769068585;
	bh=IzFXMPrtJxAcEF7nLRo09OSi9EH876SkVdkEi0zSv7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+jgzZLdo9HY2aFLY9ZnN0XC5hCnU9yeQNXt9VtJuc+XBkB6PI2qfQ9iNlStCiVpl
	 0QeMegGM348V/bZLeA3yATIjDBpXp70SJi99lEmTD1hNZC53fgi1flxMBCJ02ryonB
	 i383zs++JF67nmDDUXU+x0iMn0MywJM2DDDlWfSXqLTroMUtNeD3HAtlya/l3PSiY1
	 whFj4CRDzBqkYI+Q9latKKFeOd08V/7fVf7vnHzphgImlF2Z9teowEk89wSoV8TpMK
	 NHNHz9s5Kb5mGx7yANLPM+tJwgDD8trVg16vwC27xZIUecxZZgcTA75KK0WID4WDsL
	 APcohJJBUnFww==
Date: Thu, 22 Jan 2026 08:56:23 +0100
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
Subject: Re: [PATCH v3 10/10] dt-bindings: mtd: partitions: Combine simple
 partition bindings
Message-ID: <20260122-wakeful-apricot-gazelle-390bfc@quoll>
References: <20260121-dt-mtd-partitions-v3-0-ec3af93c8f93@kernel.org>
 <20260121-dt-mtd-partitions-v3-10-ec3af93c8f93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-dt-mtd-partitions-v3-10-ec3af93c8f93@kernel.org>

On Wed, Jan 21, 2026 at 01:56:43PM -0600, Rob Herring (Arm) wrote:
> Several partition node bindings are just a compatible plus properties
> defined in partition.yaml. Move all of these bindings to a single schema
> file.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v3:
>  - Add $ref to partition.yaml for brcm,bcm4908-partitions child nodes

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

