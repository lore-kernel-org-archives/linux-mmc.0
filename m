Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9907497
	for <linux-mmc@vger.kernel.org>; Wed, 20 Dec 2023 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HOEiSrK0"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4260b6eaae9so50129801cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Dec 2023 18:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703038046; x=1703642846; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8LN/yuxYrEC7AB6DnmDEH9McnL/s6bDaJ1CabCoPuJU=;
        b=HOEiSrK0mUhb5sCyhI1fPW09AZo4cNqTyvvhpyRRZq/0JAi885p1C5pYuEeUEm+p2R
         J7mqkbAeMmsKSzsdy6NJl5iu0pnUUNgCmomYJBKSrx0nRqUB6wMeeugLIU5D0u+XLCAv
         jRiL1t0HwA4Lk6vUkXEbFx7W0OkVlTuSi6WUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703038046; x=1703642846;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LN/yuxYrEC7AB6DnmDEH9McnL/s6bDaJ1CabCoPuJU=;
        b=nvmTV1bb98W15iXlXRzatdpEnQgcaZifPvZTqQFUFMr6JtIbNiPVU8/X0q6PHe4CZi
         IQOsOhutG3jMz/ffrkP5YJ9HG9wFxfa6g2FjUUAbTFIvP7q0IhYofQOaSdkJEh4JAGgy
         JNMvnw/HgAMCXQ00T0rlcJ8cEz6qH6q3vN2H4diAvlNTCBtMFTgsdpQNGfJkEczUdHvU
         LBLLZtDurETRfavLnz/JnmGKq28K9pyoehgiZkjA+Dbc6FbnLqZ+pLpSKmqxPynYdhCg
         jTC9fhiQmQBDYr9tzMFpuAOcpNt1b11aAVhiuxT4u6CyNhOqbr8VPKKoGyYbx2chPMBH
         WFZw==
X-Gm-Message-State: AOJu0YwRurWajJKuq+c5Kgk46+2SsQUuDhX5IM5NkgtlmBl/vW72aXGO
	ANNnXRcctGC+HeXR9D1nJAeJqg==
X-Google-Smtp-Source: AGHT+IHpcP64qQQ7Lo7j84O74Sjcd4A6jxNZg+kcuicQ10d9b7aJWUfoeS1cpuZhC3FK+GRuUuPFxg==
X-Received: by 2002:a05:6214:401a:b0:67e:ff50:f2b1 with SMTP id kd26-20020a056214401a00b0067eff50f2b1mr14715031qvb.90.1703038046304;
        Tue, 19 Dec 2023 18:07:26 -0800 (PST)
Received: from smtpclient.apple (pool-173-76-218-122.bstnma.fios.verizon.net. [173.76.218.122])
        by smtp.gmail.com with ESMTPSA id w7-20020a056214012700b0067aab230ed9sm4139229qvs.21.2023.12.19.18.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 18:07:25 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
Date: Tue, 19 Dec 2023 21:07:14 -0500
Message-Id: <B98B7C63-E1C0-4E52-B6FE-8FB8258A1F6E@broadcom.com>
References: <45b785bd-9b60-4ab7-80f9-b179d932d04d@broadcom.com>
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
 alcooperx@gmail.com, linux-arm-kernel@lists.infradead.org,
 adrian.hunter@intel.com, linux-mmc@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
In-Reply-To: <45b785bd-9b60-4ab7-80f9-b179d932d04d@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: iPhone Mail (21B101)
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cdefe3060ce771de"

--000000000000cdefe3060ce771de
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable







> On Dec 19, 2023, at 4:55=E2=80=AFPM, Florian Fainelli <florian.fainelli@br=
oadcom.com> wrote:
>=20
> =EF=BB=BFHi Kamal,
>=20
>> On 12/19/2023 5:22 PM, Kamal Dasu wrote:
>> From: Kamal Dasu <kdasu@broadcom.com>
>> 74165b0 shall use a new sdio controller core version which
>> requires a different reset sequence. For core reset we use
>> sdhci_reset. For CMD and/or DATA reset added a new function
>> to also enable SDHCI clocks SDHCI_CLOCK_CARD_EN
>> SDHCI_CLOCK_INT_EN along with the SDHCI_RESET_CMD and/or
>> SDHCI_RESET_DATA fields.
>> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
>> ---
>=20
> [snip]
>=20
>> +static void brcmstb_sdhci_reset_cmd_data(struct sdhci_host *host, u8 mas=
k)
>> +{
>> +    int ret;
>> +    u32 reg;
>> +    u32 new_mask =3D (mask &  (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) << 2=
4;
>> +
>> +    /*
>> +     * SDHCI_CLOCK_CONTROL register CARD_EN and CLOCK_INT_EN bits shall
>> +     * be set along with SOFTWARE_RESET register RESET_CMD or RESET_DATA=

>> +     * bits, hence access SDHCI_CLOCK_CONTROL register as 32-bit registe=
r
>> +     */
>> +    new_mask |=3D SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN;
>> +    reg =3D sdhci_readl(host, SDHCI_CLOCK_CONTROL);
>> +    sdhci_writel(host, reg | new_mask, SDHCI_CLOCK_CONTROL);
>> +
>> +    reg =3D sdhci_readb(host, SDHCI_SOFTWARE_RESET);
>> +    ret =3D readb_poll_timeout(host->ioaddr + SDHCI_SOFTWARE_RESET,
>> +                 reg, reg & mask, 10, 10000);
>=20
> Does this need to be readb_poll_timeout_atomic() since this function can b=
e used in both atomic and non-atomic context AFAIR?

Yes it does. Will send a v6
> --
> Florian

Kamal=

--000000000000cdefe3060ce771de
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
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKqCDXUSCZ24oav4GA0W/eTnwIL9WK5Qq1YAYQmK
T1GZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIyMDAyMDcy
NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQB9VI+gKg0Q4P3FsOiHZ3Zmrtcu4g50s6so3geVIQqBX27GwHWMJUr1vYh9
eKUqEEQdLvlyvI+BX5FAUU87SYwNbeDNc9ylp7HUiDZ9dpEGrnwUwl064rshuZccLDSW1ECxbYLy
zMcdU+Q2jfkoCiuVpFU5TEDx0tU33/vwX3TDIWLmEoMe1sqlDVty8OAE/KUusvpvOhvDwp9U2h7q
gkbHA5gyEaHvlD6ergmQITuItqguHa5IANqvPKMgZ3Bd4nZJyHSPaHMNUZ1eO38gtUzTW+yEhWqV
pA69RR9Yhp7xtCDG2Bq2v92to2bCDvtiCrvy4NCARX4eDqTKR0kblUq0
--000000000000cdefe3060ce771de--
