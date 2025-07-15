Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730F20E710
	for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594903; cv=none; b=ZESv+CCXd7S9Vf46tovJNWJPWZNnm/9kvPt+tOcLpe/XxkFnMrMyGdy14eRmGHFCle09QM0mI1ejfdVyJAMG4mLFy6W6cUzz1GXhdAjLcIbSqY7qUUsrD13Jp5IU284qfcTggj970PGwmIdk3BjuFtQrHq9Ec4baVm4X1EA/fOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594903; c=relaxed/simple;
	bh=8nDABm0QbpFqbV6qcagQDzdLTlD790+/qH/YPHReYvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpUQpeKpK79ktCn6hEJX6dGxZOHWS/oCDAY6ct8rhVmCxxSugMgLjM8UPntvM5Icx01NMGojIv10NvRYF2mNwnISFU6iRpl5P6nt+Ot3rXhX0hxb8IkIdPIoBED1oMnLUTbUArGVp2905vsqZtz3pTtjr1gOEkcmKRfQiaHKbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmA8NgHU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmA8NgHU"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e87c86845d9so4147413276.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2025 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752594901; x=1753199701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WB3s2HCYz/rePzCmNFi6RGTxoEWHz7E/oKmgCMbGRhw=;
        b=UmA8NgHUuHeRF2Y7PplUKo6i4UyA1oCg0kEXuhc7Fmjz1lKawmFR8IO4aODYLJcErw
         0P21b92+TS7d85yg0GMrChM9eSYEDXDNWSoW2/+w6ruLL6jvt1F1osP4SLIO67q+AkY3
         pnTk17MTWquIYVxV31U+Txnygyd1xbOCVPciTF1hhpHQDRx8Gy6yGZ9+4pst599uHcEn
         3bnkkIhUX5NM4Fp7/QCGgT+MDyH8JpREOtw4PusiFjjOeXBbpD8ieIDb/OreW5Htoig8
         5mRdj5eFoGuB+aneEgpFDbWOEf9HyezOfRwJRtZUWoTZZMdV6UKG5uuh8XeK5PV9f0qQ
         zk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594901; x=1753199701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WB3s2HCYz/rePzCmNFi6RGTxoEWHz7E/oKmgCMbGRhw=;
        b=F2tBTIFertE4HMJpLoKyFWd5C84qvEINZykr0wHU/bRQzJ6gCy/HGGnczgK6FT/OUp
         u66Trffekv7wJE8w0oWvskU09s5Kgm44KSyBHN6a07IJEG+sLivuQi/qfiBwgY0ix5HE
         0FWJKsuCo6a01XUMas8kAbxuMWRZZ9JoGKLA729qGXTlcmkIbDRFFIaoyLLUQ3gD1zRO
         7yQFEwVe3mWtb8cXiAwXDwUcI5EltwUA4OO3RL4JHS7y0H6C1QcaGr8Aww6sDSV3iroZ
         XNScJtOeDMMY3jX7ToqsNgxfXykj5cXHbljqN5rKz+Jl8+bw3UrombiovvH9C+36T0EU
         CdMg==
X-Forwarded-Encrypted: i=1; AJvYcCUDVlL+/u5S+xy/gnau3pFKwVd84fpSvP8KsL1Z9I0S0GP1BITC96Iu+ZhLFK52GDGqj3zxy45QGDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsQQp6qxxEHEk2ItEnpWl/6v3HZXHbRXopIWq8RfoTXJtuJ50
	y6hcV/Bei77hGY1JruJkXrUDLqo6tJgHYGAyN4mPns1iz7lgI8SZMoEFIIsJ5DmGagK7ZcotwFd
	nrcCYHz61SOZzMIqWnJicC9EXlx5vl/za+IB4lxgr8w==
X-Gm-Gg: ASbGncuCTwpcHDZlogqYlpwyg6yUp/4Su7TS1RR5y6a3oI/HCLLGr1VRfX9AmSVW+2O
	7QqJmlsCCmRvuZabUxeLC1xY+C5gVf9AwEJ69HorE2mcqYN1eFFGnMuIkJd3YfPmEqf9qiYkFU9
	37mbY6Ih/tDflBMgliDAJsFPqKHhjzvlHp6RiExDxSdEHLjSUgteAL0bUJ0N902Igkn0LNYGoa8
	De1H7mG
X-Google-Smtp-Source: AGHT+IF1zRZ4skb16lO7Hz3y8JhqIcAOzt8qRIIDde8w36pNgo8eApgWcC7+yzMMUrZ+UWRcK6MKeJzPo48e26m579o=
X-Received: by 2002:a05:690c:7107:b0:710:edee:74d1 with SMTP id
 00721157ae682-717dac32e5dmr223745117b3.3.1752594900738; Tue, 15 Jul 2025
 08:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751898225.git.benoit.monin@bootlin.com>
 <346c422139b658b2ba6272f7ba7b07374008760f.1751898225.git.benoit.monin@bootlin.com>
 <CAPDyKFp=fvyUhkeiw5TmYbELM+MiC8Do20afrainOyq_pLvSHw@mail.gmail.com> <9903989.eNJFYEL58v@benoit.monin>
