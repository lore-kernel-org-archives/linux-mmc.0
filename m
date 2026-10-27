Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133109;
	b=GpCS8Pdsm2ThoGPGQOQCJP95APVFNkwN4NA6i4tyI5XYzaEp+54d8p3LnDpqLmPeZSRY
	 APgrwEkYZbkZ+7OX4iJ2F58X8VJtFzO8ZXR8alGfH6zttGT22jDNdddSzKAbQGBM3KPa9
	 5zg/pFfhLMpP+I30pH+ADxY5Gpz7Ncvd6dL96bVKtbiyRxGT/0JZtuIIao6trwrz0bPjw
	 mxolpit8fsOloPZ5PN+0gm1TMKcNAogv3K/TG9xrT3oKT7robEOrEYuxQK6FiOqjE+Wyf
	 QlEefhQUWOFL+wn983YyQXe/yrzymQFUSXmn2j5c5dXzDWDj4YXOkBOpHmuhxyA5VJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133109;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=fGUQLb9rAt0sUarA6JO5o/vsOWD8C9Hgi2YiFTk7TL8=;
	b=q6nkCIshu6dGIY26S2crvJygYNHrvvLrgAVaUFxgfuI0X9JCSt72IY8HqDCc+GMuMLhz
	 UkPfiwONT8C0c67JE0UOKDEMyuVpab4kfT5jpLZOfxndg8+ALHGg87zrfcgRzZ5klyo0I
	 ym11pdcZeu3bgl6BeBHha6iniLdcOVbe+ENuLqnCpPqBNRwNuqSrN/WCwARu9k3K1heAP
	 0XFgxaVKLq/5fPsUg/luTG/uSsIIhUx+3KvjpHLZ2iPQL70mK9kW8BYtsfQsAI4UA9tRW
	 /peB02ksI5lZ+8jhoe1AWlqxypkOiUptnzXRZKP3H5/Bl4pctlTFe0gKqGkoseSVNBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Tz6Hzhgr;
	arc=none smtp.remote-ip=209.85.128.227
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BE606A31D
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 20:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 083BE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Tz6Hzhgr
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-8ab37e44643so1804457b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 13:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793133108; x=1793737908;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fGUQLb9rAt0sUarA6JO5o/vsOWD8C9Hgi2YiFTk7TL8=;
        b=jXgnFojau0YFGHR82Y9MsxDXqutseEjt5++/NgPZH8CZgcGTnemBg9IxxazVozB/70
         yLcbRWSTJLZp8b/AFZ1+hwRalE0A1kpgPcevsEk//FwXjxGf2u3mJJ8rPwZ81yFwDQO5
         ESTiMlAcwc4olhVSWhGFQsP5nXW5IjZvCezK0n45yPf25HqpdOeKpGnyERu4oZhn3DwH
         zzs591dwBjUcc5VxkqJW7kPWjKcNIoYggxXljjPfN8QqQNhwXzI1Zz8TRETZhf4hVRUD
         A6saVsXYJpBx0TGvXaE8r4V9H/Ny/jJCZoFj2lgKyVUXqQuJyf4TUwlwQLbWkpIfuDAY
         Qoag==
X-Forwarded-Encrypted: i=1; AKwUvByY+LCcdHzyMHx8+PTrjq13gx/fHsN7Vf1melcoUSs+05fYNryHdTivuKry2agl3EPTtp2ygAZHGmQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/cbQxzaajwafp/KeZjImyq9/0IuC/DNWllhdgEMB+QIgtc/70
	6UZ2XygpoOS+VRFK5lXog+dl8hZfp7gqO0wJzmwKS9YBKAKbA+17JnbkFuqEC5vXsWxoZD5PrlA
	VwylhL+cUZwyGcQB79d60ob8ZSTgRoFhhAI+weRbd6CF3Bv7t8kSst2DWBRrIdXgckD6K17JnGt
	PNSCttu5vup1oPG0z8BZ8YvAolyWW6l+VA3mHbvvVPi+rnoFyLppceILWKsvoS4UTx0boo03jCW
	MtElbp0W/u2
X-Gm-Gg: AYBFou2zV5+wMVM7BcduERaViwaXIM2/zZSdHJKU7Hb1nfPzy3TdyiiBz8FBTuqLz3l
	Qc0rVVG6+0kmdRwasLO6vEwFjJnEMQeUF6KQlLmwhgcs2g3ikCtzEQRRV49AC1bJ01xS8p2/IEm
	a+bUJzPq2bubYUBd68G9Ba3zpbM8zbCV5FbxZTUODaE/LZXpqTkwz3aJsVEWyJ4RQ02iENOwnQk
	KxI8Q+X8WxeQ7TMUawXiyvfJ+Zu0z54HL+A02Dhx44LCS8ag41qbUOPl1A2GfJow1PFxuv5DJ75
	pTy3fqGn07NMQpolAvIqtOePWIjOVbDhCRDR2IuCJBytRb+zgfQ4MvOb+BsXOkVl5yDyNhNUuHY
	bus4UG6aj9tWeBt4gGHUkt75VEzV/LNnlSM/5zE2GGM5IZMgfHTmmaUtFzV+5FKNGfdANUXR4m4
	fqxT53taQmF6jxqFca5k+tYLhTbGum5kVN
