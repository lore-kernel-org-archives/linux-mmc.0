Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3627FBC1
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731143; cv=none; b=X/tqaxKrittEf+pmgWcxWPx6UI2xBlHKfuZpJ6Cz5pq+ksfshT9CfFgPVEEU6juW7tOpUDpSAXIIn+mT09V7Hc5S0bCrP7YNmnQ9I+1lw2N7EhgFmeu38e7iEo58FS2/ZBIsOLBlqKWQW/LP1UsIvyWssDrdWd6rzgqCnujD+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731143; c=relaxed/simple;
	bh=mPnkZEtTSAh6vbCxB45rCsbaTkRBTrfhhwve8I26+7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD6xT1sGoPgNBjb9E9htFhYv9PppJssNyTOcPbk3K9rGKI/JCBVVv6tXalZT0QyZWshhA+0sxsRslYpYXsmHG7E2OqN/4ewf1EeAZi8iVwEbJQJuvu9cZtwJmU9i6FDlM9YthtfcfYb94uJbjoqbi54CLhqSoK+pUtRA2umkNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pT3kOgbb; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT3kOgbb"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607e54b6cf5so6718577b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2024 05:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709731140; x=1710335940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKCuv8kmiOEcIsEda8cwWHeTnSLLUr7cPDUpeRfzlFE=;
        b=pT3kOgbbhq4e6idWAGfA5/BXIMMXkmKhmqT1zal3Pt3xt5qjBCKfimqMW7V6XOrPSC
         rTLwFkEn9FI1vcw7ESJBKYxebBDVD5fMEYzHZvqPu1FXLdvPv/kt0XGwc8inM4KCS0CD
         3C6GZof6LBgGslVZIDFDzsURhA4nD9dj0Nrqbvfw6Qrrq+KoGfMPE8s87FSErTDrhdto
         5QWMJa1h1/rK10cQy1DLrdGZa8YALO/uwc+LQop6YjHQhL/ll1rMrygszAkVdSPYarNZ
         pQ8wAlD7yU3yjQ+N8qaYZ3bkzhurxFEeOZZ1evIGyf/2r/tcLQ2quRFAiDjDnClT8epw
         Gg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731140; x=1710335940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKCuv8kmiOEcIsEda8cwWHeTnSLLUr7cPDUpeRfzlFE=;
        b=bVq1DJM/XU5KOnA+pTw/z3oo6yGrJn5QNmrfCzx9Xo5+tX2dvzlVidq93YYnhdLGuC
         2jwaBV/przEGLt/yGxU+ft9U3kXalpagR3P0lnKfPzmy5pDV50/h4fUEjSgc+JQLscqM
         S3pLSHSzfgpR0xm8r0VdG0V6X1CVo81C2JSwLT2iNr64p1izvoQdW7d15ouOZs4axyDM
         7wlcanYt4v1oowyHA+sLwpDGIt/2BkoR2GwR6GGRMqrWGQX+r8/yOXcNzbMcRuuCvNLC
         IkVBGm6eOoyn/T8KKVOJLtQ3j9xSjazD2CdIf+xJLjCMgCgm50se04jbiIh/M6JfVzIe
         ssJg==
X-Forwarded-Encrypted: i=1; AJvYcCW2wFUWfHxd10C89rxbm1WDgsTyX3eixO3l2UGgsech9IlWt9kJRPavCmKmc1oAPMIg+Gg61hL9hztv4yGnECS8mLca7TfrOzTg
X-Gm-Message-State: AOJu0Yyhls2Ge+aOZQMQiM+ZWjldJmFwNUhEnSC2hrcINI+wwbFl1LP7
	qpZMUK6VDxqTksJ2ly+neGMxUixpRRU7kIR7MSgXCR9Olv9B0tXV6TtesYpq6s1WvGbFaf9x6hq
	+f022vCHngNifPVAAGE7asFEcyst9uqDhq49Uyw==
X-Google-Smtp-Source: AGHT+IGDkm2ZCHZqNIwY/rMwoAlwSt1vKAeAiD497+i/oCBk6jBkyTDSoOUTOJOh8kXMDE16FP1gsO+aQfct791EnOE=
X-Received: by 2002:a81:4915:0:b0:608:d4a0:1dbe with SMTP id
 w21-20020a814915000000b00608d4a01dbemr37631ywa.15.1709731140673; Wed, 06 Mar
 2024 05:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org> <Zegx5PCtg6hs8zyp@trax>
In-Reply-To: <Zegx5PCtg6hs8zyp@trax>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 14:18:49 +0100
Message-ID: <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:05=E2=80=AFAM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:

> That looked strange as there should be support for 4 GP but this code
> kind of convinced me of the opposite.
>
>         if (idata->rpmb) {
>                 /* Support multiple RPMB partitions */
>                 target_part =3D idata->rpmb->part_index;
>                 target_part |=3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>         }
>
> So if we apply the fix that you propose, how are multiple RPMB
> partitions (ie, 4) going to be identified as RPMB? Unless there can't be
> more than 3?

As far as I can tell there can only be one RPMB partition per device.

The v5.1A spec says (section 6.2.1):

"Two Boot Area Partitions, (...)"
"One RPMB Partition accessed through a trusted mechanism, (...)"
"Four General Purpose Area Partitions (...)"

implying there can be only one RPMB.

Also I have never seen more than one in practice.

I paged in Jens Wiklander and Tomas Winkler who used it much more
than I have, to confirm.

I think my linked list of RPMB partitions is a case of overdesign
and could be simplified. I blame the fact that I didn't have the
(non-public) spec at the time.

Yours,
Linus Walleij
