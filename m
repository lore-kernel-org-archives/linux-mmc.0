Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0A1C9EC5
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333397; cv=none; b=oRHLOQPMSqCsVeY0wYT9YnL+6DuTXHuktd2TUlF7hqNs5bbkWvjX5yDSmR8trQv6q2cPTDgb5xdzYR5ORq68Oo9MfUklVbyvjwaZe1mdBtFJh0+svDrlG85Ed10bYAZc8MUJgjW3a4nis2lLLufbVF2s8cJl3vIicQzSHPQL7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333397; c=relaxed/simple;
	bh=9dBw1PEu6CWL1/cEfJIO7MrjDnsU7F1HE6Ou2LIytgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWydKru/EQhXk0wLsog5bWneADi1ZWOMdkOunqtcobdc/m1ehnbFzzmZfzYrO/vAzpG/EfGvKcuWVndqUD3ARHAFGLO9knjh7hL0ueLemcy/E+/opS5zDiOkRvsH3FKZRt3H5bUL/VldT9RV0snb2vmkt/I2DN8SRwoSLbVFK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GMLGw4zq; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMLGw4zq"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e1633202008so798818276.2
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724333395; x=1724938195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eJithtaIUZCkQAQ+HEkIHAF7XW8+xEVWw8ZSp1qNhhM=;
        b=GMLGw4zq97d7hHRf/OqdGCFw9YflHqSZ92ewUALiqnl3BJnOQmUQIiQlgid2QyKWOY
         I6xRaiR/AybGMosfQq1IoG2MTlCvTG7MUvSnXZg4YeTC/g7kufmIMq/Q6fCWE+ZlLd9x
         6LJhiFeO2vVs4osHus5JFuIZvgIoDY/1g7ta4MCilM7iDt+TyfBqhdIS6anPidWUsxIs
         KOzQBtGF1zacOjCtRa/QA8UdsAhvGCTEd960UTeRh/blkyG8DSOKLyT0PMslNWiKf4xm
         mrG8uPjiy3EIfJ1YjPpTJWQ/ki9oorbNz3TtRY5O/Hq4d5PXg2RV7XU+AwLI0z0TotuQ
         zjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333395; x=1724938195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJithtaIUZCkQAQ+HEkIHAF7XW8+xEVWw8ZSp1qNhhM=;
        b=R6nQJy9GNuFPZV1ReijuY9YVuUHB+8bDG7ytlfnRyPv+PyQqNQDOQxe1pzkTbukdiH
         W7y3zAnjNBi1WzcmVNC7BZ4z7xbm3Rz6j9oBJD6/608+SKA3vhzhCHCk6VRe4SkRAqVa
         5+sgHRXhOOJ8na06Ee00w9tUGWOTbd8kjbjqzw31rygyLjjN8Dgv9PcuJo6PScrNunvr
         b+Smo7oTGVdDI/nwTKgAs2vI28KjYJ++H2k3B0ADOTRa7l0n6bTMi7+8nZDTg9a5uC0f
         +QKzebngmuf3n8yBVd68KuekS436HXkkYJWGkS2sYCe++s7tv+E2tI/7v/P8VhKJTZoT
         FBFA==
X-Gm-Message-State: AOJu0Ywiog8yKQQ3I8Zchj4kLk9X+yoX7o3j3jSHwEf/LAVB95sFkTyo
	m/AtTNpjM/6X+wSCDnGdpi9BMnWR3s77rKFcLE8c3aIz2CpqFVDZdA4LzhuG7QU7nBq6FcriGwK
	OVnXxj8HcryntrAsdSaGHajZJd+PyJXRumAw6wA==
X-Google-Smtp-Source: AGHT+IEyYDBmeoI6j7WiWS1CHtL0V0ruOfOhAy/rx8cQEMm0Kie5WplWz2ImACAwTbKVYrsYCe2wXmE/JW3qmwaAcHI=
X-Received: by 2002:a05:6902:e04:b0:e03:a227:6476 with SMTP id
 3f1490d57ef6-e1665445990mr6371157276.17.1724333394615; Thu, 22 Aug 2024
 06:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com> <20240814072934.2559911-2-avri.altman@wdc.com>
 <CAPDyKFqafoeiBSAbU30d0jMUJPHvED3Z7khz6rqpn_NAgYurDw@mail.gmail.com> <DM6PR04MB65758AA7B324B1E6F1BD29C7FC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65758AA7B324B1E6F1BD29C7FC8F2@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2024 15:29:18 +0200
