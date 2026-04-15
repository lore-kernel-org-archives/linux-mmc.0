Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8C3161AB
	for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776284625; cv=none; b=UkvcxlEFnHI+apR7gC3ON19JXcIE/W4U/GBquwprbxMVxGcdE8Bv2r6KrZeZuVV354n2ju8caO5LZl8xz50g331wj7iOi8zaH0Oja5V3v2Ra9M/KPnnomhbtwL/yywKUHYwMxjN9A4HuolG0MM4zYZJh3aQD/X1eeNR+Z/lUw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776284625; c=relaxed/simple;
	bh=1+VCwxP3E4C5L2zjVlstynXklE3YRtvrr/2zkYWyTk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/yufO4w3APHXVRhmK0HzAJCMSt7y9GDZuH63hhGN/EXtWfdUbkaqE1yP1cRBeXdSCDC5cQHj0Oe/E3Eg8fFyqoQ+SUbnDII59Fw+3y+NSaFAUinDebbT/VCf0TgffDsSqhSVE/VNlMn1+45tZEU3MH/Qi9BPayx8+7ucfZfNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TXyLizbS; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TXyLizbS"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-5ff05af29b4so2529591137.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 13:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284623; x=1776889423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaIL5C+ojH1VamiJ+XFLN2pYKtKwoyQJh3OjOAPSXsw=;
        b=h/MlK3fEPga2ei5uW4biatIA4ualOjidtLn1OzC9L5L/BV8RR7v7cPe4yncJ7co5Za
         sYfeBpPE9tiCBOOyuZqDl974BJmmubNmvAyq/S+eIPzPm/V8mtEFvygiJGN8ygwGPZWs
         BIXZCgYzEkSuMwZPmgCzDJmyTWYWO8Mp0sQ1vRGbb7mhVhTqpDk60nBr5L8XtPSicNF7
         AEj4KcfSiMa+TbHLXxfNDQ3kEhy4YXhtjQ1EqKfwl1dUXDM40nCRrXFpbFJSNPNI/Qz5
         GUgYXRXBPPs0nTK6unUTP2WPF5GSCE2v8cy/FYxVHGS3rByiKLL/b2R+UVZVxzoqb//q
         BvRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VkEDI2iJwFsHC5nK7bhIPpl8sdnj1nM9DV8ympyK9d3NXFmPmDeOYoxCmokpwX4d/b5fDsx0n9pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiTHk05Byu8C23dMgl0bD+OUTHER/6JkB+lgspmL3Cx74GPyw
	o8fvBpRihXrKnif/hGIO1LL31nrVKUWzQKRn8qbpvA9CxcqWsxOiM8DQi4B5st+O7F6mrQ3e6Km
	k8m+M+voRHwTMsNddL4befEfnICku7PKfWAr3HuZum0jaDj0mw+lCWyLQWXOeAVGyVGAmsIGAfR
	D+SYcMOJY3JAaQOFYGTiqap7TWr1pdJp2HGOLA6sm7YtnzQ0LGNfcV9ttqnqgT476TyhVkdFXCU
	IcJXI+cjgX2acQvwZ0=
X-Gm-Gg: AeBDietwIliRqA2VxTkMBprKtNXj1p+TFdeSuzEcnbp0J+xesYIFwIJcp3Oy6p97w9a
	gZN24o47g5JUT/QBBDvpJJNh/IHlJyjHOjaF2ehTrw3EcdoMJWvZfcZZBeqnI58fnnSlHjH3vWe
	cZErc5HERhfjkWnxqAcBrOrTC7Fu0X8iVGdnksIVrOXvwNUajzNGtwImfJ4k0PfVAe4ec1cYpDn
	uniKi0JiO2n+fknRoWaKBzqOFN/HfOUxnWZACFQrueJOpXATIT/FOS8GDEEhOMKUmp9P/P04k5O
	nVvWSt2yspOermmbBZMXUseBeuUoeG5Qo2lWTnREUaHl/wePZkKwLsJlLlTCzO2a+5cPk0+ly8p
	HEY0EKlXtrfUdEuVGcxVALMs/vgTf8UV3AqdyqEmbcftweTAa2W3RrFWC7tM0+Vn2L5+SLp8gip
	uhmD7dOjrLogR7CA5VuPSxhvNgIAVsQZpbenwoyD8aUojf9csbRXCWimTDIwe7PPMhLHxk
