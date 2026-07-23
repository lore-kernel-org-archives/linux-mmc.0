Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F2625
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836268; cv=none; b=DgmlPYAa2HO7eS2Sjdpha467MMqR2nZdAb9NvYleOlqleC7Msn2BIDVxb69+zHe+luqEvGHHq5hzgleaDK1OjxWVqBV0AOYM+6azjxR/Z866OTfrUNCl/g5b25WPviD0e4GO4myhEFJmOHL0KBWAw+FskiLxYMKLEPDJtGMy+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836268; c=relaxed/simple;
	bh=8g5rdynbb6hhCUvBDSDltxO/JrPDePi6UkwyBgKzINo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENnqyzbgyya30Om55oRDdUHvOG4MvyEFwq/k7zidT4r/gRX1t2cskZ3pY4ki4CHvU5sdOu/t2xGXIuyNik5GUuMm4r3yktWCXa5W2WCS+riJl6YgxiZvQ5qvyUpp05O9peUczKnF9nP4cw4kQeQVrq5qlUH743qPsryt4nFGr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=esf0+6/b; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="esf0+6/b"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5bfa6766cf6so473448e0c.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 12:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836264; x=1785441064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KvlKBbqVOVm/MesrbxjJQri9+Cdh2V6md6UqCISImNo=;
        b=LzC7hXWLT5FdPYT5sqWiYK4oeZ/JgRjvxuL50VkJM99kcx0eDiAwAaKU/VamKtgiZe
         gTslBs8rXBboYi6HJPHbpR9IuYz/H44x+jdFqL1grm390xDuKpCgubd1LpMlf6Yfq5NH
         +lfyjPhyBUR/YWATjanZ+WERLVFf99oOaY+/lDau8bcgdT/WcUHWk4E9CJdgGxxdtEem
         E9sR5Ts9WAB5izPpHufgn6Pn3ilX9jqJ3gpnA0YNBTDWPQa5v+jFDtB4j7dpElXfU1pY
         cIwfXhhXSxub8P216PXlHamgm0h4c6mSoROONL9k4NnW5mnTTuI36mA9nC/5sKD87BfO
         4ufg==
X-Forwarded-Encrypted: i=1; AHgh+RprQ4LbDQ7p09iEvMslngPtbw8kZ3eubO6nI+SSv7Q17QkALolQlFi+P3xy8/nSh92Ul4sGl9fsdP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0izRn0QhFVaLpV644KBKtY6/nwdx0loCMazmNhtEAkBKFGBtO
	19v8LVKd2wQSgyx5674rOMmHMyTnpgSmpdTOD6KmuGP3pUay0XjJXjk9eMUwAhFxVQU89oQV2JM
	jFSfIKFw4GLk0FgxiVJcK1toZY3h2P9q6z5BRQgRxlLJKhipOUBLqRZj2pJ7clHx9t/HtMJ9wWv
	b1fq3rcjLIlLLdaKjL0zwEmMwxU/fE36dIk29OhaB5X+CMeZSs6+rJFo9tFMIjaj5CKA1rv3UTb
	Wqzjji/slvh
X-Gm-Gg: AR+sD10DN6Q6tZU7/LUfnSpSPjvgl0bk6aWp+qAUzw19uSS40uYLdROaL/5pRQQkbWN
	RvdofS/6c7R2YCsG7k8Hu1GxReTjxys/HRrBP3DpzkONQ2nPAvPo5vEul2EIBXWhEUakM1A1+Qt
	/AEaWmaHf/0rUWWkl4dc7kPNshBZy/JMVs1WMqDp/s5eBoiG94ikb1QpE5FJQ/oCnK2F/ia02tu
	3wKI/VmAbKCa0o5hPX9V1GBMQRtmvl7QNmX2JFFTZJ/Iu5E+qTT6+p3b+qXYQTCW0mIoIlZeGM4
	dR4FGRV6VooSQwQjMhGXWp34v9y7zjtM/vkel9IxB2s/QURlOpnHlqVb8kNKLx/54BpQ8EZhElY
	k6xmEdcaFLERqg6R9S6itGUSRHc9DVjCDiSfscyEvdVX5eYjvy6uDridPG+eI3PN1snQ/DFjPT9
	WgaZ6zXKYiXOv7RhDHMXmBguY8IUxnS8o+
