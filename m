Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8302405FD
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778728; cv=none; b=QjBdWexWY6Zumuy38MOgi8I8UUmN8Yi51bUVxY//JMoOui1AN3Ak1Lgmyf8mHRZxooZfswmsagHczzzhS0T+C4QYF2mvGgQRcF9EJFmqV0wTzxuhCuMvrIMcFs50FtMuwMh6Q8wKkT3gcvqDB2Uq+EmRX10rqktwqHTIDMA4oN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778728; c=relaxed/simple;
	bh=gpg13+5lcJ27cyd2qIUlam+OyNduSaoZ/y+wkwR2QLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGPIR/LNoYkzW6sRCU+YSX1UIg0YblVwzJ8hRkHbT+qe8jYxwGcOGxrCx37QaGft9DpuEYE8BNIQVnvlENVJEeN6iUuEFELsBGzmpqUw5DqomRixcM4VQQz3GtAzfBxlzg40p5f1vsaODBHn3FYFJ2b3E9TgSot3bhYUnY0sk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pyTFDcuO; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pyTFDcuO"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fedefb1c9cso30675327b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778725; x=1742383525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qX0rkI4yHqqhFecDGUI0HeTVPb45T3mxEAw1sgnVvzo=;
        b=pyTFDcuOjGqrGbCblaf6Zhu1QWvBt/EMx8KTwk469YNZ+zr8Jq66+x5kMvh5/rQJri
         HLqF2WVBwrvtMDzUqEZ24lvRLkBALLHSi0p9jFCXTfw/c3z+8e07iBFcYVLdSm5KA9aE
         /tmlBUC1b3nb/JRDlq1qovmQnv5JM1jx/8dc+txHK/bBQLICnPD8yCRsojmemSPDUGiq
         BcK8O52ORdqEUcqcBj/GKsjf440eluXf30WbgMovrRFWwp+0TaVjwxLsUVbwp21thw43
         AWGf6Xs/UH6NJbyPzqrJlf99NZtA1e6OKHtqqFyxS6+8y76MtXdp0jYUM2XtTnREScJD
         qVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778725; x=1742383525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qX0rkI4yHqqhFecDGUI0HeTVPb45T3mxEAw1sgnVvzo=;
        b=LbtQNjHwrKVdq7zk0Q7Lt+6r/h4vLF7DAp5mXwN/69VRUApTuncrzE9NglLiu8oEjC
         NW4FvcMoTzMsipdXROn34aLv5ELM2iWEQKWYjlAjAubRDwTS1QrR5akRzNbfGf0NT/Hy
         VaDWvEk3/OVbqQxuTd+qE9g3KM2CZvF2AjzNxNJJBPTglWdrs2KmnRVDoRkfcSVjA5Rv
         20egLq87hUa0fYTum7Grvzp3Sht/RU7J0Ehqyb2JWeO1F91SAYOJGVQRYP3vQ8THl5RC
         euINOirH2YoCvoCsIcn2/QV9K42jUsMRBPZUaP8ZdoR/RaZx3QEL7k3K7BlDiDDsU143
         Abfw==
X-Forwarded-Encrypted: i=1; AJvYcCWiJb7PxeivFM+fUeDafR+PB/8XZnYbUWGFOA8IOgwnhDHTabZnIY49AdAbphwlBpH3vsr6f5feKjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSMyUmBBIQTN/uBW+TUqUIt2dL04F+9mcIxrS9D/2zinUcsg7
	wVpDcCxX5osRUO3NvVbld6vJMmgQAcze4Yk755gBY6UigdNDIJSy9cvE6AvGsHYXHoLnxExjgYP
	Z8J2sGLgcb1PeIWvNLXn4L1KOuNV1CuDrRCW7tw==
X-Gm-Gg: ASbGncsbl0v+l+ZxOEOBxqUHBmqm65bI1UyfmDcE1rTMdcEZgCR6dHollq+FI3e4DcM
	E0lqjtwsGxyQebNo4W0AfGFIwiUQp1NGifYBGSARQI8iLZK0E0mUNpa5azeOulM7iIa9rGd/6oy
	oXFdjFuPR8wTg55OBsFsVWQ84qQeU=