X-Received: by 2002:a05:6102:84c1:10b0:610:ea1d:5241 with SMTP id ada2fe7eead31-610ea1d54a8mr3890851137.9.1776284622848;
        Wed, 15 Apr 2026 13:23:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-6131648da1dsm148674137.16.2026.04.15.13.23.42
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 13:23:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65036e62f9bso5800389d50.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776284622; x=1776889422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaIL5C+ojH1VamiJ+XFLN2pYKtKwoyQJh3OjOAPSXsw=;
        b=TXyLizbSthacB8QrT0fUqY7nrvY7vm7cXvb3SnnL686oE7REDnvhCYAudZZFwcU0Cl
         CwYuYxTzob1MJDVqXNX5RrojrhP0mi+r0wJYBMmIH00ixQcO0QDWAXSq/+oJPfCD3s7+
         tyGpIlmiF2ico2ku71mNNIqgEji/AF/hrHrh0=
X-Forwarded-Encrypted: i=1; AFNElJ8IWGCJ4vu2VsC1A34W97UapVS3myjChoyuv9iP1Zp6FKtAWSogwhI/mMJ+67TwuP8m8/ZYayrP1fo=@vger.kernel.org
X-Received: by 2002:a05:690e:1511:b0:651:cfec:fcf3 with SMTP id 956f58d0204a3-651cfed057dmr10019420d50.64.1776284622276;
        Wed, 15 Apr 2026 13:23:42 -0700 (PDT)
X-Received: by 2002:a05:690e:1511:b0:651:cfec:fcf3 with SMTP id
 956f58d0204a3-651cfed057dmr10019397d50.64.1776284621725; Wed, 15 Apr 2026
 13:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327222150.2108111-1-meaganlloyd@linux.microsoft.com>
 <3305684d-8517-47dd-8852-2e34d40fc712@linux.microsoft.com>
 <702c52e4-b0b3-4e1e-a40d-29e136e46d7d@broadcom.com> <448010ef-278c-4711-a244-447a2b1a22c1@linux.microsoft.com>
In-Reply-To: <448010ef-278c-4711-a244-447a2b1a22c1@linux.microsoft.com>
From: Scott Branden <scott.branden@broadcom.com>
Date: Wed, 15 Apr 2026 13:23:27 -0700
X-Gm-Features: AQROBzAMA0T5TuKQb2KUg7n999FYzAUkrHevVmZhj48EzeDv3y6KbOhDYCRNc0Y
Message-ID: <CA+Jzhd+_CKn1X0YDsoh9-OFeCG9sc2Q0OFfphkRaXpEA647xyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: host: sdhci-iproc: implement the .hw_reset callback
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, rjui@broadcom.com, sbranden@broadcom.com, 
	linux-arm-kernel@lists.infradead.org, tgopinath@linux.microsoft.com, 
	adrian.hunter@intel.com, linux-mmc@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f30a29064f857d83"

--000000000000f30a29064f857d83
Content-Type: multipart/alternative; boundary="000000000000e68df0064f857d7f"

--000000000000e68df0064f857d7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Meagan,

On Wed, Apr 15, 2026 at 11:08=E2=80=AFAM Meagan Lloyd <
meaganlloyd@linux.microsoft.com> wrote:

