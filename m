Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508344;
	b=hFUi22zGffWxsoE2bWvboCtoxstgQXI7ptRYu0+gggHgCkgx/SREMGXz1RmLmSp84ggA
	 jz4ZQr9NIb8JHNuFKIbyZuhuWaeXuc9d36JhrP9A9gTh6ki+SUhEI/r7I1f5gJXTc1x3b
	 /sHSl/ilPnT5NPyXmPAchlzwZlJ7+jrvkGJCWZgFP4MqYuc3crX5cy2mGhACMQtL/IC7c
	 KFLxBVo3Eoh8QJS7gF4Q3dEFk5Bf2psj5C6X5F+6kti7KPFWO4082YPt6GrbsiBq83mV9
	 KymOF/7HvXZ5EJVdaoyRxISh20RLe/TTLPBWWLB6+FuLYBp4wydSFx7Di9qhfnf7HjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508344;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 X-DetectorID-Processed:Content-Type;
	bh=RWHMsrlnEd8VD9nupbFX2bUNtqsUo/pqJhcvBER1Mtc=;
	b=HPmvXNDgaYYEaBfnfuxoOH6s5JfPA2b7r1ZDxoFRYy+wyorwzEIg/wCfFO2dmtNyn0eR
	 oHxghlgKjQeXnQtvgux3X5XW5ZbT3DpQYl73CH6nK2E4dAdddWLZwEwrpCA1hG9GCQxB8
	 YJd00pOKDYjJbNpijLKQGoQmvsAwT534ZhgyBTUkuGNoNFgZnzZZ5pQuYhnwXAqViCoV2
	 0b8QmZ6ewGwOsXkJqJl/WU1kIeCf80xb9/Miu5E9WygaosdZQD1yCrFXxNX4ndWkTtIMJ
	 nPYrHqc48FCqloeHXL5xhWKgI5yfycHPaBHfTuQDVh/we5kHUAPyDWRI9o2YDB83yNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EiGSUAMM;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6E606A32A
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 18:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D6E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EiGSUAMM
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so49101a91.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 10:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508342; x=1795113142;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RWHMsrlnEd8VD9nupbFX2bUNtqsUo/pqJhcvBER1Mtc=;
        b=1L3QclbJddK9ZTOuUmeDdWHh0+wrjFuwZ7Q0IiMFeROwGKcZYNtUhiUIi2OMlhotNk
         FvnsAn3rDvFQ7riEJfzCrqBdfRQxpqLeiO6HItpdPmUisNBhMVhub4Ous1DdeyQc4Egv
         QcBlyCAbzixcwr/gq/XpzBXX73a9si93SBUkzNCXXZTlObsiCXB0S97clNG9PujOZfLt
         6yjVGgo5NCbmAUywiThNnFfVJ3zmAXnT9UaKu3ZPaSmssYKQpiqKpcYHFzG0AzvJ2n/x
         yo//i/Tn5sIIWvEQW7YFW00RP25DSnYz6uw8WOml0liLBGGV9Go+OxEwAM19SKl/5wUI
         uiRQ==
X-Gm-Message-State: APuU4Z8jS2hltVLKawX+U1C3ba9tJfOmCH+H+duYG7Pf1XNNfn2ujeYp
	+s0CUDQRi9Ygn/DDAxOitmyNnT26m7vXquWYNUur6TuhXLIs1gD2ADnCqWLEu34fkAdJl/SLREk
	Y/hFuQxuAdakZonMMpWpZP0/BgJOfBbHhxG7d5wU5wgsvalh1AKVDu8fbMAoPW2KcsxJhqiIh3D
	Dah3HQjA2a8Qo7hzTAS2tsUCNRrkYiAYO/LXuQ/R1BDdVVBCS+A5fMlA4kp7fycceBx5hgbJGWe
	FNPoJr3S4PS
