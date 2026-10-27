Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131289;
	b=gkKCLArKmbPXgO5co8H7/zkcV4fO5ETqxyZ4ESo2V4lqLJwALxElP6PfpDUf+X3TGrKX
	 VkGrp9Iu3A9Fv6IUUfxhO/FH0es5tpQ9LcES0i32c2zqvumrluOtpOdTj+SeFwi4oiRcq
	 UtESUx8977aVlyrpKCDaEb3GYuL9ISMlx4RnzT6EwVZymz7h6TkSDn/5pLqRuun2dTPSv
	 KVpUMLzcKhV4D9m/580yIy8QFTpiCp851m4SzJ8Q+Em3W7oFC4bPCMuBvBNQxeD5OgiMs
	 wfe0kM7GBeIKHfNwcaeHrNHu9q9wfOriH5NWOn2dKJyoKyFY+VtdZumXwHoK2vFhuIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131289;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=tnbmcV9bL+TB9lQOjvex7IDG6OK+65aOufF/ctjY/lw=;
	b=MW2atuxFtyqlylK49k1c/4/94AU+MO/NDwGtYa/DP625fzjEGk3VniTQB9UtqkCvmsiO
	 3upA3j7S95qOD6n7CaFEKHY8afPYk7llD6QMMusj6djvoG6hMRwWZyH5ffbrxDuKXm40I
	 ubPYPl32Qq8zUpJ6JvDlZ4+s6/wM+l1m/NjBTRrrcPJIB/DOpzO7pSwdabCEtixpAYNPx
	 S8N/Pver4LLEm3JY6dM5sCoaZQ1Py1BJbttaIClXXf+VHjEymXQEV+DKQmoyAC3GEnVOB
	 prGyGPqABIjFp8lkXuYZzG+xjn/xp5rLb6q7QmCXa8eLN7SchjDDg1lhxF0nK+CKK4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WaD3UStE;
	arc=none smtp.remote-ip=74.125.224.99
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174CE606A31A
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 20:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 174CE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WaD3UStE
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6767d92cde6so303714d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 13:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793131287; x=1793736087;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnbmcV9bL+TB9lQOjvex7IDG6OK+65aOufF/ctjY/lw=;
        b=0PRS133umLLwUVHmayIZdVKfZGlL9B0cxw7saJRf2oVFzaqOrDB3KM5lTwR7SMtK6T
         T4uSMKkGftL66fQuSDZ1Pns2B6P7u/zTDBA1MnMr0OXwNOwDWzitnfXAHObc4dP7bmV6
         m/AjzPGVwejwCpcfVVzF273qczBPbhKd+GyL8th6w8mU1I8UMnFISXjeH8QPZwf/X/Qo
         Glaorh9A1GPm7R1pmNySAsMSvzJY0bcLQQ3JcmLSJDrlty7Uvnln82A8m0+8GahHqATV
         QAsAVIYsv5S5DjlomMq4R3TAyLN0HBN5eF621y6Kx3T5T+hHnkEELGoBfv2Lu70xSZId
         qAyw==
X-Forwarded-Encrypted: i=1; AKwUvBxY78vyxfVd8iI6R96iyk9f2G2z5RzlmhB9fmbsqijttiJHsuFtLwjfqqSLPsPT7qugkkzsifBaA4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxoAVjBN/n583tVI257JegctqzFNbcFTXoyXwyIW1bJK2B0NY+
	SBrUtoNFL0ADDWwsznDQ4tCa8/xZsrq9XwhoKX8bRArOInB41ibRhBfRWJaT4HAKMEJepH6uJH7
	CbjriQazG6Y7ZTzWjk6XUK+HervfdBS0hUrVTpz6veoPD3jrCjKA4+imiw15tz9jhdrOD5qjgdC
	YCzG5cviHg9lkGtHIPH0ncZBpIu/4vfsG3d9HPn4/YdRoMydVcNNcNseEI7B8hOBtFuwiPIjcYx
	sJkWEdTSHXV
X-Gm-Gg: AYBFou3KDgrTAcK4PakIcDtjkJdgxQZvarnSOxEPAWsaBPYV1p8yzurq7J1C9jCuC8A
	ORVURRXah3tcl5HotwkhUiaU4wulWhzU74qoUP7v4tZo57WHMsz/uARDqV/fYfENUYuE2iSgbRM
	zHZhEa9Z3qlq6JBFDTWXwtlG4W4/CxCUKS9vhHzwfNnRa2ttbts/js3wOFSqGfXRilXH37dKQba
	ZQv9WMwRg0CUsbiWeyrvrRyKg/JAZQUqplO5tyQXdePe5ljDATWTcUGra1WTi6YEK4v9XGep1/N
	IpObtSH3cfMukoZPveqXysOt+aPZM1Vpxn+L2YuGSanCFacAPniy8vzcH+L0TkcMqOyWqm+zjIg
	CBv51JnCmE7vkRiHI0pTCX0+mdHSc4lVu66XiRKtSgPvcatIfPshFHeXXW2zVzidqWcNbF0CB4Y
	6IKTS95/SQ2LNJesh+Gu0o7rswWKc1J+4v
