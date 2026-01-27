Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F430B51E
	for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2026 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511722; cv=pass; b=bfpVFs4l9FfJ98ExDcgSMaBEUQRvTXImic/iKLrWLmfebsXYf4UwVtfG2YONO3fE4CzCAbofc6PWrg1vPDEf1RrxMGBu8Ubd3Wd8Fs4qy/3JwnudAz8RF77HMd+Mb7PumRwFNIg/QN5lj81eaq3/K8bBNDnEaSXz7jzcQilo+Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511722; c=relaxed/simple;
	bh=B8zdYTaGcvallBhBtXowYFbPk/Q6LuMK6Up0jicjUT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgO00/epnW3/m9sVLsPdx8ZjD00T/jMfEGHda3QuizQiZJZcqBd5epgF99BuaHOMsbIa6lstOekLFA7z0ChUJo7OGyjrXG/nCu7FPqZJbL4C7E1vL4dhqFwK89Ir7WvC9OPqJNBM+FOjvMUucVmyKv3Rtc8fjQ4e0xuFtvTGdi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Myjrrvkb; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Myjrrvkb"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dea72099eso4413369e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2026 03:02:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511719; cv=none;
        d=google.com; s=arc-20240605;
        b=NhxDkrw0N/NZ7lRFZPmryWfp9MGOfKYDoffgSEzTaI+rYzjxdazbx/U4WX2Joz4AIy
         ZJ8hzrnDGQtn8g8NLg1eHjIaJl6NqCeh1YNxn/QkhVYpUg90JQ6AQWMWbljiguteQF/Z
         AzCeerC/JMZKZrZfo5TaiCh52p+3MWtScBxfZVqsVlATmOrkRSGaDV+7NNufMnAQrbMl
         0w8yuhVPuzY84pvMS9aV63FmICVP600lk/KtrWdOIJsvAXfwgnC35u0gablh9yKBlV3V
         RWQvSsif89Vyj9gUD7MHOdkS/WBx5hgaG8LqqNebpvOUX3f2BPqLdNcqJ+Y9591gKC/h
         TSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OqeEVMZrY/b1NpZNa3oOu9VBtor2/8rkEIETkYfILLc=;
        fh=kFRR0MApUesuhdp+QW6Ep22ciKUFkwQbhealSGQsktw=;
        b=EoGD1mZ39mBeMzHekMqy5mDl3ykMfYYCt5YSrzUFwXxREC4pi+FyfwDc6tG/CUm28F
         AaHXWF7plV/+z5dztEfInaC2MigYS/WnlPClDEYpmLpYWFfI74sxAn2eSc3WTrK1O8Rj
         KTVGRS+DD1aeSxWBtrg3C6sn3kX/EVvFBj5jIRXq0xsCAE4dVonsvpa0i/Dnn17AZVo2
         1h6PUws3bMqODxKLvBtDSJfBJa116rAWQDG8hL3HQF2Iz+YxSxFXwydNMHLBlRUZRiEY
         5XkCwaqPCS8wc7u2hWokDQFdcEwkeXUE5OQmb9vGc2kjR/sjQY4EOK5RyLCFE6uigXNo
         gHaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769511719; x=1770116519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OqeEVMZrY/b1NpZNa3oOu9VBtor2/8rkEIETkYfILLc=;
        b=Myjrrvkbms+/zSeiNRh25LRTZmgqgs/ALIYMlO5Zl6nbM5cWEOqQGf6K8gLa5bMP6h
         C7ldnd2LUEITaAQSjFTeu0e+TwH/yyi5jyKFUXucYSmpyH1lbTP84AMbCk+TdL3W2nlk
         w5fIxhasviwFxrpHL65ruQZsxfic8Dw1Y6oEQr1MeP0JI//mSLjtU/q2kljZj2rT+Ymy
         yxjMznm8a7FZ+ISeUloUoGi5oKph05sQlLWg0OTc0yBRJksmFoduOB7drZ+dtuw0rMLm
         WZOlnZ9C3TWASwwFLJ65kVNHK6RdXRJj0q3Y0kFXygTLAjqe6VHzSBmBfkLvGdZ5vL9I
         eUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511719; x=1770116519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqeEVMZrY/b1NpZNa3oOu9VBtor2/8rkEIETkYfILLc=;
        b=aPpcHtiYiJRzKUzp4n3vDO9Sis6rS9hTL2S5Ybh0Dk0DkjVzQ2zmsLPtwphq8WlGFb
         A77GzNYYXwiGdmzSpoawKBWUwSAzpTurd9dJHTkck1Fh914OUkXhPBP6bgTvPQh61esz
         CoWUHwmt3usOVtpxTtqTtcWgoozcirvjs9yr031mm+9/jV6ABx1VqwU/9+JXHLeSMK91
         GTuLzPBQ94me7XifGnYFRGR84oaLBJ8ohk1ranNd94Tsx16NBKq3V9/nemSml1Z012lZ
         rQZ2zYA40KcVuGFSJcjQ9KiIbDgmr5W3oXJIhz0cgiLuACvdjEd5SQwCONZc0tBAViys
         2EBA==
