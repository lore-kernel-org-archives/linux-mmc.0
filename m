Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794860104;
	b=AGJylAz9Pv4pDorLnuUJPytShdSmija4HZq4TEcKtL5RvUgdqas7RErci9y0Jbtp4Lbn
	 HisILkk1xKl5u7PtbspvIWM65SMHx6mM7Zh9uVkOwFc93jJCvJIV7U/goXDA5XY4JPbkV
	 eQvh7c96jrBtED+k8dEFSBzPPVEYRChihkOmqwgQ+pWebdY6BWABSTkeBXe1dJeTr5e+V
	 e1I7CQxN2s0KUzVcqZSwNY9I3Q5JmYZSAn2CyJdOHfQCFBe+5xD6sga4YCGMTo0znHY22
	 mR7SUOOeyc6bbfqDeEL/PILRqJjRxzEwBnbbQmQPC7IsU50qLb2/vElLqmufc09ZLsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860104;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 X-DetectorID-Processed:Content-Type;
	bh=k+kx/9F6dKI+1j4Cph1rIaL1YuPi1oeZXmxdyVS3oJI=;
	b=igITLAuft6MVtFVb2IodmArdaO5OvSjMGMc1TD52DZhupAR0Mycb5sFxcfLzW0rGCmvm
	 vF0BoEDTl4pIB8EXoYvQ+HiKP1Z/uft3+mkOJSrVK/hmZ6xpktpL1/MFhQXt+6POTKoy8
	 5/DfTa584A9/VCfWGyzemq7wFApFtCf952z1kRUSN/8cqVg8k7f9qFHBGBvSzDyI/VBzs
	 YGdQpDgapAOv8bhue3sUpd0eKB9OaFpH8kJEIQDlOMXwblpi8Ol5+leszx8SwgrQjZckN
	 NyJpbSTO08mIuabwBVBjKruDff0nhIDvIHk/uC/NI3IeCyfqf9IER5rxtXk9sOJ4cjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cuJzYfpk;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4C606A329
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 20:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D4C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cuJzYfpk
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso2120494a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 12:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794860103; x=1795464903;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k+kx/9F6dKI+1j4Cph1rIaL1YuPi1oeZXmxdyVS3oJI=;
        b=QwOC6pSJKGq1/7LY82bVHojMBWaF9kyVG2/9pYlXdDxpUbnfXZPtu6sAB+s8rJAmUr
         INKrhVWd4ZLmzUcZ96fZmJ+7u2X9FwQeFXpylvtId6HO44OSApEnr3Hkl+wXRNlWkDkX
         F5TBK2WcX+PTaZ9FAuxKOXCD9347X5ARYIY0NIW2V/aSU31ITZScJ7vIzBRpnhhEA2WH
         u6GkQuJ0aauHlpLDd358AW3by+fqCzZPHdmIPt5ayY+AZYqg8aRch+ytIKEj21kgTXtI
         KySJOczV88tRHbKHh0jj5hBpMdP1FAMIgWGMTG9NWB5RkMZEe6FA8tPTeKXwPY0SVSoK
         LbTA==
X-Gm-Message-State: APuU4Z9es4UBVatoXDbLAr050/x6l0QafdYNgnG5B3dhsfWhXsslqCib
	Y4TQvEFdRsDT3L88SDz60JPeelSvcrVLWZGOMxDFuqJFQTadj3n83S4fAnCLOPUQ96/Gr3GKFNy
	iACb8TLW6B/Jmj0PGmj1MdLuueN8TeCCDAAsDUziIwUMxbmc8a8sAm06KwRiknnxVaP+jsajLG9
	65kMVlPtNCL2aI3O38ZzEUeZfnOqrPbN/oMZdLBAcnHmEQTQDz4u3zJ83Kv1O/OkPg4upgT58jI
	nuZPAphyIgf
X-Gm-Gg: AZFdTZdSH/u5G2wXQdsNXKefS+ickXJ6o28OOzX5rDV7r0Fy9wguqUr9DgdXNo7tzw2
	M3njCaqS+O7CP+llUUmC7C3HO6MkYtBYPJpcQeoGicQi66ICCe+MuBLSnUeyoIZA8VRUKKB3tf3
	gaqohF95QQu77nCczgMzvpHWNb8UBgEcLN0jrm4s+uZP+bs7Jb4KGjLS3RM//P5gkOFyAz80Yyg
	wTyri2M4VlMjTubUjDFabDdlyPyNZp9bL7oIND5Yq5Kc62oSiL40EW1ZIo2T2TwLpw6VPrz53FU
	S0ggTQaxHqkV0t5gcZH3votVcPnid9szCx/hV2KhMH5OM7laFmACOafBU2yCgnGHPUWH+KNgKcB
	LTIX80Dnr/siw0FfAwPVjEGf+kgpdUrgbdrUxy+VIF6ILJLorKbJMzXex+e4F4rpZCgtJsSKbCw
	17BwGTyO7xKswFLY0tTVdw2CiAthgnwkcYqY4=
