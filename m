Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B6283FC5
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163316; cv=pass; b=Am2G1h53uDNXWzHIiybzaeTo/FCQTe0FVTV70+KyKPf3+3UunryMEfIr/urWeB/6NKg1dDCYNYosZkjYLWFU6TPmH+AJRSGTwCFfAn7vpfCgIq5SIMI2yJBa3c6LO4g9zg7wyrHbj+o/rp5K34LFMqa1ljrnGwmiHE7kDwUQAJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163316; c=relaxed/simple;
	bh=l1LWw/lLO2Mxd163sD1iwfH3mnjzIBvX0B0bzcnxAn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOnPjI264Qj+2CrdQD96+mPvZkyh6iJiLy2kfXUawzPL5ZN9tLqyzbDHI2z0jFzXjdEAN9KtwfKm5sTqK0SZc4tN3z2nK/1B6XDBwf4IQ3UKxMbyIAZbVxtslDBHvsRtB21h+ULMqIQ4ou85Dnay9t5LHPhZxlTjhOTbWOUZ5s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w78DC35E; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w78DC35E"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b710d46ceso1917697e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 02:15:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769163310; cv=none;
        d=google.com; s=arc-20240605;
        b=gcQujR8zic51jJ3/XZSAswBxeVCQ1BAniiLc9ybsT29SlONK0tdg4WHmxPSnoSzm5q
         +ZAmRuA+3tiH4oKh3rpL0wLXibD2q+CZl/goKUnSffC483VXnFlqRbxyVcNzcAgw0x17
         e49GdMI1dlpojnMsX1CVszKZVLKtFO+Dwb+kpkvQiv8VVbJD7fgFtMtv/qM5VOQxX1gz
         IyD0Hj4LwOJEtayGsxPRAA5/lGbi5JqTwsMaQ8pMw3GGgsapXnpdLR6mcjYPyoYTMh4z
         pQffpgBV3twXsumdCC1wxZkkioCIRjcPLqQQD6AeKosyMDEXOEKdSNC/ek+B6ywshAhM
         7VqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f1NePwJCHgkmaOrOX/MEPkH/zPtNPeBUxGf5rTLnWwg=;
        fh=QMa6S2ZigMl57/BfUD8jF4Rm5BMiTXqWJWYshNJjdgE=;
        b=C0LyNcO8xWF50qV0Jh7gN4PXwAZX2qBsM8iGEdnifQyycJtWZXWnwyyvlOnMmnvSdD
         6mSYz5bl0Z5rwZnzv/sroY6BQCLDZrLUnB7hx3Oa9HvO+bVtNzmTVJYH2s2JRqNxayrA
         W3npOUoFCPy9hP1COj8VLfJCFUM6D76AvSUms98+pFUmpomO27HbeKBeNOLs+UsapLjW
         N+/9sPLqLDyOBJQURDqvcFgMb6dnddbMMqLELT7kKfyNMhYs+CMmJ/smLCkFoRjUQ8tp
         JGMMK+zG6C38rLaZF2y5flhWO66YbJymCYy5f6lodEeBF3K5EHS/y+7h3oNtjAnq/esY
         5WhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769163310; x=1769768110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1NePwJCHgkmaOrOX/MEPkH/zPtNPeBUxGf5rTLnWwg=;
        b=w78DC35ELycFtKwMaFjS7E+iMLkwyA3ZmyegPYFrRLlsh1YfSCC5U3MP1QrPJQ3zRG
         jva/7SQc0SrihAzSaVkEej8TnaGd+Ksu9HsJFPiafIkSZJRlGVx8JE5gzXVwvzuEqfQk
         m5dLVxIHeWfKhMgvtnDfwVO2om4C6vHUYpaN3XH6FhSL+LdozEutWqt3tjovXDK9zHzg
         mCTi/ApFLoaHPbNLlSDxvGekHfQNr2n4eLHB2Ahmmh40Mf9zogDtu/+Jhrq18QxgoAd1
         BFLFD6W20HThpboUasj/jdRAdMq2n8Z2kZoKERiFtVsrUXmWwXVYcG8Cf6Xdz3Q5gkZC
         pjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769163310; x=1769768110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1NePwJCHgkmaOrOX/MEPkH/zPtNPeBUxGf5rTLnWwg=;
        b=nampBCPXZI9thidhnucn9RXi2jWaUKf4ckcW9St382O3hNhawbbqjRlotqrPYNhCom
         WZ1kIl4e/Ru0HVIggkb9SK6fkz7tNLT7QU72v5/nhP+gIwdQ1UDyAttTqAy8C2yJwwA0
         QMBQhjh+ovy5fn/jp2iA7ljYUjOuJxjuoi5PXrHmhvKKfZd3c870bOX6JPqq5J0J3nbY
         EpXhBZL+bX3E7FQfGE11oYYcS+gMalF6/PT3IiOzFVruch41S5mEIdp8MApFRQtT2Anb
         x8CUlOjfuWarQaIX66OSiZmjAXbvwStTxHxR/qh0mY9szpL0lxf4IiJrdo4eLmXcQWQz
         HSbA==
