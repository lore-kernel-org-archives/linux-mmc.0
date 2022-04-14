Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A851C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Apr 2022 12:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiDNMof (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDNMof (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2022 08:44:35 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBB185677
        for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2022 05:42:10 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id x200so9095450ybe.13
        for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2022 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWHoaFeLEFyTbQyyMZYnysHFcbypFbYnnp17bmeE8xQ=;
        b=p7l+b60zoV8EbHFCYrkrlZlPGpIi6x8yNBWl2CNfMNjWqYWo5+0JSJX29HzJGVcQB5
         ut595z+qeYFPOuWeQGZJXgWkOgC3/IHNTgOB0whlz4vV1vFAewjGSI+bPeriSkBE1ors
         SNhkcd5h/pUsEhEaQ9bSUnb+lbx11CoLrNWCFPYHLGsDDGo7ONGbby5RlJj48JlnRhYV
         5ut7Ioh4IFeGTauJa3kP1oeldpO6ZVlpFhoW8FWRM5keMN57d0q11oXkHgUpecKZJ5+k
         BwrlhgG0rkDs6IktK3c/pQHCumGNJFW6ImRRbXieTqTLA3My9R16YZqjLwPnXcU0iywU
         dNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWHoaFeLEFyTbQyyMZYnysHFcbypFbYnnp17bmeE8xQ=;
        b=xNmKLknU9Oe2KZ3Y6C/SWmMb+Duj867b4BMmSUH2S0fTmJRUCcrGbrMoPqtUIysHe+
         bIQ5QXAEAPxYAsj/GlwT64G27lMIHVKqQ+d2MisiGp+2Skflm8HX3h/dxptF4oRRXcSX
         rPLM9O/uiWE68d3C2B93mqZrG9RE06lvG38qe88CpzpOzt47pmjCV6f9u1crdngqpK+U
         sb7BPZYcH6QtuMChJp2UV1NbqditaBydxSdBKre/7RjHwVvEQjgVqpZ5IRu5WQQH+R7v
         P3y/mH2KtcmIH6UmcHP9LVqZCHruV7lHZhTMZoHtvBt7GMcF1RDSLXaPc8sF9e9ZdGYA
         ylGQ==
X-Gm-Message-State: AOAM533DzFawspGpK5r/NjTj9qTQOMyJG1lYqbD2+bOX7KMyOmDqms9i
        XigBRCO7wstpTde6LnrkKjV5R0yIbd/ORaesqo53uwa5NWQ=
X-Google-Smtp-Source: ABdhPJxJFm3Mig/wp8Qk3weEhggYNpOCkLBwcj+BxLsONbFd9tMOfI8laj9GEtE4qDETKGW5svhg5rg7rhukUEYXD1Y=
X-Received: by 2002:a25:dbc4:0:b0:641:3029:179c with SMTP id
 g187-20020a25dbc4000000b006413029179cmr1480303ybf.176.1649940129201; Thu, 14
 Apr 2022 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
 <20220222033931.237638-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoDkxg1b0k4s_+F+eS8EUVM9ZabiwNc4VVQuCexLWNpsw@mail.gmail.com>
 <CAG0XXUGc4+8vF5paKZi9x=i_8pPpYcdCdh=Yr9zkLFe5MqNG0g@mail.gmail.com>
 <CAPDyKFrj8DZ0Adn7+7gND0VGFj4J2TDPdQf2Vuf7mOTJD4BY+g@mail.gmail.com>
 <CAG0XXUE_mH-=oxBZhvYphk+Pyg4QoHogFk2ifQu8eniq2vzeCQ@mail.gmail.com>
 <CAPDyKFpeXKBu_+0Ws10-EGTr6iR3VirTdg_M2CVAeqzwx6DwxA@mail.gmail.com>
 <CAG0XXUFYVjU8aMCCL_Caewdh8KZYfmxy0cSBD62jj6N7_pE2GA@mail.gmail.com> <CAPDyKFqnPhV3078w7NttmG2SQVETp2kZwjHXwshYCVgcb41cQw@mail.gmail.com>
In-Reply-To: <CAPDyKFqnPhV3078w7NttmG2SQVETp2kZwjHXwshYCVgcb41cQw@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Thu, 14 Apr 2022 20:41:58 +0800
Message-ID: <CAG0XXUGnTna=Rmb7BOkZq23J+AHJt_JMpgwPG_HNqvVrZ5r13w@mail.gmail.com>
Subject: Re: [PATCH V3 6/7] mmc: Implement content of UHS-II card
 initialization functions
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Jason Lai <Jason.Lai@genesyslogic.com.tw>,
        otis.wu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Apr 13, 2022 at 7:04 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> [...]
>
> > > > > > > >  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> > > > > > > >  {
> > > > > > > > +       struct mmc_command cmd = {0};
> > > > > > > > +       struct uhs2_command uhs2_cmd = {};
> > > > > > > > +       u16 header = 0, arg = 0;
> > > > > > > > +       u32 payload[2];
> > > > > > > > +       u8 nMinDataGap;
> > > > > > > > +       u8 plen;
> > > > > > > > +       int err;
> > > > > > > > +       u8 resp[5] = {0};
> > > > > > > > +       u8 resp_len = 5;
> > > > > > > > +
> > > > > > > > +       header = UHS2_NATIVE_PACKET |
> > > > > > > > +                UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
> > > > > > > > +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > > > > > > > +              UHS2_NATIVE_CMD_WRITE |
> > > > > > > > +              UHS2_NATIVE_CMD_PLEN_8B |
> > > > > > > > +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > > > > > > > +
> > > > > > > > +       if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> > > > > > > > +           host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> > > > > > > > +               /* Support HD */
> > > > > > > > +               host->uhs2_caps.flags |= MMC_UHS2_2L_HD;
> > > > > > >
> > > > > > > How is the uhs2_caps.flags field intended to be used? To me it looks
> > > > > > > like a way for the mmc core to exchange status/configuration
> > > > > > > information about the initialization process of the card, with the mmc
> > > > > > > host driver. Perhaps there is more too. Is that correct?
> > > > > > >
> > > > > > > If so, I think it looks quite similar for what we have in the struct
> > > > > > > mmc_ios, for the legacy interface(s). I am not saying we should use
> > > > > > > that, just trying to understand what would suit best here.
> > > > > > >
> > > > > >
> > > > > > The usage of uhs2_caps.flags is spread out through core and host.
> > > > > > All operations related to it cannot be integrated into uhs2_set_ios()
> > > > > > simply. I recommend maintaining the status quo.
> > > > >
> > > > > What is puzzling to me, is that the data is stored below uhs2_caps.*
> > > > > and that it's called "flags". It's not self-explanatory and it's not
> > > > > consistent with the way we use the ->set_ios() callback, for the
> > > > > legacy interface.
> > > > >
> > > >
> > > > Sorry,  I did not understand why uhs2_caps.flag is related to set_ios().
> > > > The bit flags are used to indicate current status of UHS2 card:
> > > >   - bit 0: MMC_UHS2_SUPPORT
> > > >              This flag indicates if current sd card  supports UHS2 mode.
> > >
> > > By looking at the code, it seems like MMC_UHS2_SUPPORT is redundant,
> > > at least from the mmc core point of view. Everywhere it's used, we use
> > > MMC_UHS2_INITIALIZED too.
> > >
> >
> > Yes. MMC_UHS2_SUPPORT is only useful in patch set: "Add support UHS-II
> > for GL9755"
> > (https://patchwork.kernel.org/project/linux-mmc/list/?series=378627&archive=both).
> >
> > I will remove it in V4.
> >
> > > Moreover, in patch 2 (mmc: core: Prepare to support SD UHS-II cards) I
> > > added MMC_CAP2_SD_UHS2 as a generic host cap, which is being used in
> > > mmc_attach_sd_uhs2(). This should be sufficient as a generic cap for
> > > UHS2, I think.
> > >
> > > >   - bit 1: MMC_UHS2_INITIALIZED
> > > >              This flag indicates if current uhs2 sd card  had been initialized.
> > >
> > > In patch 2 (mmc: core: Prepare to support SD UHS-II cards), I added
> > > MMC_TIMING_SD_UHS2. It looks like it tries to serve a similar purpose.
> > >
> >
> > MMC_TIMING_SD_UHS2 is used to indicate that host controller is using UHS2
> > timing now. But MMC_UHS2_INITIALIZED=1 means that UHS2 interface
> > initialization is complete. The meaning of these two flags are different.
> >
> > > Moreover, I don't see where MMC_UHS2_INITIALIZED is getting set, but I
> > > assume it must be before we try to initialize the card by sending UHS2
> > > specific commands to it, right?
> > >
> >
> > It is set in sd_uhs2_init_card():
> > static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *oldcard)
> > {
> >         struct mmc_card *card;
> >         u32 node_id;
> >         int err;
> >         [...]
> >         if (card->uhs2_state & MMC_UHS2_SPEED_B) {
> >                 err = sd_uhs2_change_speed(host, node_id);
> >                 if (err)
> >                        return err;
> >         }
> >
> >         card->uhs2_state |= MMC_UHS2_INITIALIZED;
>
> This is probably a local change present only in your own tree, because
> I don't see this anywhere in the v3 series.
>

Yes. They are in my V4 candidate.

> In any case, it's not obvious to me why you need to set it exactly at
> this point. Can you clarify why?
>

After changing data rate to Range B, the UHS2 handshake between
host and card is complete. Driver can start to use SD CCMD/DCMD
to control UHS2 SD card. Following listed the usage of UHS2 related
variables:
    MMC_TIMING_SD_UHS2 in host->ios.timing:
        - Enable UHS2 interface on host controller (drivers/mmc/host)
        - Read preset value from Preset Value Register of SD Host
Controller. (drivers/mmc/host)
    MMC_UHS2_SPEED_B in card->uhs2_state:
        - Used to indicate if current sd card supports UHS2 Range B data rate.
    MMC_UHS2_INITIALIZED in card->uhs2_state:
        - Used to indicate if UHS2 PHY handshaking between host
controller and sd card is complete.

> Perhaps, as I stated before, it's time to post the entire series,
> including the host driver changes. In this way, I should be able to
> get the complete picture.
>
> >
> >         err = sd_uhs2_legacy_init(host, card);
> >         if (err)
> >                 goto err;
> >         [...]
> >
> > }
> >
> > > >   - bit 2: MMC_UHS2_2L_HD
> > > >              This flag indicates the speed mode of current uhs2 sd card is
> > > >              2L-HD mode. The host sets DCMD argument[0] bit 6
> > > >              according to this flag. That means this flag was checked in
> > > >              every MMC request.
> > >
> > > If we compare how we managed things like this for the legacy
> > > interface, this information is kept in the "ios->timing" variable.
> > >
> > > >   - bit 3: MMC_UHS2_APP_CMD
> > > >              This flag indicates if the current SD_TRAN command is an APP
> > > >              command. The host sets DCMD argument[0] bit 14  according to
> > > >              this flag.  That means this flag was checked in every MMC
> > > >              request.
> > >
> > > Alright, so it's a specific flag for UHS2 commands.
> > >
> > > >   - bit 4: MMC_UHS2_SPEED_B
> > > >              This flag indicates the speed range of current UHS2 sd card. This
> > > >              flag is used only during uhs2 sd card initialization.
> > > >
> > > > > It looks to me that we should rather add a new variable to the struct
> > > > > mmc_host and perhaps name it "uhs2_ios", to keep this data. Whether we
> > > > > need to create a new struct for "uhs2_ios" or if it's better to extend
> > > > > struct mmc_ios, I am not sure. I guess exploring this by writing the
> > > > > code would tell us what is best suited.
> > > > >
> > > >
> > > > I will add a new variable to the struct mmc_host and name it "uhs2_ios".
> > > > In UHS2 CCMD/DCMD command packet, DM in TMODE(bit 6 in Argument)
> > > > and bit APP(bit 15 in Argument) are set according to MMC_UHS2_2L_HD
> > > > and MMC_UHS2_APP_CMD. Hence, I plan to define struct uhs2_ios as:
> > > > struct sd_uhs2_ios {
> > > >         bool                  is_2L_HD_mode;    /* DM bit in TMODE in UHS2 DCDM
> > > >                                                                   *
> > > > argument will be set to 1 when
> > >
> > > Seems reasonable.
> > >
> > > >                                                                   *
> > > > this field is true. */
> > > >         bool                  is_APP_CMD;         /* APP bit in UHS2 CCMD/DCDM
> > > >                                                                   *
> > > > argument will be set to 1 when
> > > >                                                                   *
> > > > this field is true. */
> > >
> > > Sounds like this better belongs in the struct uhs2_command.
> > >
> >
> > Indeed, it is more reasonable to put is_APP_CMD in uhs2_cmd. But uhs2_cmd
> > is allocated in mmc_start_request() and is_APP_CMD is set in mmc_app_cmd(),
> > which is called prior to mmc_start_request(). So I use this flag as a mark and
> > check it when filling uhs2_cmd in uhs2_prepare_sd_cmd().
>
> I couldn't find where MMC_UHS2_APP_CMD was getting set, but I assume
> you have some local changes that make it set in mmc_app_cmd() then.
>

It should be set here:
int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
{
    int err;
    struct mmc_command cmd = {};
    [...]
    if (card->uhs2_state & MMC_UHS2_INITIALIZED) {
        host->uhs2_ios.is_APP_CMD = true;
        /* UHS2 does not support APP command(CMD55). It use APP bit in
UHS2 command argument to indicate APP CMD */
        return 0;
    }
    [...]
}
> I decided to have a closer look at this. Instead of using a flag
> (MMC_UHS2_APP_CMD) for this, let's re-work the code so it becomes
> possible to prepare the "uhs2_cmd" in mmc_app_cmd() too. That means,
> from mmc_start_request() we need to check if the mmc_cmd->uhs2_cmd has
> already been assigned and then just leave it as is.
>

uhs2_cmd is a local variable in mmc_start_request() and mmc_cqe_start_req().

> >
> > > >         unsigned int     power_delay_ms;    /* waiting for stable power */
> > > > };
> > > >
> > > > As for MMC_UHS2_INITIALIZED and MMC_UHS2_SPEED_B, I plan to add a variable
> > > > in struct mmc_card and name it "uhs2_state", to keep current UHS2 card states.
> > > > struct mmc_card {
> > > >         struct mmc_host *host; /* the host this device belongs to */
> > > >         [...]
> > > >         struct  sd_uhs2_config  uhs2_config;   /* SD UHS-II config */
> > > >         u8                                  uhs2_state;     /* SD
> > > > UHS-II states */
> > > > #define MMC_UHS2_INITIALIZED    BIT(1)
> > > > #define MMC_UHS2_SPEED_B        BIT(2)
> > > >         [...]
> > >
> > > Please don't.
> > >
> > > If it's configurations of the card, the data belongs under struct
> > > sd_uhs2_config. If it's configuration of the host, the data typically
> > > belongs in the struct sd_uhs2_ios.
> > >
> > > MMC_UHS2_SPEED_B is typically a speed mode for UHS2. For the legacy
> > > interface in the struct mmc_ios, we have an "unsigned char timing"
> > > variable to keep things like these. We need something similar in the
> > > struct sd_uhs2_ios for this, I think. Maybe we should even turn the
> > > bool for "2L_HD_mode" into being part of this "timing" variable.
> > >
> >
> > Actually, MMC_UHS2_INITIALIZED and MMC_UHS2_SPEED_B are more
> > like "is UHS2 interface initialization complete?" and "is current UHS2 sd card
> > support Range B clock?". They are not configurations but a kind of flags which
> > are used to tell driver:
> >     - MMC_UHS2_SPEED_B:     Current UHS2 sd card supports Range B clock
> >                                                    frequency. Driver
> > can execute sd_uhs2_change_speed()
> >                                                    after sd_uhs2_config_write().
>
> I assume you mean that if both the card and the host supports Range B
> speed mode for UHS-II, we should try to switch to it.
>
> Then I have two follow up questions related to this.
> 1) Is there some specific need to inform the host driver, in the
> progress of switching to the new speed mode, to make this work? I
> would believe so, but I don't have the complete picture.

The driver I mentioned above generally includes core/sd/sd_uhs2/mmc_ops.
If we put all initialization flows in one function, MMC_UHS2_SPEED_B will be
declared as a local variable. I try to use a pseudo code to describe
their usage:

int uhs2_init(struct mmc_host *host)
{
    bool    isRangeB_supported;
    int     err;

    err = phy_init();
    if (err)
        return err;

    err= sd_uhs2_dev_init();
    if (err)
        return err;

    err= sd_uhs2_enum();
    if (err)
        return err;

    /* sd_uhs2_config_read() */
    err = Read_Generic_Capability_Register();
    if (err)
        return err;
    err = Read_PHY_Capability_Register();
    if (err)
        return err;
    err= Read_LINK_TRAN_Capability_Register();
    if (err)
        return err;

    /* sd_uhs2_config_Write() */
    Select_Lane_Number_Fit_to_HostController_and_Card;
    err = Write_Generic_Capability_Register();
    if (err)
        return err;

    if (MMC_Host support Range B data rate)
        isRangeB_supported = true;
    else
        isRangeB_supported = false;
    Select_max_lss_sync_Fit_to_HostController_and_Card;
    Select_max_lss_dir_Fit_to_HostController_and_Card;
    err = Write_PHY_Capability_Register();
    if (err)
        return err;

    Select_NFCU_MaxBlkLen_DataGap_MaxRetry_Fit_to_HostController_and_Card;
    err = Write_LINK_TRAN_Capability_Register();
    if (err)
        return err;

    /* card->uhs2_state bit 2: MMC_UHS2_SPEED_B */
    if (isRangeB_supported) {
        err = sd_uhs2_change_speed();
        if (err)
            return err;
    }

    /*
     * All legacy SD functions will use uhs2_cmd to send SD command if
     * this flag is set. Maybe it's easier to understand if I rename it to
     * MMC_SD_UHS2_MODE_ACTIVE?
     */
    card->uhs2_state |= MMC_UHS2_INITIALIZED;
    return 0;
}

> 2) After a successful switch to the new speed mode, we should keep
> track of that we are running in this mode. In this way we can report
> this in logs/debugfs. How do you intend to do this?
>

The mode will be kept until hw_reset/sd_uhs2_power_off/sd_uhs2_remove
being removed. So we can reach the goal by putting some pr_info() there
and check the mode in system log.

> >     - MMC_UHS2_INITIALIZED: UHS2 interface handshake done. Driver can access
> >                                                    current UHS2 sd
> > card with UHS2 interface.
>
> What does "driver can access UHS2 interface" really mean? Is it that
> the card is ready to accept SD-TRAN commands, for example? Can you try
> to be a bit more precise, please?
>

You are right.
In UHS-II Addendum v1.02, Figure 3-10: UHS-II Transaction by SD-TRAN can
help you learn more about SD-TRAN and "Figure 3-11: UHS-II  Initialization Flow"
shows the initialization sequence of uhs2 interface:

Power On or FULL_RESET --> PHY Initialization --> Device Initialization -->
         Enumeration --> Configuration --> Active

After sd card enters Active state, host can start to execute legacy sd
command via sdhci_uhs2_ops.send_command.
mmc_wait_for_cmd --> mmc_wait_for_req
--> __mmc_start_req --> mmc_start_request -> __mmc_start_request
--> host->ops->request==sdhci_request
--> sdhci_send_command_retry --> sdhci_send_command
--> sdhci_uhs2_ops.send_command==sdhci_uhs2_send_command

> >
> > That's why I named it 'uhs2_state'. What do you think?
>
> Let's see where the discussion brings us. Although, "state" is rather
> confusing - and it's inconsistent with the ways things are implemented
> for the legacy interface.
>

I will submit V4, which does not contain uhs2 host driver, in these 2 days for
your review. As for adding uhs2 host part, you prefer adding in V6 or
create another series of patches?

Kind  regards
Jason

> [...]
>
> Kind regards
> Uffe