X-Received: by 2002:a17:90b:3ec4:b0:3b0:bc3c:3e7 with SMTP id 98e67ed59e1d1-3b1b0a1bdc3mr11931973a91.10.1794860103294;
        Mon, 16 Nov 2026 12:15:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1b3a71eb9sm6184695a91.4.2026.11.16.12.15.02
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2026 12:15:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-85f37d25fa3so4543558a34.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794860102; x=1795464902; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+kx/9F6dKI+1j4Cph1rIaL1YuPi1oeZXmxdyVS3oJI=;
        b=cuJzYfpk1hlqBDw/2/SsSLTTl/Jw6H5VDduDkb0uOc4DFIkdncOrRqQfC2Mj7BN+Dk
         Kb9R/8N24CHQdn3WPjFq1RQwoA0MZSLjCP46Pqa6iFLgPHHW5ZoeF7q98pNFywEn2mTC
         tWij1bIuJ6PkEx1qt1E5mBu4v1TQNDS3cAQN0=
X-Received: by 2002:a05:6808:c1c4:b0:4f3:68d6:f0dd with SMTP id 5614622812f47-56e6563024dmr10471931b6e.38.1794860101823;
        Mon, 16 Nov 2026 12:15:01 -0800 (PST)
X-Received: by 2002:a05:6808:c1c4:b0:4f3:68d6:f0dd with SMTP id
 5614622812f47-56e6563024dmr10471897b6e.38.1794860101344; Mon, 16 Nov 2026
 12:15:01 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113211143.3759154-1-kamal.dasu@broadcom.com> <20261113211143.3759154-7-kamal.dasu@broadcom.com>
In-Reply-To: <20261113211143.3759154-7-kamal.dasu@broadcom.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Mon, 16 Nov 2026 15:14:25 -0500
X-Gm-Features: AclHuK_grL8FafTPMTWrPF9kQrENjp_nrDZ7UOaKKgewjcgPZAo7g3fp7Zzrzm0
Message-ID: <CAKekbetSFisJ2YCN2oC1p0_G1asOFbHE6P3UXb952vnktZmtUA@mail.gmail.com>
Subject: Re: [PATCH v13 6/6] mmc: core: Add support for resetting an eMMC at
 system resume
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d1b24a06606a6ea5"

--000000000000d1b24a06606a6ea5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 4:11=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
>
> The DT property reset-card-at-resume specifies that we need to make a res=
et
> of an eMMC card at system resume, assuming it also has stayed powered on
> during system suspend.
>
> To implement support for this, let's start by parsing for the new DT
> property and set the new bit MMC_CAP2_RESET_AT_RESUME if it's found. Base=
d
> on the property, we must also set MMC_PM_KEEP_POWER in the pm_flags for t=
he
> host, to keep the eMMC powered on during system suspend.
>
> Finally, to manage the actual reset during system resume, let's extend
> mmc_resume() to support the needed behaviour.
>
> The property only makes sense together with keep-power-in-suspend, as the
> card would otherwise be powered off and system suspend is refused. Valida=
te
> that in mmc_validate_host_caps(), to make the host probe fail upfront on
> such a misconfiguration.
>
> While at it, claim the host around the reset in mmc_resume(), as it sends
> commands to the card, and propagate any error from the reset so that a
> failure to re-initialize the card is reported by the resume path.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Co-developed-by: Kamal Dasu <kamal.dasu@broadcom.com>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>  drivers/mmc/core/host.c  | 17 +++++++++++++++++
>  drivers/mmc/core/mmc.c   | 12 +++++++++++-
>  include/linux/mmc/host.h |  1 +
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8e9e61839198..94c8ec81ee08 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -48,6 +48,14 @@ static int mmc_host_class_prepare(struct device *dev)
>         if (host->bus_ops->pre_suspend)
>                 return host->bus_ops->pre_suspend(host);
>
> +       /*
> +        * If it's required to make a reset of the card at system resume,=
 this
> +        * indirectly also means that we must keep the card powered on du=
ring
> +        * system suspend.
> +        */
> +       if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
> +               return mmc_set_host_pm_flags(host, MMC_PM_KEEP_POWER);
> +
>         return 0;
>  }
>
> @@ -375,6 +383,8 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->pm_caps |=3D MMC_PM_KEEP_POWER;
>         if (device_property_read_bool(dev, "wakeup-source"))
>                 host->pm_caps |=3D MMC_PM_WAKE_SDIO_IRQ;
> +       if (device_property_read_bool(dev, "reset-card-at-resume"))
> +               host->caps2 |=3D MMC_CAP2_RESET_AT_RESUME;
>         if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
>                 host->caps |=3D MMC_CAP_3_3V_DDR;
>         if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
> @@ -620,6 +630,13 @@ static int mmc_validate_host_caps(struct mmc_host *h=
ost)
>                 return -EINVAL;
>         }
>
> +       /* Resetting the card at resume requires that it stays powered on=
 */
