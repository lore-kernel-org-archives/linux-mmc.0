Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638A261588;
	Thu, 10 Jul 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154573; cv=none; b=LXOo47WlgAASWCeeSOIAn180Lbt3DD7J4mYlruuwJUHDcPWAT9aXDZRdbTGAf8lbfFnIQNhWNjBWFgXRSAIetsMfLk22TwqvT1YLEJLhtQvDJ9W2S0DGjncKzy7HPUMw8zBJKfbE/lYtozRuUm5LEZKsdgcNpQoTNS8Z3xGkQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154573; c=relaxed/simple;
	bh=sHYErsaISg+JEDCMHjENgDmRI113up2ilqfeDAvXGhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNQXu+QN1sIMHs+QOz0I3/tu0ZdCbXR+p1ZEaRk9zw1CDU9wxh9DMM/LtwTWy3QBNPGeKsM41/iGAIHBFAYiCmCH84572NxToNXYpwkOMKB+xc//l/hIhZXJ0eSUyX3MUKAUapTkGCILR90hp2+En/r0JR3bR4bRbCs6v7NyQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gHU6AxGK; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gHU6AxGK"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C6C843865;
	Thu, 10 Jul 2025 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752154567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5Y3YaPvhaFvXrIQ8EoGfKQ12UoZ0NZinu7gdcixP2s=;
	b=gHU6AxGKFelsF4P5ZQQkjMm+peUHlzuHT/4FOVKcUrGu6MDIgJdYH27sTt1IQewLwRW7b9
	m/Te/xtNITBmnOibpE7uTt5lheebfg3oaH/Xa4J5J2RPy6UR93Iffm5F2HXiFLMYlP1JQF
	FUmD24VpJL7N8Fr9XiBFtlt7HASAgfahqa5W/XtPiIFKBRpRAYfy53BVNTP5IFfvYVW6DG
	Bg/tgar2RlmE3JqAoF/aB0O1DjmymYWBVNH2dVqlaqZTUb+0mFiyvzUJFBu7De/ZWsIKVH
	VF3FuOxOy2u9m8CukXUGK9nx8LGpKUtTCYA6kyyaPRy6UXvw4ujj8cqZ57Bh4g==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/4] mmc: core: add mmc_read_blocks to mmc_ops
Date: Thu, 10 Jul 2025 15:36:06 +0200
Message-ID: <9903989.eNJFYEL58v@benoit.monin>
In-Reply-To:
 <CAPDyKFp=fvyUhkeiw5TmYbELM+MiC8Do20afrainOyq_pLvSHw@mail.gmail.com>
References:
 <cover.1751898225.git.benoit.monin@bootlin.com>
 <346c422139b658b2ba6272f7ba7b07374008760f.1751898225.git.benoit.monin@bootlin.com>
 <CAPDyKFp=fvyUhkeiw5TmYbELM+MiC8Do20afrainOyq_pLvSHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepuegvnhhofphtucfoohhnihhnuceosggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvtdetudelkeeuteffgeduleettdefieegfeffteehvdevudetjeefvdffveduueenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehpdhhvghlohepfhhrrghmvgifohhrkhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmhgts
 ehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhlrgguihhmihhrrdhkohhnughrrghtihgvvhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepthgrfihfihhkrdgsrgihohhukhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: benoit.monin@bootlin.com

Hi Ulf,

Thanks for the review.

On Wednesday, 9 July 2025 at 16:46:45 CEST, Ulf Hansson wrote:
> On Mon, 7 Jul 2025 at 17:24, Beno=C3=AEt Monin <benoit.monin@bootlin.com>=
 wrote:
> >
> > Add a generic function to read some blocks of data from the MMC, to be
> > used by drivers as part of their tuning.
> >
> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> > ---
> >  drivers/mmc/core/card.h    | 10 ++++++
> >  drivers/mmc/core/mmc_ops.c | 69 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/host.h   |  3 ++
> >  3 files changed, 82 insertions(+)
> >
> > diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> > index 9cbdd240c3a7d..93fd502c1f5fc 100644
> > --- a/drivers/mmc/core/card.h
> > +++ b/drivers/mmc/core/card.h
> > @@ -11,6 +11,7 @@
> >  #define _MMC_CORE_CARD_H
> >
> >  #include <linux/mmc/card.h>
> > +#include <linux/mmc/mmc.h>
> >
> >  #define mmc_card_name(c)       ((c)->cid.prod_name)
> >  #define mmc_card_id(c)         (dev_name(&(c)->dev))
> > @@ -300,4 +301,13 @@ static inline int mmc_card_no_uhs_ddr50_tuning(con=
st struct mmc_card *c)
> >         return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
> >  }
> >
> > +static inline bool mmc_card_can_cmd23(struct mmc_card *card)
> > +{
> > +       return ((mmc_card_mmc(card) &&
> > +                card->csd.mmca_vsn >=3D CSD_SPEC_VER_3) ||
> > +               (mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
> > +                card->scr.cmds & SD_SCR_CMD23_SUPPORT)) &&
> > +               !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);
>=20
> First, please make the above part a separate patch. It makes sense to
> add a helper for this, as you show in patch3 and patch4. I also
> recommend that these patches should also be re-ordered so they come
> first in the series.
>=20
> Second, I don't think we should mix mmc_card_can* functions with the
> card-quirks. Better to have two separate helpers, especially since
> CMD23 is used for other things too, like RPMB and reliable writes, for
> example. Thus I suggest we add:
>=20
> mmc_card_can_cmd23() - which looks at what the card supports, similar
> to above without MMC_QUIRK_BLK_NO_CMD23. Put the definition in
> drivers/mmc/core/core.h and export the symbols, similar to what we do
> for mmc_card_can_erase() and friends.
>=20
> mmc_card_broken_blk_cmd23() - which should only check
> MMC_QUIRK_BLK_NO_CMD23. This belongs in drivers/mmc/core/card.h.
>=20
Ok, I will do that.

