Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A1311C3F
	for <linux-mmc@vger.kernel.org>; Wed, 15 Oct 2025 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509829; cv=none; b=Ia7lAr77BR6vnZIYuA8V6wYJxRJ9P7zyx2brUxT+niM4qNOyM675T6XERpX/+XB7+hKwY7mxp71Yo1J5FiPHKIm3kfPWf/HEPWsZNzeWYvX0VCcp4PYX98o7QcjZDoUuiT3z69w8v8WKwz45vN6FLbxvawG3QYNRTSfp2SpgyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509829; c=relaxed/simple;
	bh=U+QJpInAQJD/UO7rXl6XPQY0ZAlove8LjuD2791XvXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/V0VghDs47aOopSlYYeEKJ7SYBc9LMPSA4CJhSrUQmCYHlmMkSK41JEt15dJR0lRf/aIQP5KuYhVBj8yWn2c1dQSuNEImCY9NVYyOCXUwfWneubAWFbRTRQn7h6z68Uuy/xjOMLHHWpm/3OBZDYdpAXwyq/+W6PiTWVYEdBq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nAANDeCJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAANDeCJ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-373a1ab2081so58726751fa.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2025 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760509825; x=1761114625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+QJpInAQJD/UO7rXl6XPQY0ZAlove8LjuD2791XvXw=;
        b=nAANDeCJQmapJM4yQy1/KPiB3mk3XqoNeCV8WlFFqb6MowF4ixgB/z5JXPfpNsooke
         XnL+g6aBlj3aixjQga6x7w7287CwMjp6jffyK3MXTAMrnlMgS9cR1rwQT0vHWdqdCmNo
         4DrNor8mkAIq5MJ2X5gjKj6tMcWta9qrDJAZnBAnZn6dO+JVEQOWUocalA5usOVnsPF9
         B7kElg4sZriJ7AitutCLZfxA+UKMGK/5C90hGCKhb5ePSpp9FC680yixxCEV5kjgQEQ0
         2ycg9egUPeMHz+8gln/LpOdd3WexEsz8JDltWl+vif8ESv1D2HEKXkQd+cXrh+PteE3A
         l2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509825; x=1761114625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+QJpInAQJD/UO7rXl6XPQY0ZAlove8LjuD2791XvXw=;
        b=BD+/uGG5+V10pKDgKf5nZUqhBIghbGR+4/QTdirwQ4y3U7mTVPhN+q5jmnRqNFqnnh
         UOMICIVjoU+WavjXAeM+hhhSdugkmV62FLlM4ckisJRKvkLj1JJjTTV1IxlBdzNcKA6T
         KoKbxPAKZG+O77DG72Rnk9pvomK7uTBJIuz65sggHk34Tuy+OhkvGqYmN93+0B8jyeNN
         EFwLiPjcaxFroBZkRBCfgTWjlekz/KpDglQQg8TvMxkV+qJ9SmheyTUPamOYb11FqUnP
         s78J+YFJZrH1Qev3FrQ9/HRnohV313ZXJ+JcykoELBp6cShWNkNw/NKjpGnpN9/kBkmH
         Xdxg==
X-Forwarded-Encrypted: i=1; AJvYcCUz+N5khnw5InwKbBY3FkYQhwjyI9fEBKb7Dd9qlRryEe+O/OszvmQtC/CzpAt2ugt7ixwQQS911cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAkmfDmy2hY9w7rRhBi67pUZT0cnqz+/llT6Y3WhQVij1GZcZ
	N16zRGiR7zIjLKar+EwKpCDF5hty94WnGVoeEWKQoZ+YQuR+j/Ik6WMxOmD1MVDZQJtB/BLPnAB
	Q+IqCdeEYG+PzEU/FI62o80SpziwgRgMBdWBpsn1gqQ==
X-Gm-Gg: ASbGnct5+JU8GD94ZmNaMG+o/PQxMJvyhLG6oTibJ5dcDkFd1hvh03qed0S22oRa/7I
	TKm4bIDiGAd/z2ooEQOl3W3bhk+sAWbER87+r7YNFHhsUr47eVicIwTsX3AeFP9SzceokvKuozP
	+SJA+rBd1A4f9ytBWWMP4TRPgZBwA2lrhHzjfg++1F1kkjJ+zgrkPOyL5PJyFZmgjMU6oLZDWVj
	npDJx15znb8tv3j4uEhKlRoOj60OvjjEr1O0s2vV1Dre+kf/6M=
X-Google-Smtp-Source: AGHT+IGUsgryfaHD0rnj3LtJX0svvEnMtTCvHCuJxwMxVB7v78te9kwRaSVyuTsq1gSb0ZAbdHX3z/ggHAOfux8GoC4=
X-Received: by 2002:a2e:b88e:0:b0:36d:a459:f0c6 with SMTP id
 38308e7fff4ca-37609cf2a61mr74137741fa.12.1760509824851; Tue, 14 Oct 2025
 23:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015060714.67558-1-michael@allwinnertech.com>
In-Reply-To: <20251015060714.67558-1-michael@allwinnertech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 15 Oct 2025 08:30:13 +0200
X-Gm-Features: AS18NWAUhU_Vsd9dzfVXxTibpqYvM8QTjr1kGOPoZF-KY0GMkTVsXhlFFcZV4bU
Message-ID: <CACRpkdbQH2+AoCVAZf_apQ=uhkbinkHtk60ssB0ODpBZY-gATw@mail.gmail.com>
Subject: Re: [RESEND] mmc: core: Fix system shutdown hang in mmc_bus_shutdown
To: Michael Wu <michael@allwinnertech.com>
Cc: ulf.hansson@linaro.org, brgl@bgdev.pl, adrian.hunter@intel.com, 
	avri.altman@wdc.com, wsa+renesas@sang-engineering.com, 
	victor.shih@genesyslogic.com.tw, andy-ld.lu@mediatek.com, 
	jason.lai@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

thanks for your patch!

On Wed, Oct 15, 2025 at 8:07=E2=80=AFAM Michael Wu <michael@allwinnertech.c=
om> wrote:

> During system shutdown, mmc_bus_shutdown() calls __mmc_stop_host() which
> uses cancel_delayed_work_sync(). This can block indefinitely if the work
> queue is stuck, causing the system to hang during shutdown.
>
> This patch introduces a new function __mmc_stop_host_no_sync() that skips
> the synchronous work cancellation, preventing potential shutdown hangs.
> The function is used in mmc_bus_shutdown() where blocking is not
> acceptable during system shutdown.
>
> Changes:
> - Add __mmc_stop_host_no_sync() function that avoids cancel_delayed_work_=
sync()

Why is this function prefixed with __two underscores? The
__mmc_stop_host is named like that because there is another
function with the same name, but here is no mmc_stop_host_no_sync()
so just name it without underscores.

Yours,
Linus Walleij
