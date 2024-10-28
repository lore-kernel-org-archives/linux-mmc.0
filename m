Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7ED36C;
	Mon, 28 Oct 2024 00:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730074167; cv=none; b=tyuWlWM6O8nImVGUdCGK7GrVrW2GVpIjBJF8x9u569C0Zk8znluBFimW2uDgHJIreIynHN9wc2VWi855LFBlQKHXMWartBr+yBFvpdhxitRzmh6jhfgSBEHFRGo9Tf9gNfXH2pAkFi0UqOYssVuS0kajMZJL0/QKr3sNaji18yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730074167; c=relaxed/simple;
	bh=ANF5axTXMVVS3gzJ3zqs59bDfLQorgMkuXmKY5BvbIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7ONZpxd7LsWAW9B7F8snHDdhuCRBDWKVXbo/2a/IfW/J9onpEeLQi8ZrI0Rnc1juLbvKTzLpPSQiFtYj6MczAr1qxj7Z0DpjOfs9rh/bIQGgcX1C0Eg/jjCABYdFHLkV7EkNYWrrzBCOUIHlFCf8NgKT4N+/tph1ibaEv+AFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4OFT20C; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4OFT20C"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso4267689a12.3;
        Sun, 27 Oct 2024 17:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730074163; x=1730678963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4jVhDJUCPbZ0g26fsXUoO4mush0279W/qJ7q2uEVOs=;
        b=P4OFT20CTQwqws3rvEN26dECZ74q5Opj2+llqORlVDZ2llQD48hqY/6hoQSLQW8aHU
         4WqQO9FbcfNtzanqUuauNyehVSPWsL7/gGAmQWCtV3kRgmU05X+bmRWbVs+rExwN+gJT
         gmojUM2s/r3hMcpi25so7QBxUKnDJOlTLnwaZPH/kh+FPWh9f6lsGNOrYiaAE8vZzDME
         X8weOaYmPb6LQjlIet3ndGSzfs1bkluj6bGG2KTrHKGD5UDW8l8SrJ/4uJPBj0miDfOG
         DPnSLYlQuQ5r0zoTnxcKXDwkYNRZsiaWfpSihuH+DIdzHaegMuhWOfs7E68YLVTnjMxj
         xasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730074163; x=1730678963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4jVhDJUCPbZ0g26fsXUoO4mush0279W/qJ7q2uEVOs=;
        b=rt541M8LLfNfh5ZCN+P1W7MfRSKrjuRhp3dumYto3u21j2icWe+WMbiHz1w2cdX/XQ
         jYtEP1B0fpd4rqaDFZgcIOBYiA/ilbo9LVdGXlMnaIptmFzfmOich1okGikKKsJkzs9u
         8UHBi8zu7r1gCo8EUyUeozVPGZy+clOVQPYMG4eQpbKgrbuVBSGu2qq18jtuiKYVFs//
         5yCfmxqe326jML1lNStMvvF5Wxnx2F3XtJwWwnyaCF0W6tJPK6I9aPJ8K1qYRej04zJ6
         d6cMwb/nB/ut+q3Q+dDcctMp0eSV+gfJPYATKHpiTHcaw64FTJmMN/nMYRifJY/oBF1g
         aKsw==
X-Forwarded-Encrypted: i=1; AJvYcCWrCTms0gO2ySh93YN5JfBRoYkr7GUs3nvhaNiz89UOnrUk/fOxfLhKXafw6+k05BtmculWsFRIMVB1@vger.kernel.org, AJvYcCX/Hwqa6FIs4M7qOKzXYTJKDImZ+3cCoBNdVR3tzRkmwJCWI0s9DZ0E0jUx0y6Wb5uTWsFv5L7Su4FBRcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrUyDEuvaW9MM3UfheFUGH6DtpPZchmECHTUGMi1sA6HNwSB5
	XJB1vhDhplURGBv3FT+n8bUupQik/2KBJ3qsEjRdnyDDyRXLakMtLGPfQCuqGA/edtDg8wg0bXn
	mTItnSqNCIoGOdGkNhMTAZ4N9X9Q=
