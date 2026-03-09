Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752423D648B
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068281; cv=pass; b=BErqgegbFwdGJmF9eBi9J0mMADsXwjCDnd6Q3wXNgmSoAUSX2aEWPrLGnY45DOvjXM93TmpjfH/B3Ek+/U1opMMa2ySEJTJSs07lqHUBAJqk5oKU8G0g+5+2D2hNX/UI6NTwy7UZlEvP/A9H/oBrMNaR27UOYEG5wfCFKKQwTnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068281; c=relaxed/simple;
	bh=IY4WW+gYzC0CqsNoLWw9PvrfVykX99X2D7D789S9FHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVwVmUmkxA5WjFy5k1wuDBJd6u/rzYhZr/MgQ4oUi0nO+U2yqdDHl9lwato5fJPdpH5ran1MSbNCAsi/fNfeZ0RehomiC7o0IOZ3DVfjD1aWWXaDiFJdK0oUeVN3eHUktRNtVVZr1YOxeCLLpC7yjLO0VUQAKRzBYFn4plSG3wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4S2Zzyf; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4S2Zzyf"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a13d40c760so3127690e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 07:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068277; cv=none;
        d=google.com; s=arc-20240605;
        b=SPqSWc+fSxtsuV2+x/uLVrosgrOe6t+G0PFJV+6zzg32BpjpPZQVXTnIB477icYTGg
         +CYQ/+LSN/Sa3+dY2F6s6uOeAlvmtMn4SftUCaHc1+2Z0Ct9Pjw7GIRTOwGZJSijruSk
         x/2L8kZY/svcmUwWhbwlD++fvIntfy3HhfcKMApOqVFa6gHjE0yrjMGqKNru58ahErcN
         7pe94+ps/9gwyABLI2lBGfCVBpmAOOn7vdO7AAUjWpwRouPu+wz8SjJDDZeD90HGMohM
         oSe3heG+o72s4zWz7q9uXw6ie/O+PFk8OqE8nDHAgRWiB4fHrKayy0t9FGDADX0v0mfK
         jtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qURm51V3QSNQGeHOl9B6sZgNc/jS4e13Qh0oiI6CvXc=;
        fh=ujGC8FfGEfa0ftnGfCwdl25BWaGBrL83/v8Y7Jsm3ww=;
        b=jLC/jatEiOBgxH3p0YO8TCLmMeAfn63Jnfuk4t2qObEb3AfFReerDQqlQT40qU7NUe
         1Cp5QBj7MO8Jem20mWJL9NtvgCbv7gq9CuryKDltdZB//v/LCrdwNrGyklAr2BxonIsT
         apjnCbUzkfDKJbbD+KRlSzVzvVWCKeCzWxErZ6D7F9g0lwQ5sF9TzJHiKRH4N/lwBhT3
         v4FqHeovqOYQC7dkMmLVK0Cp+1FcJWcDD4SoaqcnR56XhrSj90VCoaj6FErdhFH7s7JL
         j4VVmgMtl3UJ867YXGfHXfOQA3oLx9ckdj6uxA85yM6BDgzFjX8QiggR6rOsF0IEwy/G
         aTSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068277; x=1773673077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qURm51V3QSNQGeHOl9B6sZgNc/jS4e13Qh0oiI6CvXc=;
        b=i4S2ZzyfSx10RvjxyB93mL+DEWj7weZWAQCzmQDQRDY6oHRREPEiSZck1NCJcGtkGl
         x+/chkvGex9zTFoH4A5wvS5ZP+yz3QJtN+qN3ivMwztXWnHAFiW1PwBj8VCKboLErtOx
         eLIQ1wrVBUxYTmFP0IDyIRYdEhY8ZtZzWfeNJYqLdGxSFh61qtD7Tk7JOUOgJt/e8qME
         6HeJ8aOZEarxxDAjIlXtDEr8r3Y7kNDq383jd2VFnxS2eF5xGY/bXUBSgoIQGPS2RUOl
         +wCZL6MvdDP4cR6g5tgxMFErAiIyHrXub480foHW+CetHBLstCIkprw/J8dnYXzEuJJx
         QGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068277; x=1773673077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qURm51V3QSNQGeHOl9B6sZgNc/jS4e13Qh0oiI6CvXc=;
        b=Cvzu53n0YEPJQISsfp7q/6vzTW9xdcwetORsOcjAqMNzCHC9I8HQ+h3aTC4Sz/BdH9
         +gC6w+QR6T7OEeRfKroCIZGcjetG5ZsTeXbUe0p7ONoR4sipEc+7aPBmm/R6lXBqqbUN
         CqEpTH674BLo71NwvOPnYOEPPJmlyCu733VXT9fZUbGzauBhWMrrZWtcrRSnx2Zmq6vd
         P+edW1DOowjkaeU7SmktXER/3Z6BxxdCraRJI46Y6sp6A/mzqVphIzTv9tm0WSbc/O3S
         JyX5WNc5hB/Yq+d3SNb4KDDpy/w/AwRkZ8fwGpvNS1eQOytvMnuB2KlbCGixAAUSndeN
         xz4A==
