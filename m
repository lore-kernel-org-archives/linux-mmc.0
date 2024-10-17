Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D341DE4D3;
	Thu, 17 Oct 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177528; cv=none; b=kN6O9OZW8BZvUX3wqorIK3GcZhw8hgDUaUzZWRI37NJGw3WiSu/qw0N7OXuQ/3ct+jvXl1oz0bpqQ2cduZZbQje/mIlh5+izk6a220DxgzbuspG+OHqZoR8chrqziyHulxv6rMiWrjANRSyM+aTEq2ugyenJ0opiXGoq/vHDs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177528; c=relaxed/simple;
	bh=wqirK9/YXTjUrKBHVUHk3cQlEdrak7UuCmWp2j8ne8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JihaVXa2p/0ku/xD4XHdznTrrd1yQTKqCg9OJlWpSOf6klGvtlfhzZhoHgOO0Bz4+SbeKzv1aCpfWOJhS8QyAPzOj8Px8wsRMBjy8as1jivVwXZU4IWOD5O6fW9WQOF7G/CBlgjrZCFHEUje4FzKg4AnZ+ZmcsPiSXH7guujRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR2Mze6S; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR2Mze6S"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b149ef910eso93858085a.3;
        Thu, 17 Oct 2024 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729177522; x=1729782322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQcOhxZX5zSwmdxUppV4TBW2y9OaxRaByZ0cWdqdkmY=;
        b=GR2Mze6SA27x5DsohxIvGe/82g8B6gQ6bsKLLOqrDh5nzJ1ojLclqaFExUu3XeZln/
         BaSXZenRRXWLNxsNdwoX6XPGu/r/LAKqQcMk7Sje3DGiAk4ApWsJ6h/X3PebcR5J0xgu
         IomrpU7OBOH8zXnsYwnLLq6WJMssmVCG5WdzYxysJYxSrzjWl67UgDKVNIXCEs8GTMrs
         CJkAtGp+b+1I9HdktcVTA7T9kHaC4uLUhbyKdOQhbWIm4mWY+/Y9Djh41c1siMBcGDWh
         0fyzQdHs5iIp1tRHLBWkar4a3C29GAfQcSR035MAYZUNviXpvJTf3jwYum2wKAMZHY16
         BdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729177522; x=1729782322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQcOhxZX5zSwmdxUppV4TBW2y9OaxRaByZ0cWdqdkmY=;
        b=ntCKa9/MANiHF8DfK7kzAKz2PMUSjMqmbMqpOobWj1o5kncxpm+1gRjVTJ+9Bc667/
         a2Vo6hEFGh7uSaA+Y2XnCXed8/HefQI+Rqy3//Q3/8F1g9kvJ+Wov2MLt9Bbdol5BhjJ
         aPMB8IDg2DaxdaZFmk8vlmY99Re9GPjA2z9K4D1esf/hoDYOc5gfJv07i0GCct9xrL4v
         jgNK+QSkhLTT3K7YWowD5fRYvpX56udMcykpz4BYXx5YMfLYk8rwSMp3YT7RLzwUy8Gn
         R0Ynpbvc08yd/22kAkNeJVDyavNZzypHPXSxg1IjO9OILlznb1r5OcEbVFkEbrDXbrhN
         9GSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/QuR3Y0w78sMqWwy4+KzaXFaY2aGl+CgP+F3eHoiaY3irvyUuHw3683yVqyhb/QlevSAn8q2xFurJT/I=@vger.kernel.org, AJvYcCXyIUWd4SYc36v+wfruHaWoEFML1jL5UZr6xuhpelWvNckpgKiUCrx5UqJv+DHevC3HuBTVLPlSCEXB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TkOetxlyxC9Nnb7R/cF0H24YpsIHkaZZWmd4Hnr8lhEZYidn
	qJMij0b90kk9g846OxJOE1J+e+tXEFMUp3YM/24770XcFfWzZK+M7yAw7184nez1Nya/tV5Pjrr
	1YEpfn408H38pEWNwAc8bTMK7zYTjVwJi
X-Google-Smtp-Source: AGHT+IGBvxvUNDUAh+eTmGClnChAek11ySV6IcXJTQ0nXcQ8psjw/3riWqM7wnIjFVDd5jZv4iAPKeh/Xwc99auM5F8=
X-Received: by 2002:a05:620a:4456:b0:7a1:da5e:c4c8 with SMTP id
 af79cd13be357-7b121022d19mr3098434485a.40.1729177522330; Thu, 17 Oct 2024
 08:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41c1c88a-b2c9-4c05-863a-467785027f49@tuxedocomputers.com> <SI2PR01MB3916D4C2E36365A0CC2E128BA7472@SI2PR01MB3916.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SI2PR01MB3916D4C2E36365A0CC2E128BA7472@SI2PR01MB3916.apcprd01.prod.exchangelabs.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 17 Oct 2024 23:05:14 +0800
Message-ID: <CAK00qKCdKsdWbJ7DQRQX3RjSsd31PkinAUXt9fYtG+crx3G0Rg@mail.gmail.com>
Subject: Re: FW: [RFC PATCH v2 1/1] mmc: sdhci-pci-gli: fix x86/S0ix SoCs
 suspend for GL9767
To: ggo@tuxedocomputers.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Greg.tu@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, Ben Chuang <benchuanggli@gmail.com>, 
	Lucas.Lai@genesyslogic.com.tw, 
	=?UTF-8?B?VmljdG9yU2hpaFvmlr3li53mlodd?= <victor.shih@genesyslogic.com.tw>, 
	cs@tuxedo.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Georg

