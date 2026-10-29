Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300918;
	b=MO+ODcFdzQw1aEK4pF2SUiJusQKCHEI4mAnRqJ0zztAT+Wne0Fv3GujNLvRuO1UYl2KV
	 fqLOPYCDcJjY5xo3XjknKLT1Bu//2Foot9G2BvZPKaXRjsH6THNi9uA1oMhwGFBCIK4H/
	 U4EkxvfahRciM4KXo3K8n8O3BO50JEflVODHrIe6Qk7n980EOQDsWSc0bhgoONvpXOAUs
	 gI1ixWugF90yt0Q8Fj2ImzEww+cozPDeKXzQqpxlt83HRCzTbkemXjJGfzclON3fKRXtc
	 JTH1JydGMCu4GZy2KKKDyWRXY/c3JDwaPmFfqTHKCcC3mjpt+2Qph5nC4wHVetwIiqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300918;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=AkMZ2/X15jyOcwQ00rDHpNwR0Y79EpflvyVDD8Xt+5M=;
	b=t3TTvB/hh9w44NxMTfqo797zniPjibWRolTPiZfRoCnJJXzvh4cZSw/rGondZ26h5dYK
	 cL/3Hyu50iWagQjjJlodGodfrFhnHqC7QAk3eJbzQKgKtZm3BVIUKI6c7faOVufiQPag/
	 Brnj5ARpbTwyD1A3E4pq2qS9c5gMirBsHv1LmP4+Q+eXeM45LX3eiaXOiHnWj6EwiieY+
	 VjSH5wvMI7hIU+6EWFN6A4lpH1w8hpiwW9gmGO2BAInvEBK7ofy9sRK2DAH9x2/bSqJP2
	 zjN9GZpDiozXuEht0aYmY8dtZIQ0R15+IzsBcTUOl19O95b+OEkdK5vZc/Hf+MNV25A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="e3a4NN/s";
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9A606A31E
	for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 19:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93D9A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e3a4NN/s
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ae702d28c4so550709a91.3
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 12:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300917; x=1793905717;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AkMZ2/X15jyOcwQ00rDHpNwR0Y79EpflvyVDD8Xt+5M=;
        b=TH1PUEqZGVBER06DMOqtT6h7PZVRj5KmxW3/HRxOULvnSNWoPZw1fBBCdH9ZsZsqN5
         zJ7iBddDyLWqzDGNkvTpk4wmgfeIVxz4ZcK1yjize4sB7aO55VJ53cHh4Yx4zugQ6yso
         K5FXpkWCYzMyMNbXDmiCuZ5JRKaCT5xnn6i47L6AcstFozCw/Qz0nk1j7yfzUvAn0pf4
         pSzmsLdjF44eEZ7a6Oe83o9k03iCSwEapnmbScoODNXkJJYN55WP3dbYpulSQS4LnREU
         /8yxYHDMRrrML+N4B006NS4cic1yVX0sUXyriWBONJn2vDxusS6lMpj8XSkKOgSJZkEX
         aelw==
X-Forwarded-Encrypted: i=1; AKwUvBxWv4wJfX+Io1KFCSAZkLp4LyRgZGOW91rRtONJqZSMxWOV55wIA4Xd0GlB2KZXs2pSOXyZtxznJsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2dMTz2C1zAHF1vH+K0Ep1ok+mQtQFF1FSxybulMXA0iwJe2d6
	sS5Qg0nZoo3nHCgF58gmdSZBHbdNXRRd9paUbVJ4cNvsBD3UhYoRypWB7dEG7NJOIdSSq3FW+ye
	cH9v4+CtTIJHvOBK/YfST4gkNx1ikEqiA/y4t/KV9Hw/8cR8/v5EUSeY/ktmSE1FQnCzz9kho58
	BJfOU5FMNfxq0J0HYLwugbvnEDnuYnS183tDrS/FqAbOk9IVsZTej7rm+HwMcIusagaB7p0crkB
	CLzBx4KRrC1
X-Gm-Gg: AYBFou1ZR1ZCDbUI0LpLWZRPTGx3pJvSUKP3Z/CSNF7OtwVfK5/Moy87mWclz3TtJIz
	5YcOho5C3hPxfLs1c7DwysnR78mCdnhefgWuaDu/460uGtLgvoqwJfKRD2QiyTDDuLsaw2ScDB2
	rTTelBSaxli1z+ElMcTSQFkLvopUOMUpG/KutydZMndrgXglTuynDuEOccaKdDQ4eyafcTQtlTr
	Y/kWRLYJr9cHLB8Vk5Kfy7+fm9kYWlFMxPj2XcbFJUf02oZqF3CQ0xEbVg5EWps7Uu6LdGThMdU
	lbNMrRBt0Ii4KkYvct0dvbkYa59u3EGVLFj5VfcTnX+IgUSUQ+FezXACvidwlziApF87egCs7Mv
	Or8H/ETbb9Guiko0E0kwBKp2jhegbdKygoE4v82W0t1KhA/7o6zQhGwcM2pdpIn4aeplK7b9MV/
	HaLu9bC2Ve2QljLTWOOCqNE89oD/3fs6f0
