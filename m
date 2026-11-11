Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418136;
	b=PlE/NdXFxseV99WVS8AMz0/sIbJ8fchvWvb+tiNyBkSlxtIrQAJ9IyRvjoW4Owu4OSiX
	 MNVovhwmgjb51HTDtXG/X29k5tOaFe+0kldQOsNcmPO8Lg96/zrbeSDOnRH401m0MzKQc
	 xhAngG5gDh48kKacZdJoB2n/VXqOHnBelLJ+KkwFtgWY+eWYkk+dnR36W3iv6p7/C7zes
	 PFGdhNHEjpX6ohK8y2F4d/tPNe6oBjbLsuKBCDHdQl/tFSBVua+XiD19MtO4QjQPSBQFc
	 KvlQIcWjajtx1lRHD30G5yAz0t6I3bm30dU1oLarlsOOITurmgbETTi+8kH6iyMSf2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418136;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3HCV4LJv2AVzsWB+kwgBRgWI3i8ILQRpBf09pPR9Xm8=;
	b=IC9bxF2v4Vvgq7b2+jKt/hCB4QOKfDdFUy7LYXHU5YWdR+QE6AEB8QrLr5/ppwulSKiP
	 tDiR1Bfx1YvmzZRLIJ7nkdGnyZ1iiYupbSa8z6PFMln+ux31AlxdpvCO9fvjJT0J9qQcy
	 Zwua7mB2SHdq78pAX3YiAC6zAJN8I/M1hYx9kDNQ1nYoWI1MhF/BTY3ZJC9iBnxP6SsKI
	 QJMxolYrTwQaIUKMxgDF0eL9OQoFp6Nzrmah/SylWqAsjQh6+Rcz0ukA5uOkx1aVwUA5O
	 ppaJKTlmUjhwl5oCnHn7TTe7jeFD+B0Q8IIgsD1roFPNNMODR85sHD5n/MwmbSS1ZUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGEB8wFQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A331606A31C;
	Wed, 11 Nov 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGEB8wFQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFE01F00A05;
	Wed, 11 Nov 2026 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418135;
	bh=3HCV4LJv2AVzsWB+kwgBRgWI3i8ILQRpBf09pPR9Xm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nGEB8wFQlpOe1I0vAagDziQFO9M32px5i9X5lV4REEG9Wf3VZrUJV9IfrPevqM82V
	 1bNKjtnJ3veYMhvrIhxCjJi6AojkypfGVdkv5tEeaL9uGZshLwFDfmlH5RcpwDL6Gg
	 2dlzsHrx+2hK3/eLTmVYDCJpwpUw01+v8VOuKUtPyDLs2Rdo6yzyxzNIixNXqVVqrU
	 mkSysvwYrXsUvw85uZYBMrl/YnQpctjPNnE7FzID3pCUuRzfMjSG+ASak4R1n7nVba
	 LQEXsB1VwV4A45eeUVMwqBK9wtaJfiD/aOyEoIuQ+ZsOl1sZNgV+bHneN57aU+0Boe
	 Qy+qYeSiEGWow==
Date: Wed, 11 Nov 2026 11:28:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars Persson <lars.persson@axis.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: remove driver
Message-ID: <179441813237.77314.18160854241358046037.robh@kernel.org>
References: <20261111123548.10571-2-wsa+renesas@sang-engineering.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111123548.10571-2-wsa+renesas@sang-engineering.com>


On Wed, 11 Nov 2026 13:34:52 +0100, Wolfram Sang wrote:
> In 2019, Yamada-san already tried to delete this driver because no user
> was known. Lars revealed that it was used on Axis ARM32 Artpec-6 chips
> which they planned to use for another 5 years[1]. We agreed that this
> driver should be merged into the main SDHI driver and, for the time
> being, added a MAINTAINERS entry to make the connection to Axis.
> 
> Now, in 2026, the 5 years are more than over, and the merge to the main
> driver did not happen. Nor an addition of a SDHI device node to the only
> Artpec-6 DTS file. So, regarding upstream, this driver is still unused.
> To remove maintenance burden, let's remove it for good.
> 
> [1] https://lore.kernel.org/r/CADnJP=sg1Kp=TAvUD-ofQje9Y6mWWE_ZnQM_eB85uw3z6PHrVQ@mail.gmail.com
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> [wsa: rebased, bring commit msg into 2026]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Lars Persson <lars.persson@axis.com>
> ---
> 
> Jesper, Lars: please speak up if you disagree.
> 
>  .../devicetree/bindings/mmc/usdhi6rol0.txt    |   39 -
>  MAINTAINERS                                   |    1 -
>  drivers/mmc/host/Kconfig                      |    7 -
>  drivers/mmc/host/Makefile                     |    1 -
>  drivers/mmc/host/usdhi6rol0.c                 | 1904 -----------------
>  5 files changed, 1952 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>  delete mode 100644 drivers/mmc/host/usdhi6rol0.c
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

