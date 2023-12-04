Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="dUUHa6RY"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D9DCA
	for <linux-mmc@vger.kernel.org>; Mon,  4 Dec 2023 10:14:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso43175905e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Dec 2023 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701713643; x=1702318443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6Ysu3ckmP8RjbD8nV6PK1Q2tvFrfhEG4JhXPRcZ6h4=;
        b=dUUHa6RYmMlw45haIp7frEbwxgqhTedfSIhDquoIBX+H3DhIyhrFcbkcdYf1s5l4Fy
         lphSoPlWsx80O6rgtAA5sSz+JheuWJoPUOj2pLOJxuyVlFrdna4gN5WAGn7S5cB0KFxs
         LOiPA1MB2+HneZ7a9tSQ3iR/q5HGa57RRtp1c1dmLAHaibieJDN7oYgNkx+6B4cKE11p
         YOV5/zF2hVowpisJxOa8VAr3vw8X36KOCrup2YGwjJHTJNntZkeYgwQ/WJ6FZ01W7TmE
         QCGL6eq5VJcM2fX0Rg0HUErSmaSnPhpjLJYaUPfzHAjRJ/TjK/aAl5I93DxB0lXpInbB
         mp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713643; x=1702318443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6Ysu3ckmP8RjbD8nV6PK1Q2tvFrfhEG4JhXPRcZ6h4=;
        b=Q0iUbzis7AKNsICy2h5V1LKc6bXhxI+lUXzzDfdUNTceQ6nrNdvZEwBnKERNmJUGvV
         xMZFhkFVE6w2lFShUzAxCXGJQWj97K+rdU5AwEyuva2L6TJgLUGVLFKo6Jei1/FOy/PS
         Q4krzql21ALChaD+GTgv42Tet9cLYSofl1C6qKCrC2lUlCmwxsQ2Bx9/uORf8i7G+t/z
         /myDQpKozKR+k4bYHNwHb3pGSNke+Y+HfXmFamVvWtREbDZGJUZfGXtjYJtzG38Dj54J
         739TFsyxgKiMrZ+bkrcAdnQOly4JhoINaWcXLiaEX0rXzYxOhX4Ucy4YM0nL+ZQ8otmA
         8VRw==
X-Gm-Message-State: AOJu0YyRkAl40AGGPetVoh1uAjHD/7EGQA44nBl8C/C8PodIRTjhzFRn
	81KyBmSp1LcxOsXDUCzY8inD8w==
X-Google-Smtp-Source: AGHT+IGrD0jC+jESi6/UMgWfWzJaBcMPfbF6HcomwTApBWi3OHeF9DSppgOU5mx7mEFv5Ca22KaP1Q==
X-Received: by 2002:a05:600c:4747:b0:40b:5e21:cc19 with SMTP id w7-20020a05600c474700b0040b5e21cc19mr2906475wmo.68.1701713643338;
        Mon, 04 Dec 2023 10:14:03 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600001c300b003333b8eb84fsm6916316wrx.113.2023.12.04.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:14:02 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Mon, 4 Dec 2023 19:14:01 +0100
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>,
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
Message-ID: <ZW4W6aZq+0DCmVTi@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <DM6PR04MB657532850510D64BA7D62297FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB657532850510D64BA7D62297FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>

On 04/12/23 17:58:45, Avri Altman wrote:
> >
> > Requesting a retune before switching to the RPMB partition has been
> > observed to cause CRC errors on the RPMB reads (-EILSEQ).
> >
> > Since RPMB reads can not be retried, the clients would be directly affected by
> > the errors.
> >
> > This commit disables the request prior to RPMB switching while allowing the
> > pause interface to still request a retune before the pause for other use cases.
> >
> > This was verified with the sdhci-of-arasan driver (ZynqMP) configured for
> > HS200 using two separate eMMC cards (DG4064 and 064GB2). In both cases,
> > the error was easy to reproduce triggering every few tenths of reads.
> >
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  drivers/mmc/core/block.c | 2 +-
> >  drivers/mmc/core/host.c  | 7 ++++---
> >  drivers/mmc/core/host.h  | 2 +-
> >  3 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > f9a5cffa64b1..1d69078ad9b2 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card
> > *card,
> >                         if (ret)
> >                                 return ret;
> >                 }
> > -               mmc_retune_pause(card->host);
> > +               mmc_retune_pause(card->host, false);
> >         }
> >
> >         return ret;
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> > 096093f7be00..a9b95aaa2235 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)
> >
> >  /*
> >   * Pause re-tuning for a small set of operations.  The pause begins after the
> > - * next command and after first doing re-tuning.
> > + * next command and, if retune is set, after first doing re-tuning.
> >   */
> > -void mmc_retune_pause(struct mmc_host *host)
> > +void mmc_retune_pause(struct mmc_host *host, bool retune)
> >  {
> Since mmc_blk_part_switch_pre is the only caller of mmc_retune_pause,
> How about just move those lines into it?

+1 from me

I wasnt sure if there was some other plan for mmc_retune_pause in the
future hence why I didnt remove it and extended it instead.

Should I wait for Adrian's confirmation or just go ahead?.