In-Reply-To: <9903989.eNJFYEL58v@benoit.monin>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 17:54:24 +0200
X-Gm-Features: Ac12FXwa445k2oQ0FhDy7MdRUFjaFWJ6sZOak3AH4hAUxkdrNU2ydphifvnNNxs
Message-ID: <CAPDyKFpK11BZDT_NmWyMe6Tvj8P3gJNBpM_hX5d52urG+sn6-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: core: add mmc_read_blocks to mmc_ops
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

> > > +}
> > > +
> > >  #endif
> > > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > > index 66283825513cb..848d8aa3ff2b5 100644
> > > --- a/drivers/mmc/core/mmc_ops.c
> > > +++ b/drivers/mmc/core/mmc_ops.c
> > > @@ -1077,3 +1077,72 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
> > >         return err;
> > >  }
> > >  EXPORT_SYMBOL_GPL(mmc_sanitize);
> > > +
> > > +/**
> > > + * mmc_read_blocks() - read data blocks from the mmc
> > > + * @card: mmc card to read from, can be NULL
> > > + * @host: mmc host doing the read
> > > + * @blksz: data block size
> > > + * @blocks: number of blocks to read
> > > + * @blk_addr: first block address
> > > + * @buf: output buffer
> > > + * @len: size of the buffer
> > > + *
> > > + * Read one or more blocks of data from the mmc. This is a low-level helper for
> > > + * tuning operation. If card is NULL, it is assumed that CMD23 can be used for
> > > + * multi-block read.
> > > + *
> > > + * Return: 0 in case of success, otherwise -EIO
> > > + */
> > > +int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
> > > +                   unsigned int blksz, unsigned int blocks,
> > > +                   unsigned int blk_addr, void *buf, unsigned int len)
> > > +{
> > > +       struct mmc_request mrq = {};
> > > +       struct mmc_command sbc = {};
> > > +       struct mmc_command cmd = {};
> > > +       struct mmc_command stop = {};
> > > +       struct mmc_data data = {};
> > > +       struct scatterlist sg;
> > > +
> > > +       if (blocks > 1) {
> > > +               if (mmc_host_can_cmd23(host) &&
> > > +                   (!card || mmc_card_can_cmd23(card))) {
> > > +                       mrq.sbc = &sbc;
> > > +                       sbc.opcode = MMC_SET_BLOCK_COUNT;
> > > +                       sbc.arg = blocks;
> > > +                       sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > > +               }
> > > +               cmd.opcode = MMC_READ_MULTIPLE_BLOCK;
> > > +               mrq.stop = &stop;
> > > +               stop.opcode = MMC_STOP_TRANSMISSION;
> > > +               stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> > > +       } else {
> > > +               cmd.opcode = MMC_READ_SINGLE_BLOCK;
> > > +       }
> > > +
> > > +       mrq.cmd = &cmd;
> > > +       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > > +
> > > +       mrq.data = &data;
> > > +       data.flags = MMC_DATA_READ;
> > > +       data.blksz = blksz;
> > > +       data.blocks = blocks;
> > > +       data.blk_addr = blk_addr;
> > > +       data.sg = &sg;
> > > +       data.sg_len = 1;
> > > +       if (card)
> > > +               mmc_set_data_timeout(&data, card);
> > > +       else
> > > +               data.timeout_ns = 1000000000;
> > > +
> > > +       sg_init_one(&sg, buf, len);
> > > +
> > > +       mmc_wait_for_req(host, &mrq);
> > > +
> > > +       if (sbc.error || cmd.error || data.error)
> > > +               return -EIO;
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(mmc_read_blocks);
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index 68f09a955a902..72196817a6f0f 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -743,5 +743,8 @@ int mmc_send_status(struct mmc_card *card, u32 *status);
> > >  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
> > >  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
> > >  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> > > +int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
> > > +                   unsigned int blksz, unsigned int blocks,
> > > +                   unsigned int blk_addr, void *buf, unsigned int len);
> >
> > I really think we must avoid exporting such a generic function. This
> > becomes visible outside the mmc subsystem and I am worried that it
> > will be abused.
> >
> > Can we perhaps make it harder to integrate with the tuning support on
> > the core, somehow? I haven't thought much about it, but maybe you can
> > propose something along those lines - otherwise I will try to think of
> > another way to do it.
> >
> I agree that the function might be too generic now. Here are some of
> the ideas I have to make less appealing for abuse:
>
> * Rename it to mention tuning (mmc_tuning_read?)

Yes, something like that or possibly "mmc_read_tuning".

> * Drop some parameters:
>   * blk_addr: Reading from 0 should be all that is needed for tuning
>   * other?

Yes, I like that. If we can make it useful only for the tuning case,
that would be great.

I think we should drop struct mmc_card* too. The ->execute_tuning()
host ops takes a struct mmc_host* and during initialization when the
callback is invoked from the core, host->card has not yet been set. In
other words, there are no "card" available for the host to use.

Moreover, do we really need to pass along the data that we have read?
Can't we just alloc the buffer, read the data and free the buffer. The
important part is to provide an error code to the caller, letting it
know whether we succeeded in reading the data or whether it failed,
right?

> * Move its declaration to a header private to drivers/mmc (where?)

Unfortunately not, we currently don't have any other suitable place,
but next to mmc_get_ext_csd().

>
> Let me know what you think.
>

Kind regards
Uffe
