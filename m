Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE61242D87
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543215; cv=none; b=Mlzr9uCjC886SMxtVXaENhruaRREl/Pk6hRQwCionlssm0o3hwgTiL9edkfEkIDMP6vyjX+UWm5Fp7wfWA8Rlg6FzD7m+3bE2yIM57oY61FzlIik/cgOtZCY6EFdFiNQbANd1TpDobUPYDcwLovywF7K0qqKScbRsAH4w3lgsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543215; c=relaxed/simple;
	bh=oL1fiUD/H5TcQY8L20ynpBWeeyoVLrvI6as89SU0+ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQUMdkmSblvqaaZ4E8iTFmUJJ+GpXaaL+vj5iFjEs8PEAyMymHv1btHxmZjNlnX69+0yC5AGgPMwJOExEGO+HvQZwx5JShfmKle3DhAefNMPzMnjIowYddRE4065FIKlhfmRMi68pfTugC/mcwDSRedwX1776Qb1niRA0Gud4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xVn3Jqfn; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVn3Jqfn"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-711d4689084so86043577b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751543213; x=1752148013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dRcJkC7s98f3vSechYp71eHb0S8GWsAx/CqXIlIuU8M=;
        b=xVn3JqfnbXGPk8umcRlvHc43iM67poz5eT0Nws6qpBnoUbaXaLbrzA49ZpOrI+wPBJ
         znJC1aM7EpdNQvUPluoRae/KLIBINzYIoIAlI2MIad/Y2O3aY+sLsspzRTlmPmXR/+tL
         t4n51WWKE1vGNJMAxQtXUQuSkqW9ZdUT/QjozHfcIEMj+WzT0INFl4v2bDNsqnGzwwZN
         Fka63H3TcmPzzZ84BpFmxTsw6jrd+nebdPhcXmu6+ZWTo4O77I+mCMh/dg8d2f+8mwjw
         qw5Z7qpQ2YNJzA4J9jD7RtIsBovYtQhoGuSv/ZuBOHmvyS+rpgBOhecTTQrR2hK0Qu7R
         lvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543213; x=1752148013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRcJkC7s98f3vSechYp71eHb0S8GWsAx/CqXIlIuU8M=;
        b=hpGLexKpCYfbeuQOLSTd3taTmzdvRETQQumkXEEjmzPJQAy/GZHLvtFtDX5SxlcQmp
         niOWl/tgsKFDilBLKSQkniU82JTz9D1nSjOYaQovo55lvGzpqYnWcq71wMh6zjbYWuG5
         LRRtsSY9St3AhpRuve3HFmdPs4FrO2hvpSbz4ZoKVvLye4CR7dMGq+Dg/HZZ+t+rfTIu
         8GpENdRnX/aLdn7Eb6yJQqCxQxxCDpHMit8+Kv8+v0zwvor2IRUDizuqFinZxnbeIpKE
         hbLRz7kKPS+hACsk9hLs3wHTWYGQgTqkP7zRGgmSeTQLgcGUzDo3nbQCn0dDUi3FVL6G
         cb1g==
X-Forwarded-Encrypted: i=1; AJvYcCVj+wCPgdYPZU+o7gnT9G3GNmeZdJYRd23wYtMElCfoIcqHrEn4YQX1mOXT7Znq/etbfBftXv7VlHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQR+KCVTMbqVOa7WyVLVqtDCPK6nnRba709Lti75IN0fVrpXb
	rTWFKRXLbkDHvMd0sjWOaUpExwAMxgl/tsCQMeEzEpfXerwN8iBc64c1SmqZE9qFFDcXCR/k0Ej
	UBo1bJgge9uWWkoztYCw1mp6TUGXJpKcdDSCTclvx6Q==
X-Gm-Gg: ASbGncsyS1S20IhT57BJS7dxppM54BhFkX3ZraoVICRSXmXCfOScK8wMGegxvgcT8/7
	Tsb2vAlH06WmAm1Xl3GRx9Cy93cHQgSfmdBkvUvnLX7fVJGg8S9JbxYH97Zy50aUFuojFJoB8Cb
	BhOwuXIaTqCxgNHhm0rbQtbJhRwNcwVigBAaTBhWa70xfV
X-Google-Smtp-Source: AGHT+IENQ/QXbshMgCljz4gmmk8R1c619EaduyoIsoBZAjNf8cNJF/JDZR8Si3+fXrWsvMXvbvJ11a9NK+dsoos8ntY=
X-Received: by 2002:a05:690c:fcc:b0:710:f46d:ced5 with SMTP id
 00721157ae682-7164d55de31mr94731427b3.33.1751543212891; Thu, 03 Jul 2025
 04:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627025032.1192873-1-rex.chen_1@nxp.com> <20250627025032.1192873-3-rex.chen_1@nxp.com>
In-Reply-To: <20250627025032.1192873-3-rex.chen_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 13:46:16 +0200
X-Gm-Features: Ac12FXxEgAQvXhJW49ROmZZQODQvgNbf6i7LuEsAWgiKVBFisE7z3j2Wsi15h_0
Message-ID: <CAPDyKFrm+KE_XuzuVkLeykmwmRkbNaY8aerLgs45uSWex2SLfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: mmc_spi: multiple block read remove read crc ack
To: Rex Chen <rex.chen_1@nxp.com>
Cc: conor.dooley@microchip.com, bartosz.golaszewski@linaro.org, 
	viro@zeniv.linux.org.uk, linux-mmc@vger.kernel.org, avri.altman@wdc.com, 
	shawn.lin@rock-chips.com, adrian.hunter@intel.com, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 04:50, Rex Chen <rex.chen_1@nxp.com> wrote:
>
> Multiple block read doesn't need to read crc ack, so remove it.

Why? Please elaborate.

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
