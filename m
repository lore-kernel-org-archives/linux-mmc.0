Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5C1C3F0C;
	Mon, 27 Oct 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572717; cv=none; b=XehqhsFtRW6FgoAfndxYaNgM2Luqowly0FVXxw5R27/A3Y0eWre3EIyHEi8Vap/MRjvKYXnKIUTObkaMyn2a5bDk0tNW669DJ0z7Bd5lF6LVRe74cQpFgGGgQKQWTtbW/PbqmazaXxOaPxMytrIqWt9ioblI2nOB2/ta4DG5UUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572717; c=relaxed/simple;
	bh=ZefZPxlvHHfA6SOviuZmeM9TORsIaavGiKKEyD0zNuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnjQFFxIVhK2Y0lT6EltjGpQViBrVKOm3HQso8spDRac44YvYacFY7/lNo4fK0fmgrE8piUs4QQqrdCOXTXf7q42S2M3ZvIl+tqBsi+QVVbPdIwkSKLIP3x4ZYIS0gugGNDlDeWrreeaKDUjQH/17KSE7yekEhFAa42NjDNCkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJThxuyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJThxuyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B522FC4CEF1;
	Mon, 27 Oct 2025 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572717;
	bh=ZefZPxlvHHfA6SOviuZmeM9TORsIaavGiKKEyD0zNuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJThxuyrAA6NnVbZ04OMCGBpbWHSlbyxpJqw9Sa8rkJYd1AYcw6/QWzpOc0JjArbO
	 s5GfSW284I8/uE5fiJ723z4w9WGvBFb+bfBNlCh9jajzNKEKVTmn1FlUEV5ibcHH6X
	 y77aSNyM+6UktDaB8bXpml1X+KvpIfM5/we7+jJnCWhR60V54ngwY3bM5fz1mmrq64
	 wIQJaJ8x7OhN/pMTnL+r8bQdEYAvOhT5r9CccpMcwqp8TfV4w8klptH0LEryijwVrh
	 0TSVdCq0bsZ05Uf5nLUD21kUOEtDUlfPCW2qrgaqL2wZx3JzNrT9d8m0a/Stx+RDWi
	 YZ9b/NonygKnQ==
Date: Mon, 27 Oct 2025 08:45:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
Message-ID: <176157271074.266503.15503173472867753188.robh@kernel.org>
References: <20251023-davinci-mmc-v3-1-5b27b9c9ecc4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-davinci-mmc-v3-1-5b27b9c9ecc4@gmail.com>


On Thu, 23 Oct 2025 13:19:43 +0000, Charan Pedumuru wrote:
> Convert TI Highspeed MMC host controller binding to YAML format. Define
> 'clocks' and 'interrupts' properties to resolve errors identified by
> 'dt_check' and 'dtb_check'.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
> Changes in v3:
> - Change the maintainer for the binding to "Kishon Vijay Abraham I".
> - Link to v2: https://lore.kernel.org/r/20251011-davinci-mmc-v2-1-355da3e25123@gmail.com
> 
> Changes in v2:
> - Modified the commit message.
> - Removed 'interrupts' from required properties following the old binding.
> - Changed the maintainer for the binding to "Conor Dooley".
> - Link to v1: https://lore.kernel.org/r/20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com
> ---
>  .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 ------------
>  .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 32 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

