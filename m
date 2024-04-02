Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363565D749
	for <linux-mmc@vger.kernel.org>; Tue,  2 Apr 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054061; cv=none; b=i/i/Npb7Mo4DTyNno4zyUX+jnTYQW4Azf03GJ1k77i4sUAvh2ZX+6KGrM/5Q6f7HVVJFxymgNeEy/m2yaE0SZw568xbinZ+uStsJaBkshC/8LoIGYhNSy6gwB+n3yhMnU3O0qHCgH3AoXp/jcMcpRjzLVpbEnra4SfjGjWvhLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054061; c=relaxed/simple;
	bh=PlKo6d/Y5dHXxCDi1xlJSwnCee6AWwA7XpEZ+abQOzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2Ap1vKFQFh0iyX0r7MBxWxDTD5L0JzO5jsGSR9OGV6cG4apWvpdXgYwBFCfIdTE4KsiV9wC8znhU3PEJm5mMPjLsCFwy0/I4G2xyyKsappTk1o97WEq/4bVlXyzY/6NqGEmtohJHvJwkNoD7rRM8qGXsiAvgw5H1PLKS3C24rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oBYRLUbk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oBYRLUbk"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so4610350276.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2024 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054058; x=1712658858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvgn6VECiAz02a9UORG6+tPX9aN15gdUDX8CO7KEUQ4=;
        b=oBYRLUbkqp6YsZSM2JkIX/Byb+a2onm/oZ4uV8zmfi66BDzjB5zu2sIHzLDb//BqMY
         9jCGdwiFWSB7Ne74xPFiwk/RMOULt0+EAqKSjNzximpT5bMziiO9LzxxxwijKyrvDIug
         O7ZG70iL2ESdN5S14eMCOWCt+4nZtUnIC3iFpnuVgPIQt2zwLsr793n57sJ9WXtwdUhV
         LIbR14DBNI2CJkF0PgLHcG7boJu9uRBmFqNHBaJHsGxOaVA48Frr/A6lVn31L3xDLxwI
         Zj6TqZbab4yDdRKvLv2DX6/FScFGdECVA9OUOeO6IwdfU+UU21DnbFyP40IVgM7uWVgm
         Upig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054058; x=1712658858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvgn6VECiAz02a9UORG6+tPX9aN15gdUDX8CO7KEUQ4=;
        b=N0527hilRSo+qK9hajCwirpbLx8hTrZEPWF+dEnuezcOXa0U61apxwubAN1S62Y1bW
         ck6/HWmmDEuKIC0lmI+kgFTZ0ewqBa9quHTNdFkpefLEbn9OzD9srqb9CmYyGfzlfsVF
         pFYN2qd2a/SSZVOa6qUV/YV6eqXk54P0xqXgTFl8xcwMTVJ9QuzjlFaiwoPr59WNeNHp
         LnQ6xdD3okRobG8eOvpQdh9nDrIVaA/1r8N4k6gt6Wa89bPhN15Xny2gBEMv4CgX7eol
         9IQFsjVecnD+ccYEsp1Kzyiras5uElfz8l5cO2Fz/RyS2m+8olKGWw8kz3J3gCUkeyVZ
         OaEg==
X-Forwarded-Encrypted: i=1; AJvYcCXnb9zSEZ3Mw7RjZ2cF574bhNZVB8PYeN3YbaR9WR3TRC9XDQycD5X1SdN3YXTGT1LwCwQA0OtPNCESS7HqYtptW6qBGoXN3yYr
X-Gm-Message-State: AOJu0Yxpw1UVGdgDj4ktBVUZt0Z+8FAJcH/fCHEtLJGagJbFMwDOJCxF
	T4stpwugcN4KN+hwXRn2p2sie/cuMiX3zS8U9JPhmZEWIqwXKOf7xZ5Mi+hPSPfpNIxh07w/8Oa
	ZODZZYpj/wb3jqxgBLPktwAbm69lmvDfrodm3+A==
