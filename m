Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881B132C10
	for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015901; cv=none; b=kNpI14Vym2IEHptjCXS76jLg8kyCTRUzhtJN12HhLixstWW5rZJhERUxjW+o4HAVCMpFE3lLfL0TjeKWeH2YakxdabRZbN2k8PSLGIukXExT8mWFYH+vqxtQIG9Q4RWj0utfBAkXg+1a1Qb+jOBG3IsTFQkNxmpSQo8Ei4hyF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015901; c=relaxed/simple;
	bh=sha+65CRAruHZvHPgeTNMEaYyVy2ctkRi5VI/uxKmWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luvH33bxmIrMw98VniHCcx93jeI5W1VuYpleDkNU/BJl9s4QtWjeRRSynf4NRJSqwlwaKdmOrOizqJpCMSCYmPdg8fW+H67SV26guzYxbYMHyqJDD2HXez1kmxX9cwiTleu4bSjdGo9bMAKP9GiE0TQeILsGTwk+Vx3y1mwuQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQ0vNC5Y; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQ0vNC5Y"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so842367276.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708015898; x=1708620698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3IoBRH0M+LFAe74HMw0Du/XeziGoU8xuI+b47PCA5M=;
        b=vQ0vNC5Yidu4gMGYGqCLtj1i35wnsWqAGZTcl34/1OMY4rCPXkiO1WnxeEG/M6OdxZ
         1ok9XTqVjNrdDzNrvD2h+K6Q73fgWHURb2sf8v/cERkb+J+AIBfpv3juwHUD3Tl1DvhE
         kncEai4cGxXo8ccn/Vfg9E3bjKzXTStXFvBq86FVoeK/IpXkB9PWyaxcXlOYHLhbbKF7
         cYAEvXaXhCzM0f2RrAEKPL5oavMnbOh56/WgE5eWsSBe4F/REzb662riyJg4E8DE2CAb
         DfQ15ubow9IXgVsoTB6/44HJ/jpxahDCoTbTtErKiUL3INxABYSTQTjCI33qSb50TyJ0
         Iwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015898; x=1708620698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3IoBRH0M+LFAe74HMw0Du/XeziGoU8xuI+b47PCA5M=;
        b=eF8+jsPurgpuvW8AOUxmplgislnzYyOcnkTkWYNfqIxK4R7OKhGjH6upesiSTs26Gt
         qXRqfoAhlk5o5uaHXCWzqzi9h0YmhbgEFvp3LOeBgwVVn+jCYLayuefdmkSZg1EPE14a
         lKss9C4k3oLCRClhUAjCubJkdy0QG8YxDGMwjfhXtyJtG+qJyv7ffqP+AenDZS1vtO9Z
         1JJGVoZEBjoBz7JKWXZl6on8vbNiriaNCUHoJg8arkdER+lZIRcg1SXXLNrXyesb5f6b
         ai0hab/HtLx+k7oXjfGyQFBNOuVe20W1kG81j9Py6ZqxYkN1yYLrDswyi31Ysu4xjPm6
         Wzmg==
X-Forwarded-Encrypted: i=1; AJvYcCUNAdXOoxFWaDZt88L1qLYJIjhetbR5BZxU9DKXWdgta8zZAEHuxksmhj8zOu5c54SJA+tNYnH7WsVseHJc9B5+HKGIRtQiqoUO
X-Gm-Message-State: AOJu0Yzutok4Wkya5DL/MGXgNtjjPt9Kjvjw7uMoa5mFNHqkuTwRhMPW
	a77aGeQF1+TjYVwEly+GRnhyESb178xr/28duhTd8BCtgQq11KZEMuIaaLUY33AiHVntdlwAzfh
	vLKk/A2rPo0hpcqshryAuzNwwttw2VofhUFWWpw==
X-Google-Smtp-Source: AGHT+IEzADUxXzVHUebD8YQti/ikMzubDEe3ni3UKP6sMKE6WoX/CP5vqMWBdgFxA2yW2vHZvaJYaD+OiBuJd7jLqKU=
X-Received: by 2002:a25:c202:0:b0:dc6:daa4:e808 with SMTP id
 s2-20020a25c202000000b00dc6daa4e808mr4555953ybf.12.1708015898386; Thu, 15 Feb
 2024 08:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215161613.1736051-1-enachman@marvell.com>
In-Reply-To: <20240215161613.1736051-1-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 17:51:02 +0100
Message-ID: <CAPDyKFpNL_zFgzSNgaSRqaH8tDNjwB16ZD1YGwqM64vcQ2oxtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix PHY init timeout issues
To: Elad Nachman <enachman@marvell.com>
Cc: huziji@marvell.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 17:16, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> Fix PHY init timeout issues:
>
> 1. Clock Stability issue causing PHY timeout
>
> 2. Timeout taking longer than needed on AC5X.
>    Solve by constantly testing the PHY init bit
>    until it toggles, but up to 100X timeout factor.
>
> v2:
>     1) convert polling loop to read_poll_timeout()
>        for both patches.
>
> Elad Nachman (2):
>   mmc: xenon: fix PHY init clock stability
>   mmc: xenon: add timeout for PHY init complete
>
>  drivers/mmc/host/sdhci-xenon-phy.c | 48 ++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 9 deletions(-)
>

The series looks good to me. Although, I assume we should tag this for
stable kernels too and possibly add a fixes tag?

Moreover, it would be nice to get an ack from Hu Ziji.

Kind regards
Uffe
