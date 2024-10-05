Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FBF2595;
	Sat,  5 Oct 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152794; cv=none; b=OyiZ3RBmzf+Vrig8gH91iXx6KZvRkpwSaPWRho+P73fVx8JfDewO7qI2nJ65m5lq4Y0C1Z0UXF2HDJJNXw0UPlEoLdRg5hnTNYxZONuBhl/mwKchaxXroM2QXWXmnsT1RIrwCU0Vtkd9Uerv/T+Uys3QtwsyoXZkCEJIer25ObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152794; c=relaxed/simple;
	bh=av6UZp2/ZvFPvUVNM6xEWHxjiAb15tD5s5oKhupkDdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5uf76JYvUCpHwp59bnlt8Ok5QqhAHClqqDRdbRxxOym/ig6SW2pb+tyMHUC7WU/lJ7/51ma1qM+oqBMxNOORKLilPCCIhNrAPVfN0BtIajHzZk5utTW9CONUp1UdmiAptbdcagqkTfhNm8rpoA1FdSbFlXGVcS72jRr4FZ16oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUq769gQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUq769gQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87122C4CEC2;
	Sat,  5 Oct 2024 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728152793;
	bh=av6UZp2/ZvFPvUVNM6xEWHxjiAb15tD5s5oKhupkDdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUq769gQ99bkbpPxu/Lp0qgzLf6IDH8mzxypYavNrNHN7/EGq2BG+l8vEMBM64628
	 /wUxdxCV1bm/2hoKQycUg86hBDOgFzQJoWeJJ4nGHf3lxwHNquxt8wdfSyJKSX6Swt
	 JLdilEk6SQhjQ1AiW3CxkknwuVOvL0NwT039rlRFy7kVAokQOvlCCFN8/eWlOfij/l
	 ROhSdMCR8C27P4gOjF388oLJel3jmkVqwnAC2a8MO+BxGh1Qiqfv5La/V+4MZxVw8v
	 5nmkMFmrJTt2p3F3m0Q2+RwDAcCw9ZQ4kmQAytc6TR5sLpHV+RmUn7PfkZ8iu/Fs0h
	 +jJHnndDBWNsg==
Date: Sat, 5 Oct 2024 13:26:32 -0500
From: Rob Herring <robh@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: ulf.hansson@linaro.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Message-ID: <20241005182632.GA496820-robh@kernel.org>
References: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>

On Fri, Oct 04, 2024 at 02:07:39PM +0200, Catalin Popescu wrote:
> Add compatible value "mmc-pwrseq-simple-reset" to support reset control
> instead of gpios. Reset controls being refcounted, they allow to use
> shared resets or gpios across drivers. Support of reset control is
> limited to one single reset control.

Can't you do this without a binding change? Just use reset controls when 
there is only 1 GPIO.

> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  .../bindings/mmc/mmc-pwrseq-simple.yaml       | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
