Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1E3E8C74;
	Tue, 30 Jun 2026 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846027; cv=none; b=fmJtB06rSgy0dTABc/i15lrtsy+Bqijaxmy/tTImsx1Zot3FBFUHb1tJqexPCC6Drlr8b53R9ws3g9p2+5Z25cSkb128siPF65XjDJ9YNMyzwALfy6K3/lrRxZ3vrrt82wjr8HnUbmJqK5udTS2q5eu2kDyHVuqfsAnXJ96oAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846027; c=relaxed/simple;
	bh=+fL3DQvZUF6NuNMIgUTFuM25h8Ut+xeqc6oYf1enZxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amg6BT2wEzARSOAd2kZMjxyHGNRpBwUnEMP7QSFhOY8YgOVybyIGbJiV7bLcFVlE7z/lTWB+OYG/wDO+vKLLefuYITCmD9Vze+D2jUbMq2SDhTHxy5vrCl3NimFS3e2/FpIaZKA37IlKxIm3HXngzpcCin+AqCwvbB+fDwr85JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6kYk+dn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6kYk+dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184A11F00A3D;
	Tue, 30 Jun 2026 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782846019;
	bh=v6zQg/xYPMDSyslhP1cR6EBRnEfcHERRfBEW1QaonUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l6kYk+dnADxcNvWjIOprBPyqXQ1Y7XsBT+lzOvhvysjLNr1mIEqKRCG68oSxfkaur
	 X0rloWC/ZFjJoyHs5SDaizxbD1rft6y8ChrzW0kNjSEVmjZwFxQO3UDXAkhcC7LBQz
	 fSpGz4JN61ogW7irKbWjNPEjTPF+1rg9TlFjvstBrfqd3ji61Txsv9s7AvkX6AKZeu
	 QQNAWj5aFqut8OdrYnOcvm8v1WNFWEck/e1SFv1ftvEStTX+C/RHjNWTBZLdftqBBl
	 AddU5rpiMkBIuZCF82Gi+V4gLHO5rezVcWCciMRAL8yqgCEvTaSWV4YEJD3Uz1TBH1
	 jcYYAOz4KuJxQ==
Date: Tue, 30 Jun 2026 14:00:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: mmc: st,sdhci: Convert to DT schema
Message-ID: <178284601784.43252.5393908816899610396.robh@kernel.org>
References: <20260629-st-mmc-v5-0-3cf0e639bff8@gmail.com>
 <20260629-st-mmc-v5-2-3cf0e639bff8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-st-mmc-v5-2-3cf0e639bff8@gmail.com>


On Mon, 29 Jun 2026 16:26:40 +0000, Charan Pedumuru wrote:
> Convert STMicroelectronics sdhci-st MMC/SD controller binding from
> text format to YAML DT schema.
> Changes during conversion:
> - Preserve optional 'icn' clock and 'top-mmc-delay' register region
>   via minItems: 1 on their respective properties.
> - Conditionally require reg-names when two reg entries are present
>   via an allOf if/then block, preventing silent runtime failure in
>   devm_platform_ioremap_resource_byname().
> - Constrain max-frequency to enum [200000000, 100000000, 50000000]
>   with a default of 50000000, matching the driver's behaviour in
>   sdhci-st.c.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 ---------------------
>  .../devicetree/bindings/mmc/st,sdhci.yaml          | 105 ++++++++++++++++++++
>  2 files changed, 105 insertions(+), 110 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