I noticed that you mentioned in the patch for version 1 that the AMD
platform is fine,
may I ask that are AMD platforms and Intel platforms using the same
kernel version?
If they are using the same kernel version, how do you confirm that
the solution is to modify the kernel code?

Thanks, Victor Shih

> -----Original Message-----
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> Sent: Thursday, October 17, 2024 4:11 PM
> To: Ben Chuang <benchuanggli@gmail.com>
> Cc: Ben Chuang <benchuanggli@gmail.com>; adrian.hunter@intel.com; Ulf Han=
sson <ulf.hansson@linaro.org>; VictorShih[=E6=96=BD=E5=8B=9D=E6=96=87] <Vic=
tor.Shih@genesyslogic.com.tw>; LucasLai[=E8=B3=B4=E5=AE=97=E6=B8=85] <Lucas=
.Lai@genesyslogic.com.tw>; GregTu[=E6=9D=9C=E5=95=9F=E8=BB=92] <Greg.Tu@gen=
esyslogic.com.tw>; HLLiu[=E5=8A=89=E9=B4=BB=E9=9C=96] <HL.Liu@genesyslogic.=
com.tw>; cs@tuxedo.de; Georg Gottleuber <ggo@tuxedocomputers.com>; BenChuan=
g[=E8=8E=8A=E6=99=BA=E9=87=8F] <Ben.Chuang@genesyslogic.com.tw>; linux-mmc@=
vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [RFC PATCH v2 1/1] mmc: sdhci-pci-gli: fix x86/S0ix SoCs suspend=
 for GL9767
>
> [Some people who received this message don't often get email from ggo@tux=
edocomputers.com. Learn why this is important at https://aka.ms/LearnAboutS=
enderIdentification ]
>
> Adapt commit 1202d617e3d04c ("mmc: sdhci-pci-gli: fix LPM negotiation so =
x86/S0ix SoCs can suspend") also for GL9767 card reader.
>
> This patch was written without specs or deeper knowledge of PCI sleep sta=
tes. Tests show that S0ix is reached and lower power consumption when suspe=
nded (6 watts vs 1.2 watts for TUXEDO InfinityBook Pro Gen9 Intel).
>
> The function of the card reader appears to be OK.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219284
> Fixes: f3a5b56c1286 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9767 suppor=
t")
> Co-developed-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> ---
> v1 -> v2:
> - use gl9767_vhs_read() and gl9767_vhs_write()
> - editorial changes to the commit message
>
>  drivers/mmc/host/sdhci-pci-gli.c | 61 +++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c
> b/drivers/mmc/host/sdhci-pci-gli.c
> index 0f81586a19df..bdccd74bacd2 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1205,6 +1205,28 @@ static void
> gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);  }
>
> +static void gl9767_set_low_power_negotiation(struct sdhci_pci_slot *slot=
,
> +                                            bool enable) {
> +       struct pci_dev *pdev =3D slot->chip->pdev;
> +       u32 value;
> +
> +       gl9767_vhs_write(pdev);
> +
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +
> +       if (enable)
> +               value &=3D ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       else
> +               value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +       gl9767_vhs_read(pdev);
> +}
> +
>  static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
>                                         unsigned int timing)  { @@ -1470,=
6 +1492,42 @@ static int gl9763e_suspend(struct sdhci_pci_chip
> *chip)
>         gl9763e_set_low_power_negotiation(slot, false);
>         return ret;
>  }
> +
> +static int gl9767_resume(struct sdhci_pci_chip *chip) {
> +       struct sdhci_pci_slot *slot =3D chip->slots[0];
> +       int ret;
> +
> +       ret =3D sdhci_pci_gli_resume(chip);
> +       if (ret)
> +               return ret;
> +
> +       gl9767_set_low_power_negotiation(slot, false);
> +
> +       return 0;
> +}
> +
> +static int gl9767_suspend(struct sdhci_pci_chip *chip) {
> +       struct sdhci_pci_slot *slot =3D chip->slots[0];
> +       int ret;
> +
> +       /*
> +        * Certain SoCs can suspend only with the bus in low-
> +        * power state, notably x86 SoCs when using S0ix.
> +        * Re-enable LPM negotiation to allow entering L1 state
> +        * and entering system suspend.
> +        */
> +       gl9767_set_low_power_negotiation(slot, true);
> +
> +       ret =3D sdhci_suspend_host(slot->host);
> +       if (ret) {
> +               gl9767_set_low_power_negotiation(slot, false);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
>  #endif
>
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot) @@ -1605,=
6 +1663,7 @@ const struct sdhci_pci_fixes sdhci_gl9767 =3D {
>         .probe_slot     =3D gli_probe_slot_gl9767,
>         .ops            =3D &sdhci_gl9767_ops,
>  #ifdef CONFIG_PM_SLEEP
> -       .resume         =3D sdhci_pci_gli_resume,
> +       .resume         =3D gl9767_resume,
> +       .suspend        =3D gl9767_suspend,
>  #endif
>  };
> --
> 2.34.1
> ________________________________
>
> Genesys Logic Email Confidentiality Notice:
> This mail and any attachments may contain information that is confidentia=
l, proprietary, privileged or otherwise protected by law. The mail is inten=
ded solely for the named addressee (or a person responsible for delivering =
it to the addressee). If you are not the intended recipient of this mail, y=
ou are not authorized to read, print, copy or disseminate this mail.
>
> If you have received this email in error, please notify us immediately by=
 reply email and immediately delete this message and any attachments from y=
our system. Please be noted that any unauthorized use, dissemination, distr=
ibution or copying of this email is strictly prohibited.
> ________________________________
