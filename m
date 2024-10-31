Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA511C460E
	for <linux-mmc@vger.kernel.org>; Thu, 31 Oct 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392798; cv=none; b=TrlQf5sRvO3PiyObLv9B9WQFlKShmMz+jZShLj7heWnMSU4zM7KxGvzSRZDt7t1YbkEQtCvYoQOV5Miz/mbEooXZe+Arj0YoDNfdHvt9rSQWcMS8rx6NLJG7HEOWoKxxSdJ0rKrkodiYbhhdyNa3ApNAxY2YztJiyrSILRK6AeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392798; c=relaxed/simple;
	bh=8XdQ3HwoGz9iwZrBvHIi2ThJVAVqoiAgmx48uKGlkIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1HMjwAYqFmqRZrzs3kqaPSnGUDf1Zww2gHSVrJcFLaN3lPiKOYkzY0/+TElLizrywKB/yP/XGSshpOeb1QwwoTXUkE0iSugxnncJRIGy4vQ45Qm8sbB/ULD84/D8J9XRapwR7ovm/hXS7UYoKK21y+Jcb+/tOmMfyjOHo1noS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jqeBTNH4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqeBTNH4"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea656c60a4so853617b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 31 Oct 2024 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730392795; x=1730997595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I5eUYcRuTA0oniMSyBjEXihZ+0pUSIHnqHbjfdV88TE=;
        b=jqeBTNH4ZUHOoaJQaKwME0YQqrJRpzT/deyPzYCTs5bgeEmVbNaGby/TdNdrcfA4j6
         tfJieDaHstHnXX0wUvw9SDFzR5v1mD8RDV4UAARMs8ve/yMjhgEQbR3sAj+k/90ra5dZ
         KOhO9pn/NLtu4IKezpNOrU2F1yAYY9qI3Aq9Px5a2Cuq0W70AHhLXHCTGQ1rF5M956QX
         ti4fqSCCeVfqPpX8lS60qghMTls47EZhUtm9lLk1xNmc0Rbf4Ii0wSg9IQHkNI7NwkCK
         n1TLiM2cD0xsDBTd01byO2wAAWpWZGXX8wbLH4df0hT9DOmGFHqFIQBnGgAqHE+edGjV
         e33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392795; x=1730997595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5eUYcRuTA0oniMSyBjEXihZ+0pUSIHnqHbjfdV88TE=;
        b=cta8D51Y5UnFG+h/x5VSZTxYT22J/j3ESamB23EWyfQNLMWtk3aoKkcvG148uBHB5/
         zAW0yeuXVguqfZFTMfRjPMhhdXuBPbUKEVLvcG6JMNsBQTMpjnsyMFvRT4hceVFaveK+
         dC3+O3YJZbEyIQ6V09yoH4j81HHzUfVoPWB+ObIhaJIn314BKmeCNkuzlAthS9ME1K1G
         Nz+yJ9bbeqC492ht5pDSEVqtXY+L5F8mXxA7DEI+A6wqtMXQQilZklXdZiVoIlyDvs9I
         8aYp5S2bC1z/yLrLWt3burZm9vgj503aKm9p0nzH/yWtfEJ4FEMyYXplagBojfZPzaF1
         A6KQ==
X-Gm-Message-State: AOJu0YyMX76+HrsdnC6VWLrVMYiVTzs/O/1lGEJCCnq3Xt8bPCuU6FgG
	9FirGqy49LiSygufNsGoHYL1dX9pdQId7I097Ek27kfecCcGalBIELr87F1Fa2e1VlN+JZHM70E
	+k3ewYBB0gANCUGvX4WJniZYmaEHKeWTfg7Nsjg==
X-Google-Smtp-Source: AGHT+IH5Npva13M2z10+7v7COaSYdI5KHd4w5hjE2VqqWorqJ619LAZy1oHvwY0yx6RGyRiZthiLSnPJ+J5yQO4L4lU=
X-Received: by 2002:a05:690c:f8d:b0:6e2:1527:4447 with SMTP id
 00721157ae682-6ea3b87e1b5mr90465817b3.1.1730392795180; Thu, 31 Oct 2024
 09:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030112216.4057-1-victorshihgli@gmail.com> <ece430b5-fa6b-4ad0-adfd-73778bae539b@intel.com>
In-Reply-To: <ece430b5-fa6b-4ad0-adfd-73778bae539b@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Oct 2024 17:39:15 +0100
Message-ID: <CAPDyKFr62e7aTqjQq1QuOv2xN2RuNrF=gezG6UT=YdTnkqq7Cw@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-uhs2: correction of incorrect type in argument
To: Adrian Hunter <adrian.hunter@intel.com>, Victor Shih <victorshihgli@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, kernel test robot <lkp@intel.com>, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 14:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 30/10/24 13:22, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > There is a type issue in the argument in the __sdhci_uhs2_send_command()
> > that will generate a warning when building the kernel.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202410260525.ZUuPhMJz-lkp@intel.com/
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next and by adding a suggested-by tag from Adrian, thanks!

> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 43820eb5a7ea..7f41ca67b069 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -649,7 +649,8 @@ static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_comman
> >        * MSB when preparing config read/write commands.
> >        */
> >       for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
> > -             sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_UHS2_CMD_PACKET + i);
> > +             sdhci_writel(host, *(__force u32 *)(cmd->uhs2_cmd->payload + j),
> > +                          SDHCI_UHS2_CMD_PACKET + i);
> >               i += 4;
> >       }
> >
>
> Thanks for doing this.
>
> I just noticed there is another issue that was reported but
> did not get highlighted:
>
> >> drivers/mmc/host/sdhci-uhs2.c:73:16: sparse: sparse: cast to restricted __be16
>
> So the following is needed also:
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 0a597240d299..c53b64d50c0d 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>
>  static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
>  {
> -       return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
> +       return be16_to_cpu((__force __be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
>  }
>
>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
>

Let's deal with the issue above as another separate patch on top.
Victor, can you please submit a patch according to the above and add
Adrian's suggested-by tag.

Kind regards
Uffe