X-Gm-Gg: AYBFou329TWBgFMzzlNqyU5QqxBe+FFrl+avYedazcTvp03WLXPulbTHznZcVZut+N7
	aEnPofEd+np72Xv7K5XO986H/DhtmzX2JC/uAkyJU0y3pN1LrZ3qKmgMf94ZK5LdqLRsnaPZFL1
	lwwgfLA63W2FwaeLMh5n4h+gZEhwcn+Lawmyf4b6YDNMegmr3umBqZ4na99Yc/edpwbKWWnijq3
	F8iQrthL/DVkxrERvwOrsa/JCmLqWYp5uQ7ZjJQ1bBflokoPrui6+4dDDPu9qVvOwtDlFWaNoFJ
	lo2UNa7MllhrIBiszsx/m2yBin7PWPP+D3pZh5GEWRKFMljTUOWg5S8ea1hHJJGBgM5UDVnuUoD
	b/RbupHsWEEyD7xqu8uewyvcZoGFm+1ycQg4weuwuPyLJvg2riiNW52tzPPJb2S/hiQPZkKfrLq
	6QSe7PesMy2I6Yv7OjrKKDM89kZU8ngYKS
X-Received: by 2002:a17:90b:4a8a:b0:3b0:9e2c:9b60 with SMTP id 98e67ed59e1d1-3b182eebdeemr5733049a91.21.1794508342344;
        Thu, 12 Nov 2026 10:32:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2edb65c092fsm2389035ad.53.2026.11.12.10.32.21
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:32:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4adae31e4b1so99903fac.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794508341; x=1795113141; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RWHMsrlnEd8VD9nupbFX2bUNtqsUo/pqJhcvBER1Mtc=;
        b=EiGSUAMMsDYt2gBN+iKP3Yt81+TGutqgWAYYdFm9XKKUUZYkqb0jD0AT+bgyaO5nNc
         YEj52F5UMhZcgTc+y200tiA0+wS0Iry+RfKrtaZJnGMBgJ+DjUHHD7OqO8ghNSNYn/Ct
         bZe4Tqgtzhaws79Gbg2CAJrwljXoh1cwCRdwM=
X-Received: by 2002:a05:6871:5222:b0:4a7:4b67:9c6e with SMTP id 586e51a60fabf-4afdf2a5826mr527454fac.18.1794508340586;
        Thu, 12 Nov 2026 10:32:20 -0800 (PST)
X-Received: by 2002:a05:6871:5222:b0:4a7:4b67:9c6e with SMTP id
 586e51a60fabf-4afdf2a5826mr527378fac.18.1794508340076; Thu, 12 Nov 2026
 10:32:20 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111194426.1652644-1-kamal.dasu@broadcom.com> <20261111194426.1652644-4-kamal.dasu@broadcom.com>
In-Reply-To: <20261111194426.1652644-4-kamal.dasu@broadcom.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Thu, 12 Nov 2026 13:31:42 -0500
X-Gm-Features: AclHuK9Gcw9h0Fgz3MQFVLb11_B7QeXMY6sovaMhs__VhmnR9_UvdFmJVT7osZs
Message-ID: <CAKekbeuwQVkYiRNdOofqkmrXSazmembCdPtkR2CXkhOHasG=kw@mail.gmail.com>
Subject: Re: [PATCH v12 3/6] mmc: core: Add option to keep an eMMC powered on
 at system suspend
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Shawn Lin <shawn.lin@linux.dev>, 
	Shawn Lin <shawn.lin@rock-chips.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000037644c06601888d9"

