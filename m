Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16F37F736
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861739; cv=none; b=riOQzvm7zf+vPxu/7JMMlaJRuMutXOpicE5UZYupy0pz/V/uPCLBWIiZa3CHBuZYDl00nYjtPUYz0zyc3puIutEU5Wf72SPZtlbUehPtg6fT72sTDSmFRxf/DqkSSIm8neKBoTZa/ikWXWO3Kdve3KoPXiNwFA1xuWYnBzAxEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861739; c=relaxed/simple;
	bh=YRILLOG+HUnggAnjYrM44vQ4NLjLLdfIDUkl0o+Cm1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhoSxqkIY5ETu/3TxfzB/1Lzh3EgRm521I/lxS3OeR4TFeDrL6mcqooulEqRzp+rvY0hwrklJEJrBwLhih/dC6zr+XLpyFLRvnmtI5lsn1STOj24BsTBse9htYd0pfFK3F4fu4h+4JgL15JYnpCGqnhxzxHSshyZnKqXnhEjZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EAV1f4c4; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EAV1f4c4"
Date: Mon, 30 Mar 2026 17:08:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774861735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Jvy42babhOLsHiEQ6usNzQ70aeU07GAe8AZCgZgAp8=;
	b=EAV1f4c4rRJWfcl66mXI8RIvG/+1PnohQ+N3Fx6jEMv01wFPvtDOsKPATMBafNwdrjPmpA
	e2jyI6OCvpHWkEwrwJ23WJwDsKzU11dkXc+pjZnCVfED5pLIZZrs7eLTrl6Bttex14rseG
	k6ClXdR3bPy2XILQhP1XJHwYHuu6lKs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v5 5/9] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
Message-ID: <aco9oLumPh4OZtIo@kernel.org>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
 <20260330-orangepi-sd-card-uhs-v5-5-bd853604322d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-5-bd853604322d@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 30, 2026 at 16:38:06 CST, Iker Pedrosa wrote:
> Add SD card controller infrastructure for SpacemiT K1 SoC with complete
> pinctrl support for both standard and UHS modes.
> 
> - Add sdhci0 controller definition with clocks, resets and interrupts
> - Add mmc1_cfg pinctrl for 3.3V standard SD operation
> - Add mmc1_uhs_cfg pinctrl for 1.8V UHS high-speed operation
> - Configure appropriate drive strength and power-source properties
> 
> This provides complete SD card infrastructure that K1-based boards can
> enable.
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 40 ++++++++++++++++++++++++++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi         | 13 +++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> index b13dcb10f4d66022d27307de73a6ea3287e97441..8d82011f1af666fb78c282a2abcc0cb88f962053 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> @@ -570,4 +570,44 @@ pwm14-1-pins {
>  			drive-strength = <32>;
>  		};
>  	};
> +
> +	mmc1_cfg: mmc1-cfg {
> +		mmc1-data-cmd-pins {
> +			pinmux = <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
> +				 <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
> +				 <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
> +				 <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
> +				 <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
> +			bias-pull-up = <1>;
> +			drive-strength = <7>;
I'm a bit concerned about this value. Looking at the downstream 6.6 code, 3.3V uses DS4,
which equals 13mA. Since 7mA maps to DS0, what's the reasoning for using it here?
Do we have any documentation or measurement to back this up?
> +			power-source = <3300>;
> +		};
> +
> +		mmc1-clk-pins {
> +			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
> +			bias-pull-down = <1>;
> +			drive-strength = <7>;
> +			power-source = <3300>;
> +		};
> +	};
> +
> +	mmc1_uhs_cfg: mmc1-uhs-cfg {
> +		mmc1-data-cmd-pins {
> +			pinmux = <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
> +				 <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
> +				 <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
> +				 <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
> +				 <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
> +			bias-pull-up = <1>;
> +			drive-strength = <13>;
See above.

                                      - Troy