X-Google-Smtp-Source: AGHT+IGS32+wqYOKVKL+g25yiVlOhar5polgyd9O9jIAFQ6UlSG/aUYOwExxSV/oXR7UsFYYnIZhWGgQQRhWf+zVjMU=
X-Received: by 2002:a05:690c:700d:b0:6f9:97f7:a5c3 with SMTP id
 00721157ae682-6febf319c11mr300683207b3.18.1741778725134; Wed, 12 Mar 2025
 04:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305092958.21865-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250305092958.21865-1-biju.das.jz@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:49 +0100
X-Gm-Features: AQ5f1JqiZN6BAY0C9sURqoDIHUzj-6UfGLeCT0-XEkkgIzTP6keEfXSAu2YKu7Y
Message-ID: <CAPDyKFrX5gD0HeRNggyhCZvdMQqLffhjMtkky2_2RdoVQvbyMQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add RZ/G3E SDHI support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 10:30, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> The SD/MMC block on the RZ/G3E ("R9A09G047") SoC is similar to that
> of the RZ/V2H, but the SD0 channel has only dedicated pins, so we must
> use SD_STATUS register to control voltage and power enable (internal
> regulator).
>
> For SD1 and SD2 channel we can either use gpio regulator or internal
> regulator (using SD_STATUS register) for voltage switching.
>
> For SD0, fixed voltage(eMMC) uses fixed regulator and non-fixed voltage
> (SD) uses internal regulator.
>
> v5->v6:
>  * Added const for renesas_sdhi_vqmmc_regulator.
>  * Added Rb tag from Wolfram for driver changes.
> v4->v5:
>  * Collected tag from Wolfram Sang.
>  * Dropped redundant struct renesas_sdhi_vqmmc_regulator initialization.
>  * Added one space before '=' in the struct initializer.
> v3->v4:
>  * Dropped dts patches as it is deferred for queuing.
>  * Arranged variables of same types close to each other in probe() and
>    dropped patch#2.
>  * Added sd_ctrl_read32().
>  * Replaced sd_ctrl_read32_rep()->sd_ctrl_read32().
> v2->v3:
>  * Collected tags
>  * Renamed internal regulator labels vqmmc_sdhi{0..2}->sdhi{0..2}_vqmmc.
>  * Updated regulator phandles on SoM/Board dts.
>  * Dropped renaming the gpio regulator label vqmmc_sdhi1->vqmmc_sdhi1_gpio.
>  * Renamed node sd0emmc->sd0-emmc
>  * Renamed sd0-emmc-{ctrl,data,rst}->sd0-{ctrl,data,rst}
>  * Moved header file gpio.h from patch#6 to patch#8.
>  * Dropped overriding internal regulator name.
>  * Dropped #if guard in pinctrl node for SDHI0
>  * Renamed the label/node sdhi0_pins: sd0->sdhi0_usd_pins: sd0-usd.
> v1->v2:
>  * Collected tags.
>  * Documented internal regulator as optional property for both RZ/G3E and
>    RZ/V2H SoCs.
>  * Updated commit description for regulator used in SD0 fixed and
>    non-fixed voltage case in patch#3.
>  * As the node enabling of internal regulator is controlled through status,
>    added a check for device availability.
>  * Status of internal regulator is disabled in the SoC .dtsi. Override
>    the status in the board DTS when needed.
>  * Added support for enabling SDHI internal regulator in RZ/V2H
>  * Added missing header file gpio.h
>  * Used fixed regulator for eMMC on SD0 and dropped sd0-iovs pins for
>    eMMC.
>  * Sorted pinctrl nodes for sd2
>  * Enabled internal regulator for SD2.
>  * Added support for enabling SD on SDHI0
>  * Replaced the regulator usd_vdd_3p3v->reg_3p3v.
>  * Renamed the gpio-hog node sd1-pwr-en->sd1-pwr-en-hog.
>  * Sorted sd1 pin ctrl nodes.
>
> Biju Das (2):
>   dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
>   mmc: renesas_sdhi: Add support for RZ/G3E SoC
>
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml |  16 +++
>  drivers/mmc/host/renesas_sdhi.h               |   1 +
>  drivers/mmc/host/renesas_sdhi_core.c          | 130 ++++++++++++++++++
>  drivers/mmc/host/tmio_mmc.h                   |  10 ++
>  4 files changed, 157 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
