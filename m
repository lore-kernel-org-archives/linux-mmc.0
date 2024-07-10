Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FC1DDC5
	for <linux-mmc@vger.kernel.org>; Wed, 10 Jul 2024 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618000; cv=none; b=QOk5pUS8pL1fWeu7n1hCgW5HPRcmfEGMTzRk/54vH4x94KR7+iUjWlI3X5Eig2hpwriKzIRcJ6Kb2cyZsIpuZzS3Sqv1iw1J7sJ4NHnArmRzyssICkag3qMyw1nxeJjiHjKDfSX7aggklP6xGx5mNUjJ5TE2Z4jE7CbLKIeU/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618000; c=relaxed/simple;
	bh=Extl/nJxyYBWOkv3yGgV1wCAbbkUKIFOuvVKtqQkyTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnBrVk0M+si4yWR7JOAZ1ep4nVfs+H8+FbUR0BmBMgVsBpT2MxkpXcDLx1onNhIOY+a9V63gFGY86OENPRC/CoeZRJZxeKtu8Uq8t/Cte2AYPfB4B2wiT5XCL8aLnXJjrEhd3XEIVDRji1eic4oe/vOEdaI+iocxlwGTpUisf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUIbteBN; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUIbteBN"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so686901276.0
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jul 2024 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720617997; x=1721222797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BJEvKRRIck7D/aS4yZ5jzW+8W+HeRyeNNdVmA0gkAqg=;
        b=NUIbteBNwvEogAgkh/2DU9REBig8lFrRWXo2lNSA4K40LCIGjMO1rfHXjf81nsO9JR
         xAo0Ysy+F7QdYVtgtYM/H4TsfmG+IPxFsjk4kNAG0Ih3wOfBMEGWkEMmtC+C+GAxIwsN
         pK8N+kuNAz50aEeuCXfijb+y59Jxh9JKLruJrsGHsZLiUzPq7tHyyh/5jGfSZvS1W3rq
         LYCwC5fH5AuJWTadp34evpAQ7wI531mEKf44jTWfU4TZb9BwJaA/bODh70KoRtDPgQJx
         nCrLXH7nvcYJj7s3FCSkOv2xl6PL+2r3Yib4iWYv0kLsNwyclpRkz2P+hhDSffIaFoxT
         6gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720617997; x=1721222797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJEvKRRIck7D/aS4yZ5jzW+8W+HeRyeNNdVmA0gkAqg=;
        b=bd+y5CqL7Lm6m0pKbb9rTAYSAD3bUwVo1ZI0etXFbI5Ivu96bOqACAYtpsDYIjYiXS
         d0T9wFpNEb89477LeP7BQdp3cMFCPiLkfsLw7Pr8TU1D/xHxaV0o9vJ2IMfSUipAnTj/
         Zg+p2gTZEE7PcfMs1DFj/QMKfmAp09QUK0y7g9nOad1/TLHYJDhTPmVrE9NYjTKOMp2/
         bfQcO2ycDfjx4z5CvJMwLUm7Mg3rEuBUOmJtPCEODrNKKjKl1C2mqtvNsEgWWKWwnIFt
         ppwrkDPF+xkCjI3JCLf8s3BkDE8p2pmTLRJl5NJssLjy4+gCfDV60Buu5t4HIXDYObg7
         n2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVJdeSQIwwezl8RvWd1uVnCwWgaW0gRt2WayJrJ24NSQxDyU2SX+MyspVtm98Ed0NsSfUiMPBFjdNrWK0XR4AJ3GU0E9+2uTB7
X-Gm-Message-State: AOJu0YyB5jkJVHAQ9jvJ4Pt/xyJoBkJS2frPUbs1so4Lc0PVd4UwNZ8q
	7F+TBB0FwhUOp1JsNg06XtQR2NR/GHTBjTlipeAY/lFrI3lCEdi6CqYsCMRGqeTd0BzKSZ/vIKY
	9bhnvp6MyQCs0LKaiHEYyMTMRzyzS27S5ZtPl8Q==
X-Google-Smtp-Source: AGHT+IGCxIGtZokN+teJKPPhHkfxqw9OlhyDEFwYyLLG0/YrIEAfkHlPw/Ek4wKjBBV+f7KQyzOKeh1viBFb7s/cooU=
X-Received: by 2002:a25:bc92:0:b0:e03:5505:5b5b with SMTP id
 3f1490d57ef6-e041d05ae92mr3583037276.0.1720617997036; Wed, 10 Jul 2024
 06:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131222.1131880-1-linux-mmc@danman.eu> <CAPDyKFpvPaBwKdadCBC2LHTFGaEEjRN3ZrOC+PXp16aZKgPY=A@mail.gmail.com>
 <DM6PR04MB65756BE6093A5173C58CE9E4FCDB2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <dc3524328a701be1ac3206af24b4a185@danman.eu>
In-Reply-To: <dc3524328a701be1ac3206af24b4a185@danman.eu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 10 Jul 2024 15:26:00 +0200
Message-ID: <CAPDyKFrQc610OB+VaG=cKQys7+3pyB4m1DA4BZXeGT5WgRYQ=A@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
To: Daniel Kucera <linux-mmc@danman.eu>
Cc: Avri Altman <Avri.Altman@wdc.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 07:21, Daniel Kucera <linux-mmc@danman.eu> wrote:
>
> On 2024-07-09 22:06, Avri Altman wrote:
> >> If I understand correctly, there is no point in sending the CMD13
> >> above, unless
> >> this is the first attempt to initialize the card.
> >> Therefore, it's better to move the whole part above, inside the below
> >> if-clause
> >> too, otherwise we would end up sending a CMD13 in cases when it's not
> >> needed.
> > R1_CARD_IS_LOCKED is CMD13 response, but already in CMD7 response as
> > well,
> > So theoretically you want to skip mmc_sd_setup_card altogether.
>
> Do you mean to modify:
> mmc_select_card(struct mmc_card *card)
> to somehow return or save the R1 response to card struct?

I quite like this, as it avoids us from sending an unnecessary command
during initialization.

A suggestion is to let  _mmc_select_card() take an additional
out-parameter to provide the card's status. Then we can let
mmc_select_card() parse the status - and if it finds that the card is
locked, it can set a new state in card->state (similar to how we use
MMC_STATE_BLOCKADDR, for example).

In another future step, we may also want to keep track of whether a
locked card becomes unlocked. Using the card->state should work fine
for that too, I think.

[...]

Kind regards
Uffe
