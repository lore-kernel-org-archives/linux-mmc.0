Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A42DCC17
	for <linux-mmc@vger.kernel.org>; Fri,  4 Jul 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624022; cv=none; b=ZwBx5wvcjgAPfnX2jzM8Yvr5Chq8OIoGGL1hRwkFzyQ4iV4lc+oBQEmnadYr8vQ59Jo+9zOMjexOC4b/cuiFQRr9RoQNYh63HUa769dnp0Pz4rKSZ4sUY1jJ8zgXgt/qvJlMUWJhTA/thyfvcWmIxyeak+8fXlzbtFy6pF0X4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624022; c=relaxed/simple;
	bh=T1o8zVF/cFCDZNNIh53zqJjdu8ncRH9egG++eVLFFlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZbkuENLvBelAjuBYKmnqBRDTlan2Ng+nIX5EFx7OMR5lRD9YDM6KDOUxZRZMn6Trh8FxN8KITQGODmNzPWcYxj9lhHemp6Q9TLpsxMtEdARgFvZ7exbFRCFia5LMySyt7ppNyRuewtCiiUTUxKDyZj1L4uRYu6wad0KzRoXdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOixt6ZQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOixt6ZQ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e23e9aeefso5229577b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Jul 2025 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751624020; x=1752228820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bhwIfhLLlecI+H844ni/kvUroAH8aYg4H6qsK6trUFo=;
        b=rOixt6ZQM4WFBj5ktsRi3lqzus7fQv2dCnrAq7DYU0xdlwUXULKIHQpuInWtYINAPX
         pl+I8iEvyr9SmZhosIMhxPCzZMtH8OyHkZFS+YXXBoXcnqcTvYGR5lqmlw8H4wQD6mYI
         NXowXHrLJNW1WphKHsKGZsuc987hKzRWJM0B2CdbK0NGID+KFx/5qiiT9wiRTxqO6Wa4
         tDvVX3FHe73b/qR29+YDS0CFavCTbx4b7Pj5ZzZA2fWJ09xx/wVcwqeZ1FoUYpdQnOht
         nFuVnwguoPlxeRPrulXB5efZzbNsl63me+eUQMfhp6sY0Qe/peGmedTPZL1DRpVOTrhp
         H+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624020; x=1752228820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhwIfhLLlecI+H844ni/kvUroAH8aYg4H6qsK6trUFo=;
        b=U4GAtRbMF9GMse9U4gucm94fiA7goGP5TCrno2jeCrlskvviE8vnSaQ0oUfpPybxbf
         dqQ14Cl6EmLRGjOuRFvLdNoeAlsJP7nvHv2x7zxOk9IXZXsnUMpKvxDUH3sUurPuXl04
         COdroOSxs+E/jHx7o4+VMJXDK9WXbo8BCmhr5O8TMPFCNMLaEtc6tJihGmSb4F/a/6VC
         3bdvPN8pryV2vev51s86lUCPfcWe+6212CUml1CCl6eKf2oLrBYBFhYTwymxbM2AhHNK
         ng7M7mrTgdYKpIc8wYo242ToS68/bS+kTc8Pb81jd4DUQYHGNkgKrbmlCFrHrEh7Yx+C
         ewUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiijtgaUpUUAc5QmLsZIrCR5Inw06k8ORIA2X3V4IAV9CuXZCgyXY2kuX+hELPyc5aMdOIvBd5cHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtnYYXfSHAgVbOMQAvQxoztSxHB7POWtxSxxWbx18nhklUwSAm
	hfKWV5eLckyafK2e8vxO1wCi5lDBrfldHBzz/Sny8k5PRlPeNFDBmfXttZ5GhhSWeGO7HeuIwX3
	NFz6/a7S3Mu46IbuoK2Nbxs8bCEgc9//A0iDhyHmb2w==
X-Gm-Gg: ASbGncuLusgMLeNXwXwlB15qAIaTH8UGlLMOIBoBBI/+I1vkJIEb1B7lF96Ocg5Xs3Y
	pEbwaflTr8tNB88uRQegVuViKfhfMBJhr9XrB2NBOm74z3ebbypOHUeeGVvVDIMgz9gLEL3E5D3
	/9QrgvdcxQ2q0JpQqM5TPagfXktRB1I7RPtL//cimeaCe4
X-Google-Smtp-Source: AGHT+IFCojsOaFFuTCHDob/vBSy4PFfsxxiSkJ5LZotc+tQtAUOzjraYend7DvWsUF/2lKb1zrEz7hiExcap2QCz9Es=
X-Received: by 2002:a05:690c:62c3:b0:70e:1d14:2b76 with SMTP id
 00721157ae682-71668ce35d5mr24547577b3.23.1751624019949; Fri, 04 Jul 2025
 03:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704090340.2231041-1-rex.chen_1@nxp.com> <20250704090340.2231041-3-rex.chen_1@nxp.com>
In-Reply-To: <20250704090340.2231041-3-rex.chen_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Jul 2025 12:13:03 +0200
X-Gm-Features: Ac12FXy_p6mYjDAAfXrChcUhKp02YgTxqyk8sSd0S1YIJ4plrEDifTNGYvTuNTQ
Message-ID: <CAPDyKFqDxb6jjxo3+tf_L=KDyakMooBeTtgbL+cntA5SamGVhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: mmc_spi: multiple block read remove read crc ack
To: Rex Chen <rex.chen_1@nxp.com>
Cc: conor.dooley@microchip.com, bartosz.golaszewski@linaro.org, 
	viro@zeniv.linux.org.uk, linux-mmc@vger.kernel.org, avri.altman@wdc.com, 
	shawn.lin@rock-chips.com, adrian.hunter@intel.com, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 11:03, Rex Chen <rex.chen_1@nxp.com> wrote:
>
> Multiple block read doesn't need to read crc ack, so remove it.

In v1 I asked for more information here, as this is just too vague.

Exactly *why* doesn't multiple block read need CRC ack? Please
elaborate on that here, in the commit message.

Kind regards
Uffe

>
> Signed-off-by: Rex Chen <rex.chen_1@nxp.com>
> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 47443fb5eb33..f42d5f9c48c1 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -563,7 +563,7 @@ mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
>          * the next token (next data block, or STOP_TRAN).  We can try to
>          * minimize I/O ops by using a single read to collect end-of-busy.
>          */
> -       if (multiple || write) {
> +       if (write) {
>                 t = &host->early_status;
>                 memset(t, 0, sizeof(*t));
>                 t->len = write ? sizeof(scratch->status) : 1;
> --
> 2.25.1
>
