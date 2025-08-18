Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047B318131
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514525; cv=none; b=Ry88P5IOfbJwJN/33ciHmxHTUQKs0GaADN535Zr0v21B5wNhfvkUgQMhTRxphvyytP2eLMbeEZJRDrHQ96P6LR8rJUdDSHgb/5FyLXr1GlfMreZHJIGxGs7ioGNdpQ+6qGCELVcYqwcMLvmBL8NOHVg0oEAQq2/FLrK/d38ND+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514525; c=relaxed/simple;
	bh=1B8WjQD8aKur+ksU7TSq0KwogfrxP4QpmvyI6HIFcPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnEApPHB8T9wDP6r7imDvECGMTOte8RhtlciQCzV6AOsydPYYyTcB8yVJfvTUg+sXbHHwBVSo3WYJxQdG5IIX9qMqOyxymSIOJ8fHDKTzU1XK4VI0g5phBBI8TWgy9yt6+LZXUSVel4xo9Omi6O7dlL7vOdDbV+T07OUNjtih8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JHBEvL/1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHBEvL/1"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d60504bf8so33610767b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514523; x=1756119323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ENmtRIEDhmxvQ94icOvqd3Bf6ucroHzMRQeAeEkJDjc=;
        b=JHBEvL/1S/HcebvdO9h2iVbobK3c7au2nja8q0crcsVVU5ZV/LjEtLoCpH4QxISnXz
         Ty4dUx6dieK8iemoCVZ6Aj8yfJVvsW2nfcECPtspLb6nPkEr3ZqNu3W8B8DtjwV3zkhX
         5vo7U+58q/jHw200wvvKzW0S2PjwuzyGaUQuxNVKNuZJKFwcGbTRNf2XbG1S8UWr46ft
         AKANHDkdvTZpO27NL1JkxGoyc56LSzNJf/4cisj/LhOKKosgl7Lo42315v0pg/HA82Z2
         KGNvYuMhK8EvyMUiu8Mf9yZe/SXSoGKcg5tpO7T1sbvV+8jBpch9FxQp2CGhOnT5qRbt
         7qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514523; x=1756119323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENmtRIEDhmxvQ94icOvqd3Bf6ucroHzMRQeAeEkJDjc=;
        b=Nv7IXWsXY2+t8Ze82xdqxrPvNg/Jyy0EWcPuTRWoN+ACSh2TJ1ij3foWOfc29vy5sh
         7+qjrnvRg+HxcI9uCxosNsao+3XsD4pSnrMR+2JfyEsoGpre+CdJyo9mq9QpvxGWDZwo
         WSnwbVmV51umDPtGbFjqv9SvSUzVzMQlS+VXbQsxl6voayutALHisSadd8P1G1XMBj47
         017roLRKFOFTsI755sj2eRanvAh8cydcn4c5Vj5RQEFXiasdkoakC9WcYdUCTEr5ef5p
         R1gxBosySO7KS1Ay85d+Y6/emzVaU52OMFT9IxUmn+cKfMqHgqCWKOtSP8bV1Qnvbg+i
         x/PA==
X-Forwarded-Encrypted: i=1; AJvYcCXK3UcQ0VI502pw7suT+K+3pzdY9YRZvjEzCO4K+KQd/0jEInSn5ZlgFYBfFeP8vSadCSeHDu5tWxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kXA1RPSds1IEF/HUKpzMZetW24fog15cCdfgVysjRbz78kKS
	RFctRU8PKRB85acWTzRJqIh3K3L3CYLSmyu2vZh7SlK4etvMY1LivSoWtQ9uDjXFldn8JOTh9/o
	Yk5zr2dPa8B7FLnArZKFT8AYRGvOfzxcM6GPz5v7AeA==
X-Gm-Gg: ASbGncvYMHswETPRwe/YUGzziVAiRLFo19qTVGv9ZgBFJDc7HydJVx7d/LVqBieNK2L
	LdlIaDDkoGnA6rN36J8rzbB/4dCjwT3PuAeFNEjfUkRwvWvr/uUYQF2qwGkFCoXk54j2eZEQefI
	yqlsSZ0Hz1ONpsAczkpVHgno4VJQYHFOVFJwZkG0gqJYayytjW5ZnMBT/JxdwXDR88/HK7Nw8TN
	eKbACX+W5j+MabrO3Q=
X-Google-Smtp-Source: AGHT+IGFrvcRLmBqC4ykAY5f9r7pHXOXtSKkgdQx0dMA+FB1OXOj4uJgVPQiYyCZtPfzGrL32zU3NCUmh42e+GVA1xk=
X-Received: by 2002:a05:690c:eca:b0:71a:45f7:b78e with SMTP id
 00721157ae682-71e6db0daf0mr134659817b3.26.1755514522745; Mon, 18 Aug 2025
 03:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728082230.1037917-1-rex.chen_1@nxp.com>
In-Reply-To: <20250728082230.1037917-1-rex.chen_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:45 +0200
X-Gm-Features: Ac12FXwJq4t3cFVfAr8ETGstDf_wr5B-SQb7QqMcxinPkFAXCan72ZZuywZKj8s
Message-ID: <CAPDyKFrSYohNh3tFRZoaPjAm=4GOe_Q1P2RS=8GD7i=BhD=UZw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2]
To: Rex Chen <rex.chen_1@nxp.com>
Cc: conor.dooley@microchip.com, bartosz.golaszewski@linaro.org, 
	viro@zeniv.linux.org.uk, linux-mmc@vger.kernel.org, avri.altman@wdc.com, 
	shawn.lin@rock-chips.com, adrian.hunter@intel.com, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 10:22, Rex Chen <rex.chen_1@nxp.com> wrote:
>
> [patch 1/2]
> No change for patch 1
> [patch 2/2]
> Add more details in commit message
>
> Rex Chen (2):
>   mmc: core: SPI mode remove cmd7
>   mmc: mmc_spi: multiple block read remove read crc ack
>
>  drivers/mmc/core/sdio.c    | 6 +++++-
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> --
> 2.25.1
>

The series applied for next, thanks!

Do you think we should tag these for stable kernels too?

Kind regards
Uffe
