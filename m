Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE903C4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Jan 2022 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbiAGRJB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Jan 2022 12:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348477AbiAGRJA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2022 12:09:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE215C06173F
        for <linux-mmc@vger.kernel.org>; Fri,  7 Jan 2022 09:08:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j11so17822556lfg.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jan 2022 09:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbk4KS36tLPS9p48WD+kXKsMhjwH9p5kHyXiG3GUpc0=;
        b=LWH9pulSgdkhhmhOl+9uRUgzQ7dcRDXQBiYzFNy8zGHF+5MsaTh7A2Mw975cOHadCL
         +GVAzhWmtmFObftWPl1RoMLundRraArABEHoQeDufiZKEf1JvLl/0Qz9c/s1NOmgraec
         QgBiFjOk1oC04oHnNZ1+FtfhVmB+AG5kD3+MCaWR8u6aDq4RffDai/ir0SnaHTYGXNZD
         vWDu3yoexxceygJwIe2PAlCK16azN8y808vavCfRdpEXeTafwO87bYQWGsVvcRb7gYUo
         X2hGz7IEf0lzA6YvcxOh7wz/2nyH/32ov6IS6Kf8EPDSbAVTlzzquSkQv8nmihn7nVP/
         UrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbk4KS36tLPS9p48WD+kXKsMhjwH9p5kHyXiG3GUpc0=;
        b=k9ApTo0ECQMl3Z83SMLj1eAiS9bp5uSiYTYMpAfdxDpTneL8RF9rzXWNg3up5qxMWH
         Y/6WQhNVufPO1TeKYFKfY6fWoeeGPsEigybPMIreKVe40KlrlZW9I4l02GbU19hNxEdg
         r3bqNKCsdr3L44LeHQ7fq87whGNuCYwFs0DtCUuferQ28IjXXydZ4KdYL6x/QbEHDCcm
         pU4vuk8gGm3N73MuLipJmGImJRPZMaX2dTHSrHMgf45GOcGhbmHcfnl5E2rsmAHGYln9
         msjy4hVkcWTcYumOFICaCQ5lnm9ex9xWABnEVdG9hdBmAo6lGeOxSxHALgRl5ZuHaR7y
         XnQQ==
X-Gm-Message-State: AOAM531RlI750cI4VTUTugTe/iLzaqWG2zuux0C3TqzbAoaE1QWvV0pB
        Id+Dzn4s/rTlXekxEwcKTy/YfGNVL3msJoX/QmdjYw==
X-Google-Smtp-Source: ABdhPJw0P0y5SYv5aKKXrqUc3xiVRuOgx+5xHo5MW6inbcMwbwHySwEUgv0/wntgStLkrWMrVUhzLCz7gU6pg/6m2bs=
X-Received: by 2002:a05:6512:4015:: with SMTP id br21mr57717956lfb.233.1641575337877;
 Fri, 07 Jan 2022 09:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
 <20211203105103.11306-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoptpMeKS29qqMN1E-h_FMieHAKVvbAZ6vDAYPdSuvTqQ@mail.gmail.com>
 <CAG0XXUGKJt1AhWDmgkwT5ecrBk5eP2qrinS0_cm+J8fBWJwkVA@mail.gmail.com>
In-Reply-To: <CAG0XXUGKJt1AhWDmgkwT5ecrBk5eP2qrinS0_cm+J8fBWJwkVA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jan 2022 18:08:21 +0100
Message-ID: <CAPDyKFohVdSmRuF4DOQay7Jr7R-sEr7RfMAGB4x-j1v2TtyQtw@mail.gmail.com>
Subject: Re: [PATCH 6/7] mmc: Implement content of UHS-II card initialization functions
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Jason Lai <Jason.Lai@genesyslogic.com.tw>,
        otis.wu@genesyslogic.com.tw,
        =?UTF-8?B?6I6K5pm66YeP?= <benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 6 Jan 2022 at 11:31, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
>
> On Wed, Dec 15, 2021 at 4:29 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> >> On Fri, 3 Dec 2021 at 11:51, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> > >
> > > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> > >
> > > UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> > > Part 1 - PHY Initialization:
> > >          Every host controller may need their own avtivation operation
> > >          to establish LINK between controller and card. So we add a new
> > >          member function(uhs2_detect_init) in struct mmc_host_ops for host
> > >          controller use.
> > > Part 2 - Card Initialization:
> > >          This part can be divided into 6 substeps.
> > >          1. Send UHS-II CCMD DEVICE_INIT to card.
> > >          2. Send UHS-II CCMD ENUMERATE to card.
> > >          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
> > >             of card.
> > >          4. Host compares capabilities of host controller and  card,
> > >             then write the negotiated values to Setting field in CFG_REG
> > >             of card through UHS-II Native Write CCMD.
> > >          5. Switch host controller's clock to Range B if it is supported
> > >             by both host controller and card.
> > >          6. Execute legacy SD initialization flow.
> > > Part 3 - Provide a function to tranaform legacy SD command packet into
> > >          UHS-II SD-TRAN DCMD packet.
> > >
> > > Most of the code added above came from Intel's original patch[1].
> > >
> > > [1]
> > > https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
> > > git-send-email-yi.y.sun@intel.com/
> > >
> > > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > ---
> > >  drivers/mmc/core/sd_uhs2.c | 831 ++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 810 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > > index 24aa51a6d..d13283d54 100644
> > > --- a/drivers/mmc/core/sd_uhs2.c
> > > +++ b/drivers/mmc/core/sd_uhs2.c
> > > @@ -3,6 +3,7 @@
> > >
> > >  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> > >
> > > -static int sd_uhs2_set_ios(struct mmc_host *host)
> > > +static void sd_uhs2_set_ios(struct mmc_host *host)
> >
> > Please don't change the function to return void. It's better to allow
> > the callback to return an error code, even if that might not be of
> > benefit for your particular host variant.
>
> I have a question about the return type of this function. In
> sd_uhs2_set_ios(), we only called
> host->ops->set_ios() and the return type of that function was VOID. So
> is there a reason
> that this function must has a non-void return type?