X-Received: by 2002:a05:690c:ed6:b0:89a:63da:fa90 with SMTP id 00721157ae682-8b1b5d61998mr899797b3.75.1793133107712;
        Tue, 27 Oct 2026 13:31:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8b19e68d3b2sm496277b3.47.2026.10.27.13.31.47
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:31:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso406595c88.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793133106; x=1793737906; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGUQLb9rAt0sUarA6JO5o/vsOWD8C9Hgi2YiFTk7TL8=;
        b=Tz6HzhgrK9H9H1v1Cz13hMzLrFGXrewhRVSzqovH+jxuT80/YpDjy4gtzscEzzGilD
         HQZCF1wpoQJdQwnDp0SEqDgpbQcYRGHBDfkNp+keMbDTGWmL8QnVdv9VjtnQT72hdKtP
         uI65Tipv+VZG5LyT7EezDgjzuLrqZ3Q+S/xiw=
X-Forwarded-Encrypted: i=1; AKwUvBycOpUlKP4kYIYZLyAuKFHlT2B+WiEuYczd62iLMfqJZ9safv1moHJkyIsWqf8wXrrtBHzKgiCA8Ig=@vger.kernel.org
X-Received: by 2002:a05:701b:4503:20b0:144:fb42:52 with SMTP id a92af1059eb24-1a6ceba5bf9mr380650c88.28.1793133105900;
        Tue, 27 Oct 2026 13:31:45 -0700 (PDT)
X-Received: by 2002:a05:701b:4503:20b0:144:fb42:52 with SMTP id
 a92af1059eb24-1a6ceba5bf9mr380630c88.28.1793133105327; Tue, 27 Oct 2026
 13:31:45 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com> <00b63b4f-053c-40cf-82db-21a86fc485c6@kernel.org>
 <CAPx+jO821-wULVT_KbZB4oaPSYAHi3PEpM0VzvSL_7NBns1t_g@mail.gmail.com>
In-Reply-To: <CAPx+jO821-wULVT_KbZB4oaPSYAHi3PEpM0VzvSL_7NBns1t_g@mail.gmail.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 27 Oct 2026 16:31:08 -0400
X-Gm-Features: AclHuK_Itubp6CbNonscZ0YWNQzB-O_bB5nF8e1k_ZMrP-o8WPQN1vd6hYikrnM
Message-ID: <CAKekbesRt5qDOf76MBG_8hROMa6Z=UCNdXHKoE=5u3xFcznhhw@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000defc02065ed8555f"

--000000000000defc02065ed8555f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:48=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Tue, Oct 27, 2026 at 4:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On 27/10/2026 15:40, Ulf Hansson wrote:
> > > From: Kamal Dasu <kamal.dasu@broadcom.com>
> > >
> > > keep-power-in-suspend is currently documented as SDIO-only, but the
> > > requirement it describes -- preserving card power across a
> > > suspend/resume cycle -- applies just as well to any card type. Drop
> > > the SDIO-only restriction so eMMC and SD platforms can use it too.
> > >
> > > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.co=
m>
> >
> > Incomplete DCO.
>
> Sorry, I should have explicitly stated that I will leave that to Kamal
> to contribute on top.
>
> Kind regards
> Uffe

Hi Uffe,

No problem. I'll resend the two dt-bindings patches myself with the DCO
fixed and the DT list on Cc. Do you want them as a separate two-patch
series on top of your patches 3-6, or should I post the whole series
as v11?

On the SD wording, since you plan to add SD support too, I'll keep the
description as it is, unless Shawn or Krzysztof object.

> That said, I was also thinking that maybe it would make sense to add a
> sysfs node to allow the behavior to be controlled by userspace.
> Thoughts?

For this board the requirement is fixed hardware behaviour. Firmware
reads the card at every S3 resume, so the card has to stay powered and
be reset each time. Without both DT properties the board enters suspend
and then resets at resume, so I think the DT properties are the right
way to describe it.

A sysfs knob could make sense where it is a policy choice, for example
on SD. If it is added, I think it should not be possible to turn it off
when reset-card-at-resume is set in DT, since that would bring the
board back to the failing case. I would prefer to keep it out of this
series and add it separately when SD support is added.

Kamal

--000000000000defc02065ed8555f
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
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgH62j89bcl9KrjgtV
k8YKShJE2zNYPdyUKDM/N4RrIcMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYxMDI3MjAzMTQ2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAoBu5qps6gixDmAjwuZnfJ6FgJqIMLkLNkRkHowB/9wMsFuMTaNzj
W30diiP7bS+5aLIRizqiLLmTCGf2n7c8aGLPCy6aU/Rckhh/iPzzh79NCV0LaGIqtx7XFAEFFFC1
86NXr91/Attqj8BCw/iXojmiWEXO1rAGiE70w4f7QvFcsTN9iTWXPWCvl5WYmmfhLL/jE7ubUNyt
uI9G8GGmt8XhyuC3yIm/q89m/lvGWdj2iUVL9U/nVroZC9gWgiVeGXQ6Oy7+B5Zvi0yP6yo7vfP7
sXvCOyD/K5Y3pWtXeWYM+qVMIvMfJ9q6BexzG/TQ3eTkIK4YkZDqRqEHddE27g==
--000000000000defc02065ed8555f--