X-Received: by 2002:a17:90b:3812:b0:3ac:adce:60b2 with SMTP id 98e67ed59e1d1-3ae57e33be2mr5422903a91.2.1793300916686;
        Thu, 29 Oct 2026 12:08:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e6ec859sm2670870a91.2.2026.10.29.12.08.36
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 12:08:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso4087197c88.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793300915; x=1793905715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkMZ2/X15jyOcwQ00rDHpNwR0Y79EpflvyVDD8Xt+5M=;
        b=e3a4NN/sH3I6dlfi5/L5a+hPAI8q2uojU9BUzmRDd9Ksg3fAYxusoMt0ZcJ0zZl3aX
         Dt9IXplh0QAFaZICHM34SLLg3w/cEh/e0Qb8lANDLdFX61WRAuU+YjJWX5swCEW9FG5o
         TJIxU+R+b/IYo3eJ0CiaNQETG6dGau8ytibTk=
X-Forwarded-Encrypted: i=1; AKwUvBxcLk21chiWM2LtUHcnuGHiTnzbnuHbNazhEbfeFIrQrHpCWSMPpn96KMJ3CEZMbOCkD8VQOVy8GCY=@vger.kernel.org
X-Received: by 2002:a05:7022:fd0c:b0:14d:baf5:c411 with SMTP id a92af1059eb24-1a6cd3a1c88mr9734472c88.14.1793300914277;
        Thu, 29 Oct 2026 12:08:34 -0700 (PDT)
X-Received: by 2002:a05:7022:fd0c:b0:14d:baf5:c411 with SMTP id
 a92af1059eb24-1a6cd3a1c88mr9734419c88.14.1793300913542; Thu, 29 Oct 2026
 12:08:33 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009003201.68288-1-kmehltretter@gmail.com>
In-Reply-To: <20261009003201.68288-1-kmehltretter@gmail.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Thu, 29 Oct 2026 15:07:56 -0400
X-Gm-Features: AclHuK9Gp_umrR9f7760TOdauAd0wIgK9jYiWKcirw0qq1f9Kqqbr0vbfNEZx08
Message-ID: <CAKekbesg6e3z-xX1NkavXM31XYk8BLkepnQNU_rqt1C_s+CCpQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: don't log an error for missing BOOT registers
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulfh@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000008a3d9065eff684a"

--00000000000008a3d9065eff684a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 8:32=E2=80=AFPM Karl Mehltretter <kmehltretter@gmail=
.com> wrote:
>
> The BOOT register range is optional: the probe function ignores a
> failure to map it and the suspend/resume code checks for NULL. It is
> mapped with devm_platform_get_and_ioremap_resource(), though, which
> calls dev_err_probe() when the resource does not exist. Every
> non-removable host without a third reg entry therefore logs an error
> at probe time and then works normally.
>
> The binding only describes the "host" and "cfg" ranges, so this is the
> case for the in-tree users. On the Raspberry Pi 5 family (BCM2712),
> where the SDIO host of the Wi-Fi module is non-removable, each boot
> prints:
>
>   sdhci-brcmstb 1001100000.mmc: error -EINVAL: invalid resource (null)
>
> Look the resource up with platform_get_resource() first and map it only
> when it is present. Hosts that do have the range are mapped by the same
> two calls as before.
>
> Fixes: b7e614802e3f ("mmc: sdhci-brcmstb: save and restore registers duri=
ng PM")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

LGTM

Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>

--00000000000008a3d9065eff684a
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
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgSrYdE0sFsEo+ItOh
IWs3ImaOwgPHSmb50ifWPB7IkvowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYxMDI5MTkwODM1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAEg/u8uMQ/KJ0zTXIYwiugwMhnu70nIHBI2vLxDbKIGokl734rJX7
6xfA/qmL+nQI2CNcDXTYs65XIdTt9psjqnDRZyu/xkX3E1OwT5atHf43qIlHQp+TInvG2S+etU2I
sDSlVyDOCIK2ZohSMTcvpABZ+pwAAW7AcS/2lmSRSv1xE2ypHMg7VhuyTnNgjFXtj8Mi8z2BchOt
6c2Ox04RFSe321hBgyIzOvxrqZCjMm0EseB55OQtllQJtZ+FRcb44QjTXb3lYtUAtmXslCKgSQtQ
xlNSbGvV4RB9LLD2oEWEyeMH0HEt5iLvxfKeF3YK4AIv6i+Vir44AB1WN1BBMQ==
--00000000000008a3d9065eff684a--
