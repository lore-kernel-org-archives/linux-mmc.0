Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9244C515
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834720; cv=none; b=nDEWfQrnoDDxeQyevfwCbZ5G++QFMvTFDgFirHKqjnKH4QQ/5OMh6Af49DuQD0L7Qq7DDXV7I1L5CQjD2ZPAv1wNFT56gXT2ndVd0EftZUpNkME+ySBL1MaFJVvV7w/fdIl2+wCbEwO3tSc0TdB1XYDRd7ZWM8PM2AAKexboEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834720; c=relaxed/simple;
	bh=vtVwHqXFb9waLPROD0kAEV78bI167tOOYOub22/FggE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIJ2ZebnoiaBZsDETeu6rH7od7NTpoe7XlQd3PMqjjimjHR5D9yRFSgalHl78Aj15dFVtBTbGNGm6V23LntUQKEEaCvyE5B9i4ShR/DV0eDMEfklBxQL6LiTLuRN1PwXCdWgWremdD1pEqx1phK47OUjzFY8JMlwxLFj8bp2dFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WCthOXq8; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WCthOXq8"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2cc891373e0so13576905ad.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 12:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834719; x=1785439519;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHXmNxyLtQV01P9WUp7/zq65QII3djvXZL7Fu5fWSVM=;
        b=ULUt4lIuXi0rFpB6qdGxm9kcOsC/JE+CTgQbNfvarGqhnfBUoQh+BILf21gD0BAFlU
         RLLWlR5HxnnYWZjiOtThZcGds5Eh02EB8AwSJzjuA+lZLdXI0F6GQdHulotiQUS1NMY6
         exXlyKwqrgSFdPHurW6e4G3OxrQxBQD+BrGV/R4//OelF/CsfS6iqrx4AJwgeJKfzTTq
         rqyuYiBzKH+ObKrV4TOpluUQjwYeLi16bZm4SvQuyyRbneNo/0/ko4SRWnHYCf1HsROQ
         FBxnu2YoGOuV0cnlTZutxZbudyD2xlIqJLKmdryI4N5g4HtxvKXW0NribeyAHqSKLb7j
         g8RA==
X-Forwarded-Encrypted: i=1; AHgh+RoSwsy8Y4sVfXtSI49bzHLxKc/EosPbWNeHFN3q/WMmu95p2YNZ2mGKDejdJiVK/XSs4CvvsCFY2ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX44/vfxOUzUz9AbPUqz0AQIaMD5mXL07W7LvP2OXJNLCXJoJv
	vpfqVCHMmTW7hEwBYUwVmoAG6XB5wrZ1DIerPoSsXsCHr/cWDmh1PMHAyLKu6FhMouTfBWrer9D
	hsa//AAyM54Wf2dL2oNlm3ilH8pR2pCHM25aCq0MySehDbowV/VphAh4e54XKMe+q8Cp85z8k4t
	WVzh+WJAPXKAznd5MwjJJoRHr4EIwyvSyK0QhhYxI4HyA1fKBgWJMO9soy2+Pi292+gXsUr8InU
	o6pDFxcGJWP
X-Gm-Gg: AR+sD11htK/ji02FMZQqy/PcD0LhVUVkh/QcmI00Kib4z/i3MBbeN4Mo8VODvYQybB5
	YQugu0Z/GQU4ZO17doimGyb+yUnvM9GoMiaoc8rd4RY51hIuCs4xN++i6BUc8veiYGMNJuCEs7x
	DqAHVvp7A28hFK8hb/jVJonLiN3e2PrgIJBSHBh3fSfnXZblgZGGFHTl1zCnXUmRLidMACWae2s
	8/hnh9+hzv0X+yj3aetZh+DOwKTeaYJlV9SrIlLlFpd/wqPwZdRGK1/psGxiUrPYEvb6CijBzUG
	/EtAC2+/+b8TPIQcOMNyZh9CyQ8mkoCJVxhZy+aGpl2BpTFLzQc11PI2xUmt4xLlw/i+gaeUFM0
	dwfQPsA3Yk0JDYqGOQf/dtolXP/zT7P7Fp2BovcDgJr1IRQmvp7sQ6TTomJo8uTE/XMR7b9N62p
	LQ63/GHPGDtHGwM9J656j2NOgyPj5KUK9e
X-Received: by 2002:a17:902:f70b:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2cfa6b75449mr49194445ad.17.1784834717937;
        Thu, 23 Jul 2026 12:25:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cf8efdf990sm5757895ad.13.2026.07.23.12.25.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2026 12:25:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso1085368a91.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784834716; x=1785439516; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHXmNxyLtQV01P9WUp7/zq65QII3djvXZL7Fu5fWSVM=;
        b=WCthOXq8YdSCQtvf/kuYkuU/zQnx+WWDKHoD3o1pA/zTxj3vd0tIiqc87RUHKjL5Jb
         iw0qQMzpttLwT3fr7w7LLanHJ6mVNpqYQ2oO5Nxzb/pMApKjLSf6Ze7WVPseB7ZVUB98
         vmWVDjbDOzhQ7Cl/KhkFgm+pPPnPsGEylczYA=
