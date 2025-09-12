Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BD30B527
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684128; cv=none; b=cm2U0LkhF4a0EI0mnfb9A61/GV62AYN6JT1CoggwjH5IdyLNPzIjJpEin+zyj0dckx6ThHsZIJHgparcxCgqFbpIOGzwoOJoH7/0fz1PfXeNU64cexi57ekqQRmG9kTshskj7SRcwfk4AVMY73Lw6sabjQda9/OVWGjjwNz3cP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684128; c=relaxed/simple;
	bh=DhFoXxx/ZoCRrl5/qjZ7xUGRby29SFvFRCBfMl3HJ6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhB1F7iv874vsmUpvahfQ2o/WyScZ8/EgRaJQuJ3iyDMyBrIa57qYQq/D9fbHJPOtubGmLNLxAl6uQeJtTZM78POw4xkI05lVFzP40S0DEWPczJrsOpU7v1F3bGZhPRvfQ5Q8XBQdsXzo+47wpQAK6/iU3lKWSGpYIxVM1gp1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ric80Gf7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ric80Gf7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e98b7071cc9so1871946276.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684126; x=1758288926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c3kENDuYQWIaoY6qZHpDDkAQPYvv0d/p99bV+wo3us4=;
        b=Ric80Gf74IlHSdmv+iZMzYo8Jt4OBLOfQbJIxvSteNwUZQeCQPYkw4QClxyhJqzNkI
         2ZtsIS5g+HPC6MuMZSmif8CVskX7AP/CsuYVIhIiBxZk+7irVXrgbX5x3T453RShJNwx
         rzovM8qEjZlPZbZbbif6fqPubaUe9z0NlooBa9g4C/acqlYYfJLOqxpCugkzg8BVsLxj
         LcUJYap3dvhnSqeNgTOrC3SO3BqosM5XVC600maofslWvSK7tYpvrW7u1B9V6REHV6NJ
         LkzcGYuuIaX/9e6WTV3OWzTyBYu2dgPym39dshgHCsWtXaY21n/qZ3DjMbhFEZEXwdiT
         GUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684126; x=1758288926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3kENDuYQWIaoY6qZHpDDkAQPYvv0d/p99bV+wo3us4=;
        b=bRUa6JfRKxzE4Fss/VPMIeEW7QRPajOLDceTKIVcWWQq6L7qAf+JSqrLKuJW16oEBW
         L610M0ww9xu5UVwmEvfjv0NJE9XQXWZ98Q6XMoYWutJ/Ufj2yHlCo2VPITkQQaqM1YKE
         PZscGfDp5jdP9IdIRIHr5Z/foNVwXLXAKAPgFbK6ZGS5qEjeD+qfNIUT3szp8SKo1Mg+
         U/mQ9fhLdiK0emJjP70Ejuv15xslowQPbO+2/UKAG4A3eHDBTYoBxaGmw28T5oih8msd
         wD2CHYGv1FQ0Fpq81PMTpHmfG5kA04Vc1N7FiKnJfS0ac0J4b7HJyZYDbVwUs2SlZZ6Z
         TBhQ==
X-Gm-Message-State: AOJu0YxfjAcstoQOiogH/Abzthz3+AIjFHwpCNovxw32bhQGaGUeR3hr
	PEKqKHo9qD4/DATceMdp42h+KOe4zbQFi1H7PY98EreM7yprkheTYgZqw9GcyBgH6xD7NsCEclV
	IOzLiW6/bm/JEwRAvVMYLUH4xff5wM65mpU5Xqr5gMA==
X-Gm-Gg: ASbGnctsgM9AG+kUiD60o4kPGW2jzrDuJ7ABBtRP10JOe7wy4Xje5R8wvRgNpQ9X25c
	uD8WDbq17MaRS0TCpXFfrS0DEAbIplp81fM6M0TS30eaRh4Q2vNwezNkILDJ5bHz53hZmqbeiDs
	6udg9+wOblGfsXAbQR2mr+dLuVDZjHn5p3kjUhsMQkdDC7NTevUihNbdTTBm8XVYP2Bp9R2AShN
	RLwFZST
X-Google-Smtp-Source: AGHT+IHLY3sJ+XBl8M0ubtCgBLh8VOl745m1FRhd77E+11Vwzivys23HcJIA4EgLnrKjqSEQGf8a+h+TbT7IcJJtj24=
X-Received: by 2002:a25:c2c5:0:b0:e9d:681d:875e with SMTP id
 3f1490d57ef6-ea3d9a6d46emr1593265276.40.1757684125476; Fri, 12 Sep 2025
 06:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31fb75e1-abf4-4fb2-b838-074edbee5423@siemens.com>
In-Reply-To: <31fb75e1-abf4-4fb2-b838-074edbee5423@siemens.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:48 +0200
X-Gm-Features: AS18NWDS7KVI1rsrqJNrqvjTfTkRubUyv6FBBxJ0WEgYZI6yaYVP8dNW7ubUwOs
Message-ID: <CAPDyKFpQ1CnrbttDnQMAF8xyeuJkT1v42ZCXSaxQawon3Pk3tQ@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Warn during rpmb read-counter on expiry
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-mmc@vger.kernel.org, Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Sept 2025 at 11:26, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> When the counter reached its limit, any further write request will be
> rejected by the device. Warn the user in that case while showing the
> counter value.
>
> Suggested by: Avri Altman <Avri.Altman@sandisk.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied for mmc-utils master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 429a9c7..5990502 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2360,6 +2360,8 @@ int do_rpmb_read_counter(int nargs, char **argv)
>         close(dev_fd);
>
>         printf("Counter value: 0x%08x\n", cnt);
> +       if (cnt == 0xffffffff)
> +               printf("WARNING: Counter expired, no further writes possible\n");
>
>         return ret;
>  }
> --
> 2.43.0