X-Received: by 2002:a53:dd4a:0:b0:679:932e:6bac with SMTP id 956f58d0204a3-67a7bd6424cmr408386d50.105.1793131286675;
        Tue, 27 Oct 2026 13:01:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-67a7a1be275sm23996d50.47.2026.10.27.13.00.50
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:01:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3692c5b061bso623539eec.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793131250; x=1793736050; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tnbmcV9bL+TB9lQOjvex7IDG6OK+65aOufF/ctjY/lw=;
        b=WaD3UStERl7vxgL9DFCeaNWAXR5MohLK8fB4AdL72D0xz8cQ1BOJEmvK6wbZFF3iP1
         mI4j3t52MSEKcgmJhBQz+PU4C5OnznXVjbGzOUpIfNbBOLgFkf1HlAksG2YboRdIRElX
         7BAyx/RrhPGa+r/yzdoN7Uw/Ty17J3GBCN6Iw=
X-Forwarded-Encrypted: i=1; AKwUvBw+z/rDHFJOJpzHOKse2YaGSvP5srUxJqONs873Xkc4vbLXQZSPGNZD83sM98M0Ag7oFxbppMYtTps=@vger.kernel.org
X-Received: by 2002:a05:701b:2405:b0:143:5266:48ee with SMTP id a92af1059eb24-1a6cf4480a9mr315209c88.42.1793131249547;
        Tue, 27 Oct 2026 13:00:49 -0700 (PDT)
X-Received: by 2002:a05:701b:2405:b0:143:5266:48ee with SMTP id
 a92af1059eb24-1a6cf4480a9mr315151c88.42.1793131248548; Tue, 27 Oct 2026
 13:00:48 -0700 (PDT)
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
 <20261027144051.249211-7-ulf.hansson@oss.qualcomm.com> <d106e4f5-7702-4bc4-ba69-765e2050a28f@linux.dev>
In-Reply-To: <d106e4f5-7702-4bc4-ba69-765e2050a28f@linux.dev>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 27 Oct 2026 16:00:10 -0400
X-Gm-Features: AclHuK8fSy5zTtPPiSPl0qQJFIYdIbBCY8QmkwltnhfBOPLmUC039rpKq71R854
Message-ID: <CAKekbev+q+8-NXWaSEe-t-XLCmbyaf5xOkM2nbpOQmytQw7k4A@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] mmc: core: Add support for resetting an eMMC at
 system resume
To: Shawn Lin <shawn.lin@linux.dev>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-mmc@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000036ba04065ed7e7a2"

--00000000000036ba04065ed7e7a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:21=E2=80=AFAM Shawn Lin <shawn.lin@linux.dev> wr=
ote:
>
> =E5=9C=A8 2026/10/27 =E6=98=9F=E6=9C=9F=E4=BA=8C 22:40, Ulf Hansson =E5=
=86=99=E9=81=93:
> > The DT property reset-card-at-resume specifies that we need to make a r=
eset
> > of an eMMC card at system resume, assuming it also has stayed powered o=
n
> > during system suspend.
> >
> > To implement support for this, let's start by parsing for the new DT
> > property and set the new bit MMC_CAP2_RESET_AT_RESUME if it's found. Ba=
sed
> > on the property, we must also set MMC_PM_KEEP_POWER in the pm_flags for=
 the