X-Google-Smtp-Source: AGHT+IF2vr/abIo7YaQa16taPapiDn+D2f/lvM9TC0lb6RX93CCTumBAM8s6QUV3C0/41/9+axoLWqYjR242zRJ4nJQ=
X-Received: by 2002:a25:a81:0:b0:dc6:bbbc:80e4 with SMTP id
 123-20020a250a81000000b00dc6bbbc80e4mr9519575ybk.4.1712054058273; Tue, 02 Apr
 2024 03:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214831.1544595-1-helgaas@kernel.org> <20240327214831.1544595-3-helgaas@kernel.org>
 <CACT4zj9BFwMLsDSzNQ=wHSBCHqoydggtM-7-7rsfo0pRV2iLEg@mail.gmail.com>
In-Reply-To: <CACT4zj9BFwMLsDSzNQ=wHSBCHqoydggtM-7-7rsfo0pRV2iLEg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:33:42 +0200
Message-ID: <CAPDyKFpHuLsYg4=gs_d++u1bSvuAW7uY56kCciTNmD1VBp2AkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: Use pci_set_power_state(), not
 direct PMCSR writes
To: Ben Chuang <benchuanggli@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Kai-Heng Feng <kai.heng.geng@canonical.com>, Sven van Ashbrook <svenva@chromium.org>, 
	Stanislaw Kardach <skardach@google.com>, Brian Norris <briannorris@chromium.org>, 
	Jason Lai <jasonlai.genesyslogic@gmail.com>, Renius Chen <reniuschengl@gmail.com>, 
	linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 at 02:01, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> On Thu, Mar 28, 2024 at 5:49=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > d7133797e9e1 ("mmc: sdhci-pci-gli: A workaround to allow GL9750 to ente=
r
> > ASPM L1.2") and 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allo=
w
> > GL9755 to enter ASPM L1.2") added writes to the Control register in the
> > Power Management Capability to put the device in D3hot and back to D0.
> >
> > Use the pci_set_power_state() interface instead because these are gener=
ic
> > operations that don't need to be driver-specific.  Also, the PCI spec
> > requires some delays after these power transitions, and
> > pci_set_power_state() takes care of those, while d7133797e9e1 and
> > 36ed2fd32b2c did not.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Hi Bjorn,
>
> Thanks. It looks better than the vendor specific.
>
> Best regards,
> Ben Chuang

Hi Ben,

I assume I can consider your reply as a reviewed-by tag. If not,
please let me know.

Kind regards
Uffe


>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 20 ++++----------------
> >  1 file changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 3d5543581537..0f81586a19df 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -25,9 +25,6 @@
> >  #define   GLI_9750_WT_EN_ON        0x1
> >  #define   GLI_9750_WT_EN_OFF       0x0
> >
> > -#define PCI_GLI_9750_PM_CTRL   0xFC
> > -#define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > -
> >  #define SDHCI_GLI_9750_CFG2          0x848
> >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > @@ -149,9 +146,6 @@
> >  #define PCI_GLI_9755_MISC          0x78
> >  #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
> >
> > -#define PCI_GLI_9755_PM_CTRL     0xFC
> > -#define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > -
> >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> >
> > @@ -556,11 +550,8 @@ static void gl9750_hw_setting(struct sdhci_host *h=
ost)
> >         sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
> >
> >         /* toggle PM state to allow GL9750 to enter ASPM L1.2 */
> > -       pci_read_config_dword(pdev, PCI_GLI_9750_PM_CTRL, &value);
> > -       value |=3D PCI_GLI_9750_PM_STATE;
> > -       pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> > -       value &=3D ~PCI_GLI_9750_PM_STATE;
> > -       pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> > +       pci_set_power_state(pdev, PCI_D3hot);
> > +       pci_set_power_state(pdev, PCI_D0);
> >
> >         /* mask the replay timer timeout of AER */
> >         aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> > @@ -774,11 +765,8 @@ static void gl9755_hw_setting(struct sdhci_pci_slo=
t *slot)
> >         pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
> >
> >         /* toggle PM state to allow GL9755 to enter ASPM L1.2 */
> > -       pci_read_config_dword(pdev, PCI_GLI_9755_PM_CTRL, &value);
> > -       value |=3D PCI_GLI_9755_PM_STATE;
> > -       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> > -       value &=3D ~PCI_GLI_9755_PM_STATE;
> > -       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> > +       pci_set_power_state(pdev, PCI_D3hot);
> > +       pci_set_power_state(pdev, PCI_D0);
> >
> >         /* mask the replay timer timeout of AER */
> >         aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> > --
> > 2.34.1
> >
> >