>
> On 4/13/2026 10:43 AM, Florian Fainelli wrote:
> > On 4/13/26 10:38, Meagan Lloyd wrote:
> >>
> >> On 3/27/2026 3:21 PM, Meagan Lloyd wrote:
> >>> Implement the .hw_reset callback so that the eMMC can be reset as
> >>> needed
> >>> given cap-mmc-hw-reset is set in the devicetree and the
> >>> functionality is
> >>> enabled on the eMMC.
> >>>
> >>> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
> >>> ---
> >>>
> >>> SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been
> >>> repurposed
> >>> on my Broadcomm processor to be eMMC hardware reset
> >>> (SDIO*_eMMCSDXC_CTRL[12], HRESET).
> >>>
> >>> Can you confirm this repurposed bit is consistent across the Broadcom=
m
> >>> iProc processors and thus the .hw_reset callback can be uniformly
> >>> applied in this driver?
> >>
> >> Hi Ray & Scott,
> >>
> >> I hope you're doing well. This bit looks to have been repurposed from
> >> the SD Host Controller Standard's VDD2 Power Control to being used for
> >> toggling the hardware reset signal to eMMCs. Can you verify that it
> >> applies across the iProc processors so that I may finalize this patch?
> >
> > Which iProc process are you using? If you are not sure this applies
> > broadly, can you at least make it specific to the SoC you are using?
> Yes, if it comes to that I can. I think it's overkill to roll a new
> compat string/associated structures over this small change, hence
> checking with Broadcomm iProc maintainers on this thread.
>

Which iProc processor are you using?  You will have to check with
RaspberryPI as I think they use this driver as well.
If that family also supports it then you probably don't need a
compatibility string.

--000000000000e68df0064f857d7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Meagan,</div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 15, 2026 =
at 11:08=E2=80=AFAM Meagan Lloyd &lt;<a href=3D"mailto:meaganlloyd@linux.mi=
crosoft.com">meaganlloyd@linux.microsoft.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><br>
On 4/13/2026 10:43 AM, Florian Fainelli wrote:<br>
&gt; On 4/13/26 10:38, Meagan Lloyd wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 3/27/2026 3:21 PM, Meagan Lloyd wrote:<br>
&gt;&gt;&gt; Implement the .hw_reset callback so that the eMMC can be reset=
 as<br>
&gt;&gt;&gt; needed<br>
&gt;&gt;&gt; given cap-mmc-hw-reset is set in the devicetree and the<br>
&gt;&gt;&gt; functionality is<br>
&gt;&gt;&gt; enabled on the eMMC.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Meagan Lloyd &lt;<a href=3D"mailto:meaganlloyd@=
linux.microsoft.com" target=3D"_blank">meaganlloyd@linux.microsoft.com</a>&=
gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been<=
br>
&gt;&gt;&gt; repurposed<br>
&gt;&gt;&gt; on my Broadcomm processor to be eMMC hardware reset<br>
&gt;&gt;&gt; (SDIO*_eMMCSDXC_CTRL[12], HRESET).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Can you confirm this repurposed bit is consistent across the B=
roadcomm<br>
&gt;&gt;&gt; iProc processors and thus the .hw_reset callback can be unifor=
mly<br>
&gt;&gt;&gt; applied in this driver?<br>
&gt;&gt;<br>
&gt;&gt; Hi Ray &amp; Scott,<br>
&gt;&gt;<br>
&gt;&gt; I hope you&#39;re doing well. This bit looks to have been repurpos=
ed from<br>
&gt;&gt; the SD Host Controller Standard&#39;s VDD2 Power Control to being =
used for<br>
&gt;&gt; toggling the hardware reset signal to eMMCs.=C2=A0Can you verify t=
hat it<br>
&gt;&gt; applies across the iProc processors so that I may finalize this pa=
tch?<br>
&gt;<br>
&gt; Which iProc process are you using? If you are not sure this applies<br=
>
&gt; broadly, can you at least make it specific to the SoC you are using?=
=C2=A0<br>
Yes, if it comes to that I can. I think it&#39;s overkill to roll a new<br>
compat string/associated structures over this small change, hence<br>
checking with Broadcomm iProc maintainers on this thread.<br></blockquote><=
div><br></div><div>Which iProc processor are you using?=C2=A0 You will have=
 to check with RaspberryPI as I think they use this driver as well.



</div><div>If that family also supports it then you probably don&#39;t need=
 a compatibility string.</div><div><br></div><div><br></div></div></div>

--000000000000e68df0064f857d7f--

