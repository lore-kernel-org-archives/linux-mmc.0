Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="Kh3CC4hs"
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F1610C0
	for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2023 06:42:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332c0c32d19so4709534f8f.3
        for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2023 06:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701268926; x=1701873726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDawgaKO9bOyEPEa/Yo3vIWZebyfrSgz6Xg0p2qhlTA=;
        b=Kh3CC4hsZZDAv6ZEe5EdNL/qaNaaaOAmibPXcoEF7XUqZmeJ9TdLGDZ1qVPJAfJoUl
         iWoklNYll2MFMbjBFi0QQKKlW4k3Pg+U+94w2ZcTL5Xv9x0q3qkYhxnlAb8gpE9myI7u
         N3xnedfPnB/ivxbhpFX/2Uh68D0jSEeeu/T6V2UVOyuBOpGCqN4fnz7KC0/ECohYbib5
         9a58oxdwqaZdr1LZOhkuF5EXxf6A+86lXsKbiw+Go45XRu/ElwQYAbQ8zMZWlSPspI8U
         /NDCFCcvmPyREd3GtkgcCLjihiNqh3+7tjlPMuKQqCylg/d5IRs1dLzUWRsbFsTZk3bF
         7FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268926; x=1701873726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDawgaKO9bOyEPEa/Yo3vIWZebyfrSgz6Xg0p2qhlTA=;
        b=YtN/oa3acGoKJAPmRvhgMT1oKGIM77rqgKTCGi7+WzIVLVx8E2RuF/3C6ZsPSfbFkL
         qlUGX9wx0Z/GbqcgMnc1BshEtE8r96tNvJMt+RW47ro7xMY8OQoMpPtMsZXGMRQphsUU
         NVyXXmu0xBI689lC/Qx2rqiHax+onZLboC8fnLy3nmMzLI/wHno5MS9UuDOhckxq9tTE
         aNARGAdSX+yaZGehFV9Gj8BW7BX/noS4azi+SpRXiRgeXtnfAj7yt36Ar5M5Kh6Ta3Zd
         xeU1rpycQQZqs3+u9yQ0BVhiY2tiAMGOcHYyPITBoC8/g9UnrEuiwna254dN+hkiCebY
         ECCA==
X-Gm-Message-State: AOJu0YySYY/x2b/If4uAvUXxDaeixTTAAOv7fvartOdEOxm4rLXZRuTJ
	W8EvBZRi0lknotF75sx5PCTI+A==
X-Google-Smtp-Source: AGHT+IE1UstuUrCAEpJ83OsWvDZt3bUHv1jHnmiWwiUh+B63lX+u7BESc63x+3uJCo1ai4LlfTdNdA==
X-Received: by 2002:a05:6000:180f:b0:332:f889:39f7 with SMTP id m15-20020a056000180f00b00332f88939f7mr9676195wrh.10.1701268925589;
        Wed, 29 Nov 2023 06:42:05 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00332fda15055sm10106814wri.111.2023.11.29.06.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:42:04 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Wed, 29 Nov 2023 15:42:03 +0100
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>, ulf.hansson@linaro.org,
	adrian.hunter@intel.com, CLoehle@hyperstone.com,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Message-ID: <ZWdNu5l8U++Z6h6t@trax>
References: <20231129094350.2605322-1-jorge@foundries.io>
 <e159b627-22d4-489d-89a0-4de3be9af99b@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e159b627-22d4-489d-89a0-4de3be9af99b@arm.com>