X-Forwarded-Encrypted: i=1; AJvYcCXiBmK+wQilIxaohSrRC1SXm8xaoz45QuMDGDL0QZSfk0hKH41IDwySG/+nQrZuQwaeRc5Tp4BxJpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcObuBVywY+3v/S4MqBS0YdV7kbwMBRKqvO4nrxJvbMIjOtIP
	SgAmHFdGEX0QrZTm26hqqs98yyzYoAQGVo0260zDbTAoBopHjVS9/FJ+4gGB9VketO2n0wGlFKO
	eABRmikFSXIEDzQKyPZrjFx2r9OrTGBdL91ASCxlfrbj+TSBKlieGFZI=
X-Gm-Gg: AZuq6aIRBV+nzKTOlMueO67cBQ4a8tBLucdP2jQlbZBKGC+pO44jOGT+BW0GwAaHaKI
	TyxXYU36REnptRUkzCoFHdgAIc90aHs28Pa28yD9uD9JJ4xTopdKJUNqB2LueYXf/ZiRiqQqq+6
	ECaoLHrK1eyDzdjX6/Ss7MsERrrQGAAzn36KcXJEzT/6dMQpYfr/CAZC6sMPbS2323/BMTxCdpi
	fSORKNPHgJwA2c+PDXW6FCbPkUI9oLBTuNBL71lfCYAebtlsBJfw2JmHoS0VLlV1xvejN0I
X-Received: by 2002:a05:6512:10cb:b0:59d:ccb3:2f0d with SMTP id
 2adb3069b0e04-59de4922159mr793933e87.36.1769163309685; Fri, 23 Jan 2026
 02:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1769132482-177365-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1769132482-177365-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 Jan 2026 11:14:33 +0100
X-Gm-Features: AZwV_QgGSg-BBq9S7_AV3LtbRn4AJfL-B908kIEEoaE0Y2St9LA5MAJw9GzsJKM
Message-ID: <CAPDyKFp_Hw68uf=Bw0ndc9EzDOTQpp-dLejuy71wrygRSyBV2Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Remove deprecated mshc alias support from dw_mmc
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Wei Xu <xuwei5@hisilicon.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 02:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> The support for the mshc alias has long been deprecated[1], as the mmc core
> already provides standard alias support for obtaining the controller ID[2].
> With mshc aliases removed from the last Rk3036 plaform[3], the only remaining
> users are the HiSilicon hi3660-hikey960 and hi3670-hikey970 boards. This patch
> series removes support for mshc from the dwmmc driver and updates the DTS files
> for the hi3660-hikey960 and hi3670-hikey970 to use the standard mmc alias instead.
> Considering that the hikey960 and hikey970 are open development boards, users are
> expected to use newer kernels, and the need to adapt old DTBs to new kernels is
> relatively low. Therefore, backward compatibility of DTBs is likely not a major
> concern here.
>
> [1] https://lore.kernel.org/linux-rockchip/20211124184603.3897245-1-john@metanate.com/
> [2] Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> [3] https://lore.kernel.org/linux-rockchip/c6feab79-5b73-413b-a94f-9d1b2fa6df43@gmail.com/
>
>
>
> Shawn Lin (3):
>   mmc: dw_mmc-k3: Remove mshc alias support
>   mmc: dw_mmc: Remove mshc alias support
>   arm64: dts: hisilicon: hikey960/970: Convert to use standard mmc alias
>
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  4 ++--
>  arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts |  4 ++--
>  drivers/mmc/host/dw_mmc-k3.c                      | 22 +++++++++-------------
>  drivers/mmc/host/dw_mmc.c                         |  9 +++------
>  4 files changed, 16 insertions(+), 23 deletions(-)
>
> --
> 2.7.4
>

In general I think this makes sense, but we need to make sure that
patch3 is merged before we drop the mshc alias support in the dw_mmc
driver, so please re-order the patches in the series to make this
clear.

If we agree that the $subjeect series makes sense, I could potentially
help by taking the DTS patch too via my mmc tree.

Kind regards
Uffe
