Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432655C0A
	for <linux-mmc@vger.kernel.org>; Mon,  3 Jun 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402724; cv=none; b=mdBt8Au9miUN+jGSHge8SxnYnxYcO1XnaDsqDSZd41UioFBeuzpcQzzkkqmoI/2J7gwxP5ElELjsAu0+MOPYt6p7y347iNrtvD+7lgg5Pe8CySZ6tGonouNJi0HU37wst7QHg8Aw2XAd7tfPa+lX0iYcmkPc1A+64cOBXF2EYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402724; c=relaxed/simple;
	bh=y60PmytRxNV/LxaHyQo9+trLEbq8ZgG0uoszlQV3X8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mWvSiMnkD2Y/BWQxBzo2p97is0OWMtRveAwWhd6UlEKR01ZM329PY/BER5FWsmX8bXFLYwRrcAS8IDpehxRU8nXjckAUp2T4p2seg5WtdYUHHn+9d2V/7NG5mAh9glrFPU1L5W4kHIZKKW3hZvrvqYWkEN2Z8HzLBpUILGoYTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A87741042;
	Mon,  3 Jun 2024 01:19:06 -0700 (PDT)
Received: from [10.57.83.47] (unknown [10.57.83.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAD0E3F792;
	Mon,  3 Jun 2024 01:18:40 -0700 (PDT)
Message-ID: <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
Date: Mon, 3 Jun 2024 09:18:40 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Tim Harvey <tharvey@gateworks.com>, u-boot <u-boot@lists.denx.de>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 21:47, Tim Harvey wrote:
> Greetings,
> 
> I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
> for a specific set of microsd cards if I have accessed the microsd in
> U-Boot with UHS/1.8V the kernel will not recognize that microsd when
> scanning.
> 
> The issue does not occur with all microsd cards but seems to appear
> with a large sample size of a specific card/model (Kingston SDC32 32GB
> SDR104 card). I do not see a signal integrity issue on the scope.
> 
> Instrumenting the kernel the issue is that the host reports a CRC
> error as soon as the first mmc_send_if_cond call which occurs in
> mmc_rescan_try_freq.
> 
> I can avoid the issue by either not accessing the microsd in U-Boot or
> by disabling UHS/1.8V mode in U-Boot therefore what I think is
> happening is that U-Boot leaves the card in UHS/1.8V signalling mode
> and when the kernel scans it sets the voltage back to 3.3V
> standard/default and default timings then issues its clock cycles to
> 'reset' the card and the card does not recognize the reset. I'm
> wondering if this is because the reset is done via clock cycles after
> the kernel has set the I/O voltage back to 3.3V when perhaps the card
> is still in 1.8V mode (although I don't see how that would cause an
> issue)?

It will cause an issue for many cards and might break some cards.

> 
> Is there some sort of MMC 'reset' I can/should do in U-Boot before
> booting the kernel? Has anyone encountered anything like this before?

There is no 'switching back' to 3.3V signalling from UHS 1.8V.
The only way this can be done is therefore a full power-off.
Is that done correctly for your system?
AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/signal
lines can also sustain the card somewhat, as leakage is only limited
within operating voltage.
