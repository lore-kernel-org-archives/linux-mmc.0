Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033D32548C;
	Sun,  1 Mar 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370728; cv=none; b=dZRrIaN2anLXurPz1v050433eVlMWXfP8W7y20ZDdPFNoaD9ahchB0mQu7yelULY9w78AWPRZo0rf+NrabAn2jg6un8Wb0vHrn73Egj6k/YFzwlPrx5bXglJYJN0TJRIG9uCryt2UUl4tQtj2ak0CKnAHT5zynvpxTBd0qRwDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370728; c=relaxed/simple;
	bh=QxpYqEriI/iMqXBW19wHPzJAIDNmx2/LIrcdUt374O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbObrk4qELR5XgqxPXoh3WRWhyH9VCz7Sfg1M5zkJoDmgf0tR+cG23bsWo70VRgRrvO7JArmVw1NR5/eMU9yQP0eNt+CyJ/xoLzq5OA2jrTe6bT9s66B2S9n2rUn9FOxI8EbWqP03poP4pmv0nGz0+M6r4Bu7Bcd3MtFqTL2gNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXKMp+tR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXKMp+tR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D03C116C6;
	Sun,  1 Mar 2026 13:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772370728;
	bh=QxpYqEriI/iMqXBW19wHPzJAIDNmx2/LIrcdUt374O8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MXKMp+tRWJ4JwvJkO3xT4co71sY4DEl7Zwy/x+7C3qhl8nrZfi/EiuRY6ShNCagEE
	 yGzQxYT1tiwBo95UoqMv389S+HzEnC8YHPJkMaCleASZKhx84N5nuwBp8ZUGpp49Tn
	 te4uhTuj2CdXW77UwxuZuQVvB/6PtarL6d4OvlVBDNIBQCPqPfd9A6ujSLxdLch1PH
	 pUBLzUU6OoNvSJqdL+cLt/mu3kfSQNbDx9eJgLJYwE93dfKz0tISwltiGruj33C9wI
	 8ZWbJYCg27pLTSyLyuSnofuluEcmVfXc8j3sA+lC+DFq0PgNL74l/9kPA5gvvmHJDP
	 XGadXlDcKd0Mw==
Message-ID: <12058c14-67c7-4b43-bbbc-ef0ccb813e61@kernel.org>
Date: Sun, 1 Mar 2026 14:12:03 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] arm64: dts/defconfig: enable BST C1200 eMMC
To: Albert Yang <yangzh0906@thundersoft.com>, arnd@arndb.de, soc@kernel.org
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 gordon.ge@bst.ai, bst-upstream@bstai.top,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225100613.3791261-1-yangzh0906@thundersoft.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20260225100613.3791261-1-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2026 11:06, Albert Yang wrote:
> This series adds DTS and defconfig support for the eMMC controller
> on Black Sesame Technologies C1200 SoC, split from the v5 MMC series [1].
> 
> The MMC driver patches (dt-bindings, sdhci bounce buffer, BST SDHCI driver,
> and MAINTAINERS update) have been applied to mmc-next by Ulf Hansson [2].
> These remaining DTS and defconfig patches are submitted to the SoC tree.
> 
> Changes since v5:
> - Patch 2 (defconfig): fix CONFIG_MMC_SDHCI_BST ordering to match Kconfig
>   position (between CONFIG_MMC_SDHCI_TEGRA and CONFIG_MMC_SDHCI_F_SDH30),
>   as pointed out by Krzysztof Kozlowski. Confirmed via savedefconfig.
> 

Please do not send patches to soc@ for review. It is explicitly
documented - read:

"The main SoC maintainers can be reached via the alias soc@kernel.org
only in following cases:

1. There are no platform-specific maintainers."

So are you claiming now that BST is unmaintained? Because if so, we will
mark it for removal.

First you send patches for review to the mailing lists. Only then,
AFTER THE REVIEW, you send them to soc@ list.

Please read maintainer soc profile.

Best regards,
Krzysztof