> > +}
> > +
> >  #endif
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index 66283825513cb..848d8aa3ff2b5 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -1077,3 +1077,72 @@ int mmc_sanitize(struct mmc_card *card, unsigned=
 int timeout_ms)
> >         return err;
> >  }
> >  EXPORT_SYMBOL_GPL(mmc_sanitize);
> > +
> > +/**
> > + * mmc_read_blocks() - read data blocks from the mmc
> > + * @card: mmc card to read from, can be NULL
> > + * @host: mmc host doing the read
> > + * @blksz: data block size
> > + * @blocks: number of blocks to read
> > + * @blk_addr: first block address
> > + * @buf: output buffer
> > + * @len: size of the buffer
> > + *
> > + * Read one or more blocks of data from the mmc. This is a low-level h=
elper for
> > + * tuning operation. If card is NULL, it is assumed that CMD23 can be =
used for
> > + * multi-block read.
> > + *
> > + * Return: 0 in case of success, otherwise -EIO
> > + */
> > +int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
> > +                   unsigned int blksz, unsigned int blocks,
> > +                   unsigned int blk_addr, void *buf, unsigned int len)
> > +{
> > +       struct mmc_request mrq =3D {};
> > +       struct mmc_command sbc =3D {};
> > +       struct mmc_command cmd =3D {};
> > +       struct mmc_command stop =3D {};
> > +       struct mmc_data data =3D {};
> > +       struct scatterlist sg;
> > +
> > +       if (blocks > 1) {
> > +               if (mmc_host_can_cmd23(host) &&
> > +                   (!card || mmc_card_can_cmd23(card))) {
> > +                       mrq.sbc =3D &sbc;
> > +                       sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> > +                       sbc.arg =3D blocks;
> > +                       sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> > +               }
> > +               cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
> > +               mrq.stop =3D &stop;
> > +               stop.opcode =3D MMC_STOP_TRANSMISSION;
> > +               stop.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> > +       } else {
> > +               cmd.opcode =3D MMC_READ_SINGLE_BLOCK;
> > +       }
> > +
> > +       mrq.cmd =3D &cmd;
> > +       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > +
> > +       mrq.data =3D &data;
> > +       data.flags =3D MMC_DATA_READ;
> > +       data.blksz =3D blksz;
> > +       data.blocks =3D blocks;
> > +       data.blk_addr =3D blk_addr;
> > +       data.sg =3D &sg;
> > +       data.sg_len =3D 1;
> > +       if (card)
> > +               mmc_set_data_timeout(&data, card);
> > +       else
> > +               data.timeout_ns =3D 1000000000;
> > +
> > +       sg_init_one(&sg, buf, len);
> > +
> > +       mmc_wait_for_req(host, &mrq);
> > +
> > +       if (sbc.error || cmd.error || data.error)
> > +               return -EIO;
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mmc_read_blocks);
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 68f09a955a902..72196817a6f0f 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -743,5 +743,8 @@ int mmc_send_status(struct mmc_card *card, u32 *sta=
tus);
> >  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
> >  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
> >  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> > +int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
> > +                   unsigned int blksz, unsigned int blocks,
> > +                   unsigned int blk_addr, void *buf, unsigned int len);
>=20
> I really think we must avoid exporting such a generic function. This
> becomes visible outside the mmc subsystem and I am worried that it
> will be abused.
>=20
> Can we perhaps make it harder to integrate with the tuning support on
> the core, somehow? I haven't thought much about it, but maybe you can
> propose something along those lines - otherwise I will try to think of
> another way to do it.
>=20
I agree that the function might be too generic now. Here are some of
the ideas I have to make less appealing for abuse:

* Rename it to mention tuning (mmc_tuning_read?)
* Drop some parameters:
  * blk_addr: Reading from 0 should be all that is needed for tuning
  * other?
* Move its declaration to a header private to drivers/mmc (where?)

Let me know what you think.

> >
> >  #endif /* LINUX_MMC_HOST_H */
>=20
> Kind regards
> Uffe
>=20

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