X-Forwarded-Encrypted: i=1; AJvYcCU7cNbvcjcbd0qybj3KxvJrsUGNQknFM7udLiUNIxXbg9XcwSB9ZsGI6Z9wHjCsbOuAdlxgd/nVUBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYspcS0EinVbdMq2X8SI/dncNXNA0REyWjULEZtzPKNYQMbpQ
	G4YJzrTd3o6HTOzw2JnN26yWhIP9VFqqrcM6gKIk+MWoBE0WmqYTPlgRnfEjq4lJ0la6eReRTgE
	BvfXPzAtEux3EgX4CF1bag8UKb70Jr1KrmyXSpInoyg==
X-Gm-Gg: AZuq6aKXFD6w21vueXQ1riMQwu7ts9RVN2dwPNDCDBh27Un00m1BFndlhsqUejlEJ0x
	nHW9OMUzE9hlRa/it/jCRSHsX2+RbTzA4MPyY5nh6YV9TXqsKmBi0RIvj7xf1bBNBGBybAns13w
	C9CALoHwt5HYr+AMDgzwG2JBOO7bDHRaPm3R04gRmzlaJj1gHdLDpt8kcfp6JWQpqYJZpcy9s08
	3g7aaPDcwzTgVgoM0GzXYAcp4vzvrSTGU73l9UdAA3lWuk1e/zopYfMRBuCtsEQKHnoMJJvsLZj
	k/oYFHA=
X-Received: by 2002:a05:6512:3407:b0:59e:39b:f46f with SMTP id
 2adb3069b0e04-59e0402f27fmr590217e87.43.1769511718237; Tue, 27 Jan 2026
 03:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1769171049-74327-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1769171049-74327-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 12:01:21 +0100
X-Gm-Features: AZwV_QjWKWIZU3kG6heS5jQbYm2iHh9G7GKnI8uUsEJZ2hAre5A9ItHgOfjtB5Y
Message-ID: <CAPDyKFq_=7SS5RWyFXYjec3hTFdwN2_aKAt5O6SqgBuYxFh7Ew@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Remove deprecated mshc alias support from dw_mmc
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Wei Xu <xuwei5@hisilicon.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 13:24, Shawn Lin <shawn.lin@rock-chips.com> wrote:
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
> Changes in v2:
> - Fix a warning(lkp)
> - reorder patch sequence
>
> Shawn Lin (3):
>   arm64: dts: hisilicon: hikey960/970: Convert to use standard mmc alias
>   mmc: dw_mmc-k3: Remove mshc alias support
>   mmc: dw_mmc: Remove mshc alias support
>
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  4 ++--
>  arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts |  4 ++--
>  drivers/mmc/host/dw_mmc-k3.c                      | 23 ++++++++---------------
>  drivers/mmc/host/dw_mmc.c                         |  9 +++------
>  4 files changed, 15 insertions(+), 25 deletions(-)
>
> --
> 2.7.4
>

The series applied for next, thanks!

Kind regards
Uffe
