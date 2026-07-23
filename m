Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35E355055;
	Thu, 23 Jul 2026 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847668; cv=none; b=RHQWacMeg6tWsTJzklDQqPXBCs3zmPJwVdcVH25uA5CbQTzSQ287zxYmEY6hkDjFzLxcysAMXTJO/ixUuSCJMjn4CeX1KI5mhwnwwj8IjxeyiL8KEttlW35zHIAV24nHAQcJbgUAyTHcWYIoIKbUsKSmN573IThvxvzWRUWXdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847668; c=relaxed/simple;
	bh=pTBTQyaLkUOAE3l+7NJYUSNO7wYiiCx9l9nKAaXGdQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtlZWm1SSwx3yvFNulUxvEsuZpI4/tjFt8iKSDVCrCg0Xpirokqh7yzIpwE7ck3L1FFTLSjLqJg5ybYzfU+UwpWAzelLucZ8eSbYD2y+R4kyDWvAi9V4I0dRGb+nK7Fiky2B0y3Td1nx2BVVSR8YSghc+YtVtdzqaP+qTk/+x0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTbN0KTG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTbN0KTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F5A1F000E9;
	Thu, 23 Jul 2026 23:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784847666;
	bh=NzzVubqqY2CM6by26+6Bo4GAF/+87NIwQZ28x6KoXsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JTbN0KTGYXxJ4e82Vz8O+84c2PfluCw7CUHoJhRhpcDPwZOOK+IQwFb6i20jeRSAi
	 0g6qh/MmdNAHcU/hkFYsIF1RWunBMJ1ogy9kJrHjgim9x6wX/A9But+D29nLKsj/zi
	 YnKRsBa2mwmmP3jpjaC3zyUtB6QfkW3hz7IzLGO+bB5/ArU3S6v0CrUPbbRZtxhngO
	 5urLkRgmGMD9tOvIYHXK8esynz7GvhQNAwzZH7h2vK5GUDqALP5Mhsmx6Y1wGIR7TU
	 xYl9q0XCifxTbr06TSFaJCAd/zWLPFwHpnBR/0fcQFoFurpRBWFHkTMVBiHdJgv5C+
	 Rc5FihvLKIyhw==
Date: Thu, 23 Jul 2026 23:01:04 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: Jie Gan <jie.gan@oss.qualcomm.com>, ulf.hansson@linaro.org,
	adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
	quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
	quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v4] mmc: Avoid reprogram all keys to Inline Crypto
 Engine for MMC runtime suspend resume
Message-ID: <20260723230104.GA662946@google.com>
References: <20260529092612.1749752-1-neeraj.soni@oss.qualcomm.com>
 <e9cdf8dc-40ea-49f2-a655-b99ed0707a8c@oss.qualcomm.com>
 <66caaafd-cea4-b624-57a1-f2cd04d109b9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66caaafd-cea4-b624-57a1-f2cd04d109b9@oss.qualcomm.com>

On Fri, May 29, 2026 at 04:05:52PM +0530, Neeraj Soni wrote:
> Yes for cold boot this is true and Crypto reprogram is not needed. This patch addreses the use cases like
> runtime suspend resume, deep sleep / Quick boot (DS/QB) and suspend to disk (aka hibernation) use cases
> where the runtime context is preserved either in dynamic memory (DS/QB) or in secondry memory (hibernation).
> This is tested internally on SAR1250P chipset for hibernation and DS/QB.

But sdhci_msm_gcc_reset() is called only from the driver probe function
(sdhci_msm_probe()), before MMC_CAP2_CRYPTO is set.  So Jie's comment is
correct: the new key reprogramming path is dead code.  And as per the
following comment, key reprogramming is still needed in some cases
(https://lore.kernel.org/linux-mmc/42797330-868a-bfcd-e0bb-b5f0dd3eeb16@oss.qualcomm.com/).
So doesn't this patch break the sdhci-msm driver?

I'm also skeptical of the following change, which seems unrelated to the
rest of the patch:

> -#ifdef CONFIG_MMC_CRYPTO
>  #define MMC_CAP2_CRYPTO		(1 << 27)	/* Host supports inline encryption */
> -#else
> -#define MMC_CAP2_CRYPTO		0
> -#endif

Because of that, mtk-sd sets MMC_CAP2_CRYPTO even when
CONFIG_MMC_CRYPTO=n.  That makes CQHCI_CRYPTO_GENERAL_ENABLE be used
even when CONFIG_MMC_CRYPTO=n.

- Eric
