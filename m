Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2181ABEBF;
	Fri,  1 Nov 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457626; cv=none; b=GvcvZjhlSsXr5vsUfEkkj+Dnz8qJdh6aG4lT7rGMzLkFGe6t/R4MlRIwiIB/dHCaRIGr7O+CJLyogsC1UVBDzOEOEAkDS9CgYE+6ORSAV+PYZ1t9DEHmYFSQyPBUE+X8JZdg57Oa8zJ4T958RXtOE2bxP2dSfcH+YlxliFXXplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457626; c=relaxed/simple;
	bh=PgMvmjZjRqAMe9HYyhCALJYt7d5kQnoA3J/aX1M8aIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6Hq5ghhq1CT0SY/gOLFJmGoQ4mOebelo8X2WFow5RNFld7VYl5HRKVSp3emNeHcGT5ccHtlvZQ3xSkB6rpBz3d6rwJkJ6u1A44VUpiFxIAi7WfyqM696SoMHHXYppiim7sp+tLjxmMTJXp+VjDSXTU/5Gn7d3lP8GOcDHL3wio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROODtNYy; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROODtNYy"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d3d4d2ad2so703576e0c.0;
        Fri, 01 Nov 2024 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730457622; x=1731062422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoCnhkfRv//zFAXRhEji5I7YPGBTc8nAyEWnjixpZas=;
        b=ROODtNYyGzZbR0Ug8B3hi7d5HPqEEJiVCSO6MxzPNRyHiOmjlM/75qyvTDbWXGUGgw
         vWcfWtw9OrkljJsiI2mFyzv3P42Hu0ycvzGzfxRGakf2MrgWbPuooTLBIsYRA9eev6Qs
         kkpAepLv2+pqPu2b5No6XXqxrIXI7QMekgk+l2k+wticstOqZQMwBe7206umbpQAojG7
         mQ7AzJb9f0D7YZBXDJQdQBsjbckJX8r7uoVQzolPaTNZfAxRtFppQZI1fo47duXD6C8K
         dNdXub0FFODl/pJp0YCXEefnSh5aIvAuwAMucOp4gHDuGPqeDxGRhFP8NzMT/BsSHD4d
         ShEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730457622; x=1731062422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoCnhkfRv//zFAXRhEji5I7YPGBTc8nAyEWnjixpZas=;
        b=fCQPClFYL2Fxfx1h3WdaspP1rZF30TuZ8P+r2RxJImLDou1WyOqd06+WfluQjBtCpQ
         RFz2iThipS4QfXvkImFA+Hpk5oKrM0nn4JRwLDNV/VCm72S5JY5ble4hUsuwBwCml9At
         nTlRvi35nfiJJIfT209HxM3vNq87wzXsDPTZxOyyAkLYSLJ9KUtDfCLX+Pg99171D/7P
         yG6IEBZT9OF3iVpOkBa46gJkxHn9l9DQTtkE5eKBrWH6RzmI4w3/+Fd8KTDKZmH3EvH+
         OYWBkCSUcxSDD3O96TQrH7ouc/TboLWZKY1GgGRuH5a5cxtdHzMVUwzV96NvKc01ZUs7
         T8PA==
X-Forwarded-Encrypted: i=1; AJvYcCWaBFQVrtnuoiYV44VVfXltGqHpC6E/jSa2S5EWngWARkngPqmZLYybEnM6yi8p3XHHHeu4KY9tTnnK@vger.kernel.org, AJvYcCWkY09fLdcXh2NGWEzSbQSDdd6rZk4rGTkGoSXWxBCtRnj5hWoMa5/3+IZYWT2TbWZ5X0ppnZpQ/bKdq+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7hNs6k2SCF5sJRR/1AC5fACEZ9rk/R48gABv0UEOY0wYH4jJ
	BjALP4AAYysO4y64xmYLco04VuhErdrNyTokO1UxL/BOI8BppWcF1ymN1EpoE+tDw6xt6uOU9/B
	19OFJOEiHcm1dOQkQHRxVAsi33Nk=
X-Google-Smtp-Source: AGHT+IGrSodyP9yhNuF+9Hm9tFbHuSy5dGg1pAkOjOmi3hAZbbXJ7CBKKilniArGmnfJWLaurMkhdWF4KF41b8atKRI=
X-Received: by 2002:a05:6122:a06:b0:50d:160e:de73 with SMTP id
 71dfb90a1353d-512270d0383mr2970830e0c.6.1730457622371; Fri, 01 Nov 2024
 03:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030112216.4057-1-victorshihgli@gmail.com>
 <ece430b5-fa6b-4ad0-adfd-73778bae539b@intel.com> <CAPDyKFr62e7aTqjQq1QuOv2xN2RuNrF=gezG6UT=YdTnkqq7Cw@mail.gmail.com>
In-Reply-To: <CAPDyKFr62e7aTqjQq1QuOv2xN2RuNrF=gezG6UT=YdTnkqq7Cw@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 1 Nov 2024 18:40:10 +0800
Message-ID: <CAK00qKC9qg9=HxajEqqQSyUh-z_buAXuw-BLs=fByU1wkzdDWw@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-uhs2: correction of incorrect type in argument
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	kernel test robot <lkp@intel.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 30 Oct 2024 at 14:08, Adrian Hunter <adrian.hunter@intel.com> wro=
te:
> >
> > On 30/10/24 13:22, Victor Shih wrote:
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > There is a type issue in the argument in the __sdhci_uhs2_send_comman=
d()
> > > that will generate a warning when building the kernel.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202410260525.ZUuPhMJz-l=
kp@intel.com/
> > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Applied for next and by adding a suggested-by tag from Adrian, thanks!
>
> > > ---
> > >  drivers/mmc/host/sdhci-uhs2.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-u=
hs2.c
> > > index 43820eb5a7ea..7f41ca67b069 100644
> > > --- a/drivers/mmc/host/sdhci-uhs2.c
> > > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > > @@ -649,7 +649,8 @@ static void __sdhci_uhs2_send_command(struct sdhc=
i_host *host, struct mmc_comman
> > >        * MSB when preparing config read/write commands.
> > >        */
> > >       for (j =3D 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++=
) {
> > > -             sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI=
_UHS2_CMD_PACKET + i);
> > > +             sdhci_writel(host, *(__force u32 *)(cmd->uhs2_cmd->payl=
oad + j),
> > > +                          SDHCI_UHS2_CMD_PACKET + i);
> > >               i +=3D 4;
> > >       }
> > >
> >
> > Thanks for doing this.
> >
> > I just noticed there is another issue that was reported but
> > did not get highlighted:
> >
> > >> drivers/mmc/host/sdhci-uhs2.c:73:16: sparse: sparse: cast to restric=
ted __be16
> >
> > So the following is needed also:
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 0a597240d299..c53b64d50c0d 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >
> >  static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
> >  {
> > -       return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR=
_MASK;
> > +       return be16_to_cpu((__force __be16)cmd->uhs2_cmd->arg) & UHS2_A=
RG_IOADR_MASK;
> >  }
> >
> >  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> >
>
> Let's deal with the issue above as another separate patch on top.
> Victor, can you please submit a patch according to the above and add
> Adrian's suggested-by tag.
>
> Kind regards
> Uffe

Hi, Ulf and Adrian

I got it. I will be submitting a separate patch based on the above comments
and adding Adrian's suggested-by tag.
Thank you very much for your help and advice

Thanks, Victor Shih
