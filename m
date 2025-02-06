Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0223C380;
	Thu,  6 Feb 2025 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881302; cv=none; b=n6Ve0cjO9DDs9rQJknIXYUwu0rNHyETLNMUorhPYdiWHj/boUPGCsqMD4QwdqoSrfyXOSNy4GSwtfJuvdyixRnZre47Wc/Fib+WIPedyD4bUSzxGtoT9cVfvtOp7/RZ0KlQ+0MPCVP6gLWkksl281Gh3Z9zPksFc/17K06oqgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881302; c=relaxed/simple;
	bh=IZXEY5vMHCoqLV6H5pXvafGHB8QHPbhQJ6aGOJSTzoc=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:
	 References:In-Reply-To; b=FZ7kE8ua4FmNxmqZu00x3cVbEcRq7sH1fvCc8Yl3B0GFO3H7HXWQe+ntNRWU2EuaU+a7Nn9sGkoIavWJaHbSZPgCyQ6fv9Gd7QuW2I6+QxEnnaBaYt5Bodp2Q2HBkcbZ7/J3ogJnlXsxWKSN31Z7DnjuS0MWxLFifuV0f8GR4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=i3uHnp2h reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="i3uHnp2h"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f464b9a27so16068045ad.1;
        Thu, 06 Feb 2025 14:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738881300; x=1739486100;
        h=in-reply-to:references:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:dkim-signature:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HoTLm124BtyobaFQcvhZ1RRXXabhFTJwDRzgEs6l7w=;
        b=v7VxF+8Jk1HsseqEhDtvj916S7DCpMrdP7vQVXGG+a8s6i/rr3n4TmpMDb9xRu7nxa
         +hoBtVtqIC28URCVHXyPK4iTAo2z28My5h4OhGE0czDt0BdI2ZKI1Eti4HI4VW3BQhEp
         4YxaZ0l7DHQh2q58GYGtTvlSZYADDZ//m9q2gvZSFWw0XOPvSD3/c1hkESI4iNPg7ao9
         SeusteIsRBDL9OAr6+iNb4TSFFvxuIv7S4EtZ1A2jJD+3a9VK8AbQnuoZI4y4PqH6AQa
         zFS3A2ttdQFZXRPPa+pBYSqZmuQp4o8I31fOGVEtcnvUyKBE/7+AtIa5kfh0joo2Xfo2
         Erpg==
X-Forwarded-Encrypted: i=1; AJvYcCVkmRQhvdNnPEuJNtfNhwWUv2borgQ+e0fKmNpjZRzg5OmJwF75KG8P1oVPzG/V/mj6Q2CDl6briNzZue0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMY4gRncbXD0dvSgpuPCs18GPA0PqUeClzbJtggVl7qu4bFf7u
	ifjkLoqCNJe/7ZGj79XJJl8b+bLNH8J1poJLlRVFnEzxB2Y/aMIn
X-Gm-Gg: ASbGnctOc1x3d7avFMGK0EJ88pdJAfSbTcH1SaMV35RVJHGtvqXQgZ58TJYuStXGMCm
	05ElTTBKvqBDIFztVgj5az4d+O1/Za5ET7z0Kv0rCrHU13tzWvx/cz/CveX5y3CkpGvkmoSLwhV
	NW623MO0jrz0+4+5MGcYiSgfaT59OdSKbq70QdOwitf5N98oWfcwzm5mhY65U6vFKJMbog6Ex45
	4Uw7MWU8r7whY66u7Htl4rqDuxJi32uI3OBtnO+s2CwBqpAG++QS4oSgwFiV/BicjzDjzfrobLl
	E4Uj89pVdABWrEGbWg987cjjPRjq0wDE
X-Google-Smtp-Source: AGHT+IHcalIEhkt4RcbAcvntcJVpUoUyY4g/LswjKcB5cTUwZet9v0OfRl3BfHglMY5Axu9lOpqQjw==
X-Received: by 2002:a05:6a00:9286:b0:72f:f86f:f8d8 with SMTP id d2e1a72fcca58-7305d411615mr1679952b3a.2.1738881299717;
        Thu, 06 Feb 2025 14:34:59 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad5eebsm1862355b3a.64.2025.02.06.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:34:58 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2025; t=1738881297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HoTLm124BtyobaFQcvhZ1RRXXabhFTJwDRzgEs6l7w=;
	b=i3uHnp2hv8RPv7Tz0XG5AY++3aoSsPkMf847RKzNr4YZjDu5n5PDhqkUY4nyTzXC1ZL4m9
	UWuxrJsET3rzNq+70OuEpb3YIU7DxHXsrCEo277el+2t7MzZj8eeXFQf7mX1Ql6ju8NGOJ
	eiekDAh4h9d475c/C/mfYfHrdw7vPFTBKVmxDW2r4lmDwwVsHInqrTvDRrzfE2oXfFnafl
	nWSyFSJMWGDXnlkDHfAlIKAh+E77CWUHeenk7ZBaPiDjS0RGjWekNB4nN0BVXtIG8fYLPR
	hC0Uhz9xRiFasf3aZsPgNgnBY2qGzFoYzM2mr/uNroUp1244ZakNuhk/jwpb3Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Feb 2025 19:34:52 -0300
Message-Id: <D7LPZ1L5CJLC.3CZRIDER6UHSO@marliere.net>
Subject: Re: [RFC PATCH V2 1/2] mmc: Update sdhci tune function to return
 errors
Cc: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
 <adrian.hunter@intel.com>, <avri.altman@wdc.com>,
 <wsa+renesas@sang-engineering.com>, <quic_jjohnson@quicinc.com>,
 <andy-ld.lu@mediatek.com>, <victor.shih@genesyslogic.com.tw>,
 <keita.aihara@sony.com>, <dsimic@manjaro.org>, <cw9316.lee@samsung.com>
To: "Erick Shepherd" <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>
References: <20250206210835.2980500-1-erick.shepherd@ni.com>
In-Reply-To: <20250206210835.2980500-1-erick.shepherd@ni.com>

On Thu Feb 6, 2025 at 6:08 PM -03, Erick Shepherd wrote:
> Updates the sdhci_execute_tuning function to return the error code
> that was returned by the __sdhci_execute_tuning function.
> Previously this code was only stored in host->tuning_err and not
> actually returned.
>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..b35b8917fa1e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2967,7 +2967,8 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 =
opcode)
> =20
>  	sdhci_start_tuning(host);
> =20
> -	host->tuning_err =3D __sdhci_execute_tuning(host, opcode);
> +	err =3D __sdhci_execute_tuning(host, opcode);
> +	host->tuning_err =3D err;

Reviewed-by: Ricardo B. Marli=C3=A8re <ricardo@marliere.net>

> =20
>  	sdhci_end_tuning(host);
>  out:

