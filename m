Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125A22338
	for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2024 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696713; cv=none; b=uU65Dn7C25E5gbAf1PRdxj04X2F3/+na8uPSgEASlUB7evH02BrCcw5r0mWkKbIcCdSPSntbCsLZbomE85a+EQI6a3E/Aln4ILGP21DentCktgw1AkC3bTgPHEOsxQSbfPtlsuexTp7rVylSJs24KKN/bVMBFQPVld0Gny/VJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696713; c=relaxed/simple;
	bh=KC7S0skwYs3GFMNRXqE79l7hJwkTaWj26KWuTeXKN3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkJOB2eZP7QQdGuZL4RgPkH8f4MgU49Ds5XHSFTTmcpZkgSZURq2CowG+vVtoj+FwWU2SN+JK0nrMXmy+ZA2n4ogueT4gqSsfqg5epXnmyxK2jqSBp4KUXPK1hRS1x0CTbZAM9LjI89CjeOPuRp+jkijB/4VCLrDMZlsEf0Vk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P56iIy5K; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P56iIy5K"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c197d042fso2071025a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2024 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711696710; x=1712301510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC7S0skwYs3GFMNRXqE79l7hJwkTaWj26KWuTeXKN3c=;
        b=P56iIy5KFwYUmSSp7GM1gkHWOslblXaj9g87foA4T9vm3q3C26FvRNGoRjma9H5KSq
         EVgq2PGSM2LKRA/mlgah3V7P6soL1aPHKXEnSXQeIYotYRpsGr9Fc2M9nIrKvwWRVRZi
         plW1Kp98kQZkOaD/d0IA1k8sIGNxUwwtlz/749qfB1WB0vi56TxvUGx2KVRjovvCI2e3
         SCOnUN0pmJ0hRNpXvzyzvagXBHwShsEKqBq0m7akCXS5DC41o5NO2I6SQoRX4rn/GXh4
         IS9y7AJUtqGaHq3J4cdscsph7mc0uw7Xc/07n7jeHnSJqde+BoDSWLLN7k3bsdMCJkDs
         UP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711696710; x=1712301510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC7S0skwYs3GFMNRXqE79l7hJwkTaWj26KWuTeXKN3c=;
        b=UoXbFSXeCGs5ECEhFoIBQA8PW8DIrYnGTF1S+Xvs7vw6FGSujONGho/Qty5gMggxNi
         N07Zn66nWSshRqOxI6HdNxSVpyMaHGK+jcbG/WkS1EeKqKBnmKbZ6SpngdPIrMOYXRDL
         pBnQG5Lx+NcLR6+Q+WUbk1FI+aZt/6ujhLfmP2SaCmOFrKabjmn6lfIRO9k0FOuNtSWo
         5yyEOjvkunbdxKfhbFVgpqeUuvYrjfwq+HBnOC0Mm+92+n6Agwd80mtFBFQWjWnbSzSc
         M9UTLQH1rlq8eDljcgyNJWWfB7wnRIn4b8NwwmI58skJNIUfFIV8ixlhGh1C8k+Wyzbo
         jUbg==
X-Gm-Message-State: AOJu0YzzQNClj38rQL61OrkrqXNa5A3b/bzRNxoIBV7xyImEcga2sxiq
	4bSBiFz1UpYlH1P42YS8UtIlx0PV8edCWD4nG2od0pmGA6RDGJbufbkAAJr8Y8Va7IycY2ZHUem
	mpOu4/3ov2g2zJG8ISr5wsVFDoq3Pq1AqYrk=
X-Google-Smtp-Source: AGHT+IFmrI8RczDQEnyWof3gBK8pWPHLNiRDQ2JysIg1T59stmyW47OYrglDoYd5yx5x3hWN84cmXt81wgnrloa+Ve8=
X-Received: by 2002:a17:906:aac4:b0:a4a:859e:97b8 with SMTP id
 kt4-20020a170906aac400b00a4a859e97b8mr722685ejb.24.1711696709614; Fri, 29 Mar
 2024 00:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+DkFDb7HQukpUyxVemvoH4rXxt3F3Q957EnKzasnehKfbEEzA@mail.gmail.com>
 <0cc46baf-8924-4ca7-98f3-c8376f7a5d87@arm.com>
In-Reply-To: <0cc46baf-8924-4ca7-98f3-c8376f7a5d87@arm.com>
From: Patryk <pbiel7@gmail.com>
Date: Fri, 29 Mar 2024 08:18:18 +0100
Message-ID: <CA+DkFDacWTfrEJBRejbT=D10bFCX5UvZAPaLBWwJu4Kbc8-iQg@mail.gmail.com>
Subject: Re: SD card specification and eSDHC controller
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks a lot for the response

czw., 28 mar 2024 o 14:25 Christian Loehle <christian.loehle@arm.com>
napisa=C5=82(a):
> Yes. mmc core will handle it if the card supports it.
> "power management features" is a bit misleading, it's
> SD_EXT_POWER_OFF_NOTIFY.

So, this will work even though my SD Host controller is: "Compatible
with the SD memory card specification version 3.01", yes?
Does this mean that the compatibility concerns things like physical
connection, and supported speeds whereas things like
"SD_EXT_POWER_OFF_NOTIFY" are solely software features that can
handled by mmc core if sd card firmware supports it?

Best regards
Patryk
