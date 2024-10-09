Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FA18EFE6
	for <linux-mmc@vger.kernel.org>; Wed,  9 Oct 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470296; cv=none; b=H3uK90N2XwxG+eVGQQdY4Pgh/NjPEIBMxDduE6NmiU45UQAmMV/9pf6Va8sfyCBSpM7qOmD8QRJav3HbLWvAL/kBQL3sXwrQ32ZDwmITa47k78Hc1MZK4udIcY2vsamOq4EGnD2XB0u38wCAjS2y+s7S8Z5SGSdEPxtLXZAdAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470296; c=relaxed/simple;
	bh=Bh+XjD17aMUarcdTO7uSWw8kcbNLHSX05G1HB+CCinQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIy7dcsV5xpiZzmMnyPB3kdokmJYuKTPtm2/1jpY8uZjhhpJdzzQvw+VeoAaYcvjARlQ4Yfxi6Ic3ofMK1nlXCx3K5TJ5AM43uEkRJ1aQ7PDJp1tbKsye3EPnQOeUmQtfwIipr6Xi/8S0/iRme17GHYDWJsjVs3b18faC0CW1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uDEQ0r7U; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDEQ0r7U"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso6673615276.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2024 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728470292; x=1729075092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3VJeVYBfKYnkpG7DLQGKL9U1kDI2Y0lA6CnEfPiWNjA=;
        b=uDEQ0r7UsdCBEie321mD9kTD5XPt/TkiNXq0y8J1qbWoHeE6/avuS/S3XMWztUHlVW
         jaJ7iTzYjTNv9kY367j/7wtwKzJV+p0gMeW+qeido7ZYvFWadMCMI5mr4SQxOhDlWs7a
         nVGGkKI9r0YtY9sQSzuVUssQm1giDtusceDvcTiHvGIrLKQZ8ff9r5nRaCdaBLB+NjKr
         vC3fdHxsZDdz8gXPzQNYODCKCWzsuckxppF8dexeQmV4TAi+Q03blhOg5yY7uU5fN4v1
         JUWjWEfI75fbs0NZ6yjumRD1bX/xhyfGi4fz6MlXYc3x80omjnd4gVRZnQJpTyMjSi5J
         gBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728470292; x=1729075092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VJeVYBfKYnkpG7DLQGKL9U1kDI2Y0lA6CnEfPiWNjA=;
        b=Zs77lOAS02+aqDXl7LwSGZsPxlDb7mt/ScYrkihdDliNNu1OvJryNKSHEk2e1zz/S5
         4i4ognfPDM6RpmNNiKs/FmNLCF3U7ZzKdzFauRCEk87QnpHs+UP17CSP/NaOWLvsyXf/
         EFLTSggaf7RRMkGxMqsA9BGf2L3WXcZ9/m+rTTUuW3lCIa780sFJdB1tOZnrf5TpDlpu
         RuOqY8yZy5AozlaBT7vhjoANbKIa0daxalqEvKl4KQFV8dXwWLNMLxUtUX91F76ygWbG
         ekHG9vjt7ya+ehtFGvzOY6hKJ+U9RSfeyY3dcTlDMQpCzhOBUX8xU6UixHr702OCbYex
         tcBw==
X-Forwarded-Encrypted: i=1; AJvYcCUGQJg6eW2+IL8n4FR3Dy8IQ6k4Btu+GQcgG4V7Kvuk2Pqmnw5G/3Q73bbIzrJIxmYsy2zOdKfUAOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzEhb+oNfABlrdwTSzFnH+3saSTyUyG1hUYZQY1Sj9OD39Su+
	KsVdqhUYAssbCUbcJPg1+J6p6KrDHP6dxGaXoMz/SjOwrwFhJgRRrNYRBQ4/cDzSb1/1uYyWBBW
	NF7AAYN3soK0qP1HM27bXcEC0jwVqjKparNebTA==
X-Google-Smtp-Source: AGHT+IEaCqT2FEb0CIjrhdIKMtBmr3sjquXjMBesp6gahz+RMRdDBcgXZh9L7SRu1wzN7reOTF/jLVAAQ5XdWvmbnAY=
X-Received: by 2002:a05:6902:1a4a:b0:e28:67b3:d731 with SMTP id
 3f1490d57ef6-e28fe4cf0cbmr1708003276.9.1728470291883; Wed, 09 Oct 2024
 03:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <20240913102836.6144-3-victorshihgli@gmail.com> <c053b350-f1ef-4a1c-b19e-4fe704279f49@ijzerbout.nl>
