Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Klsm5AGt"
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2521720
	for <linux-mmc@vger.kernel.org>; Fri,  8 Dec 2023 12:50:53 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b72192f7a1so2501939f.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 Dec 2023 12:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702068652; x=1702673452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UXg26pKX3lvs1vWaPnx9pc82uFcibvp6uYU0Ge8uEdY=;
        b=Klsm5AGtLOS906MHH3X21cogNxPilgyA52SImV31OQWDM6wH2ALLV0rQAWkRcZc6tv
         OgMczkADHMO7XbGvqZd7QO26TaNoViSZ0zJ43szF/te5IXfUEeqhmmKyi0VDCyTUlDxQ
         LFBetNFwjgTwNYDMvCwpNw8S4WSfqAiWjRmTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702068652; x=1702673452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXg26pKX3lvs1vWaPnx9pc82uFcibvp6uYU0Ge8uEdY=;
        b=e1lMHiz9z/4GRrNMkCCSzaVgtsC8rKVjmhUoBSfKMlFaPQPhO76IRUYqyuQlGWGqyY
         SaXbFQ83rZT7Cs+SEPDVrftkF6JFcnjMK3ewRNVOKCLZX0abvcZY5zGp7aIeyRQ1Pnya
         K8MQp0KWQPQrpwUzwITgEiT9Gqf0jHlBbwPLaRuypl/czg+SZ7IU6s6Cu20rbxpy53wl
         8Gb4wPNJpyx8LSJeg7WcfqkalGLc4qSQxbNZERz01gBK8dChYnQJQRnUnW7fZ9NCRnYI
         a61kp/o4UcqJrOV7xagt4mxKraSzwx9mc32qURsQ2fE4SgrCMyxuiJHH2Yfhf6IYZt81
         htfA==
X-Gm-Message-State: AOJu0Yy+B9euOoTacLiHSB820f/MeqR9S1pzQ+9+yr8xyzsjz+W5WMZ6
	SaezJh38EtZGfzV4JiqoenQWUnO4/juV3rYd2XjiKA==
X-Google-Smtp-Source: AGHT+IF8voVooVkU2cjlTivb4y8mDU7eVt2A6pWqgAeFgslUmQJft+2wa2TnsRmJmEgTomFsojqMyZdsPfdgf+8vMP0=
X-Received: by 2002:a05:6e02:1805:b0:35d:6e59:e9d3 with SMTP id
 a5-20020a056e02180500b0035d6e59e9d3mr729298ilv.6.1702068652425; Fri, 08 Dec
 2023 12:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208202108.7468-1-kamal.dasu@broadcom.com> <12b3dce8-92c4-4084-9cc2-4e0d6432c6f3@linaro.org>
In-Reply-To: <12b3dce8-92c4-4084-9cc2-4e0d6432c6f3@linaro.org>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Fri, 8 Dec 2023 15:50:15 -0500
Message-ID: <CAKekbesbYZWVVDd46B_JJ0QWUY++OHS+4_zJ2ogZ7OvHLV6ptw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 74165b0
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, alcooperx@gmail.com, 
	linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com, 
	linux-mmc@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, f.fainelli@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006cbf23060c05bde0"

--0000000000006cbf23060c05bde0
Content-Type: multipart/alternative; boundary="000000000000695af0060c05bd66"

--000000000000695af0060c05bd66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 3:28=E2=80=AFPM Krzysztof Kozlowski <
krzysztof.kozlowski@linaro.org> wrote:

> On 08/12/2023 21:21, Kamal Dasu wrote:
> > From: Kamal Dasu <kdasu@broadcom.com>
> >
> > With newer sdio controller core used for 74165b0 we need to update
> > the compatibility with "brcm,bcm74165b0-sdhci".
> >
> > Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
> > ---
> >  .../devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml          | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git
> a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > index c028039bc477..cec9ff063794 100644
> > --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > @@ -13,6 +13,11 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - items:
> > +          - enum:
> > +              - brcm,bcm74165b0-sdhci
> > +          - const: brcm,bcm74165-sdhci
>
> What is exactly the difference between bcm74165b0 and bcm74165? Your
> driver does not use bcm74165, so I wonder what its purpose is.
>
> Few days ago, for different patchset, I was asking "why", because the
> motivation was not clear from the code. Here you said "we need to", but
> I would argue: no you do not need to add bcm74165 if it means nothing,
> thus this commit msg has similar problem. Does not answer why it is done
> like this.
>
> I agree it can be removed in this case, it is just a convention that we
have the base chip id without the a0, b0 postfix in general. However since
this compatibility is just used by the sdhci core it's not necessary. let
me send a v2 version with the change.