--000000000000f30a29064f857d83
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVXQYJKoZIhvcNAQcCoIIVTjCCFUoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLKMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGkzCCBHug
AwIBAgIMQ/J/kffzZe31gvM7MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDYxM1oXDTI3MDYyMTEzNDYxM1owgdoxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEQMA4GA1UEBBMHQnJhbmRlbjEOMAwGA1UEKhMFU2NvdHQxFjAUBgNVBAoTDUJST0FEQ09N
IElOQy4xIzAhBgNVBAMMGnNjb3R0LmJyYW5kZW5AYnJvYWRjb20uY29tMSkwJwYJKoZIhvcNAQkB
FhpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBANCmSo9ytxRwrEeeI585yVCbXXS/UKRfFgmNKvjSPAMcAELWtTaoMsOqbekGjwGVMbAuKY3z
RgzD22UbOw0Zc0KK6oEqIJEAlIrv24IqbfpBvv9ihHsCuxWYJ8CSpLe8QjayPrn+axqd+5Dszeq1
e2Bj1RteOLHZmVZON3GXCP9UEW81tcGPWzRrQecRrMsteaNZrrEEYkJfZzt11fWe2Asq+jIqsL1/
Cy2haJfVcTI8xOl3Rvo2awEudgucwkNJMqNaHA6x7foZr+nopW8H/mbCFMWeuZTvpHy/ckGL/T2j
Yh5xQM8hlq62Mp//bt7EVK5o0HRVhZ54EY4QK/n/ovMCAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2NvdHQuYnJhbmRlbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJEzKwZUjRbcpvkjk7tk
h02Vb3haMA0GCSqGSIb3DQEBCwUAA4ICAQAIie4RmMGexhzDlGHzd9NieUPgI1AMnB0ZdRUFkXcm
5UxItAUgYBpEZKCf3/ofAzfzjhiOtwT+tB85U0kNZrkctXOYsGbpbev5HAT7nYtTMN74WQRUcDCB
hIOOBywH9JHH9/nV1v+oOVDFaIg1foYRzas77gQ2CFLVrTkSqyDD/844LAREi/HfYyo5g4m72Rae
tEGh5DNGimduSBgpLlL215XmqpcD7o0lcif4Mpk79yQ+wx/dik8bnY3a4bJTU4Qak90xo98l42l3
iVVzHIvycGGS+WtXlCkenQ3QWMlrM5s4htoRatVpbmFCZI/i5nnKx9UDTasTeCi4/VJdB81tP8X6
6cNYFYoD9K7nA5NMOyW6Ytyqus/7x4fJ9dpLClUxu6CLpsNgvEKgdbn4PhXqpfyS9co/8xrZhWWw
KFClxU8qJ/EFYtnkCsWRIIaoYoZ83zacdRmydf7u/4IpGVNSTBhfNY1EKPvWhhsT8FvyTHiCGQAd
LpQZhJAuAmPv4bY4r3dijWYK4OI0jygHmS1rqjVo0oOtO17ILX7MdKYUlzg/qxoU+VChpC9/BTCF
5eORxrQ/1u2guYvZ+6W5C93W9vbI9YxmbPgaHsN66ShGZ3RxMSalF1omvREH+hW760MPcbt4tuYw
wW2Dt9mzgwY8jt8iUXWlCdh4R+V/at4kLzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDEPyf5H382Xt9YLzOzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
Yf006XO+pCWkOUPs943qEiT6c8WMWdj0rMgPRoAhXzwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNDE1MjAyMzQyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAaAl8Wb8B12sjdXl2vJTcIA5hdNodbuYe06C9
cpnzPnI6kJq9QHnGir5ZJIOsmlYhowRpa9fI6D272gdiiwF4kiMJ62o0N/OF7jXPAsxtunoLD/gC
xAlZkn/ltuIIYTAQb/G3V07CdOpi+DKPAjWD0SkK0eDmOKvQKyEnKtVyfNo5KNhKbMhP45pmBr5m
cG63Phlfn+MSqg5z0V+N0/5as2yYaG6nqKPjx9P5BMKb4WehL5+U1FW54legN7UNRr1r+SHtMs7G
k8MdKDLqPXf277V9dDFFjPU0vBGZsMSXJVzEK6gxCoaBGTXLG3K7HEJoYWeUO9NeV9eczS3V32DR
bw==
--000000000000f30a29064f857d83--
