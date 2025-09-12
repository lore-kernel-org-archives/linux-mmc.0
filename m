Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4531E0E8
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695517; cv=none; b=CtAM4kno9iY1mkteu9kjLLNKpP+uGP7Kmg0dOz26tBfyH+PnZSY1tYD87EnMd+vaATMy4JZq6zNDyqC/DnEA60Nt+0q2rLHkDuL/T7hoiZxka/AimFcYtTjkzS77RWezc/rdgoDFeY4pyEYYnFZXssv/GJm0e2lQ/6UYQbgGL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695517; c=relaxed/simple;
	bh=ZmHWzzMQnkNu1DQZJomGbkmqj/K7U9SR8BDRUpmOmCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uj56iqeci/wEVYZElf+TWMPDHdgpvEmH6bnRRiTXSKMi2SL24daRyiDJRvSH+OM1AOUjwyqqK5taocofN2KB/3vBDmKHX+Kvugr/McWpfbSVSbPGFxqX8hXY3oJEKqGxTolgEz71+eFcFwLkvCMLSEYEUDc69gn5HqRhnvWA+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHewSIw3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHewSIw3"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32dd4fa054bso1759928a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695514; x=1758300314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ivwy92WD1EdDsFvqB7Vmxor/snCn/LydEUlEddK10bc=;
        b=RHewSIw3Hle/eeJecfW0beMC5sEfzHxvb6CPV8QgVy3FYd3AJGTXYEJCRbaD4V6qKp
         orDSDmpSYBpo1G5ase89JIhQ+YMYrpW6+xyr9M+Ye+GY4lHvPEtCkUcT78lQSnT9nN9A
         dZJoFUUm9D9vOLw++yF6q4Y0kwokD9M4VBQ9RUrVleMizux9xnyBMPMca+8XhqLWuh/o
         NB6WGPKXF1REjOIgEswwueXj2uZbudVsO4mo6V5y9AXZPO5XgZ+U+6lL/zAnkls6p7VV
         KUfwpVMY7rqcVWv6k/YISAc0QNfJPrPRf5a8JJuXGOW6ai9SlwUvT+RZQ3bZZCOGdMc0
         S57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695514; x=1758300314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivwy92WD1EdDsFvqB7Vmxor/snCn/LydEUlEddK10bc=;
        b=frAwuzrasf9p5clHj9CoUfslzAxkL2XxhpJXiKqgqe8TpIQWCIULCy0UAKxdKzMDEQ
         NIkrBGDVfrNhh9r8Qw6FFBy8nlImhalRebmp+0X4PjTd+oKfQe5SEN5RkOncB/CBMD62
         xbGAY2h+TwEUJiyPDzykoNVQETX9NXrPlQTfyh3KVVom1AmTollkEAV9Ovez1ACYio/x
         bXDBBarJ2k1HfmV3y8z9b5mClPiH19GkjBqDdVo6C/xu0S/P+QRT9yMqdb7eCYQE7Idt
         E1rk/VuN7kWzhgOFQjeq2IAFhelpoTbAq6ziAtuk8UmjOwP4Xdkxt5IR5CWzkHPSHpqw
         Lvew==
X-Gm-Message-State: AOJu0Yyb1IUyh3NLysUp/kcaVcg0sr4dFlShgw2YAg3a63v/mGo96n2O
	J1EFitKlkSiQU14sR52q5nhn7nxjEkgFGcVPfYMU1BwUipkYif2hU5Ak