In-Reply-To: <c053b350-f1ef-4a1c-b19e-4fe704279f49@ijzerbout.nl>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 12:37:36 +0200
Message-ID: <CAPDyKFpLOdydbOEe4KSmVc_C=umAieR_+Bo--JmVRDtPiX3YuQ@mail.gmail.com>
Subject: Re: [PATCH V22 02/22] mmc: core: Prepare to support SD UHS-II cards
To: Kees Bakker <kees@ijzerbout.nl>
Cc: Victor Shih <victorshihgli@gmail.com>, adrian.hunter@intel.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, dlunev@chromium.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 21:56, Kees Bakker <kees@ijzerbout.nl> wrote:
>
> Op 13-09-2024 om 12:28 schreef Victor Shih:
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > The SD UHS-II interface was introduced to the SD spec v4.00 several years
> > ago. The interface is fundamentally different from an electrical and a
> > protocol point of view, comparing to the legacy SD interface.
> >
> > However, the legacy SD protocol is supported through a specific transport
> > layer (SD-TRAN) defined in the UHS-II addendum of the spec. This allows the
> > SD card to be managed in a very similar way as a legacy SD card, hence a
> > lot of code can be re-used to support these new types of cards through the
> > mmc subsystem.
> >
> > Moreover, an SD card that supports the UHS-II interface shall also be
> > backwards compatible with the legacy SD interface, which allows a UHS-II
> > card to be inserted into a legacy slot. As a matter of fact, this is
> > already supported by mmc subsystem as of today.
> >
> > To prepare to add support for UHS-II, this change puts the basic foundation
> > in the mmc core in place, allowing it to be more easily reviewed before
> > subsequent changes implements the actual support.
> >
> > Basically, the approach here adds a new UHS-II bus_ops type and adds a
> > separate initialization path for the UHS-II card. The intent is to avoid us
> > from sprinkling the legacy initialization path, but also to simplify
> > implementation of the UHS-II specific bits.
> >
> > At this point, there is only one new host ops added to manage the various
> > ios settings needed for UHS-II. Additional host ops that are needed, are
> > being added from subsequent changes.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Updates in V10:
> >   - Drop unnecessary definitions and code.
> >
> > Updates in V9:
> >   - move sd_uhs2_operation definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >   - move uhs2_control definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >   - move mmc_host flags definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >   - move mmc_host flags MMC_UHS2_SUPPORT definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >   - move mmc_host flags MMC_UHS2_SD_TRAN definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >
> > Updates in V7:
> >   - Drop sd_uhs2_set_ios function.
> >   - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_up().
> >   - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_off().
> >   - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
> >   - Modify sd_uhs2_legacy_init to avoid sd_uhs2_reinit cycle issue.
> >
> > Updates in V4:
> >   - Re-based, updated a comment and removed white-space.
> >   - Moved MMC_VQMMC2_VOLTAGE_180 into a later patch in the series.
> >
> > ---
> >
> >   drivers/mmc/core/Makefile  |   2 +-
> >   drivers/mmc/core/core.c    |  17 ++-
> >   drivers/mmc/core/core.h    |   1 +
> >   drivers/mmc/core/sd_uhs2.c | 292 +++++++++++++++++++++++++++++++++++++
> >   include/linux/mmc/card.h   |   7 +
> >   include/linux/mmc/host.h   |  23 +++
> >   6 files changed, 340 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/mmc/core/sd_uhs2.c
> >
> > [...]
> > +/*
> > + * Run the enumeration process by sending the enumerate command to the card.
> > + * Note that, we currently support only the point to point connection, which
> > + * means only one card can be attached per host/slot.
> > + */
> > +static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
> > +{
> > +     return 0;
> > +}
> > [...]
> > +/*
> > + * Allocate the data structure for the mmc_card and run the UHS-II specific
> > + * initialization sequence.
> > + */
> > +static int sd_uhs2_init_card(struct mmc_host *host)
> > +{
> > +     struct mmc_card *card;
> > +     u32 node_id;
> > +     int err;
> > +
> > +     err = sd_uhs2_dev_init(host);
> > +     if (err)
> > +             return err;
> > +
> > +     err = sd_uhs2_enum(host, &node_id);
> node_id is still uninitialized, see implementation of sd_uhs2_enum above
> > +     if (err)
> > +             return err;
> > +
> > +     card = mmc_alloc_card(host, &sd_type);
> > +     if (IS_ERR(card))
> > +             return PTR_ERR(card);
> > +
> > +     card->uhs2_config.node_id = node_id;
> Using uninitialized node_id

I practise this should not happen as the thought is that
sd_uhs2_enum() should return an error code, unless it can provide the
node_id.

In any case, it's better to initialize node_id at declaration, so I
have amended the patch like that.

[...]

Thanks for reviewing!

Kind regards
Uffe
