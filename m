Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD01CA88
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764779; cv=none; b=ioHup9Rz4H0xXFSUQbP/19Qk62r+fdbCsLFCJNjfALgKh0cvlBezfysrhJVke28yl6wABb7svDcKjybKuBo0b+YdVeTkHNqfoOOh2NhFx6AJKhI6akmggZKc4oHmCV+4bvSxU2gkZw9WR+d9+h3QevY0MVHwz4sdGB/IYg6YrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764779; c=relaxed/simple;
	bh=uLe63viurQ3turla71biZSNzeHZERkHtpVBGMD4Knbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ol5IeGe6KxrVxlNroTwvZ5bCzaXUNDPCSVz1HTVr3L1VLyHfrLoELHdGj99O1mV0qd6gaUZXOWbLmMFOAxTE50JesXAYLLMTUrxYTi+oOpVWB+sTL9a/OvCr7cMIEAE4hO+Tj73HxAMOsMg28P6XRciHH/b+RrAgP3fUTpT6pBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCJrMKDH; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCJrMKDH"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso241791276.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2024 14:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709764776; x=1710369576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9vVK9zCdzIjogBkv8fl2BDMmRUTvYVhUa47aKUSIwk=;
        b=hCJrMKDH0f0SvaGviMN/ed/EieJ93R+PFWjpanA1td4Kttnl9v2iwCI9by6zNiBtmH
         IHdthxO8Lf479m0hxcXPQy82lCI4NeuMKxRq9hGXkSsqIv4AkF1RzuLjWjp+Z5o/l0C7
         5hLgzEorX+OnVyOkEmcMZv79Uaq3k1YBZ1i+ldMP3shenzQQh0vSEUYszDBajdN6u4SP
         v1KpMheeQfQx94V+w+G08MEFXmfDtugyvOSu0ZItTN0NYeHjhV1T8+Q3pvpasR3skpkV
         oqG2ZDBhCFr5Y0nm6G0P+nIszu/NBKEhKIMqOInoTx1UNt68RLgzKDkdQY/tjzySQBXQ
         IKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764776; x=1710369576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9vVK9zCdzIjogBkv8fl2BDMmRUTvYVhUa47aKUSIwk=;
        b=vZmzpSLq7NtbyNS5RecjlwlDbFXpiyiaZ1sfEA8pFpQ4Ns2a1KKVhpnhJ+dLw/Dm+p
         YHgQS1XNLQLo4qXvbkDXd24sifiQ9LNBwUGRc0TVzUpDDh6MxHSMJl/RxqfJRTqy2ibC
         jizTyqAnm8R2Qvo5nBnAGH55GoUgLHn0nF5ZgBzGbnwhy14Qfq69dbsuyizzFdiHRzKJ
         cAdTEEbjAlQwoXFSYpzT7xM+t5kyofFWq5c6FwSTO+MTDhrp4jzfiNIYubxD2kDF93zV
         5ZaEmEjWXgiHooixFLK7BYD9YKS9ojAIDmgyTU83YYdRyEgw/PL0h7m2C3aj0ypuLzLd
         Mh+g==
X-Gm-Message-State: AOJu0Yx+rqQbSlLC8+B3YMQ+C0QmClvGvAxdg4HtM1Qp8exqs9g/czkA
	J2CgDgojJsyQxuNGGlOjbRRCp/RqmHxfGxTyB5aP742By/1TDOTNhhQgTQ77Z5QeLPp22H2BJoB
	5gZPgLl8wo/V2gn9sPrqP2/9Oo4YUWhB1FpxFbQ==
X-Google-Smtp-Source: AGHT+IF/THkJ+YHww9cnfN6k2wCID7Xyd+DBGlTKOnX3BMJuZFhCJ/eFUhl1SAD7Qu8yGUVfFkXSR521FcIDe0ngjks=
X-Received: by 2002:a25:880b:0:b0:dcb:aa26:50f9 with SMTP id
 c11-20020a25880b000000b00dcbaa2650f9mr13196885ybl.46.1709764776292; Wed, 06
 Mar 2024 14:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-class_cleanup-mmc-v1-1-4a66e7122ff3@marliere.net>
In-Reply-To: <20240305-class_cleanup-mmc-v1-1-4a66e7122ff3@marliere.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 6 Mar 2024 23:38:59 +0100
Message-ID: <CAPDyKFpx2hsqmmyRRZeWjZuF2Fot=UR5=EzmCRi7Cv8xFaFUwg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: make mmc_host_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 20:49, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the mmc_host_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3aa9dda6fd4f..8f8781d6c25e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -88,7 +88,7 @@ static int mmc_host_classdev_shutdown(struct device *dev)
>         return 0;
>  }
>
> -static struct class mmc_host_class = {
> +static const struct class mmc_host_class = {
>         .name           = "mmc_host",
>         .dev_release    = mmc_host_classdev_release,
>         .shutdown_pre   = mmc_host_classdev_shutdown,
>
> ---
> base-commit: 0cd8fd15a75e82ef249e99b3d80e2012a729d028
> change-id: 20240305-class_cleanup-mmc-75258142f27e
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>
