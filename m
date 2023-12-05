Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="Ba5MuIdF"
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2218D
	for <linux-mmc@vger.kernel.org>; Tue,  5 Dec 2023 08:10:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so5120755f8f.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 Dec 2023 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701792604; x=1702397404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdrpO8C0nU4ljU4ooPjskl+QNi6RFyVvcGgF3Sty5jA=;
        b=Ba5MuIdF4U+NnpyoFjfElzDxb9c5FXXRQ1M49oAh1CfjMDF079zjnJRRwxaxjWoRWv
         RArBWuMaQ5oJYiYq+hhCK+bwo23gsLV5NfMglE3fqQvEkEh0XQ6pORaU6lS459FMH2D0
         KlHvd6aOTR2OJJe6v28AA0vzxRB598Ck8Nyi9edLQdSRW8DvRPSQHwPvVbxVEbCvX6Z/
         G9DouKbQChX5KYmvjXRIlw9dvfOT12xDw5nxrc7FdGpV6UHi5Ebv9zO/AwXuYdw6GAGH
         qwMJsZ+WN3hJjXR4AMwQ/tnB42DVnvDjMhWQst3nmaGTqnPze5TLk5qJ/2tIVmR3tGYx
         Afsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792604; x=1702397404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdrpO8C0nU4ljU4ooPjskl+QNi6RFyVvcGgF3Sty5jA=;
        b=kGzFPUHxyAEXvs8Cekx5tBYs86IQuR+x6hMmHIOJIecxaIWlyoXMjKQfUYHUUg1CfJ
         XNFLXTysaSIbCQiKYyqTd3QmwP4vCOVlLfFWa+BRJX7FTYUTO6yBBOj1cGRawvM2Rh+L
         nkGTmII5b50SI2zuashRbQo8zx7InQJY4eWInqEEs0Pq3VjouZ4DStCV6MOqicCxre2y
         cA955c9qcFNyw3AjzN/oviowrZMx37wjeamOxA0IPzBbJoXyzXAMWwWFES97vCcvYXTo
         2LR2vhK80ZkzOnoNv++vmgt3ap5VsDVT5GCZXGxoDNrR8hT5+W7Hy2Fc0zbAaS9P8Tlf
         Bh9w==
X-Gm-Message-State: AOJu0Yy59QQzLWa3G8cBuHH7VGpz7CAR3lJU/G9knJ1n/v9SiEcPxN8r
	IZr8ajF8Ru7N82l/bE/j4azB4Q==
X-Google-Smtp-Source: AGHT+IGzKI/9qgICgI6hzaCZ6WXjGUwnD39wKIQydbCs838fDoa9j5N4kkchpcnNi9FNxJDE48HHUw==
X-Received: by 2002:a5d:5691:0:b0:332:ffdb:e9ad with SMTP id f17-20020a5d5691000000b00332ffdbe9admr3124222wrv.46.1701792604504;
        Tue, 05 Dec 2023 08:10:04 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600002a700b00332eb16d215sm14913576wry.23.2023.12.05.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:10:04 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Tue, 5 Dec 2023 17:10:02 +0100
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Avri Altman <Avri.Altman@wdc.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"christian.loehle@arm.com" <christian.loehle@arm.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"beanhuo@micron.com" <beanhuo@micron.com>,
	"yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
	"victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
	"asuk4.q@gmail.com" <asuk4.q@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"yebin10@huawei.com" <yebin10@huawei.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Message-ID: <ZW9LWrlYa2+lUcVc@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <DM6PR04MB657532850510D64BA7D62297FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZW4W6aZq+0DCmVTi@trax>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW4W6aZq+0DCmVTi@trax>

On 04/12/23 19:14:01, Jorge Ramirez-Ortiz, Foundries wrote:
> On 04/12/23 17:58:45, Avri Altman wrote:
> > >
> > > Requesting a retune before switching to the RPMB partition has been
> > > observed to cause CRC errors on the RPMB reads (-EILSEQ).
> > >
> > > Since RPMB reads can not be retried, the clients would be directly affected by
> > > the errors.
> > >
> > > This commit disables the request prior to RPMB switching while allowing the
> > > pause interface to still request a retune before the pause for other use cases.
> > >
> > > This was verified with the sdhci-of-arasan driver (ZynqMP) configured for
> > > HS200 using two separate eMMC cards (DG4064 and 064GB2). In both cases,
> > > the error was easy to reproduce triggering every few tenths of reads.
> > >
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > ---
> > >  drivers/mmc/core/block.c | 2 +-
> > >  drivers/mmc/core/host.c  | 7 ++++---
> > >  drivers/mmc/core/host.h  | 2 +-
> > >  3 files changed, 6 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > > f9a5cffa64b1..1d69078ad9b2 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card
> > > *card,
> > >                         if (ret)
> > >                                 return ret;
> > >                 }
> > > -               mmc_retune_pause(card->host);
> > > +               mmc_retune_pause(card->host, false);
> > >         }
> > >
> > >         return ret;
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> > > 096093f7be00..a9b95aaa2235 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)
> > >
> > >  /*
> > >   * Pause re-tuning for a small set of operations.  The pause begins after the
> > > - * next command and after first doing re-tuning.
> > > + * next command and, if retune is set, after first doing re-tuning.
> > >   */
> > > -void mmc_retune_pause(struct mmc_host *host)
> > > +void mmc_retune_pause(struct mmc_host *host, bool retune)
> > >  {
> > Since mmc_blk_part_switch_pre is the only caller of mmc_retune_pause,
> > How about just move those lines into it?
>
> +1 from me
>
> I wasnt sure if there was some other plan for mmc_retune_pause in the
> future hence why I didnt remove it and extended it instead.
>
> Should I wait for Adrian's confirmation or just go ahead?.

just making sure this is not falling through the cracks.
