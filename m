Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190D446BC
	for <linux-mmc@vger.kernel.org>; Mon,  5 Feb 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154160; cv=none; b=EuHDhsxRY2hZgxUfP+MPBzrtV2MgwDE7c29qHgSf5ff0qP4FtV6xXWlNI1vAxHZ3JNQrjzVzWjrhk4i+qZ2UI0hcyddG8aYArGuzfdhGJkABEjq+thzaMet7FjVBFDE4+KLZjIUfo3li5s6CxFTiVnpXU2ODtITMcq5m4F7+BHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154160; c=relaxed/simple;
	bh=es3DktGPBh05dwkx5i2qdiSJVoOY1idADTS2y6a37gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HK5VxlvGiiLPTqwhGQSqXfnv3WfXNMm1MDeylXttwri1bXAujZkm/1Vv3y3SxcKFy9WuUq6fCeNrz1tUTetjvf7ctNLXmOnYu2R6CMF/qCbx5FbfuYrtU7XqEZnWjzaEaBFAbMYrrhqxwP2EUEmso0xTlIFcNi1f9B+zPpkMxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nwxhN6qm; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwxhN6qm"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6040d33380cso48010067b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Feb 2024 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707154157; x=1707758957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NinqwOuC4qMofgGjRx8zD+hwpAO/q3k3rjwTwr+rC8E=;
        b=nwxhN6qmGHJZIBTWuKOheB7TBrDLJKo5yvmWT4YrwDo7RZxz5gD7y8YIxLWO2IvJ+y
         XtEmRh77WfWvQofwWf70eQLm3b7oSNvG6Y3bCe4eGzZNl/DCC6Tqgyp/OeewEdP6fCem
         qJua+psTMqrE7DfJIA3AvSaxSHpSzHZDCu9xmEevhEuVk8dplvzh7ph+3l8q0gFJ1ADC
         RiDFFSGdZDC4ZhLEctdPa+LLfzJpeN56xtSv3IOJn0OGLLOoPDK7IuUHiMi5h3pVR3su
         2yRfu735FB61uU2lVKdL5qZ7soMbUH5qFEHeDTD0Fbtm14QOhOWXMJdM6CeqJ0Av5kLi
         ec4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154157; x=1707758957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NinqwOuC4qMofgGjRx8zD+hwpAO/q3k3rjwTwr+rC8E=;
        b=XN/1CS0gWHZvHE0oNhqCssTufK3ByWZGU7QL1X90ZUSL+bfq6l28Eq4gyCeRlL9i3r
         FxauDjvwasXpGgoXwWNEv2yJ1vwnvxJX1vI8XR7gnahNnYQAAko5ZTthSc8HQ49Fjkyy
         tMe9LdUzsmIr/rxeaWn75wt0DqLjYfDrPyCj2lRCv2x/Txn/eQYX9t0sWPQfHhFr0tsr
         PgZuHdCKHQlmCZeYRerxGjk7hmXIVsJ14ZW+15Yo72DFe5M/UocRRotEaNma2FVlCWoH
         pobFSxoJwhAaYrFQo8RIhkSsn9gFpz/4566UNDuGZ+D8cWdiFXrhFXiy7ZB4/jm5KUGw
         hcrA==
X-Gm-Message-State: AOJu0Yy/XTfzEQ2YYi0uuJYHLYVOiMR1zH71nIeucgsl1H6ltdrO+JEH
	TnscbBNGQhkokPXC4eK9TpFRAtbggh/Jpc6R5vgvddLC019ZUblCS50KPPgeLXRVm282zBU6W4k
	zaAjGlkxfGy3BljEQ6vRiApgs2l+2F8Fo/WDytg==
X-Google-Smtp-Source: AGHT+IFO9mSeOm3Uy+itY0C+eVUHYH1eSpbF967sxuZKmQRI4cYGC/XH3XcvJFqRFVwgUMTe4eDN+Hg2UXv7cY+7tPM=
X-Received: by 2002:a05:690c:3686:b0:600:3a38:a815 with SMTP id
 fu6-20020a05690c368600b006003a38a815mr274401ywb.35.1707154157600; Mon, 05 Feb
 2024 09:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>
In-Reply-To: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Feb 2024 18:28:40 +0100
Message-ID: <CAPDyKFqkJjdc5vNr-wisTPXqf+2ORsBkcOZUS+LyaktpN-cCKA@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: make memstick_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 21:05, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the memstick_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index bbfaf6536903..23fea51ecbdd 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -164,7 +164,7 @@ static struct attribute *memstick_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(memstick_dev);
>
> -static struct bus_type memstick_bus_type = {
> +static const struct bus_type memstick_bus_type = {
>         .name           = "memstick",
>         .dev_groups     = memstick_dev_groups,
>         .match          = memstick_bus_match,
>
> ---
> base-commit: 4e99ffb173faaf38f010acb369bff57a20e9e531
> change-id: 20240204-bus_cleanup-memstick-071b3564d808
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>
