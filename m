Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ACF22A4EA
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332037; cv=none; b=AeHRUBUCPtpHFkKYb5wbjUemQWfMnhqHlLawUAL+Tk7UxC0FjqWH5d14g2eSM41kZkdLyuqVLGw4f/miWSQsXvVJvV9c+F4te7dv6uZBG2BOaNiZRqA/5cCAhj3Ub5I8ehxbz4ttGbH9J2DyycBaBkhGNUvV+V/H69GMs197bjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332037; c=relaxed/simple;
	bh=9pSahM0HmxhP6UtGl7AOfeIBaFsaVroRHY5Tv3KWLyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMzQRg1sA3h0DKmRfCG3W28FywZFnXdZo4JGdPWyMjhfBUaOPv3WKLlzKIpE/PcrHcbL5nWIvhMDQCq9fGhZ9UcILqQPVe/P6R9wTju41roTcbwVtEVGQDm4xQODHOHcIy/bFIg/d/MirVTxJWyojc2+93ffCw0TlNHTflvHdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jBP3CyOq; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBP3CyOq"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8276224c65so768438276.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332034; x=1750936834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3xEvTLQHosr95aKQz8ls7/EAhineMRS0oHFEy/wGbTg=;
        b=jBP3CyOqwTdNRnoLLsQKhx96nHOa4tRYXlAUhQCD0vdQFQITa1qepl10XKw8G+bTyc
         lDBvQFt4eB984lr6rmKSvLKXEA1NIO4gSYMA2RQ5VjvJhhN89F7mvzs3/a6JQmNGqOoA
         0iAwqZW/c9YmOpjcs4oxrXbGaurq2ai5Rmndu0yvS1rZ16jKY09nTUYURio4WBjzsVAh
         JGlXkn4d96LJhKfUpP/u4D8lw403/l2WghGhcGKZI6Z0MzFfbZaHq62u5rRZkvPpdcEV
         jQZaLYqag4peRjbuOI8HWoqlQuDJEV3Xe+pOLoDeQj7RwYrEPKIqGpf8wHgB1GsCGYun
         /K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332034; x=1750936834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xEvTLQHosr95aKQz8ls7/EAhineMRS0oHFEy/wGbTg=;
        b=Kq+5yo9N2vl5lv4knGbRI3zJH7r0a0s5/oZVQmnmawjnZImsGJxzBVIS4P970VrYGc
         tLrv+s+6yRfyprKI+u8SKScxCs6fk55x9DUl4gAXJXQAStIFsriRGhrV/SBhSYJL6ZrW
         rL5RzU/5ftfxbyu2oZ60PDBjsalwHXvx47xwxUnFceuXzrTgS11igjhO/ys+24iOLL48
         Oy9gkdgMMyHoZ1V3RePdfRKWdxh0cXq5lKtOZJBqozOMz2tsXuKYFpeBQwiGjIs8qRnm
         a5BibMXuyjIjzebyCS+r55PzjQVzNROf2FIc8J0y5/4dkQfwg/xKGEMF/h/lRzZiRrBx
         kQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXS7yXtvMO+lpOe2+n+zaZyhBr+h4MEx1YVnYtSIvOlN6v5eoGcHuL5pw+JiM8roJJLsyPV+c2H4YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HR6zhP6uL0a84qw8AMarZOzvjzKmXyWk0Wqkam9M6koqUKgo
	8JbgjlCpQazPyRAzPvrkmfyFVeFtMkVVJLNvo/BFE0KsLUN0EDR4fzu2FANI+cqpJbITk+t6gH+
	roXGY2T1Bred4Fnhi914wkYzVWdkD0deBjFvRNmts5lw4KTkCDvax
X-Gm-Gg: ASbGncv4fDmrfw6ioqCP+swu3x+JBCvVkdOAxp4XwjgjSKwG7NZd/3Erx6Iq7QV3vBu
	38QOz5RrM8t+9WSsCkyRn7jTL492HPyK/8sBh99dY3fDDQif9NxvK5MLEKklAM87zXqAGzppU2O
	9ZRUIvwukjbg0NlWd4jC9qPdGLqWNCIhOd/Lf38TtzeAlV
X-Google-Smtp-Source: AGHT+IHReMbe4e7CYUTrFlvHqEy2OoF755pDBH2zwKUZpS8zGhtltmAJpMWBYtkk36UX+5cBHvHG54lCGBmFTund9GE=
X-Received: by 2002:a05:6902:2611:b0:e81:45ca:7918 with SMTP id
 3f1490d57ef6-e822ac9a9c6mr27837692276.40.1750332034050; Thu, 19 Jun 2025
 04:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610072545.2001435-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20250610072545.2001435-1-yoshihiro.shimoda.uh@renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:19:58 +0200
X-Gm-Features: AX0GCFshKpw4sVOE43rS78CtziFk1gnCfgajseqdc-k80l16iBEUigL_cuZ1Hr0
Message-ID: <CAPDyKFqncNemZXZtNBL6EvPuK5HtK29Z19_G2n6z52J3CL5JyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: host: renesas_sdhi: Fix incorrect auto retuning
 for an SDIO card
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 09:25, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> This host controller is possible to change incorrect tap if an SDIO
> card is used because DAT1 is used for interrupt signal on SDIO standard
> but the contoller doesn't take care of it. So, in the worst case,
> this behavior causes a CRC error.
>
> To resolve the issue, add some new ops into the tmio core and
> add fixed code into the renesas_sdhi driver.
>
> This patch set tested on RZ/G2M (r8a774a1-hihope-rzg2m-ex.dtb) with
> EmbeddedArtists 1ZM module.
>
> Before I don't apply this patch set, the RVSCNTL value was changed
> unexpectidly like below.
>
> [  687.103589] renesas_sdhi_internal_dmac ee100000.mmc: renesas_sdhi_auto_correction: rvscntl = 00000701
> ...
> [  768.490979] renesas_sdhi_internal_dmac ee100000.mmc: renesas_sdhi_auto_correction: rvscntl = 00000501
> [  768.500307] renesas_sdhi_internal_dmac ee100000.mmc: renesas_sdhi_auto_correction: rvscntl = 00000401
> [  768.509640] renesas_sdhi_internal_dmac ee100000.mmc: renesas_sdhi_auto_correction: rvscntl = 00000501
> [  768.518947] renesas_sdhi_internal_dmac ee100000.mmc: renesas_sdhi_auto_correction: rvscntl = 00000501
> [  768.528217] renesas_sdhi_internal_dmac ee100000.mmc: renesas_sdhi_auto_correction: rvscntl = 00000501
> [  768.537494] renesas_sdhi_internal_dmac ee100000.mmc: renesas_sdhi_auto_correction: rvscntl = 00000601
>
> Yoshihiro Shimoda (2):
>   mmc: host: tmio: Add .sdio_irq()
>   mmc: host: renesas_sdhi: Fix incorrect auto retuning for an SDIO card
>
>  drivers/mmc/host/renesas_sdhi.h      |  1 +
>  drivers/mmc/host/renesas_sdhi_core.c | 48 ++++++++++++++++++++++++----
>  drivers/mmc/host/tmio_mmc.h          |  1 +
>  drivers/mmc/host/tmio_mmc_core.c     |  5 ++-
>  4 files changed, 47 insertions(+), 8 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe
