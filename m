Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3619C540
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419093; cv=none; b=aq+61jJzBcnpepR7TWFQhMGlXR43L5qDH2yv5308RAQfTvY7yAO3kmj06obUrFyfjyZ4DarEzFHfnbwyIqABfUtbAymnU52UQNlnrECa+W08R+L9GjUtixxJZSAHOdEK7/yObyLeK+hjGjaHz+3A+AXOvyTL/UtpdJH1YtYYWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419093; c=relaxed/simple;
	bh=mu44mICBjJy6ESj4c7B46ibOC6pSKep9ZLPFn1ogPB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYPoM7NhiCCqvqTmsekIapYLquRTf+8+NkEOF/h6LpNaUVvWa0pUmSiqH6fMatcGq/uMOzfX8oxtqLjeno1kqFyUSm1W7Znjs9NNJyQOS15k4Cb5YtSY4GTM5LgK5y7ymBpEnL7t/DrfNI8uVyTFVyBAr2F1rhduikU/w9U6lvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c0fcRZ4V; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c0fcRZ4V"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a110548cdeso1466385ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 11:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768419091; x=1769023891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdJONMpS0CH1Wj+PaQYsc3RGWF7GCekgnHRJwJ4RdMQ=;
        b=ukV5lwen+exlPGilVFKbBANQ5bS4ZksphWAbe70ya5KkydnaZoCxKXYd/4g+JYKcvY
         e2jM+k/pB+B1PYpcGm/AMrmVhiZ/MixvzA4iABl2AsifDDVExPWvWMnUOpMwRxWH6IN1
         Rj1HPgmmjKN6+S98kJdJgxUyCxOV2NQZ2kFvEQmQx/WqyXOdapi9nXthjkI4VLJ+XaDa
         ECGzsvn69GXspkkxa7FaJuCFfl6bjIuQXMzlBS2TD342YZtBuZkjD9vp7fJbRd8gp6Up
         3vM2Bl92LYAs8kBxyDL66L2+DQkn6aeWVGaR2DQX+nERzII4KKFs3GtZwjzO8VSCxInw
         J2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWiPaY72pYcoAiuijE3jtgEL3k/1A5wzRXbN/q7EooU+Q1VlGG71FkclO+BKsrLscR/O1R0EoQ/by4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdNh3crlAzvhNSNUt1E8Uf3kgiKRQH6PUAEz9yl2g4YawhGCZ
	E4HTLt2LW6FWAQDcJobdPZT5kdaLOEcOXdmpwAl++1ouxFGnIkkFT4hmtGnSVYWgBZVwNz5dD61
	vQHasdKrcvyuDIT+IpnzeXhAVCq96UsXecICWrUozaxFkaEi3lqSRGNWBRvrsPgkWjP9HXi1UZD
	yCXXXluckbr/0mNFQi0bgrd6jP0LHCUFo18sZPXLaKuFjQfZWG0QCZrPKhTKCMmqFZeTxbvY7xL
	zjhjUO8duUvROb1
X-Gm-Gg: AY/fxX4K6kqsSAQesxmXLkibZJoY5M6zMEFCxO6NY1RVsa4JLV0Q7/+zAnR7O9raA4B
	d70IYox0yj9dgoNjPGk1/dJxqHC2q8Zk9mXgiTVj5qwPrzg/W31ds0DZjQOst715NCLiR4Ulhbn
	ZjDVrvfx5npH42K3mcmfkOtsllF3CGEj/X2h+92MoA7bqv7nfbrIwpoWCsr2fVecJ4nHpL9I0D6
	6bpYX/jPvt6Kyb6FAIk251Ddg+buEdIkA3uStykAqV9BhVGx+a9R8RO8aFLkGErWj0ncsK0xLIU
	PMCfhjKqXt4OXhgzEOq8UNhXdxtbV6CGfgsxeObhO+hpMqWdcYAd0PTl5wTsPAhTkYcaKuvdyku
	UWaegqIkmlZ93DpsAAC2n3+nbQB43sjbZ5dZNZp1CYHQWjpGiLrMN31Zcyz1CWnbTUHJpvZrzls
	xBChhvWc+eBMxJyWDPHjsBGBXES425sPj8KIoUuMehbg98s/+O