--00000000000037644c06601888d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:44=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
>
> The DT property keep-power-in-suspend, allows us to specify whether the
> platform is capable of keeping the power to the card during system suspen=
d.
> Up until now, this has been restricted to be used for SDIO cards only, bu=
t
> let's add the initial support to allow this for eMMC too.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>  drivers/mmc/core/mmc.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a02b04938e1a..c936272bcd81 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -38,6 +38,7 @@ enum mmc_poweroff_type {
>         MMC_POWEROFF_SHUTDOWN,
>         MMC_POWEROFF_UNDERVOLTAGE,
>         MMC_POWEROFF_UNBIND,
> +       MMC_NO_POWEROFF_SUSPEND,
>  };
>
>  static const unsigned int tran_exp[] =3D {
> @@ -2157,6 +2158,15 @@ static int _mmc_suspend(struct mmc_host *host, enu=
m mmc_poweroff_type pm_type)
>                         goto out;
>         }
>
> +       if (pm_type =3D=3D MMC_NO_POWEROFF_SUSPEND) {
> +               if (host->retune_period) {
> +                       mmc_retune_timer_stop(host);
> +                       mmc_retune_needed(host);
> +               }
> +               mmc_card_set_suspended(host->card);
> +               goto out;
> +       }
> +
>         if (mmc_card_can_poweroff_notify(host->card) &&
>             mmc_host_can_poweroff_notify(host, pm_type))
>                 err =3D mmc_poweroff_notify(host->card, notify_type);
> @@ -2193,9 +2203,15 @@ static void mmc_remove(struct mmc_host *host)
>   */
>  static int mmc_suspend(struct mmc_host *host)
>  {
> +       enum mmc_poweroff_type pm_type =3D MMC_POWEROFF_SUSPEND;
>         int err;
>
> -       err =3D _mmc_suspend(host, MMC_POWEROFF_SUSPEND);
> +       if (mmc_card_keep_power(host)) {
> +               pm_runtime_resume(&host->card->dev);
> +               pm_type =3D MMC_NO_POWEROFF_SUSPEND;
> +       }
> +
> +       err =3D _mmc_suspend(host, pm_type);
>         if (!err) {
>                 pm_runtime_disable(&host->card->dev);
>                 pm_runtime_set_suspended(&host->card->dev);
> @@ -2260,7 +2276,13 @@ static int mmc_shutdown(struct mmc_host *host)
>   */
>  static int mmc_resume(struct mmc_host *host)
>  {
> +       if (mmc_card_keep_power(host)) {
> +               pm_runtime_set_active(&host->card->dev);
> +               mmc_card_clr_suspended(host->card);
> +       }
> +
>         pm_runtime_enable(&host->card->dev);
> +       host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
>         return 0;
>  }
>

Hi Ulf,

Sashiko reviewed this patch and sent the result to me and the DT list
only: https://sashiko.dev/#/patchset/20261111194426.1652644-1-kamal.dasu@br=
oadcom.com?part=3D3

It points out that with MMC_NO_POWEROFF_SUSPEND, CQE can stay on across
suspend if _mmc_flush_cache() sends no command (e.g. cache disabled),
since the flush is then the only thing that would call ->cqe_off(). It
looks valid to me from reading the code.

This patch is unchanged since v10 and Sashiko had no findings on it for
v11.

Would you like a guard in that branch, e.g.
"if (host->cqe_on) host->cqe_ops->cqe_off(host);"? I can fold it into
the next version v13 if so.

Regards
Kamal

--00000000000037644c06601888d9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVUQYJKoZIhvcNAQcCoIIVQjCCFT4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghK+MIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGhzCCBG+g
AwIBAgIMRxplQYK7p3ShPUz7MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYxOTA4NDAzN1oXDTI3MDYyMDA4NDAzN1owgdExCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzENMAsGA1UEBBMERGFzdTEOMAwGA1UEKhMFS2FtYWwxFjAUBgNVBAoTDUJST0FEQ09NIElO
Qy4xIDAeBgNVBAMMF2thbWFsLmRhc3VAYnJvYWRjb20uY29tMSYwJAYJKoZIhvcNAQkBFhdrYW1h
bC5kYXN1QGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANYnWmzR
GGguz2PH40SpHaw/tESF4nlf3YYuxXpp0U9KEiIPEDcrxS6lcojBW16h3RppkY+lAbs0mzfPKysT
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
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgK4PlZ+jjL4V/WC9B
VMlLhrlB1Bz5TQMVrnkLa/dT48swGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYxMTEyMTgzMjIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEARvTkGFnNVhpGD1KNsLdjoTn1lYWIkGJ+FHem845H4ve/b2F03rk3
hQIqFdk2Ozps5UrAMwcYNI7bZCGbd4m8K+5saJ62oAlSJuuukE+40+KT9iLAm++3No+R9zU7jbAm
6d6EvfLp33tQzJDcJqFShQCgZDh7KsCSXIzDV4lSPj158azKiEXa+RPCkLmzxvU01nA37wGcHhLa
LSL3Uc3w93sqeIwyQt0NeLLykWRUfIqfJAuP8bcNTBucKeHr0u/MxT9ksvTR5AtKqn6boOtY8EwC
ss6fA3YSszwFG2zkqkTdrWdusolEgLennZG6tzmLgN86LBUlbA5CIzJmRpBYxA==
--00000000000037644c06601888d9--