Message-ID: <CAPDyKFpTpzFcntDurKTbd2+Y64HG-Znhtbk+2yNsWMo0i4ShLQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] mmc: sd: SDUC Support Recognition
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 15:17, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On Wed, 14 Aug 2024 at 09:31, Avri Altman <avri.altman@wdc.com> wrote:
> > >
> > > ACMD41 was extended to support the host-card handshake during
> > > initialization.  The card expects that the HCS & HO2T bits to be set
> > > in the command argument, and sets the applicable bits in the R3
> > > returned response.  On the contrary, if a SDUC card is inserted to a
> > > non-supporting host, it will never respond to this ACMD41 until
> > > eventually, the host will timed out and give up.
> > >
> > > Tested-by: Ricky WU <ricky_wu@realtek.com>
> > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > > ---
> > >  drivers/mmc/core/sd_ops.c | 19 +++++++++++++++----
> > > include/linux/mmc/host.h  |  6 ++++++
> > >  include/linux/mmc/sd.h    |  1 +
> > >  3 files changed, 22 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > > index 8b9b34286ef3..7f6963dac873 100644
> > > --- a/drivers/mmc/core/sd_ops.c
> > > +++ b/drivers/mmc/core/sd_ops.c
> > > @@ -168,12 +168,16 @@ int mmc_send_app_op_cond(struct mmc_host
> > *host, u32 ocr, u32 *rocr)
> > >                 .cmd = &cmd
> > >         };
> > >         int err;
> > > +       u32 sduc_arg = SD_OCR_CCS | SD_OCR_2T;
> > >
> > >         cmd.opcode = SD_APP_OP_COND;
> > > +       cmd.arg = ocr;
> > > +
> > >         if (mmc_host_is_spi(host))
> > > -               cmd.arg = ocr & (1 << 30); /* SPI only defines one bit */
> > > +               cmd.arg &= (1 << 30); /* SPI only defines one bit */
> > >         else
> > > -               cmd.arg = ocr;
> > > +               cmd.arg |= sduc_arg;
> > > +
> >
> > This code doesn't belong in mmc_send_app_op_cond(), but rather in
> > mmc_sd_get_cid(), which is where we add one various OCR bits before we call
> > mmc_send_app_op_cond() with it.
> >
> > For example, if the response of the SD_SEND_IF_COND commands indicates
> > an SD 2.0 compliant card, we tag on the SD_OCR_CCS bit. It looks like that
> > needs to be extended to the SD_OCR_2T bit too.
> OK.
>
> >
> > >         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> > >
> > >         err = __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US, @@
> > > -182,8 +186,15 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> > u32 ocr, u32 *rocr)
> > >         if (err)
> > >                 return err;
> > >
> > > -       if (rocr && !mmc_host_is_spi(host))
> > > -               *rocr = cmd.resp[0];
> > > +       if (!mmc_host_is_spi(host)) {
> > > +               if (rocr)
> > > +                       *rocr = cmd.resp[0];
> > > +
> > > +               if ((cmd.resp[0] & sduc_arg) == sduc_arg)
> > > +                       host->caps2 |= MMC_CAP2_SD_SDUC;
> > > +               else
> > > +                       host->caps2 &= ~MMC_CAP2_SD_SDUC;
> >
> > Please don't abuse the host->caps2 for this purpose.
> >
> > Instead let's keep using the card->state to keep track of what type of card this
> > is. You may have a look at how the MMC_CARD_SDXC bit is being used and
> > just follow that behaviour for the SDUC cards too.
> >
> > Moreover, rather than assigning card->state at this point, let's do that from
> > mmc_decode_csd() instead, when we realize that the card supports the new
> > CSD structure version 3.
> Just to recap - so we are all on the same page:
> Ricky suggested this in v1 as well.
> And we had a discussion if we should use the state field to indicate the card type.
> However, Ricky had some good point why it should be here:
> "...
> I think host->caps2 is for host to claim caps, here can just call mmc_card_set_ult_capacity?
> Don't need to wait csd, because SDXC and SDHC need to identify by capacity, but SDUC can be identified here
> And all your mmc_card_is_sduc() I think change to mmc_card_ult_capacity() to know the card type
> ..."
> This is because according to the spec, SDUC identification is not mandated by its capacity, but rather by the rocr.

In principle you are right. The rocr indicates whether it's an SDSC,
SDHC, SDXC or an SDUC card.

On the other hand we are checking the CSD structure version for
SDSC/SDHC/SDXC - so I would rather be consistent with that way, as it
seems to work fine.

According to the spec the CSD structure version 3 is dedicated for
SDUC cards, right?

[...]

Kind regards
Uffe
