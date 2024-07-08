Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE71386BF
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jul 2024 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446220; cv=none; b=MPpMBTsakpTZ1jxJQk02I5cR14Z5y824lXpGDBPs5rLqlL3DnYgM9VmCVRa4z2N9M5wPZnZPV+3R4yZ+sXgBIjgaimTrxYVq1Wmg2b7dK476B+eirAsK7spZVwfQckz6zDuLBbpIKyK+iBlHap7TzWoHj7pSB1+gS1UEopvass0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446220; c=relaxed/simple;
	bh=PoZpE4mLEJ9RRHcFaQ/S2FCQqRb7izLgnvLDLnKlrhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFW2dsW+6PbpRIKHtggR+fbtiF1cCyuHnwQ5UdF05aLo0qBKDJ62TXiSSIhp3Iyi8uQ0wXzfUPrdnZpfxJipTgLj7uOPbE1DWAw3LMt+UIVjC/T8rNMO08IxaZm30mvKdyIG1zNZh6519u0tAcEKsj6jLvwcnv0I/KPEQJtL6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m+BT+UGw; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+BT+UGw"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e04196b7603so135410276.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2024 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720446218; x=1721051018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYa3dMigYX1AmuvCTpji/dSfuY3QuxLjFAYr4cKdF78=;
        b=m+BT+UGwpTvIfwuTJ9wmyNuZIjgRfvk0xcxFYUi4MneOc7BYLyoTsih0EqC1dXsmb2
         1SE+SdUjlnL4l00bOjxFUDz2T4JGyqYNvdQYyuMr8qVYAzezXE5O5qTVhil0oFe+9dnP
         JKmjPqsZW3fYjcMviKjWms0n6SAG6nDrvK2IZxJ7f33mUPWA/ZX2wdowWpd0BUuPBOei
         W9TDye06CRramTU67Wzj2Z56A9ent+wsiJKUFOnp1Bqe2/L0JOQB9c7MI5rr3ZYmQbKk
         JspOf4kXerrZ0SDN/fNI1vr3Nz7Do4TT6dH5DG8QcrMy2THL5NeH0YOAi4JTQBe13MxA
         fO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720446218; x=1721051018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYa3dMigYX1AmuvCTpji/dSfuY3QuxLjFAYr4cKdF78=;
        b=i08Aq5Dm4PsdOP9BQ8HKZ3d8x4qm0eBGHk1pgSk2TY7QtLdGSi5otMjQoxZB1wr0fu
         Bz3Tp9eixOQU09dq3jjZjnDhewLqIkioSdFe5TrJVmaoJBVKri8o992fNJbgm9p2OHKi
         eqgaSZJcfmgMPkQ1tn2ogu86iRNoCAmJBVsynuaRl7X3AYTYvYqyzUDcd+P3xJ+zJ7AA
         Hepb4rVUmDyBomV9H27VYKqKoqUAA3nhRtcCkMzcnemn3Sqinu/NJG9H8+8X5n2hoHhd
         vreCkqSLW12SbOUt1DgPdud74LZILAXetRn01XD9o4AtQCiJj1yOUwjc0Kq0bbIXlk8I
         im9g==
X-Gm-Message-State: AOJu0Yyoi8dH4Xg9HhB0jZTPvo2T4ErcvKf/fwFnFOpMts5kcUwJflJO
	+fhcb7+vsD8v0KzBhP9ucJT5Ypwg+qY9uhTOowaJK/owyg6PS0HZmK1+u5cFHizgTGBnqNqkkfj
	83moo5wam94kKi1wKoJALYlMx0uduUeje1KLrdLCggZDnBg8/aSo=
X-Google-Smtp-Source: AGHT+IFc3mWh7gxNXmE3E5G7zuiaEOtAZNNw9xQnIuhAedRezjxysj3wovHBcA9OaW8s4N/+ZHR5iSI82PSCYgMAc6Q=
X-Received: by 2002:a25:aa72:0:b0:e03:5abd:4b9b with SMTP id
 3f1490d57ef6-e03c1bc8f81mr12245391276.59.1720446217935; Mon, 08 Jul 2024
 06:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
In-Reply-To: <20240606131222.1131880-1-linux-mmc@danman.eu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 15:43:01 +0200
Message-ID: <CAPDyKFpvPaBwKdadCBC2LHTFGaEEjRN3ZrOC+PXp16aZKgPY=A@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
To: linux-mmc@danman.eu
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
>
> From: Daniel Kucera <linux-mmc@danman.eu>
>
> Locked SD card will not reply to SEND_SCR or SD_STATUS commands
> so it was failing to initialize previously. When skipped,
> the card will get initialized and CMD42 can be sent using
> ioctl to unlock the card or remove password protection.
> For eMMC, this is not necessary because all initialization
> commands are allowed in locked state.
> Until unlocked, all read/write calls will timeout.
>
> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> ---
>  drivers/mmc/core/sd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdd..ae821df7d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit)
>  {
>         int err;
> +       u32 card_status;
>
> -       if (!reinit) {
> +       err = mmc_send_status(card, &card_status);
> +       if (err){
> +               pr_err("%s: unable to get card status\n", mmc_hostname(host));
> +               return err;
> +       }
> +
> +       if (card_status & R1_CARD_IS_LOCKED){
> +               pr_warn("%s: card is locked\n", mmc_hostname(host));
> +       }

If I understand correctly, there is no point in sending the CMD13
above, unless this is the first attempt to initialize the card.
Therefore, it's better to move the whole part above, inside the below
if-clause too, otherwise we would end up sending a CMD13 in cases when
it's not needed.

> +
> +       if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
>                 /*
>                  * Fetch SCR from card.
>                  */
> --
> 2.34.1
>

Kind regards
Uffe