> Best regards,
> Krzysztof
>
>

--000000000000695af0060c05bd66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 8, 2023 at 3:28=E2=80=AFP=
M Krzysztof Kozlowski &lt;<a href=3D"mailto:krzysztof.kozlowski@linaro.org"=
>krzysztof.kozlowski@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 08/12/2023 21:21, Kamal Dasu wrote:<br>
&gt; From: Kamal Dasu &lt;<a href=3D"mailto:kdasu@broadcom.com" target=3D"_=
blank">kdasu@broadcom.com</a>&gt;<br>
&gt; <br>
&gt; With newer sdio controller core used for 74165b0 we need to update<br>
&gt; the compatibility with &quot;brcm,bcm74165b0-sdhci&quot;.<br>
&gt; <br>
&gt; Signed-off-by: Kamal Dasu &lt;<a href=3D"mailto:kdasu@broadcom.com" ta=
rget=3D"_blank">kdasu@broadcom.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.=
yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml<br>
&gt; index c028039bc477..cec9ff063794 100644<br>
&gt; --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml<br=
>
&gt; +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml<br=
>
&gt; @@ -13,6 +13,11 @@ maintainers:<br>
&gt;=C2=A0 properties:<br>
&gt;=C2=A0 =C2=A0 compatible:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 oneOf:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 - items:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - enum:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - brcm,bcm74165b0-sd=
hci<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - const: brcm,bcm74165-sdhci<br>
<br>
What is exactly the difference between bcm74165b0 and bcm74165? Your<br>
driver does not use bcm74165, so I wonder what its purpose is.<br>
<br>
Few days ago, for different patchset, I was asking &quot;why&quot;, because=
 the<br>
motivation was not clear from the code. Here you said &quot;we need to&quot=
;, but<br>
I would argue: no you do not need to add bcm74165 if it means nothing,<br>
thus this commit msg has similar problem. Does not answer why it is done<br=
>
like this.<br>
<br></blockquote><div>I agree it can be removed in this case, it is just a =
convention that we have the base chip id without the a0, b0 postfix in gene=
ral. However since this compatibility is just used by the sdhci core it&#39=
;s not necessary. let me send a v2 version with the change.=C2=A0</div><div=
><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
Best regards,<br>
Krzysztof<br>
<br>
</blockquote></div></div>

--000000000000695af0060c05bd66--

--0000000000006cbf23060c05bde0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQZwYJKoZIhvcNAQcCoIIQWDCCEFQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2+MIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUYwggQuoAMCAQICDDz1ZfY+nu573bZBWTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjIwMjFaFw0yNTA5MTAxMjIwMjFaMIGK
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xEzARBgNVBAMTCkthbWFsIERhc3UxJjAkBgkqhkiG9w0BCQEW
F2thbWFsLmRhc3VAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
qleMIXx8Zwh2WP/jpzRzyh3axDm5qIpwHevp+tTA7EztFd+5EoriRj5/goGYkJH+HbVOvY9bS1dJ
swWsylPFAKpuHPnJb+W9ZTJZnmOd6GHO+37b4rcsxsmbw9IWIy7tPWrKaLQXNjwEp/dum+FWlB8L
sCrKsoN6HxDhqzjLGMNy1lpKvkF/+5mDUeBn4hSdjLMRejcZnlnB/vk4aU/sBzFzK6gkhpoH1V+H
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
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK3oVWywZdm6xjAjpxrHzXId5NuBd59y8wmnfaQN
BZ3uMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIwODIwNTA1
MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQB5ivpjzDoMWER5mZ5rMF0cYwcnwY6mvEiEL/VPhdFXChfdzcx7fML0Blyp
01Ve1YUAukpLVyiaeaDuW05fFqpaLFLrXVTCu4+pTnDs1hyGSHDzEZwOKSDkg2e4qk4kDsJpYT4X
T1M0nn/oYn3dDmaUyhTphkaicbx5l2C/RiW76iOZn/0yGwOIH4p4yYpClOOYPB7ALrHU2HC/iRD3
aIXWcQjwYB1xuo8HHvQmTXx2LY+1CI3iqcKw5ATeEAaoSB5HdsrC/xBkrkhFZNNPFbsJSVspocln
KEiApztp3gnd3WrDDGZ9Va/n/ZmpfRTzxA27qWkCRCun/N6mXfINFJ4u
--0000000000006cbf23060c05bde0--