> > host, to keep the eMMC powered on during system suspend.
> >
> > Finally, to manage the actual reset during system resume, let's extend
> > mmc_resume() to support the needed behaviour.
> >
>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> > Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> > ---
> >   drivers/mmc/core/host.c  | 10 ++++++++++
> >   drivers/mmc/core/mmc.c   |  5 +++++
> >   include/linux/mmc/host.h |  1 +
> >   3 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 8e9e61839198..e3daf4026cba 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -48,6 +48,14 @@ static int mmc_host_class_prepare(struct device *dev=
)
> >       if (host->bus_ops->pre_suspend)
> >               return host->bus_ops->pre_suspend(host);
> >
> > +     /*
> > +      * If it's required to make a reset of the card at system resume,=
 this
> > +      * indirectly also means that we must keep the card powered on du=
ring
> > +      * system suspend.
> > +      */
> > +     if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
> > +             return mmc_set_host_pm_flags(host, MMC_PM_KEEP_POWER);
> > +
> >       return 0;
> >   }
> >
> > @@ -375,6 +383,8 @@ int mmc_of_parse(struct mmc_host *host)
> >               host->pm_caps |=3D MMC_PM_KEEP_POWER;
> >       if (device_property_read_bool(dev, "wakeup-source"))
> >               host->pm_caps |=3D MMC_PM_WAKE_SDIO_IRQ;
> > +     if (device_property_read_bool(dev, "reset-card-at-resume"))
> > +             host->caps2 |=3D MMC_CAP2_RESET_AT_RESUME;
> >       if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
> >               host->caps |=3D MMC_CAP_3_3V_DDR;
> >       if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index d4bf0f25bd74..908d5cad304b 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -2315,6 +2315,11 @@ static int mmc_resume(struct mmc_host *host)
> >       }
> >
> >       pm_runtime_enable(&host->card->dev);
> > +
> > +     if (mmc_card_keep_power(host) &&
> > +         host->caps2 & MMC_CAP2_RESET_AT_RESUME)
> > +             _mmc_hw_reset(host);
> > +
> >       host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> >       return 0;
> >   }
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 032c018650e0..552873da7987 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -430,6 +430,7 @@ struct mmc_host {
> >       u32                     caps2;          /* More host capabilities=
 */
> >
> >   #define MMC_CAP2_BOOTPART_NOACC     (1 << 0)        /* Boot partition=
 no access */
> > +#define MMC_CAP2_RESET_AT_RESUME (1 << 1)    /* Reset the card at syst=
em resume */
> >   #define MMC_CAP2_FULL_PWR_CYCLE     (1 << 2)        /* Can do full po=
wer cycle */
> >   #define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND (1 << 3) /* Can do full po=
wer cycle in suspend */
> >   #define MMC_CAP2_HS200_1_8V_SDR     (1 << 5)        /* can support */
>

Hi Ulf,

While testing this series I get a burst of WARN_ON(!host->claimed)
backtraces at system resume (29 of them) when both properties are set:

  WARNING: drivers/mmc/core/core.c:351 at mmc_start_request+0xd0/0xe8
  Call trace:
   mmc_start_request+0xd0/0xe8
   mmc_wait_for_req+0x70/0xf8
   mmc_wait_for_cmd+0x7c/0xb8
   __mmc_switch+0xec/0x258
   mmc_init_card+0x14f0/0x1cc0
   _mmc_hw_reset+0x68/0xa8
   mmc_resume+0x80/0xa8
   mmc_bus_resume+0x2c/0x80
   dpm_run_callback+0x6c/0x280

  WARNING: drivers/mmc/core/core.c:637 at mmc_wait_for_cmd+0xa0/0xb8
   (same path, via __mmc_send_status and __mmc_switch)

_mmc_hw_reset() ends up in mmc_init_card(), which sends commands and
requires the host to be claimed. mmc_resume() calls it without
claiming, unlike _mmc_resume() and the callers of mmc_hw_reset(). The
reset does complete, but it runs unserialized against other users of
the host.

This fixes it for me, with no warnings left:

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2317,8 +2317,11 @@ static int mmc_resume(struct mmc_host *host)
  pm_runtime_enable(&host->card->dev);

  if (mmc_card_keep_power(host) &&
-     host->caps2 & MMC_CAP2_RESET_AT_RESUME)
+     host->caps2 & MMC_CAP2_RESET_AT_RESUME) {
+ mmc_claim_host(host);
  _mmc_hw_reset(host);
+ mmc_release_host(host);
+ }

  host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
  return 0;


Regards
Kamal

--00000000000036ba04065ed7e7a2
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
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQggH2ASIbk7eXXnwpn
mkzZSlS+oUgKIEJCLQVMfYiwhqQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYxMDI3MjAwMDUwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAKzvD4L7okHovWzbiHMMBjRs6TjRzj9wqrqYnZuWRcXQRQ2XNoKKq
d2i1acilrPw79EY6mrFEkwHuoZJdir7LUzmhXIIy3a0E+BLdXbywr5yyXABlykAt9lmkP423sSg3
9Nd2h6dGKbqanizNoUTRlA8WEnxKdtWOXAE2JzX+/q9mH8GcdybjlXeUDSSvZwlQftYj+DXIxVrJ
Bvmujnx2VxPKxkuLzKkE8zy8nOpVBngjutSG00wyrYKqCXyiTrDtk2iYoqX8JzHEUv5FkRjlYeb3
T/rx9DP9B4BCc/u9oWnqd+H6JujWTM18OVn5Il82TaLwlRvLJgDh45IaekI2IQ==
--00000000000036ba04065ed7e7a2--