> +       if (caps2 & MMC_CAP2_RESET_AT_RESUME &&
> +           !(host->pm_caps & MMC_PM_KEEP_POWER)) {
> +               dev_warn(dev, "reset-card-at-resume requires keep-power-i=
n-suspend\n");
> +               return -EINVAL;
> +       }
> +
>         /* UHS/DDR/HS200 modes require at least 4-bit bus */
>         if (!(caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) &&
>             ((caps & (MMC_CAP_UHS | MMC_CAP_DDR)) || (caps2 & MMC_CAP2_HS=
200))) {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 122ac9ba0a4b..829947374dcc 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2316,14 +2316,24 @@ static int mmc_hw_reset_recovery(struct mmc_host =
*host)
>   */
>  static int mmc_resume(struct mmc_host *host)
>  {
> +       int err =3D 0;
> +
>         if (mmc_card_keep_power(host)) {
>                 pm_runtime_set_active(&host->card->dev);
>                 mmc_card_clr_suspended(host->card);
>         }
>
>         pm_runtime_enable(&host->card->dev);
> +
> +       if (mmc_card_keep_power(host) &&
> +           host->caps2 & MMC_CAP2_RESET_AT_RESUME) {
> +               mmc_claim_host(host);
> +               err =3D _mmc_hw_reset(host);
> +               mmc_release_host(host);
> +       }
> +
>         host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> -       return 0;
> +       return err;
>  }
>
>  /*
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 032c018650e0..3c0ea74e3e35 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -430,6 +430,7 @@ struct mmc_host {
>         u32                     caps2;          /* More host capabilities=
 */
>
>  #define MMC_CAP2_BOOTPART_NOACC        (1 << 0)        /* Boot partition=
 no access */
> +#define MMC_CAP2_RESET_AT_RESUME BIT(1)        /* Reset the card at syst=
em resume */
>  #define MMC_CAP2_FULL_PWR_CYCLE        (1 << 2)        /* Can do full po=
wer cycle */
>  #define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND (1 << 3) /* Can do full power=
 cycle in suspend */
>  #define MMC_CAP2_HS200_1_8V_SDR        (1 << 5)        /* can support */

Hi Ulf,

Sashiko reviewed v13 and flagged one thing on this patch:
https://sashiko.dev/#/patchset/20261113211143.3759154-1-kamal.dasu@broadcom=
.com?part=3D6

MMC_PM_KEEP_POWER is set in mmc_host_class_prepare() but is only cleared
in mmc_resume(). If system suspend aborts after prepare (e.g. another
device fails dpm_prepare(), or the cache flush fails), mmc_resume() is
not called and the flag stays set at runtime.

I think this is real, though unlikely. SDIO sets the flag in the function
drivers' suspend callbacks, which run later, so the window there is
narrower than setting it in prepare.

If you want it handled, I can clear the flag in mmc_host_class_complete()
when MMC_CAP2_RESET_AT_RESUME is set and send a v14. Otherwise I'm happy
to leave it as is, or do it as a follow-up. Let me know which you prefer.

Thanks,
Kamal

--000000000000d1b24a06606a6ea5
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
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg9WZ/ftn6Fk2jSVUL
sKK9UrBv9Qn57bjX9g8tF24LDdMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYxMTE2MjAxNTAyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEA0OIn2X6qTnhrsCh0L+V6Hy60fkWgK2pDwJu0GwBOTXDp+Z92YfdB
VKbVF1JjGFIZVaUYh8MheV0O0lHtIWhi5KsWo5XAIK5Fnm6NPiX75HLYen5CT2L+H3Wl3QlLp6/i
kBdQ9juLhdOwe3c+7AZW61G4Dhuh+MXzF3nw6i/VApDjq5iELExCRsB6eII/vBsdn0Fx7kWtbhEe
RgVRIuKGYgHEpwckAvMQS6geX+qSAo4k8pvmJW1MSDIuganRB79x2doWC+LjcXfTF7Y5inab7fyp
mcrzHXMgdbBZsubJal7KX99Zp/7pk3wR5ptUDEDGTFwq4d5cx3Y3T1bpIXaS7A==
--000000000000d1b24a06606a6ea5--