X-Received: by 2002:a17:903:1585:b0:295:fc0:5a32 with SMTP id d9443c01a7336-2a599da7496mr39476445ad.3.1768419091340;
        Wed, 14 Jan 2026 11:31:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c49ea5sm28626985ad.24.2026.01.14.11.31.30
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jan 2026 11:31:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78fc63a4637so1430817b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 11:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768419090; x=1769023890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdJONMpS0CH1Wj+PaQYsc3RGWF7GCekgnHRJwJ4RdMQ=;
        b=c0fcRZ4VWWRbrnx6/K+84yOdtlcIVekMIGQTPxmZj1xJ8nroM/SKFxaW+m6L9ZW/zd
         ZIZr0pwmquWL9p7QKaWvW0v9Hm3TuhLb8faPIOSNSmDTXxapbhTGwm/LFF7XV6w0mDVi
         0wmU9xoCROWTP7rUrjTWhOV1NYnGASdmrvxaQ=
X-Forwarded-Encrypted: i=1; AJvYcCWb61Lpki7mZo4r6MgXfKDoBCwHXsmNsuEREmzk8CS6FCsBHXDHDn8QLWi6EsOLY85M81lLgPsL6nc=@vger.kernel.org
X-Received: by 2002:a05:690e:1503:b0:63f:b446:7019 with SMTP id 956f58d0204a3-64901b1a4demr2848123d50.64.1768419090159;
        Wed, 14 Jan 2026 11:31:30 -0800 (PST)
X-Received: by 2002:a05:690e:1503:b0:63f:b446:7019 with SMTP id
 956f58d0204a3-64901b1a4demr2848106d50.64.1768419089600; Wed, 14 Jan 2026
 11:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-1-124a53ce6279@kernel.org> <CAHi4H7GvSsX=BO2AWy4BB=FfQ8bWx_C3PBh9UQHYOo+G247P_g@mail.gmail.com>
 <20260112154805.GA271138-robh@kernel.org>
In-Reply-To: <20260112154805.GA271138-robh@kernel.org>
From: William Zhang <william.zhang@broadcom.com>
Date: Wed, 14 Jan 2026 11:31:16 -0800
X-Gm-Features: AZwV_Qjbm5J2wcTaNLGOlsCrlNMjOpv3tOlSAapv7lbKCL7hMflyF1Pf6b6muXY
Message-ID: <CAHi4H7HbJ6fZYzzXfnxo7jfncnuQ62C=2i0a8jxys8UeHhQ6Tw@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: mtd: brcm,brcmnand: Drop
 "brcm,brcmnand" compatible for iProc
To: Rob Herring <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b4fd4d06485e272a"

--000000000000b4fd4d06485e272a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:48=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Jan 09, 2026 at 10:05:04AM -0800, William Zhang wrote:
> > Hi Rob,
> >
> > On Thu, Jan 8, 2026 at 9:53=E2=80=AFAM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> > >
> > > Some users of "brcm,nand-iproc" include "brcm,brcmnand" and some don'=
t.
> > > The "brcm,brcmnand" compatible is not useful for iProc systems as
> > > there's a separate driver for iProc. So drop it as a fallback.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml=
 b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > > index 064e840aeaa1..3105f8e6cbd6 100644
> > > --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > > +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > > @@ -66,7 +66,6 @@ properties:
> > >          items:
> > >            - const: brcm,nand-iproc
> > >            - const: brcm,brcmnand-v6.1
> > > -          - const: brcm,brcmnand
> > >        - description: BCM63168 SoC-specific NAND controller
> > >          items:
> > >            - const: brcm,nand-bcm63168
> > >
> > > --
> > > 2.51.0
> > >
> >
> > Another fix would be adding brcm,brcmnand to the users of
> > brcm,nand-iproc to keep consistency with all other brcmnand chips and
> > utilize the fallback mechanism in the driver, although I agree it does
> > not happen in real life case.
> > I don't have any strong opinion either way but a follow-up change is
> > needed to remove the fallback from the brcm,nand-iproc dts files if we
> > go this route.
>
> The question to ask on a fallback is "is it usable on its own?". IOW,
> would a driver than only understands brcm,brcmnand function in this
> case. Given iproc needs its own driver and specific handling, the answer
> is no here.
>
> Plus, this matches what dts files actually have at least for the arm64
> ones.
>
> Rob

