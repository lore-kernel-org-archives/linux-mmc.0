Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983F14D2B2
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062163; cv=none; b=XJHv1f/hM53FgjiAwZE4i4a6ZNRVGz06JAt2jjAXw8ZnNJiLXJIYZAhaegSyyrb4JSvEnfrX7BoLhZ8PpcGJw36ghVC3xK8ETZFnq2NlZVYe7banTEAqxa++a8f6CL6oWhQUnqOoUXHlx0DlHgjH0Gj4UIwqAplmXLIuIga6zqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062163; c=relaxed/simple;
	bh=i+P+k68CcmymOGvSb9vwn08NeXxYv0s2xH5x3OQW8tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTsBRMUlf4yMCL1CgRQTBlFbcxPi2Vbmxk99UXskx1UykMA9UqDqKBG0iLZPvx0l+NUpPcjZWew7CyHcAuhTpJa3PTp2uDqaWm56+1NPu66kYINbj3twN3vWxHB0G59CgFuYXn6ufoIg5lTy75fcKGJ+q/bf5tnht1C0NpqRfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GhYKPTuS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhYKPTuS"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-617cd7bd929so12633217b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062160; x=1714666960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i1JK7+wEtbfY7qkRNIeP+416+igSJp+SapW7jNKxfo0=;
        b=GhYKPTuSruRSYHht/AYnaoLRkqLy9SBVbXZAQEu+H4hN0qUPzZFsYhbROycVpg3kqA
         AmKYFGGNHrNxsin8wi7jnalG/Dut4NMuDpZC5ir1DoCfBidA+G4lXOmfO6wjdVfz+wjV
         IDw6i54hdq9fgw1Kx2g16GSIV5VWHFilIx99ByrRuMEjQuPCVplrkxziWfulCVxjilVQ
         3Qo4a47CzVAZlBWphXnP6MryuSVzsoKQsS5gLPUGeOEWBeECPwoIIL7wIgjnixkz2cpQ
         7qUr+VzWN5lzixjRb0rAHR5uhHjJEAQnO3MbAKWBvIHcMjRZOMlWj4JxgpyLI7xpueSo
         mAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062160; x=1714666960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1JK7+wEtbfY7qkRNIeP+416+igSJp+SapW7jNKxfo0=;
        b=K+QRjklX4se/YLonadWQnzfpQBtRvIUb4wqUboH/lCy2BUC5FkzbJOGrWMmNZYhdA/
         0qClWZboMiKQYQaRzEZUBj2ofCP1Ar5SyuXMjchLe3GmZWUmhFcCh1+StrMRuVfAY7GV
         iEnfbz0NoFnU5AZxIk9QPOwRMStf+1Px0FawbC/PuMwpNZogvxpZUOElQfmMs1YNrwhB
         y6ZnS9PfDJS9zt2ghth1L8LPWrYAKNmAsvxemOI285AvetV5642LlTF7a/Yf6gPidyYb
         0/5mF8E/FLGD7dqTMrMPFPZkehw8v54YDN4/NfVKWX0kzouNpGUYFJhMxFqaYxTJvxKX
         Qmdg==
X-Gm-Message-State: AOJu0YyFgy+Zo1fNggyGcINotxP5i9hS1EWtti+JVzu2kZjLCzJRwOTk
	RpiHvPavv6VkZkh2pQq4xNGoORBL+Xs73RqbltBGODnQBUGe7+WqCYaDbBGwUQMbl2c90iaWXVl
	Xl+owX3dBVyW43/hiXLXn/z7bBrVvjqI7VQF7Tw==
X-Google-Smtp-Source: AGHT+IFwYxHrIdsfhr3Jta5nV0D+DvLpBWGX7J4D9bw5RjuKbvDtZnGIcR2Op8i48Ly4Ck4MI6LQPnK6/2Rea8NdNs0=
X-Received: by 2002:a25:ef0e:0:b0:dcd:3e78:d080 with SMTP id
 g14-20020a25ef0e000000b00dcd3e78d080mr177868ybd.4.1714062160661; Thu, 25 Apr
 2024 09:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:22:05 +0200
Message-ID: <CAPDyKFqac92AswQvORoiAUxpSj88GVZScLsW8+Wap=NScN3Y3A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] mmc: atmel-mci: Get rid of leftovers and clean up
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Aubin Constans <aubin.constans@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 18:57, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I used to have some patches against the driver, but it appears that part
> of it has been applied (in different form as done by someone else).
> However, there is still room to improve, hence this spring cleanup series.
>
> Andy Shevchenko (5):
>   mmc: atmel-mci: Get rid of platform data leftovers
>   mmc: atmel-mci: Use temporary variable for struct device
>   mmc: atmel-mci: Replace platform device pointer by generic one
>   mmc: atmel-mci: Incapsulate used to be a platform data into host
>     structure
>   mmc: atmel-mci: Switch to use dev_err_probe()
>
>  drivers/mmc/host/atmel-mci.c | 308 +++++++++++++++--------------------
>  1 file changed, 131 insertions(+), 177 deletions(-)
>

I decided to pick patch 1->3 for next, leaving the remaining patch4
and patch5 for you to re-spin, thanks!

Kind regards
Uffe