X-Received: by 2002:a05:6122:1687:b0:5bf:b497:87c3 with SMTP id 71dfb90a1353d-5c2d9d86222mr2557278e0c.0.1784836264187;
        Thu, 23 Jul 2026 12:51:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c2c5fc5427sm597507e0c.0.2026.07.23.12.51.03
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2026 12:51:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1178319a91.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784836263; x=1785441063; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KvlKBbqVOVm/MesrbxjJQri9+Cdh2V6md6UqCISImNo=;
        b=esf0+6/b3yZ2jk3Q8DjydbBs/xx4QOS5HphXjNximCJXy+CA+D5LH4WSfdWLlXFnAt
         MaHCDETeaDVbU4RKJoZl4eUlHpSOSy0uc33DvalJ/UqBZ214BnD1VmWexAzqYQQy0EC5
         mw8fIC0z4QRVZwPK4RfUuoa+UIV2eqCZiYa+8=
X-Forwarded-Encrypted: i=1; AHgh+RrgqsPrNCK4Y4ufSE2eYQ+CwG8ne+r3ZTBBsVKpoIyFH9gIHe/S19bX/bukns+FEU/85v726IubngE=@vger.kernel.org
X-Received: by 2002:a17:90b:1d52:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-38ec69575acmr4652372a91.7.1784836262846;
        Thu, 23 Jul 2026 12:51:02 -0700 (PDT)
X-Received: by 2002:a17:90b:1d52:b0:38e:75f3:ad4d with SMTP id
 98e67ed59e1d1-38ec69575acmr4652325a91.7.1784836262308; Thu, 23 Jul 2026
 12:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722211417.3702709-1-kamal.dasu@broadcom.com>
 <20260722211417.3702709-2-kamal.dasu@broadcom.com> <20260723-venerable-infallible-oriole-434b75@quoll>
 <CAKekbevxiN=8q60sHkRLKzEwc75PYHO7nJtMEahLF+u39g-FBw@mail.gmail.com>
 <1a9d18ce-e6dc-40e0-aa2a-e27f694e1217@kernel.org> <CAKekbetBskYyteYn2bMG+fNZrGhEQziZB3p+bKOvjx1CWRZA8g@mail.gmail.com>
 <5021dbc6-35a7-4af1-bc7b-d918faa2c4fc@kernel.org>
In-Reply-To: <5021dbc6-35a7-4af1-bc7b-d918faa2c4fc@kernel.org>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Thu, 23 Jul 2026 15:50:25 -0400
X-Gm-Features: AUfX_mzt2vs2fKjckmO7rB0MSeGpeZYQXDFqKeyCSNIF3I52W6eCoxZ7V8Hkggs
Message-ID: <CAKekbeuMtzwYWax97DRo89p_UnG-Gg0ALnhRNFjS-XP9-KV_WA@mail.gmail.com>
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
	boundary="000000000000744cbd06574c93ba"

