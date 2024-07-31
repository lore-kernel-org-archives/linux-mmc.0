Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC881E487
	for <linux-mmc@vger.kernel.org>; Wed, 31 Jul 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435559; cv=none; b=cNhtXdC5F89JrYm++nhCk18bRklfsiNJueK9eT/vrBGpCU7xg92bk+WzirWWQ1+qrFUKvYNNPrBTo7hng2Pn/kIgTWeg4YZaC+x7uLE2BS4GiJMKHAPcq1Nf52SQdNzmt4URhJXGDPFJniNVyxovloEkxhVQRXH5WsdktLyLho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435559; c=relaxed/simple;
	bh=dcHoy/hCd9RS3zuZywsjGJQ4EO7mcWbrQ5g6teTiRFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTdwtDYEKJZWJyH0r+pa+bHcBwx0Aj9MBQeTmE+S3OjMGEuIG/Ev7uuLhOpjsjxgvVSjLaDe09mBb/17IhtOwOJIRcCCEoY20jatytQNPlf1iSTdfOfClfuRmIiu94pqN1FVDjmsPY8qHE0PAJJHwEjXF/xb8CP5rUUd3pSJKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=StP/BXJA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="StP/BXJA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc60c3ead4so40393755ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 31 Jul 2024 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722435557; x=1723040357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dcHoy/hCd9RS3zuZywsjGJQ4EO7mcWbrQ5g6teTiRFc=;
        b=StP/BXJAz5slWsQaQrMZ9mblCBg4Bqo2V1WiWj7eRPWa/mSA7Gut3POmI7Ey1NGZt4
         s5/ZdaJWvqHmz7NDGNmbHrxz330gwmzEkuUr57V9vmZ1pZtg/h0sYnmEcM84IQnGPxAO
         reksQLri+dJDzDXCaD0WNbPS0EfTTgemjaz9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435557; x=1723040357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcHoy/hCd9RS3zuZywsjGJQ4EO7mcWbrQ5g6teTiRFc=;
        b=bHSx0NJ1rNtguPrsxnBp+TFgG09aTi6FcCEYVMv+KM/NPvoZdU/RAUIMxqekRDIhFr
         aQUGGUrmP7a1QaWViAtLaKMCzV1JjkXI1vWrdbrx0w8O0i3LVDn41A8icpvYZzj6OuUU
         PGX4VEiHOoxFQdZyetftZAo9mRiDIlBFxz05/Lbs4NbBqDLDzP6XpymHw2a2wX2EMIAz
         8SDKYUeMkRDrXPl+SSrrZvCsn9U/eH3xgQ03Ufjap+Ob+dtrapRyXJZ5JiSxWuooulNg
         BroPgT/U3zomEI4BvGp+7XswES/GW3WAy9yDfmbyWRngdipKfVE3Jz0wOsWPTeCG7IC4
         g8+w==
X-Forwarded-Encrypted: i=1; AJvYcCVXZmfUGsFFQjadsvFTBED6aR9hqGDtSLZ9LiD1XUpfF80Oswtg5GMi/NwNK19ZNq6EqcjRdWWwRZF4I/y6a2BfSlZG3GYT8I/b
X-Gm-Message-State: AOJu0YwQVDR0XSTiSm39jX7CjyYOYHwK8FWUJaFLWJFs2ZoI8VxmoUxs
	+vzIrslSSvjb/cvdTh1CSuXy7yI9KBsQzDYJYRiAdQaA0HDs1lnb7rQrdFNCo78O2ZXIbVigZRk
	RtaTRNKK0s5JMvrU17gvQs7670w6xtNSnNcXQ
X-Google-Smtp-Source: AGHT+IG26ZPS43xsCqnDu7RvpNzGnASRsZDYRwgsMtdb4czD1DHjABcdSbZ6JAPFvHCtf183BVdDUBS33B9yxJ0TyJc=
X-Received: by 2002:a17:902:ecd0:b0:1fd:88d2:47f6 with SMTP id
 d9443c01a7336-1ff048616a6mr147214595ad.38.1722435556319; Wed, 31 Jul 2024
 07:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730115838.3507302-1-quic_mdalam@quicinc.com> <cbf18ce7-f9bd-c05d-d22-f56ca4ae3240@redhat.com>
In-Reply-To: <cbf18ce7-f9bd-c05d-d22-f56ca4ae3240@redhat.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Wed, 31 Jul 2024 10:18:39 -0400
Message-ID: <CAKekbeuzqhcKGLiQER3Xo-eVXDaq5p-a=Ez_iYixYAefPX+05A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add Additional algo mode for inline encryption
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, axboe@kernel.dk, gmazyland@gmail.com, 
	agk@redhat.com, snitzer@kernel.org, adrian.hunter@intel.com, 
	quic_asutoshd@quicinc.com, ritesh.list@gmail.com, ulf.hansson@linaro.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_viswanat@quicinc.com, quic_srichara@quicinc.com, quic_varada@quicinc.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000899d23061e8bc731"

--000000000000899d23061e8bc731
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is not related to emulation, but was. upstream linux development

Kamal

On Wed, Jul 31, 2024 at 8:50=E2=80=AFAM Mikulas Patocka <mpatocka@redhat.co=
m> wrote:
>
>
>
> On Tue, 30 Jul 2024, Md Sadre Alam wrote:
>
> > This series of patches add additional modes for inline encryption
> >
> > This series of patches depends on [1] Add inline encryption support for=
 dm-crypt
> >
> > [1]: https://lore.kernel.org/all/b45d3b40-2587-04dc-9601-a9251dacf806@o=
pensource.wdc.com/T/#ma01f08a941107217c93680fa25e96e8d406df790
> >
> > These patches tested on IPQ9574 with eMMC ICE for raw partition
> > encryption/decryption.
>
> Hi
>
> I discussed it with Milan Broz <gmazyland@gmail.com> and we concluded tha=
t
> there is no need to bloat dm-crypt with this logic.
>
> We believe that you should create your own target (like
> "dm-inline-crypt"), it would work like a linear target and it will attach
> encryption requests to the bios that it processes.
>
> Mikulas
>
>

--000000000000899d23061e8bc731
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDs3ac3VqjLztdHHzgNRBXN1a+UqHay38jpgsX0V
ADwVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDczMTE0MTkx
N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQCatF8j4hhyhmUbNCdC9EYjve7lK60/tGNuPcRMJe4VT9/Tn7mFbO2xjGiC
NuxFJGyDCwu/uAvd0nm7d2XuUbTssITm+mV+Jha0ET8atsSOlLyC3ABNgfKcq4FF1jeQj+VAGoQN
mjVZZ6l38MFG+oOrO9u8gIZnnJ3VXr8NfE0+NuvvQhPkF/52waCk16nnZV+Dva/A+z594i2CzLmz
TpoKOv5QZR8T8jAQU5AqbYICruH+ExWfzzpm2WnopZ39mz7HS46wfyQeYrbpCY9lUaaq9J71+Rza
v5SxntIEyYw/CKXtWzBsOIE2PDKdelToBZMKiZR9AlGrJTYguJu6Zxbk
--000000000000899d23061e8bc731--