X-Google-Smtp-Source: AGHT+IFOBVWLyNKQF9dOMrgGt05/88DCBl1fgz0RWe1gW1ND3s2UGMyTVN0kRDlppBNjAP48Othci5Ht78QsnGVn79s=
X-Received: by 2002:a05:6402:2742:b0:5c9:ba84:d3a with SMTP id
 4fb4d7f45d1cf-5cbbf8a41f6mr5473210a12.10.1730074163113; Sun, 27 Oct 2024
 17:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025060017.1663697-1-benchuanggli@gmail.com> <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com>
In-Reply-To: <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Mon, 28 Oct 2024 08:08:49 +0800
Message-ID: <CACT4zj-JC4FAN1qVhROX+7+wV1d426boqkNUPM4TR88A7TjBqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the
 set clock function
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw, 
	greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw, 
	victorshihgli@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Georg Gottleuber <ggo@tuxedocomputers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:23=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> + Georg
>
> On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-only
> > after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz().
> > So the low power negotiation mode cannot be enabled again.
> > Introduce gl9767_set_low_power_negotiation() function to fix it.
> >
> > The explanation process is as below.
> >
> > static void sdhci_gl9767_set_clock()
> > {
> >         ...
> >         gl9767_vhs_write();
> >         ...
> >         value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> >         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <--- (a=
)
> >
> >         gl9767_disable_ssc_pll(); <--- (b)
> >         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >
> >         if (clock =3D=3D 0)
> >                 return;  <-- (I)
> >
> >         ...
> >         if (clock =3D=3D 200000000 && ios->timing =3D=3D MMC_TIMING_UHS=
_SDR104) {
> >                 ...
> >                 gl9767_set_ssc_pll_205mhz(); <--- (c)
> >         }
> >         ...
> >         value &=3D ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> >         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- (II=
)
> >         gl9767_vhs_read();
> > }
> >
> > (a) disable low power negotiation mode. When return on (I), the low pow=
er
> > mode is disabled.  After (b) and (c), VHS is read-only, the low power m=
ode
> > cannot be enabled on (II).
> >
> > Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz =
and enable SSC for GL9767")
>
> Is this the same problem as being reported in
> https://lore.kernel.org/all/41c1c88a-b2c9-4c05-863a-467785027f49@tuxedoco=
mputers.com/
>
> ?
>
> > Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
>
> Not sure the above SoB makes sense. The below is perfectly sufficient, ri=
ght?

Yes, just keep the company's SOB. Thanks.

Best regards,
Ben Chuang

>
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Kind regards
> Uffe
>
>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 35 +++++++++++++++++++-------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 0f81586a19df..22a927ce2c88 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -892,28 +892,40 @@ static void gl9767_disable_ssc_pll(struct pci_dev=
 *pdev)
> >         gl9767_vhs_read(pdev);
> >  }
> >
> > +static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, boo=
l enable)
> > +{
> > +       u32 value;
> > +
> > +       gl9767_vhs_write(pdev);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> > +       if (enable)
> > +               value &=3D ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > +       else
> > +               value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> > +
> > +       gl9767_vhs_read(pdev);
> > +}
> > +
> >  static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned i=
nt clock)
> >  {
> >         struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> >         struct mmc_ios *ios =3D &host->mmc->ios;
> >         struct pci_dev *pdev;
> > -       u32 value;
> >         u16 clk;
> >
> >         pdev =3D slot->chip->pdev;
> >         host->mmc->actual_clock =3D 0;
> >
> > -       gl9767_vhs_write(pdev);
> > -
> > -       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> > -       value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > -       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> > -
> > +       gl9767_set_low_power_negotiation(pdev, false);
> >         gl9767_disable_ssc_pll(pdev);
> >         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >
> > -       if (clock =3D=3D 0)
> > +       if (clock =3D=3D 0) {
> > +               gl9767_set_low_power_negotiation(pdev, true);
> >                 return;
> > +       }
> >
> >         clk =3D sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> >         if (clock =3D=3D 200000000 && ios->timing =3D=3D MMC_TIMING_UHS=
_SDR104) {
> > @@ -922,12 +934,7 @@ static void sdhci_gl9767_set_clock(struct sdhci_ho=
st *host, unsigned int clock)
> >         }
> >
> >         sdhci_enable_clk(host, clk);
> > -
> > -       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> > -       value &=3D ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > -       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> > -
> > -       gl9767_vhs_read(pdev);
> > +       gl9767_set_low_power_negotiation(pdev, true);
> >  }
> >
> >  static void gli_set_9767(struct sdhci_host *host)
> > --
> > 2.47.0
> >