I think the original ->set_ios() callback should have been "int"
rather than void. It's clear that those callbacks can actually fail,
but today there is no way for them to report an error.

Therefore, please use 'int'.

[...]

> > >  static int sd_uhs2_phy_init(struct mmc_host *host)
> > >  {
> > > -       return 0;
> > > +       int err = 0;
> > > +
> > > +       /*
> > > +        * Every host controller can assign its own function which is used
> > > +        * to initialize PHY.
> > > +        */
> > > +       err = host->ops->uhs2_detect_init(host)
> >
> > It looks like you didn't declare this callback as part of the struct
> > mmc_host_ops, so this does not even compile. Please fix that.
> >
> > I also suggest moving the above comment into the header file along
> > with its declaration, as it's usually where we keep this information.
> >
> > Moreover, to make it clear what the callback is intended for, I
> > suggest renaming it to "uhs2_phy_init".
>
> There are 5 callback functions for UHS-II:
>     int   uhs2_detect_init(struct mmc_host *host);
>     int   uhs2_set_reg(struct mmc_host *host, enum uhs2_action act);
>     void uhs2_disable_clk(struct mmc_host *host);
>     void uhs2_enable_clk(struct mmc_host *host);
>     void uhs2_post_attach_sd(struct mmc_host *host);
> According to your suggestion, I plan to integrate them into a single function,
> named "uhs2_do_action", since they all realize the specified function by
> setting the controller.

I don't mind that we add a few callbacks to support UHS-II, but at the
same time it gets silly to have one for each and every operation.

That said, I think the above approach that you suggest is worth a try.
Let's see what this can bring us to.

>
> > > +       if (err) {
> > > +               pr_err("%s: fail to detect UHS2!\n", mmc_hostname(host));
> >
> > Maybe "failed to initial phy for UHS-II", is better?
>
> Okay. The string will be modified in the next version.
>
> > > +       }
> > > +
> > > +       return err;
> > >  }
> > >
> > >  /*
> > > - * Do the early initialization of the card, by sending the device init
> > > -roadcast
> > > + * Do the early initialization of the card, by sending the device init broadcast
> >
> > Looks like you are correcting a spelling mistake, which is good.
> > However, please make this a part of the patch that introduced this,
> > earlier in the series.
>
> Do you mean to create a separate patch which only contains typo correction?

I would appreciate it, if you can amend my original patch to fix my mistakes.

[...]

> > > +
> > > +static int sd_uhs2_go_dormant(struct mmc_host *host, bool hibernate, u32 node_id)
> > > +{
> > > +
> > > +       if (host->ops->uhs2_disable_clk)
> >
> > Again, another callback that lacks declaration.
> >
> > > +               host->ops->uhs2_disable_clk(host);
> >
> > In fact, rather than adding another callback, we could make use of the
> > "->uhs2_set_reg" callback?
> >
> > Or, another option would be to use the ->uhs2_set_ios(). That would be
> > similar to what we do for legacy SD cards with the ->set_ios()
> > callback.
> >
> > For example, we can do like this:
> > host->ios.power_mode = MMC_POWER_ON;
> > host->ios.clock = 0;
> > host->ops->uhs2_set_ios(host, &host->ios);
> >
> > What do you think? Maybe we need a separate host->ios_uhs2 for this too?
>
> As I mentioned above, I intend to use integrated "uhs2_do_action()".
> What do you think?

As stated, seems reasonable, let's give it a try!

[...]

> > > +        * Get CID, send relative address, get CSD are the same as legacy
> > > +        * sd, call mmc_sd_init_card() in sd.c directly
> > > +        */
> > > +       err = mmc_sd_init_card(host, rocr, NULL);
> > > +       if (err) {
> > > +               pr_err("%s: %s: mmc_sd_init_card() fail!\n",
> > > +                      mmc_hostname(host), __func__);
> > > +               return err;
> > > +       }
> >
> > So this means we will start using the host callbacks for the legacy SD
> > interface, like ->set_ios() for example.
>
> I will remove this callback and reorganize codes in this portion.
>
> > In other words, data in host->ios.* seems to be used, both for UHS-II
> > and legacy SD. That can be messy for host drivers to manage, I think.
> > Maybe we should add a separate host->ios_uhs2.*, that we use solely
> > for UHS2 instead?
>
> This topic can be discussed.
> The ios structure can continue to be used after adding new definitions to
> certain fields, for example, adding MMC_TIMING_UHS2 for ios.timing.

I don't think it's going to play well for existing mmc host drivers to
use the current host->ios.*.

Let's try to add a new host->ios_uhs2.* and add the data we need for
UHS-II in there.

[...]

> I will start preparing for the next version submission after receiving
> your response to my question.
> Thank you for your patience.

Great!

If you need some additional guidance at this point, just ask.
Otherwise I will defer to review your next version of the series.

Kind regards
Uffe
