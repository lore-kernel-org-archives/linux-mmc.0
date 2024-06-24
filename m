Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90119DFAC
	for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240971; cv=none; b=CbcVB5AkmAmcMf0QrBcQBGZRXdOUUOKPklq3sEaBqdj4/BRbfBOCoa7mkCK1ZDNqSUz8exs7MdagnA5d7zQ/LKr9YGX6ecJepNhGq+U0ufsgtdkl+bKzP+F0hPCb+RvhUwMclB7CpFNYtqyQLYmc8ygCdEiAS5Zk7kw/0GXhj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240971; c=relaxed/simple;
	bh=/rcuYfsC9eMXg7bGCQ9A+y4XcLw5FONtQZwoyuilmr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkVZ9ureejCAXMWSyQ+KLCyAwBR+k74jyXpR3D/dfu1pBPqzqzANz5eHutVyEBUFCU6sVnA1A2OG1aYNWh7NGHQkHI0DPTgii+DiQKlZrK/qLu6bZbHzqYezADfb8Z7p15hJL5r80NzRjD++7RYTtEh9/5R92oqP3txyPcnKSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aXO1cnfT; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXO1cnfT"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-630daaec9c7so40558497b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719240967; x=1719845767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AuAYxiWC4TvD0a3p6GxU9uZDqvQlp2MZzMqiBjXKRCU=;
        b=aXO1cnfTtCDoEN1mcriM7q1p8LuGuAaGz+KTVSBILcM9gnBoMCo76bBltZKpaE9AvT
         XZsr87/+gFYTwiQSfGxG1fUfDmuo22w4BEFMrplvMNoT9o2BSUObkKzNKfcnIKXDf1Bz
         uTJBcmixEYLKw0PR36PCFVB+aM7zEZTKimx5V+gFPE4qjVkcWU3g9K9mXIGFWB0RGL4l
         x/Rp+cw6O4xxdx8m1vl8ZHyKm7SdMPJy7rhm0XTRGuMzyoh5TgB+z/63VcJx6+eCgPyY
         thVgMECFwlDk/gdc9JEI7VTEEeoqkmKG6l9t44Qr5onLq1GNFZ2XkL8UHl9KF9wzXuG2
         Y+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240967; x=1719845767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuAYxiWC4TvD0a3p6GxU9uZDqvQlp2MZzMqiBjXKRCU=;
        b=U6qQK6puoTMrK7G5pTmWFptk7gkxNidmmIRL/46j5zdY1FsSBhbW449vDnUliwurop
         Bzuri1m8mLhEqwQ3Wj3MkKSV0zf8RfMcSlG1yQ9VT9EG+5XbzYRSwGrlQQhlTXLMsLlv
         R2JJXOStJSaffFUxMc+J2v+jPD1eGaBImIRuL/Al+VNbwvgqyJ8hsP60qzoZcCo4GoWk
         /AdZu0R6Aqul/PPOzapTaqo0L58P4+wkj9iF88VJBIIH7nV5aAPnUyKvLBCGVJSqefnU
         dEJDWYI387mIkxY7ptt3J/q5UVR4J8PR3OzC1X6HEEI41qXOa4SmN3wCyXpcL5qA83eZ
         1olg==
X-Forwarded-Encrypted: i=1; AJvYcCUXOcsgef73rxdEG1rvh+4k4qeRjglR8qID5FpPbInZHJu56PrnNCaryA4m6SBFwGxB6iPRqkUKPXE8x56qw4CU5RWG8wU2l9Sf
X-Gm-Message-State: AOJu0YzH75X7AiH2XCJHyOMegXFuVA6sB/MW4iB9O0ARti2L2AysvNlb
	nsFF8Y/mq3bimV+G5hpTbhlSJMwamLiJnAIDwaY4jDUFCxfGRWoj+PVdEE91kksYJbvbLSaxojz
	fVzxy63z7yuv4HHyuD0pOOl6vya+uBqYiLEWUKQ==
X-Google-Smtp-Source: AGHT+IGbNOJ6QDZx9hqjAHMWcJWpOtmqUWrF8dHeHS0GosTP6j1Yhpc3k6MDGo6NH7cJ/CXWiA1aGC4mzCnhS4X8Tz8=
X-Received: by 2002:a25:aa87:0:b0:e02:9c87:d291 with SMTP id
 3f1490d57ef6-e0303f52695mr5166865276.18.1719240966752; Mon, 24 Jun 2024
 07:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621101833.24703-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240621101833.24703-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Jun 2024 16:55:31 +0200
Message-ID: <CAPDyKFoeYd6PZQ8+tKTyX68Fh7M+6ZMCAGZ+SNKrDU=ePQpZ0Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop entry for VIA SD/MMC controller
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 12:20, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> EMail addresses of both maintainers bounce. Since there have been only
> cleanups for the last 10 years, let it fall back to the default MMC
> entry.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  MAINTAINERS | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf9c9221c388..5ef1e83e0fd7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23645,12 +23645,6 @@ M:     Kevin Brace <kevinbrace@bracecomputerlab.com>
>  S:     Maintained
>  F:     drivers/net/ethernet/via/via-rhine.c
>
> -VIA SD/MMC CARD CONTROLLER DRIVER
> -M:     Bruce Chang <brucechang@via.com.tw>
> -M:     Harald Welte <HaraldWelte@viatech.com>
> -S:     Maintained
> -F:     drivers/mmc/host/via-sdmmc.c
> -
>  VIA UNICHROME(PRO)/CHROME9 FRAMEBUFFER DRIVER
>  M:     Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>  L:     linux-fbdev@vger.kernel.org
> --
> 2.43.0
>
>
