Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01703152197
	for <linux-mmc@vger.kernel.org>; Mon, 22 Apr 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808602; cv=none; b=PbFGjAZda1yT39AGHCX/WQEMHbuLbQT61RUaYPgWLApKn+Guc8NvkQQ27LQS05nYAVxxP/8jG9m8jm1GzOzg+tzSnPrZARlv4gTd5Fd/6gw6HSIxzdfAKdlBDe6I0YDbN0EMPWR1gqaVJrs4qiz/vfaiWK4dwWV+zOnRR4QV0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808602; c=relaxed/simple;
	bh=CeDKuqZpRK5NjHJewgOWK37JtlkW9wLhfxLAr0U/bcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ4IO+MQ/jpdz/rlYG97K+4auDvnXE1yMUOHhZzKUWbln5/E8r7KjO+vSCN6EQ+cUfmPM5+kA+K7iJGX/H56NCcaQBZc9/Ku/VGnUL5lB6YVk91ALyeoBLrs5D7AekZ4FODa8P1zacqGeIqf/xEBP6gZyHaE/oW3G3kCpGbmGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3KXTOR7; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3KXTOR7"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de528effbfbso1313140276.2
        for <linux-mmc@vger.kernel.org>; Mon, 22 Apr 2024 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713808600; x=1714413400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSNE12RwAhLSsb0j0icuv+XwFCbPVvOY1VkFNRGWJ0k=;
        b=c3KXTOR73lfzDHYyGvNTs4GWd6b4r3wWVjwvBjGvNDUwEdQhT9E2qfj3VLYN38PFMM
         fSmBvu1c81FLcLtPwim3S9+x+L/7xrgtoCLbH2YLVZaG8Xtz9cfE2YLkiyNgW75gjCtU
         KwX99FwVqlg9KEYDPuXTs/ivE0RgntXsCOrYfbYs9eWkFUCOCOv7oRzehoc/gjYIIbJY
         UvjhD/Hxwh3UWNoWJ1tWhC9R2QHqjaHpuVCsmLd+xHWgwreaDNgjYG8ss7vPchFeZLJM
         CGn3uuJfQjBuQK8TEcmawjkL75+V2vJg5gLaTgBoFkyEpzTPxODH0psiUKG3V1Yy8PqV
         jNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808600; x=1714413400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSNE12RwAhLSsb0j0icuv+XwFCbPVvOY1VkFNRGWJ0k=;
        b=g23k18ZkA7shGJQGd5admlv5LZ+ypQlsCmkgJJcszzUnyY8hnqE4yxi6V1AjVO5kD8
         yj4Lv2I3ErnG1ERjm3vXeFO7WlLQU3sJb/T0GKnAFcwsq5zMio9zhcyAVri6Tjt+h5Hn
         xOQttzJdia9Z2PIf1xmCbNTXQSngh2v5XHKhhUYxBbmvK2OSBlXoFRdgV4h7UfqTB/1C
         EEdUADLToiuqHD2Hz+xeFU+cbnBdaiWkNQfOr393UyibNkQwdqQ5BAXP+TWLNXGGIFwx
         hv9nYpH9SIsANsNS0JkoBZd2sJ0Aey4ev1knDyI3FtW5cTFRNMbmvfEry1RrA9tk7PJ0
         UyKw==
X-Gm-Message-State: AOJu0YzRPhply0cdYkx2YwtOBHvYx0fWc/OUbalou3XeSn8OeFK8AR/a
	/MDWQQEDamzyfUFLmIqThrUwsZhOhHJndrJBntNgGJIt1CFyvJpcqcapBFmhUMyjO2f8eht4XdR
	aUWhvZ1NaoeCXx60JP/89yz5jJmoMYwhT8xypBuAWdxhXDZdV
X-Google-Smtp-Source: AGHT+IHh+dL0ZbMEEZYwmSys0EHDkrAGlP1eanWndxqE2I8DK1sRBuCxrIUDoHPepVykUJYdVg1mxxd/7dT8rQ+SUJk=
X-Received: by 2002:a25:83ca:0:b0:dcd:13ba:cdd6 with SMTP id
 v10-20020a2583ca000000b00dcd13bacdd6mr9918017ybm.47.1713808600074; Mon, 22
 Apr 2024 10:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422153607.963672-1-saproj@gmail.com>
In-Reply-To: <20240422153607.963672-1-saproj@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 22 Apr 2024 19:56:29 +0200
Message-ID: <CACRpkdYoLjXHwN2EKsxZz8FdxNQ8beuqSO6EX9CjZmE0nX3tUw@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: fix handling of sgm->consumed, otherwise
 WARN_ON triggers
To: Sergei Antonov <saproj@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:36=E2=80=AFPM Sergei Antonov <saproj@gmail.com> w=
rote:

> When e.g. 8 bytes are to be read, sgm->consumed equals 8 immediately afte=
r
> sg_miter_next() call. The driver then increments it as bytes are read,
> so sgm->consumed becomes 16 and this warning triggers in sg_miter_stop():
> WARN_ON(miter->consumed > miter->length);
>
> WARNING: CPU: 0 PID: 28 at lib/scatterlist.c:925 sg_miter_stop+0x2c/0x10c
> CPU: 0 PID: 28 Comm: kworker/0:2 Tainted: G        W          6.9.0-rc5-d=
irty #249
> Hardware name: Generic DT based system
> Workqueue: events_freezable mmc_rescan
> Call trace:.
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x44/0x5c
>  dump_stack_lvl from __warn+0x78/0x16c
>  __warn from warn_slowpath_fmt+0xb0/0x160
>  warn_slowpath_fmt from sg_miter_stop+0x2c/0x10c
>  sg_miter_stop from moxart_request+0xb0/0x468
>  moxart_request from mmc_start_request+0x94/0xa8
>  mmc_start_request from mmc_wait_for_req+0x60/0xa8
>  mmc_wait_for_req from mmc_app_send_scr+0xf8/0x150
>  mmc_app_send_scr from mmc_sd_setup_card+0x1c/0x420
>  mmc_sd_setup_card from mmc_sd_init_card+0x12c/0x4dc
>  mmc_sd_init_card from mmc_attach_sd+0xf0/0x16c
>  mmc_attach_sd from mmc_rescan+0x1e0/0x298
>  mmc_rescan from process_scheduled_works+0x2e4/0x4ec
>  process_scheduled_works from worker_thread+0x1ec/0x24c
>  worker_thread from kthread+0xd4/0xe0
>  kthread from ret_from_fork+0x14/0x38
>
> This patch adds initial zeroing of sgm->consumed. It is then incremented
> as bytes are read or written.
>
> Signed-off-by: Sergei Antonov <saproj@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: 3ee0e7c3e67c ("mmc: moxart-mmc: Use sg_miter for PIO")

Oh it was that simple.

Thanks for fixing this Sergei!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
