Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855901D63FF
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779708; cv=none; b=NE2yTNn823qxS21H1aAAdt0cf4s9RB4hf/SICu1U53vfP8hLJm5hHkqJjdeYfSUMDlB1YIf/mO+I2JyfYI2LCYbLkIskCw0IWrCZbyEeQjzhS6YfUfnpf141DuK7Cr1AjdtsMo4t3jR02swteMeRi469dztw2va1OtnoZZP4Kd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779708; c=relaxed/simple;
	bh=7X6sEAaSMthvUSCexSRcw4P0r/3b9gVJHLUMo54hiyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbWtzWFBE1DmX1eGouEJFJ3a3H/livqhiqZpGtQS8m39xMPz8uVHa5YPTGmi4q3JRwBQcPMhz1EwK3y5pFYe7B3etHgyJg5f2TQt/egKAvZFezsxTd9BoCWdW+KTVQmqKJMa+fgC0gPZiKmTsaFh9cO/gS1F1OPdx26cDxX3bpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bYSMV816; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYSMV816"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f6ae4846c7so62079027b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741779705; x=1742384505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ioGw4y5xwbpIgtHn7hgYihYbHTQjfV1moGfCfOGeOos=;
        b=bYSMV816QlLFGv6feQ6463knax1Jy0eAQk6jVYYGrQLuBkALk3ltKOC1+Dh46Xfvvd
         H+5zbe0WxLkT0wAe2JlCIkPo3mvZoL0GNaUpwpXG2gVhLfH1Tx+hZvG7InXd9VVRgrPG
         oSbtl87DO5GaHor77IzCz5+X/kKvvEZ8kiRsUU6UCnVeROCmX26pKUVi3NPkxM0432PI
         CPg5765mxiF/XLFTqGR926cs6RuMwnrnqhSV2bMrbkK9gUs7xVACf6w5EkN/9c1S2IPu
         qk3lr7K4UmDmcvTvMnb892zVvDZwqVimvrKpplTm9quVGPRx6DVtV98o2CnHo1SPUNwC
         l3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779705; x=1742384505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioGw4y5xwbpIgtHn7hgYihYbHTQjfV1moGfCfOGeOos=;
        b=buDmFTXhVlbIh2K8zw4Lg1pZCFYH7yrRon8sK+DgHdCQRgmJU2XfzMKlcg4XyMFu9C
         j04ZMEHWmi7nqh8Ip7esrj8C8Azz4fzGCHr4CbrejHEmgRahhE8sKF6fw9e7Ln7WNmXH
         3ZCZGqRsWA6hV53MdetA0StD3ZeUMaibh2jfPCuWAy+5JEvj8UrBpVEqRvYRbbpdb4U5
         /S97Ts2ByhlZWdLEYGcT9MA0ho8g/YjmKQ/Rysgsyqyz8FhHQFs3rqA8Tf43Ol/42ce7
         jZa+AH+nqSnK9Q59KuqWdblYhIwSsvWlTQC5qMU2UvcAlFj0oLv5Ep4RjwW+zffvDc1n
         /dLA==
X-Gm-Message-State: AOJu0YzqSSjzL3BR8p79hucp+TmsEy1QbKZtOvkubmHSpZ9F+Ofg5uJy
	Ca1rBdo5ZK9XWSSQLjUQQzoECu7BBoUcMsD4+hv5ZPBlO+LbB/na7j4v6hRRLAGJyTucgWG+0EQ
	jLc5UuSAmXcNbosFwLxzPfvTPqLmSmiTdCFsUe/ZkkTxzVArk
X-Gm-Gg: ASbGncu99cNKZh9H0JUVf7rGeBiWswY5QIBqDPYwNoozfpMKuQavJC40JW+q0cTIyWY
	TEId9Oxybwx3htgw/yF0cmmeqO7oCws84Y6rC1wRl36wguQh330XzJDqDVigBS46rmzJk1twuOa
	orcoETqwZY6L+0vGF9ft73aGH1yns=
X-Google-Smtp-Source: AGHT+IHvhWLQUiUWkHV6WopVzGhOdXoPO/sPMWXlvVVZUWs7sHwEx7+uWukZrPHcLwq150ydHhSigNY4wPa8RoKu8CY=
X-Received: by 2002:a05:690c:a98:b0:6f9:9d40:35cb with SMTP id
 00721157ae682-6ff091abebbmr104760167b3.6.1741779705583; Wed, 12 Mar 2025
 04:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210063947.3298-1-avri.altman@wdc.com>
In-Reply-To: <20250210063947.3298-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:41:09 +0100
X-Gm-Features: AQ5f1JoRm_A4xzxoSd1bYJg7afyVUPSMwhBq9YEFZBXqxwJEkt3ADAWn8NBwQSU
Message-ID: <CAPDyKFpKo3DLECzfhCRnWO=jwo9s6TMaZWkk94_8yPfpg0iOkQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Documentation: Add missing entry for
 "writeprotect user get" command
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 07:42, Avri Altman <avri.altman@wdc.com> wrote:
>
> This commit adds missing documentation for the "writeprotect user get"
> command to both the man page (mmc.1) and the documentation page
> (docs/HOWTO.rst).
>
> The "writeprotect user get" command prints the user areas write protect
> configuration for the specified device.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied to mmc-utils, thanks!

Kind regards
Uffe


>
> ---
> Changes in v2:
>  - Fix a typo (Christian)
> ---
>  docs/HOWTO.rst | 3 +++
>  mmc.1          | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
> index 095a9bd..3902fa4 100644
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -28,6 +28,9 @@ Running mmc-utils
>          If <number> is passed (0 or 1), only protect that particular eMMC boot partition, otherwise protect both. It will be write-protected until the next boot.
>          -p  Protect partition permanently instead. NOTE! -p is a one-time programmable (unreversible) change.
>
> +    ``writeprotect user get <device>``
> +        Print the user areas write protect configuration for <device>.
> +
>      ``writeprotect user set <type> <start block> <blocks> <device>``
>          Set user area write protection.
>
> diff --git a/mmc.1 b/mmc.1
> index 543742c..2f7209c 100644
> --- a/mmc.1
> +++ b/mmc.1
> @@ -27,6 +27,9 @@ If \fInumber\fR is passed (0 or 1), only protect that specified eMMC boot partit
>  .br
>  It will be write-protected until the next boot.
>  .TP
> +.BI writeprotect " " user " " get " " \fIdevice\fR
> +Print the user areas write protect configuration for <device>.
> +.TP
>  .BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\fR " " \fIblocks\fR " " \fIdevice\fR
>  Set the write protect configuration for the specified region of the user area for the device.
>  .br
> --
> 2.25.1
>
