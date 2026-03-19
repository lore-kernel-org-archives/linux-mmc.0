Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4793F0776;
	Thu, 19 Mar 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953947; cv=none; b=DtAx4YgEsLsFosSffTWvZkGx6tEeG9egBDVVTQKtNAFZkZs5DuCvSFQ3d7tOX2yvJLlKlYNdAEktjG8IXf/S9Ycnq+eK+Qxk15MAjfCqil5NNjMJ0ll0SsGYkmO3H5XtmwaErL/r1qAfP6PBcEPFAYZ9TzPUFUhFg5AcURzrt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953947; c=relaxed/simple;
	bh=aG1MwsESbRey8VnT9AYIGOGFrASzJHW9rV+8BFxYtMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHBHPmctDxnyis+HggGI93JS/XHpzEM0qAWhR2zhczOpqYwp2xrGUnr7cpGO9+nN8Qa/Sv4Uhf9nDNnTM7D4oI2ZvX0bpCrj0zl6o87ZJsAQ88VQW9h4LwnX8UmWkD7C8Woq2bdiR3y2UI2/EcpRR4SsYndVbD76OL5rwe+g58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZJPDA/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZJPDA/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD7EC19424;
	Thu, 19 Mar 2026 20:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773953947;
	bh=aG1MwsESbRey8VnT9AYIGOGFrASzJHW9rV+8BFxYtMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZJPDA/ri98XPyN/efzyjsbgyJ3tCntgCy4y6+Hf9MAl5fBLSpasGfbgBrr85cQvR
	 E3QEvNagj1T3BiKdbirjv00ZQdMXjCxcfbmAYT+477tQvB2Zncc6YEBaCwBAHGsYOE
	 9j1znLcOqgW55O8EGQscunpxqgNqUSLwLMUjblJemBapM+ZTplKx+6Y7ia4uUbJ6Yo
	 a/W9VWUuNstAp8XEuxmhQD9FdoI2MB/NfAANtllTJ3m4YmGv+K8yqfBGoxzbJ+TymH
	 ugYFxkG3b1fGDEMCdhXm8Jrxn/+bbaz/FPOnL8Vv8sNdBTOD9cbIPL9whb5JBDWADf
	 ghCEAhML1rAdg==
Date: Thu, 19 Mar 2026 13:59:06 -0700
From: Kees Cook <kees@kernel.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mmc: core: Add MMC pstore backend driver
Message-ID: <202603191358.1895CEC26@keescook>
References: <20260319185705.1516950-1-kamal.dasu@broadcom.com>
 <20260319185705.1516950-5-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319185705.1516950-5-kamal.dasu@broadcom.com>

On Thu, Mar 19, 2026 at 02:57:05PM -0400, Kamal Dasu wrote:
> Add mmcpstore, a pstore backend driver that provides persistent storage
> for kernel crash logs and other pstore data on eMMC devices. The driver
> registers with the pstore_blk framework and performs direct MMC writes
> during kernel panic using the panic-context host operations.

I'm glad to see another pstore_zone user! I can't speak to the MMC bits,
but the interface to pstore looks correct to me on a first pass
examination.

Thanks for picking this up again!

-- 
Kees Cook