X-Gm-Gg: ASbGnctT/JJf6URLKDaDA5tpdIeOKCw/wzxd8TQjN2euYGpZKrKJNeLcvtBI1aYWrEu
	CSAjVqAqsS68Klf6R+OndW+UvcRToUG2v8tqYP/ZsqvuZvT2+g22YZbgnPQGPmEM9gI1k/3mX6Z
	EU2MsFcE17ZXbNZTaFkX11au5sQ1vG17YxaUgGOE7BzRaUIF1XJ30E7LDRksTAqysefMDFE+gfq
	oJpzWC+GBcysU2BKvhH7c8pkdnjx76d+uFZHB6dMMgDe75jN7N0mcdyZYHL0LZGjvealP/l4kvm
	ePU9ci6M49R1odUIIwrzD11RfPliT4RXYT1389jkgiZVftZpBRCvpYQymzm+3trqrC6VL2lVXhE
	N301s+gsSefnv03k3N91sLB8gs/EbRmaF6iXjnUJezT4X
X-Google-Smtp-Source: AGHT+IHAHN1W40y3PsT2XFdvvYnc2ao8gak7IxyVguBuuynOpLHCD0tzcr3IkKmgD/D3mfz4NQN8ew==
X-Received: by 2002:a17:90b:4d0e:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-32de4b88595mr4435665a91.2.1757695513920;
        Fri, 12 Sep 2025 09:45:13 -0700 (PDT)
Received: from localhost ([2401:c080:1400:648d:5400:4ff:feac:ea03])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd620c696sm6699045a91.7.2025.09.12.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:45:13 -0700 (PDT)
Date: Sat, 13 Sep 2025 00:45:10 +0800
From: cuu <dexterkidd@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc_spi: Fix cd-gpios for SPI SD card insertion/removal
 detection
Message-ID: <cb4iqeqwac7pv35wbs2cwkyvdztgrfke3bzmic3nnsbuulhchv@xdfrinxazr7p>
References: <20250824084736.172222-1-dexterkidd@gmail.com>
 <CAPDyKFpobot01WBzvMUH0_85aUELhtijF9Yv9giEJSworObnbA@mail.gmail.com>
 <nyiodgyzyb6f2kkjlvjdlfflfkdccr2lgnij2uxkdm4mrpznf5@srcxlmdh47da>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nyiodgyzyb6f2kkjlvjdlfflfkdccr2lgnij2uxkdm4mrpznf5@srcxlmdh47da>