--000000000000744cbd06574c93ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:36=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 23/07/2026 21:24, Kamal Dasu wrote:
> > On Thu, Jul 23, 2026 at 3:01=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 23/07/2026 20:53, Kamal Dasu wrote:
> >>> On Thu, Jul 23, 2026 at 3:51=E2=80=AFAM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote:
> >>>
> >>>> On Wed, Jul 22, 2026 at 05:14:16PM -0400, Kamal Dasu wrote:
> >>>>> On some platforms, firmware accesses the (e)MMC card directly durin=
g
> >>>>> system resume from Suspend-to-DRAM, before the kernel's own resume
> >>>>> path has run, in order to load boot code using hard wired logic tha=
t
> >>>>> is not field updatable. This requires the card to remain powered
> >>>>> and responsive throughout suspend: it cannot be put to sleep, sent =
a
> >>>>> power-off notification, or have its supply removed.
> >>>>>
> >>>>> Add a no-mmc-poweroff-suspend flag property so affected boards can
> >>>>> tell the mmc core to keep the card powered across suspend instead o=
f
> >>>>> sleeping or powering it off.
> >>>>>
> >>>>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> >>>>> ---
> >>>>> Changes in v3:
> >>>>>   - Renamed from no-mmc-sleep; dropped S_A_TIMEOUT framing per Ulf.
> >>>>>
> >>>>> Changes in v2:
> >>>>>   - New patch, replacing v1's card-level quirk, per Ulf.
> >>>>>
> >>>>>  .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++=
++++
> >>>>>  1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git
> >>>> a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> >>>> b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> >>>>> index 3d7195e9461c..5f7b3f8ef1dd 100644
> >>>>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.y=
aml
> >>>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.y=
aml
> >>>>> @@ -232,6 +232,16 @@ properties:
> >>>>>      description:
> >>>>>        All eMMC HS400 modes are not supported.
> >>>>>
> >>>>> +  no-mmc-poweroff-suspend:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>>>> +    description:
> >>>>> +      On this platform, firmware accesses the attached (e)MMC card
> >>>>> +      directly during system resume, before the kernel's own resum=
e
> >>>>> +      path runs. The card must therefore stay powered throughout
> >>>>> +      suspend, and the controller must not send it a sleep or
> >>>>> +      power-off notification. The kernel re-initializes the card
> >>>>> +      after resume, since firmware may have already reset it.
> >>>>
> >>>> Isn't this exactly the same as keep-power-in-suspend?
> >>>>
> >>>>
> >>> Not quite, though I see why it reads that way from the description
> >>> alone.
> >>>
> >>> keep-power-in-suspend only takes effect through host->pm_flags, which
> >>> gets set at runtime via sdio_set_host_pm_flags() -- an SDIO function
> >>> driver opts in from its own suspend() callback, per suspend cycle.
> >>> The consuming logic lives entirely in mmc_sdio_suspend()/
> >>> mmc_sdio_resume() (drivers/mmc/core/sdio.c); pm_flags is never read
> >>> in mmc.c, which is what this series touches.
> >>>
> >>> no-mmc-poweroff-suspend differs in two ways:
> >>>
> >>>   - It's a fixed platform characteristic, not a per-driver runtime
> >>>     request. There's no SDIO-style function driver to call an opt-in
> >>>     API from for a plain (e)MMC storage card -- the requirement here
> >>>     (firmware always touches the card at resume, on this board) is
> >>>     always true, not something decided per suspend cycle.
> >>>   - The resume-side behavior differs. keep-power-in-suspend without a
> >>>     wake IRQ does nothing at resume: it assumes the card's state
> >>>     survived untouched. This flag needs the opposite -- keep power,
> >>>     but still fully re-initialize the card via mmc_init_card(), since
> >>>     firmware may have reconfigured it while the kernel was suspended.
> >>
> >> All this is just driver stuff which I did not ask about.
> >>
> >> The property is described pretty the same - do not power off during
> >> suspend/resume.
> >>
> >
> > Do you want me to fold this change into using 'keep-power-in-suspend'
> > for mmc as well ?.
>
> I don't want a new property if it has exactly the same meaning. Of
> course I am happy to hear why the property has different meaning in
> terms of hardware description. We do not talk here about drivers, obvious=
ly.
>

In terms of hardware description, yes, it's the same meaning: don't
power off the card across suspend/resume. I've folded this into
keep-power-in-suspend rather than keeping a separate property --
extended its description to cover (e)MMC alongside the existing SDIO
wording, and reworked the mmc core side to honor it for (e)MMC too.

Sending v4 shortly.


> Best regards,
> Krzysztof

--000000000000744cbd06574c93ba
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
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgU2E2q1UkaoRVegRW
XhXCP3FEfp77dDpIbStnIr1yxl0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYwNzIzMTk1MTAzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAXxwD0/mJPNUhidipvjEdz5S2vzFY5dOhVqJbCyOy3IORylQ4ycLh
exvR/yOEgvm5lUsUDKLplAxqj3sueawtH9xj1twGlUuuravVzRSdMoDaYEH3oAaadH3pQD00sXAG
7mxCycikPAWLHymqgQlo35YVDxebnMTjV7019TDm/BJ4s33ZLcqkdKEMyADc/6Fe2RQc2+S/UsdK
cLMMKdJLxtyqto3a5z120MmC/R91nEqfkUPkt29Q5IksemrblBBfZDI756MhHom5cuEaIBfpBiEs
NUEwbDadu8qIZccLml9P4W8OJf7t38846GzAbpCd+Ep47a4NlMMMRBTT/dRWow==
--000000000000744cbd06574c93ba--