Fair enough.  With that,
Reviewed-by: William Zhang <william.zhang@broadcom.com>

--000000000000b4fd4d06485e272a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
PRi27wH/XHTDMdyL0Org+kxniXue6MSNJvcQwaLO/UQrmgTygBlVGa+Qg9ZFfS00xvuqeYH7tImO
48WiXeu9rgn5KTH0IWP1+R74KIgxJQ+65la+caZvxwC9V3ik5p/LOGA2qS4GEjGuaYF8QKhRTR4h
/QBSktqZLbzVxpjJXrqFTA2BLlYRp9hPhqNxbn46WuLufpMWhFtjUoQi/8fRRWRsMAY0o1J0f+kB
6EI8FoxPTOpvuLRonqHIWMHk5YRnDdqJ3G5Oc8zmV+UCAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEad2lsbGlhbS56aGFuZ0Bicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFHjI7pbQZurVKsSRE/a9
7gUEyVCkMA0GCSqGSIb3DQEBCwUAA4ICAQCFA4fU1GnG8sY7kyUXp5tle+VeWveoWb272jPauU5R
w+udkhVXmnR0Kg7RgkCD00PLTKHNRyegXXDMArs3N9NhO3s9eSp9KjDh+h3WuQWCJH3QBHLGW0qE
fyV87wUtBIy/QsHwO4S8OlOZiXECR7V1EGIF6t3s0W+3UzgYeHL+Ttuhda+2wIVY0EbS0eNH9Vob
4YG17VTBBe7hyobXFpd9d1JGENFzIWncPUshOE0Wv7KlkrRc6aBOpL4p5xO1pHi9h9w8utyHkMoV
nefXixkn5YVHnuV/jbSF/IM4Mlqt0E+n/TRp2c0eR+1AauZKENV2syNBo4aMa0BkmikBjLSnDjt/
TYQdwHNWdV495n71idvueWwTFUhUsnudYcnh42eZENopBOYjVu2WhsffyrNz0hsuR85LriqSuBbf
drd9DMo3DgtfJ7hh4sEAhSw/x/Br86rfLBftZMU02htlnkOI9Tp1QuDsr9+MsqY6AjKeXAy67m7H
TVAZ9uyO9N20yU0p7igESOWKR1ccL1TPA1jrSHK18Y75ot5199FNWeE/UKoDKSML39iPZho9XPh/
/RlsfRFiVOPrI5Gwi4YfIfi0jjEWf310/CYEmA5jrp5gUQSdo/+FgfXLKDFiEHCf5b3B1l70r6bR
WkDCNNacYJWZtSp87i6jmw+l5xx7OkEJ9DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDD2ooFIye/WiO3KgZTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
OI/KxqdLKKl/0CRoKpI26pgVpffBih+18maEUKs7uB0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMTE0MTkzMTMwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKRg82nRRGGtkAXumnPzigPFCKvd0ze0fNje5
cK/2o/Qbtggr3FWkEPin0UYZmbspS7JnGMXJwEroy1KU3c08uDSxKx6hgpTBpiREjDcpgC6UCSV3
0SM4xlKpam3eoRTxQ9tPP4VrpbpT6O0YPbC+7WdZoYWyaWSczkZ70KyD1VGlALB+SYJnv36+8mnW
113aJP4g8NW3YZ17T+kk5hF7Mv/V+hUj5KzbXPsGB0Ti+bQafRxCiIv7b6ch2V42po7tCW78h2v9
hNTEW8Mik/NmOkxMKG+sR6TJhvFVl1m1Q4D/c/3ZTAGr/85QmmNH/B1wzLa1bjLwkBWolYSZ5Eeb
iw==
--000000000000b4fd4d06485e272a--
