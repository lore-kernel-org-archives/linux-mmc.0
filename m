Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CD62818
	for <linux-mmc@vger.kernel.org>; Tue,  2 Apr 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055452; cv=none; b=kzEUMm6Cv4bcinaqOxTkq+aVPGOOkCR6K5IzKohptXnV7wIyc21PRrTrl21re6VnU9Qpe/PbWOV4kiNCUcIGuGf697jVp7aolB4O5RfUkrCfCCw9bnvHWlYXNdctt+6v9msffui/FBdagGVXlgUcr+VvSihx1fJg4HtPSXMGVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055452; c=relaxed/simple;
	bh=d0W7s7xEzq40ODWgrd/gyvKQEv+isEPy+Q1IH9uK4tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shfPiFHfcvcjs6JybKLJ52VUYhhdqxS1nyrucgYLcSZXHYtkdG1YqbckFvzAdMnISKReRD0KUzfJ90YXdr+WhpPNKCqzVVbLtF2XR5gcpMSC7gX/dGVE1bi9uVaAcTG6FxXxeJoO5Kp+4k94wztogvh8oYCWKywz+owsDmWV36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bl/iffb0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bl/iffb0"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-614b02f8ed6so14777707b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2024 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055449; x=1712660249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5ud0WRFEiUcD7UIgiAFguot1tshhBCNqaEQ95A64vY=;
        b=Bl/iffb0SvBElBl/1KphMhKNwho/zK0tkmV5uxGRj7iPBGQZul38M/4XjZLpGWZ+Nb
         iDJtZAPrje7DaKGyq9N+TcYp7bURVSCVSVNu+TjIAE7g70K3ZKpUrGmZ2a74I6oLWfqe
         VqYjqYnVdfczAb32CHFgfxa9RbAAgzHgRdjBvgLvnvbMY853JxQk1kvpMzBR/+HuP09p
         NSHHPRFD8rwLd4kUh2Kw6QiHf5ZN1ZeD5ik97hmyCF2nA3Zo7/OhNGJ87RzD0urBVbxn
         pM2PjoVD8QHNpSzp6MrcFtI0gBgKY0apPI6puqk0lngKef8eH62aaKqLMRVea3mdHHqf
         rqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055449; x=1712660249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5ud0WRFEiUcD7UIgiAFguot1tshhBCNqaEQ95A64vY=;
        b=xPJWUZR6zFfcccUfhVwomLMQFjcBXg2tiiyWcl3ZGyJPd/cDNaJaDAh2xzfaW02G5J
         qA9aULaCmewIHqcbNk/M5t2Ae8OtEnDrwOuQeIT7vc70t9AzQr87X/pRsaXSbMAdGmKK
         NJ4QhV/iS8qgNEyKxIEYn2FUpwW7EJNItvdiqWL0vPR7WsPDYPdDRgkLma4BZ+3zgu8d
         xk2wtoh5aVjdEyUEx1eGI8mdQfTw5w7jiriuTmLbwko9YrRK1q24OXiOROKLea0UJ4Vk
         VgIcCSriCAgv53x4kI4FUedcY3ajhIcRNP0LeIo+8R2dnok/ccBBGD5yXB1Ej6jgH5g4
         rRFA==
X-Forwarded-Encrypted: i=1; AJvYcCXEkspgsPcEDYrugYhAWd9lZ+q/Cgfkf+BVUUeJP3NjYW21pWV29mNXN/oMzxf5op/AiwPLMrNdGNd+1PsBRAwcH/7nCOYzB1Ix
X-Gm-Message-State: AOJu0YyeJjwP1eOSYrNzCs1BnXT42blVIB/kOx4Y9OazXdHwzuvNWAxw
	DoQocZXsqRZs8zfHTgDbwobX+g50EIpLEOfjy1oNzupS+ID57jYrVYqlkVibtZG6jNrxEj2L2z6
	7XRfx950yPlLBO2fSaDNrQEv39htX28yqt32VEw==
X-Google-Smtp-Source: AGHT+IGarruifddPehjtofjaAlYrasfSCyCAHxLYlqaILPgbiDf3R0LL4s0ZCEXlMQG2/UuAHB0wKSQdufrufErbgeA=
X-Received: by 2002:a0d:cc57:0:b0:615:f9f:7a62 with SMTP id
 o84-20020a0dcc57000000b006150f9f7a62mr1948418ywd.13.1712055449212; Tue, 02
 Apr 2024 03:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326094215.212930-1-r.czerwinski@pengutronix.de>
In-Reply-To: <20240326094215.212930-1-r.czerwinski@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:56:53 +0200
Message-ID: <CAPDyKFq=bUdEneAqDTx8NkiwUsa_8xLjEOs3kENeipmrRyLqSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: debugfs: convert permissions to octal
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 10:42, Rouven Czerwinski
<r.czerwinski@pengutronix.de> wrote:
>
> Convert the existing symbolic permissions to the octal presentation as
> this is the preferred representation for debugfs permissions.
>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 1642ea72d22c..6dbab860e453 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -351,11 +351,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         root = debugfs_create_dir(mmc_hostname(host), NULL);
>         host->debugfs_root = root;
>
> -       debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
> +       debugfs_create_file("ios", 0400, root, host, &mmc_ios_fops);
>         debugfs_create_file("caps", 0600, root, &host->caps, &mmc_caps_fops);
>         debugfs_create_file("caps2", 0600, root, &host->caps2,
>                             &mmc_caps2_fops);
> -       debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
> +       debugfs_create_file_unsafe("clock", 0600, root, host,
>                                    &mmc_clock_fops);
>
>         debugfs_create_file_unsafe("err_state", 0600, root, host,
> @@ -388,7 +388,7 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>         root = debugfs_create_dir(mmc_card_id(card), host->debugfs_root);
>         card->debugfs_root = root;
>
> -       debugfs_create_x32("state", S_IRUSR, root, &card->state);
> +       debugfs_create_x32("state", 0400, root, &card->state);
>  }
>
>  void mmc_remove_card_debugfs(struct mmc_card *card)
>
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> --
> 2.44.0
>