On 29/11/23 10:32:41, Christian Loehle wrote:
> On 29/11/2023 09:43, Jorge Ramirez-Ortiz wrote:
> > On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
> > re-tune before switching to the RPMB partition would randomly cause
> > subsequent RPMB requests to fail with EILSEQ:
> > * data error -84, tigggered in __mmc_blk_ioctl_cmd()
> >
> > This commit skips the retune when switching to RPMB.
> > Tested over several days with per minute RPMB reads.
> >
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  drivers/mmc/core/block.c  | 6 +++++-
> >  drivers/mmc/core/card.h   | 7 +++++++
> >  drivers/mmc/core/quirks.h | 7 +++++++
> >  include/linux/mmc/card.h  | 1 +
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 152dfe593c43..9b7ba6562a3b 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -860,6 +860,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
> >  				return ret;
> >  		}
> >  		mmc_retune_pause(card->host);
> > +
> > +		/* Do not force retune before RPMB switch */
> > +		if (mmc_can_retune(card->host) &&
> > +		    mmc_card_broken_rpmb_retune(card))
> > +			card->host->need_retune = 0;
> >  	}
>
> Is this just an issue for rpmb switches or did you try other non-rpmb
> partition switches, too?

I only tried the reported failure case (ie, RPMB switch).This failure
case came from a product verification team so I believe all the other
scenarios should be functional - other than RPMB accesses (these tests
started a few months ago), no other issues have been reported from eMMC
validation in the last couple of years.

Is there some additional check/test you would like to see done? if so,
please could you let me know how to trigger them?

> And only HS200 or that's just what you tested with?

Yes that is just the product configuration; so the only one I tested.

The host controller is sdhci-of-arasan for xlnx,zynqmp-8.9a. I inspected
the driver history and auto-tuning was extended to support ZynqMP (DLL
reset) some years ago so I believe tuning itself should be fine.

I am referring to commit 8d2e334377dbe645415fbe031711324bc2281907 "mmc:
sdhci-of-arasan: Add support for DLL reset for ZynqMP platforms "

>
> >
> >  	return ret;
> > @@ -3143,4 +3148,3 @@ module_exit(mmc_blk_exit);
> >
> >  MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
> > -
> > diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> > index b7754a1b8d97..1e1555a15de9 100644
> > --- a/drivers/mmc/core/card.h
> > +++ b/drivers/mmc/core/card.h
> > @@ -85,6 +85,7 @@ struct mmc_fixup {
> >  #define CID_MANFID_MICRON       0x13
> >  #define CID_MANFID_SAMSUNG      0x15
> >  #define CID_MANFID_APACER       0x27

I had to add another ID for SanDisk - maybe 0x45 is for Industrial
controllers? do you know?
> > +#define CID_MANFID_SANDISK2     0x45

> >  #define CID_MANFID_KINGSTON     0x70
> >  #define CID_MANFID_HYNIX	0x90
> >  #define CID_MANFID_KINGSTON_SD	0x9F
> > @@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
> >  {
> >  	return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
> >  }
> > +
> > +static inline int mmc_card_broken_rpmb_retune(const struct mmc_card *c)
> > +{
> > +	return c->quirks & MMC_QUIRK_BROKEN_RPMB_RETUNE;
> > +}
> > +
> >  #endif
> > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > index cca71867bc4a..35dfc8437d29 100644
> > --- a/drivers/mmc/core/quirks.h
> > +++ b/drivers/mmc/core/quirks.h
> > @@ -130,6 +130,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
> >  	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> >  		  MMC_QUIRK_BROKEN_SD_DISCARD),
> >
> > +	/*
> > +	 * SanDisk iNAND 7250 DDG4064, this quirk shall disable the retune
> > +	 * operation enforced by default when switching to RPMB.
> > +	 */
> > +	MMC_FIXUP("DG4064", CIF_MANFID_SANDISK2, 0x100, add_quirk_mmc,
> > +		  MMC_QUIRK_BROKEN_RPMB_RETUNE),
> > +
> >  	END_FIXUP
> >  };
> >
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 7b12eebc5586..bd6986189e8b 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -296,6 +296,7 @@ struct mmc_card {
> >  #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
> >  #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
> >  #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
> > +#define MMC_QUIRK_BROKEN_RPMB_RETUNE	(1<<17) /* Don't force a retune before switching to RPMB */
> >
> >  	bool			written_flag;	/* Indicates eMMC has been written since power on */
> >  	bool			reenable_cmdq;	/* Re-enable Command Queue */
> > --
> > 2.34.1
>