X-Gm-Message-State: AOJu0YwES7GdX5GnPSsmmbc/bzJCU7QMsVzQQvIYNbAfZbaosQMJxlB1
	MxNAnvdngDK+A/61hwsLFaCseQep/7g9Z60Z7erVbdMWrlfOiw77SyvNd6wqyswETdvle9Cpqrd
	byzO/Y2dQ82k2g+eiNoLGxqeM2RI1JUWaqHSkO2nbSw==
X-Gm-Gg: ATEYQzzAs90z82TeHX0muQ2eH+iMmrEKF7DLAMVjB7xUw3xJclPWFEFulu4CZ8MqiIh
	hZU4Y4Bq6RB/tRaVEsVfb+47c6iC6000UPFusoDd1B/dCS+gbAQVp98yvaXH5bzzM0RC0PJ5pgO
	Y0EIkp61nlakzgO8L5zP/Juv1k+/VNu+oTS52QnJM7P34m1Mj62FH2uKLIHcJbzdERdepOHTeGT
	EdItptIRLU781yqcxQ1nh3F6Xan/w74+6+kmpkseCK1NIGI+kVfjQIgYehIqtPCVrPpJGU6KP1m
	1ULrZaV7
X-Received: by 2002:a05:6512:334a:b0:5a1:3864:9306 with SMTP id
 2adb3069b0e04-5a13cd5e6eemr3313001e87.43.1773068277300; Mon, 09 Mar 2026
 07:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306124812.332098-1-shawn.lin@linux.dev> <20260306124812.332098-2-shawn.lin@linux.dev>
In-Reply-To: <20260306124812.332098-2-shawn.lin@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 15:57:21 +0100
X-Gm-Features: AaiRm528f9oKI7V9QcuGDk4ovUjJmSyll385pR4-Q8Nubghuerd4MERf_mqfmlg
Message-ID: <CAPDyKFpKBU9woEd8EfLAxuHWgyDqL=nKCPVdC687u6n-vE0duQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: Validate UHS/DDR/HS200 timing selection
 for 1-bit bus width
To: Shawn Lin <shawn.lin@linux.dev>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luke Wang <ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 13:48, Shawn Lin <shawn.lin@linux.dev> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> UHS/DDR/HS200 modes require at least 4-bit bus support. Host controllers
> that lack relevant capability registers rely on paring properties provided
> by firmware, which may incorrectly set these modes. Now that mmc_validate_host_caps()
> has been introduced to validate such configuration violations, let's also
> add checks for UHS/DDR/HS200 modes.
>
> This fixes an issue where, if the HS200/HS400 property is set while only a
> 1-bit bus width is used, mmc_select_hs200() returns 0 without actually performing
> the mode switch. Consequently, mmc_select_timing() proceeds without falling back to
> mmc_select_hs(), leaving the eMMC device operating in legacy mode (26 MHz) instead
> of switching to High Speed mode (52 MHz).
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> [Shawn: reword the commit msg and drop HS400 change]
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
> ---
>
>  drivers/mmc/core/host.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 88c95db..d1d4870 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -624,6 +624,15 @@ static int mmc_validate_host_caps(struct mmc_host *host)
>                 return -EINVAL;
>         }
>
> +       /* UHS/DDR/HS200 modes require at least 4-bit bus */
> +       if (!(caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) &&
> +           ((caps & (MMC_CAP_UHS | MMC_CAP_DDR)) || (caps2 & MMC_CAP2_HS200))) {
> +               dev_warn(dev, "drop UHS/DDR/HS200 support since 1-bit bus only\n");
> +               host->caps = caps = caps & ~(MMC_CAP_UHS | MMC_CAP_DDR);
> +               host->caps2 = caps2 = caps2 & ~MMC_CAP2_HS200;

Hmm.

How about just updating the temporary variables, caps and caps2, here?

Then at the end of the function when we have validated all "caps", we
can update the variables in the host, like:
host->caps = caps;
host->caps2 = caps2;

> +       }
> +
> +       /* HS400 and HS400ES modes require 8-bit bus */
>         if (caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
>             !(caps & MMC_CAP_8_BIT_DATA) && !(caps2 & MMC_CAP2_NO_MMC)) {
>                 dev_warn(dev, "drop HS400 support since no 8-bit bus\n");
> --
> 2.7.4
>

Kind regards
Uffe