X-Forwarded-Encrypted: i=1; AHgh+Rqo5G710OfSXSNcShoWWI960/F/JdQgB6m/gPc81hVl1Vm4JuNAQr2JpYQaXUL0j374K0lt058JQSo=@vger.kernel.org
X-Received: by 2002:a17:90b:54c8:b0:38e:b400:a86c with SMTP id 98e67ed59e1d1-38ec698f5a0mr4438804a91.16.1784834715990;
        Thu, 23 Jul 2026 12:25:15 -0700 (PDT)
X-Received: by 2002:a17:90b:54c8:b0:38e:b400:a86c with SMTP id
 98e67ed59e1d1-38ec698f5a0mr4438773a91.16.1784834715484; Thu, 23 Jul 2026
 12:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722211417.3702709-1-kamal.dasu@broadcom.com>
 <20260722211417.3702709-2-kamal.dasu@broadcom.com> <20260723-venerable-infallible-oriole-434b75@quoll>
 <CAKekbevxiN=8q60sHkRLKzEwc75PYHO7nJtMEahLF+u39g-FBw@mail.gmail.com> <1a9d18ce-e6dc-40e0-aa2a-e27f694e1217@kernel.org>
In-Reply-To: <1a9d18ce-e6dc-40e0-aa2a-e27f694e1217@kernel.org>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Thu, 23 Jul 2026 15:24:37 -0400
X-Gm-Features: AUfX_mzNsFSazjYfngXtOnsJ_fZvErPN--iSDbQp8oN1J7FRMPry5-FEvFRemkg
Message-ID: <CAKekbetBskYyteYn2bMG+fNZrGhEQziZB3p+bKOvjx1CWRZA8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Document no-mmc-poweroff-suspend property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Avri Altman <avri.altman@sandisk.com>, Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, 
	Erick Shepherd <erick.shepherd@ni.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003fcc0506574c37b8"

--0000000000003fcc0506574c37b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:01=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 23/07/2026 20:53, Kamal Dasu wrote:
> > On Thu, Jul 23, 2026 at 3:51=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >
> >> On Wed, Jul 22, 2026 at 05:14:16PM -0400, Kamal Dasu wrote:
> >>> On some platforms, firmware accesses the (e)MMC card directly during
> >>> system resume from Suspend-to-DRAM, before the kernel's own resume
> >>> path has run, in order to load boot code using hard wired logic that
> >>> is not field updatable. This requires the card to remain powered
> >>> and responsive throughout suspend: it cannot be put to sleep, sent a
> >>> power-off notification, or have its supply removed.
> >>>
> >>> Add a no-mmc-poweroff-suspend flag property so affected boards can
> >>> tell the mmc core to keep the card powered across suspend instead of
> >>> sleeping or powering it off.
> >>>
> >>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> >>> ---
> >>> Changes in v3:
> >>>   - Renamed from no-mmc-sleep; dropped S_A_TIMEOUT framing per Ulf.
> >>>
> >>> Changes in v2:
> >>>   - New patch, replacing v1's card-level quirk, per Ulf.
> >>>
> >>>  .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++=
++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git
> >> a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> >> b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> >>> index 3d7195e9461c..5f7b3f8ef1dd 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yam=
l
> >>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yam=
l
> >>> @@ -232,6 +232,16 @@ properties:
> >>>      description:
> >>>        All eMMC HS400 modes are not supported.
> >>>
> >>> +  no-mmc-poweroff-suspend:
> >>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>> +    description:
> >>> +      On this platform, firmware accesses the attached (e)MMC card
> >>> +      directly during system resume, before the kernel's own resume
> >>> +      path runs. The card must therefore stay powered throughout
> >>> +      suspend, and the controller must not send it a sleep or
> >>> +      power-off notification. The kernel re-initializes the card
> >>> +      after resume, since firmware may have already reset it.
> >>
> >> Isn't this exactly the same as keep-power-in-suspend?
> >>
> >>
> > Not quite, though I see why it reads that way from the description
> > alone.
> >
> > keep-power-in-suspend only takes effect through host->pm_flags, which
> > gets set at runtime via sdio_set_host_pm_flags() -- an SDIO function
> > driver opts in from its own suspend() callback, per suspend cycle.
> > The consuming logic lives entirely in mmc_sdio_suspend()/
> > mmc_sdio_resume() (drivers/mmc/core/sdio.c); pm_flags is never read
> > in mmc.c, which is what this series touches.
> >
> > no-mmc-poweroff-suspend differs in two ways:
> >
> >   - It's a fixed platform characteristic, not a per-driver runtime
> >     request. There's no SDIO-style function driver to call an opt-in
> >     API from for a plain (e)MMC storage card -- the requirement here
> >     (firmware always touches the card at resume, on this board) is
> >     always true, not something decided per suspend cycle.
> >   - The resume-side behavior differs. keep-power-in-suspend without a
> >     wake IRQ does nothing at resume: it assumes the card's state
> >     survived untouched. This flag needs the opposite -- keep power,
> >     but still fully re-initialize the card via mmc_init_card(), since
> >     firmware may have reconfigured it while the kernel was suspended.
>
> All this is just driver stuff which I did not ask about.
>
> The property is described pretty the same - do not power off during
> suspend/resume.
>