On 25/09/13 12:23上午, cuu wrote:
> On 25/09/12 01:59下午, Ulf Hansson wrote:
> > On Sun, 24 Aug 2025 at 10:50, cuu <dexterkidd@gmail.com> wrote:
> > >
> > > Previously, SD cards using pure SPI protocol with mmc_spi could not
> > > reliably detect card removal via cd-gpios. This patch fixes the issue
> > > by extending the card alive check in _mmc_detect_card_removed() to
> > > include cd-gpios detection.
> > >
> > > Additionally, mmc_rescan() now includes a status probing function
> > > specific to SPI SD cards to ensure the card state is correctly updated
> > > on insertion and removal events.
> > 
> > Sorry, I don't get this.
> > 
> > What is so special with SPI cards here that makes the regular card
> > detection/removal procedures not to work?
> > 
> > Is there something wrong with mmc_sd_alive()?
> > 
> > >
> > > Signed-off-by: cuu <dexterkidd@gmail.com>
> > 
> > Please use a proper name for your sob line. I assume "cuu" is an alias, no?
> > 
> > Kind regards
> > Uffe
> > 
> > > ---
> > >  drivers/mmc/core/core.c | 15 ++++++++++++---
> > >  drivers/mmc/core/core.h |  1 +
> > >  drivers/mmc/core/mmc.c  |  8 ++++++++
> > >  3 files changed, 21 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > index 874c6fe92855..e028ec8fbf46 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -2123,6 +2123,11 @@ int _mmc_detect_card_removed(struct mmc_host *host)
> > >
> > >         ret = host->bus_ops->alive(host);
> > >
> > > +        if(mmc_host_is_spi(host)) {
> > > +               if(host->ops->get_cd){
> > > +                               ret = !host->ops->get_cd(host);
> > > +                }
> > > +        }
> > >         /*
> > >          * Card detect status and alive check may be out of sync if card is
> > >          * removed slowly, when card detect switch changes while card/slot
> > > @@ -2238,9 +2243,13 @@ void mmc_rescan(struct work_struct *work)
> > >         }
> > >
> > >         /* Verify a registered card to be functional, else remove it. */
> > > -       if (host->bus_ops)
> > > -               host->bus_ops->detect(host);
> > > -
> > > +       if (host->bus_ops){
> > > +               if (mmc_host_is_spi(host)){
> > > +                       mmc_detect_mmc(host);
> > > +               }else{
> > > +                       host->bus_ops->detect(host);
> > > +               }
> > > +       }
> > >         host->detect_change = 0;
> > >
> > >         /* if there still is a card present, stop here */
> > > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > > index 622085cd766f..5b48c50b5bb5 100644
> > > --- a/drivers/mmc/core/core.h
> > > +++ b/drivers/mmc/core/core.h
> > > @@ -78,6 +78,7 @@ void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> > >  int _mmc_detect_card_removed(struct mmc_host *host);
> > >  int mmc_detect_card_removed(struct mmc_host *host);
> > >
> > > +int mmc_detect_mmc(struct mmc_host *host);
> > >  int mmc_attach_mmc(struct mmc_host *host);
> > >  int mmc_attach_sd(struct mmc_host *host);
> > >  int mmc_attach_sdio(struct mmc_host *host);
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index 5be9b42d5057..e73de34e072b 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -2316,6 +2316,14 @@ static const struct mmc_bus_ops mmc_ops = {
> > >         .flush_cache = _mmc_flush_cache,
> > >  };
> > >
> > > +/*
> > > + * Export function for mmc detection
> > > + */
> > > +int mmc_detect_mmc(struct mmc_host *host){
> > > +       mmc_detect(host);
> > > +       return 0;
> > > +}
> > > +
> > >  /*
> > >   * Starting point for MMC card init.
> > >   */
> > > --
> > > 2.34.1
> > >
> 
> Hi Ulf
> 
> I worked On a PicoCalc board I added an extension board for the Raspberry Pi Zero 2W,  
> while still wanting the Zero 2W to access the PicoCalc’s own SPI-connected SD card.
> 
> Here is the DTS I wrote:
> ```
> /dts-v1/;
> /plugin/;
> 
> / {
>     compatible = "brcm,bcm2835";
> 
>     fragment@0 {
>         target = <&spidev0>;
>         __overlay__ {
>             status = "disabled";
>         };
>     };
> 
>     fragment@1 {
>         target = <&spi1>;
>         __overlay__ {
>             status = "okay";
> 
>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             sdslot@0 {
>                 compatible = "mmc-spi-slot";
>                 reg = <0>;                        // SPI CS0
>                 voltage-ranges = <3300 3300>;
>                 spi-max-frequency = <8000000>;
>                 gpios = <&gpio 6 1>;
>                 cd-gpios = <&gpio 6 1>;
>             };
>         };
>     };
> };
> ```
> 
> With this setup, card insertion is detected, but removal is not.  
> From what I can tell, `mmc_sd_alive()` itself is fine, but it seems does 
> not check the state of `cd-gpios`.
> 
> For removable SPI SD cards that provide `cd-gpios`, I believe relying on  
> the `cd-gpios` state may be a more direct and accurate way to determine  
> card presence.
> 
> Therefore, I added a check in `_mmc_detect_card_removed()` to handle  
> the case of SPI-protocol cards with `cd-gpios`, so that removal detection  
> can work properly.
> 
> I am not deeply familiar with the Linux kernel, so if I am wrong
> please  correct me. Thanks a lot.
> 
> Ps:
> 
> You are right and I am sorry, my sob line was wrong
> the correct version is
> ```
> Signed-off-by: dexter kidd <dexterkidd@gmail.com>
> ```
> 
> I don't know how to fix the sob line, re-send a patch to you again?
> 
> 
> Kind regards
> 

Resending my previous reply with the full CC list this time.
Apologies for the noise.