Do you want me to fold this change into using 'keep-power-in-suspend'
for mmc as well ?.

>
>
>
> Best regards,
> Krzysztof

--0000000000003fcc0506574c37b8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H0K0rs+X8O45xZIUJlxzf5UZex3BLi1f/H+08rSQULWEtO/ECwkFod2DIzSX7fZdz5RQ1PpziEOp
goo/JZPYIeCmgt3rIyvMuupj8Ymb0J/velhpXfQuYUM52viw2nmqVcxCwBqyM3Iq7eI4xtEOFRmR
wxSizd3MSQMf6GCHA4/B/6ttnxhGAr3utaOU+x/RnzG0gPLTW1XRAQ0+GVc/tGFdI864OG1cyrRl
GvBnHJQSAFOIKwYrUk2oFpgMbafQ6osCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQEAwIFoDAMBgNV
HRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIgYDVR0RBBswGYEX
a2FtYWwuZGFzdUBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAU
ACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFOV9h+N/T9ZsJ40qRxh7NYYD+N6MMA0GCSqG
SIb3DQEBCwUAA4ICAQAKtKh30wv1/30230mCimgUjMWQE/LImRmyfDgrp2IhBVS6mDun+wH8thEB
WhBHQMz3gsGixU4ZBJG72eWi39IzQ7CGnisJwA0+hsGaGg03AVtFtqo1rXYRZ81MEDOb6BPYLigJ
RsHbNmrUGR+LsGeUwOWUeRXqBrYaYFrkgHKvVK1NEewv+vUY08n4tsezO3jq0HKhVDY46bMbf8vL
oQqqhtcQvu2+5FK2jpUayeubpzPwobjEG61RIhBvM0KivY4CB2s9A7qgjL1XBycAybIvG03BbFoT
t282FqXwk9JU6YihLlt+hpzO9UF7E8GZYlQlVIZOLOvytqilhua+2h77Yy8Jz/FJyIXKuaLPtvb2
SC2shL7jF28kQbP3QUKwAig+cxwbpngnUkd9D9cXSHVq9PPwYm0A4eAO0YQ/80Uq20+gXF++g0sy
NKrrV3i0T1dbCd86miGDKvarGzjh7pdsdwNY15liGP6Orib1tnWkJcbtP1rJty4r/mbbxcK8ILO4
IvTGFG6BfjJ+La0aRt69i1fQmjUWHLwzkLNpw9cJH8/MONZcEJeDkq9WELSyy29bagStk5KHu7NO
TH65sZg+i/4qmj3DEeEGTr/Shzp4YWSNn4W7NEelr0VgDlwa7xqlwZjXxG4MIJqy0SsQlAwEXtqd
nH2FpJfzgAetkuyU6DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
bFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDEca
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgnGzdgO582LIChuNp
c9+jMqyDyKwer+u4fJrobEfQq7AwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYwNzIzMTkyNTE2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAHsPx+wSgpXO6xhKxPb4uTtcht3zJUu0KbiUVz6h/CmIFd+fKC+OC
q1W13HGJs/d6MFxJ62L5cNrQC8wRsEVCz5CFvspHvZedDrTHbZodRfqng1kRSecj3mZAAInVZohz
1pKOW8akprvyWBhUcs8NaisNnIwUOYnNtVsbapQSc54MvvTjczQ46ASVSs1ARDb8o3PeEOaUm5H2
1hzaKKxJI/QvQ6bbSWR/x76C+b9bBClnm8bGG327p9Nr96loY/Z23Vo6uXXxxMddo3h6k4nCqFl1
5gQiiQVQCoYXAjA2VC8WgNAwVymQye5T0bejFQ/gAgPGwRdAM4OtxzG9gUq7kg==
--0000000000003fcc0506574c37b8--
