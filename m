Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11129C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Apr 2022 07:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiDMHUk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Apr 2022 03:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiDMHUi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2022 03:20:38 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5669EBC3D
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2022 00:18:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ebf3746f87so12456507b3.6
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2022 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVK+U/e6EYxz7aFROetO7ibDtRiOlW58efAYKMwB+ro=;
        b=aRNXYAMm6Vv61Y4TwcgRTBANfgsp0OfCmGNS6YBES5twyevWAbV60gd9VkXDq5Zexh
         +39XNj+07+2XOKRB45bnMq0R71uZicPBhdaVYWtf9RPP3Ai7yiZ5xOeTtMVPX6iRQPzx
         fxIw9hAjvt3/eyldzgP/owsgdpL7hPqxWtWpPfdBlE4oqHehLmqETZZ2E4BKl5/1cdP7
         Ts8fF2OV7GhJOuhwCkKiwesFy8SwLdUstN7+2X/BvcZ1F8TDCNMC7QVT0sbNkjk6hGRg
         RqdH/eU/Rh/2hQ5ae6W/LlVEeQHdJ6MwQeM8UtZ1WTbI9KQMyGuIEIIMsdaWWtEcIeve
         aeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVK+U/e6EYxz7aFROetO7ibDtRiOlW58efAYKMwB+ro=;
        b=RUZ93sEVYytovqom5wKWu8++VWLxiWD+8zLSlSJer443ryq8IkezGxQRy4ZZgyfywM
         IDj/K3BZk1yDFImboU8eIWK301FRM0k1FHKaAbgntaEVOHDtPKJCBVg3fofWXrKx9l0C
         4wI4mjmxMuF4SSQQ3fP681t9e9X2gloQWKSLm68cVII0PJuKlttkwctN68g0mkGulgx2
         h8nWuKrkRKr0xcBi1D0NARwPrRhvIAUbp7RbgrQOFD5h9iHbITGuJ34xPHfHNCjAiggI
         lwfbvvT5MoXRwsozt/ytXP1rmRjpXPi+w43Ph1s551zk+BpD3fE/dnXqInxqoNY8FrYc
         B/5A==
X-Gm-Message-State: AOAM530sRnTsOQJaCVXvA7kv3+wBxovJ593MiD848xvzWhzvZJzXntz8
        92fODwuXVatxoS6bIsp0Q7Xa9qgxd/P9bAmNe1w=
X-Google-Smtp-Source: ABdhPJwbZuBCL0LVutSudAlfPuR1meYy86rbWVArDPmhPICS2TJ4T7qQmsjX/0NZNa04gnoUZAu0Zi2UAKtzYb+zYF4=
X-Received: by 2002:a81:3902:0:b0:2eb:f9f0:4b0c with SMTP id
 g2-20020a813902000000b002ebf9f04b0cmr15462644ywa.419.1649834296492; Wed, 13
 Apr 2022 00:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
 <20220222033931.237638-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoDkxg1b0k4s_+F+eS8EUVM9ZabiwNc4VVQuCexLWNpsw@mail.gmail.com>
 <CAG0XXUGc4+8vF5paKZi9x=i_8pPpYcdCdh=Yr9zkLFe5MqNG0g@mail.gmail.com>
 <CAPDyKFrj8DZ0Adn7+7gND0VGFj4J2TDPdQf2Vuf7mOTJD4BY+g@mail.gmail.com>
 <CAG0XXUE_mH-=oxBZhvYphk+Pyg4QoHogFk2ifQu8eniq2vzeCQ@mail.gmail.com> <CAPDyKFpeXKBu_+0Ws10-EGTr6iR3VirTdg_M2CVAeqzwx6DwxA@mail.gmail.com>
In-Reply-To: <CAPDyKFpeXKBu_+0Ws10-EGTr6iR3VirTdg_M2CVAeqzwx6DwxA@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Wed, 13 Apr 2022 15:18:05 +0800
Message-ID: <CAG0XXUFYVjU8aMCCL_Caewdh8KZYfmxy0cSBD62jj6N7_pE2GA@mail.gmail.com>
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

On Tue, Apr 12, 2022 at 7:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 12 Apr 2022 at 05:32, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
> >
> > On Thu, Apr 7, 2022 at 11:01 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 7 Apr 2022 at 12:45, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
> > > >
> > > > Hi Uffe,
> > > >
> > > > On Thu, Mar 24, 2022 at 12:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Tue, 22 Feb 2022 at 04:40, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> > > > > >
> > > > > > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > > > >
> > > > > > UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> > > > > > Part 1 - PHY Initialization:
> > > > > >          Every host controller may need their own avtivation operation to
> > > > > >          establish LINK between controller and card. So we add a new member
> > > > > >          function(uhs2_detect_init) in struct mmc_host_ops for host
> > > > > >          controller use.
> > > > > > Part 2 - Card Initialization:
> > > > > >          This part can be divided into 6 substeps.
> > > > > >          1. Send UHS-II CCMD DEVICE_INIT to card.
> > > > > >          2. Send UHS-II CCMD ENUMERATE to card.
> > > > > >          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
> > > > > >             of card.
> > > > > >          4. Host compares capabilities of host controller and card, then
> > > > > >             write the negotiated values to Setting field in CFG_REG of card
> > > > > >             through UHS-II Native Write CCMD.
> > > > > >          5. Switch host controller's clock to Range B if it is supported by
> > > > > >             both host controller and card.
> > > > > >          6. Execute legacy SD initialization flow.
> > > > > > Part 3 - Provide a function to tranaform legacy SD command packet into
> > > > > >          UHS-II SD-TRAN DCMD packet.
> > > > > >
> > > > > > Most of the code added above came from Intel's original patch[3].
> > > > > >
> > > > > > [3]
> > > > > > https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
> > > > > > git-send-email-yi.y.sun@intel.com/
> > > > > >
> > > > > > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > > > > ---
> > > > > >  drivers/mmc/core/sd_uhs2.c | 835 ++++++++++++++++++++++++++++++++++++-
> > > > > >  1 file changed, 817 insertions(+), 18 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > > > > > index 800957f74632..f1e8e30301eb 100644
> > > > > > --- a/drivers/mmc/core/sd_uhs2.c
> > > > > > +++ b/drivers/mmc/core/sd_uhs2.c
> > > > > > @@ -3,6 +3,7 @@
> > > > > >   * Copyright (C) 2021 Linaro Ltd
> > > > > >   *
> > > > > >   * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > + * Author: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > > > >   *
> > > > > >   * Support for SD UHS-II cards
> > > > > >   */
> > > > > > @@ -10,19 +11,31 @@
> > > > > >
> > > > > >  #include <linux/mmc/host.h>
> > > > > >  #include <linux/mmc/card.h>
> > > > > > +#include <linux/mmc/mmc.h>
> > > > > > +#include <linux/mmc/sd_uhs2.h>
> > > > > >
> > > > > >  #include "core.h"
> > > > > >  #include "bus.h"
> > > > > > +#include "card.h"
> > > > > >  #include "sd.h"
> > > > > > +#include "sd_ops.h"
> > > > > >  #include "mmc_ops.h"
> > > > > > +#include "sd_uhs2.h"
> > > > > >
> > > > > >  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> > > > > >
> > > > > >  static int sd_uhs2_set_ios(struct mmc_host *host)
> > > > > >  {
> > > > > >         struct mmc_ios *ios = &host->ios;
> > > > > > +       int err = 0;
> > > > > >
> > > > > > -       return host->ops->uhs2_set_ios(host, ios);
> > > > > > +       pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> > > > > > +                mmc_hostname(host), ios->clock, ios->power_mode, ios->vdd,
> > > > > > +                ios->timing);
> > > > > > +
> > > > > > +       host->ops->set_ios(host, ios);
> > > > >
> > > > > We discussed using the ->set_ios() callback in a previous version. To
> > > > > repeat myself, I don't think it's a good idea. UHS-II needs an
> > > > > entirely different power sequence than the legacy interface(s), hence
> > > > > I think it's simply cleaner to separate them.
> > > > >
> > > > > To move forward, I see two options.
> > > > > 1) Use only the ->uhs2_host_operation() ops.
> > > > > 2) Use a combination of the ->uhs2_set_ios() ops and the
> > > > > ->uhs2_host_operation() ops.
> > > > >
> > > >
> > > > I referred to the usage of "host->ops->set_ios" in core.c, it is called in
> > > > mmc_set_ios() and ".set_ios" is directed to sdhci_set_ios(), which is
> > > > located in mmc/host/sdhci.c. So I created sd_uhs2_set_ios() and call
> > > > host->ops->uhs2_set_ios() inside it. The ".uhs2_set_ios" is left to host
> > > > part to implement it.
> > >
> > > I see. In that case, what you are looking for is an sdhci specific
> > > callback, this wouldn't belong as part of the generic mmc host ops.
> > >
> > > That said, I still think we need to choose between the two options I
> > > suggested above. Otherwise, I fear that it will turn into a nightmare
> > > for the mmc host drivers to support both UHS-II and the legacy
> > > interface.
> > >
> > > In other words, I strongly suggest that we must not call ->set_ios()
> > > to manage the UHS-II interface.
> > >
> >
> > I will defer to you. But it's a bit complicated so I need more time to think
> > about how to organize these operations.  Therefore, I'll submit PATCH V4
> > before sd_uhs2_set_ios() being implemented.
>
> Okay. I will do my best to continue to provide guidance and review.
>
> Perhaps you could also have a closer look at the legacy code for
> eMMC/SD, to get some inspiration on how to structure the code in a
> consistent way.
>
> >
> > > >
> > > > > Both options work for me. However, perhaps if you could incorporate
> > > > > the changes done on the host driver at next submission, it becomes
> > > > > easier for me to understand what makes best sense.
> > > > >
> > > > > > +
> > > > > > +       return err;
> > > > > >  }
> > > > > >
> > >
> > > [...]
> > >
> > > > > >  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> > > > > >  {
> > > > > > +       struct mmc_command cmd = {0};
> > > > > > +       struct uhs2_command uhs2_cmd = {};
> > > > > > +       u16 header = 0, arg = 0;
> > > > > > +       u32 payload[2];
> > > > > > +       u8 nMinDataGap;
> > > > > > +       u8 plen;
> > > > > > +       int err;
> > > > > > +       u8 resp[5] = {0};
> > > > > > +       u8 resp_len = 5;
> > > > > > +
> > > > > > +       header = UHS2_NATIVE_PACKET |
> > > > > > +                UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
> > > > > > +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > > > > > +              UHS2_NATIVE_CMD_WRITE |
> > > > > > +              UHS2_NATIVE_CMD_PLEN_8B |
> > > > > > +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > > > > > +
> > > > > > +       if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> > > > > > +           host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> > > > > > +               /* Support HD */
> > > > > > +               host->uhs2_caps.flags |= MMC_UHS2_2L_HD;
> > > > >
> > > > > How is the uhs2_caps.flags field intended to be used? To me it looks
> > > > > like a way for the mmc core to exchange status/configuration
> > > > > information about the initialization process of the card, with the mmc
> > > > > host driver. Perhaps there is more too. Is that correct?
> > > > >
> > > > > If so, I think it looks quite similar for what we have in the struct
> > > > > mmc_ios, for the legacy interface(s). I am not saying we should use
> > > > > that, just trying to understand what would suit best here.
> > > > >
> > > >
> > > > The usage of uhs2_caps.flags is spread out through core and host.
> > > > All operations related to it cannot be integrated into uhs2_set_ios()
> > > > simply. I recommend maintaining the status quo.
> > >
> > > What is puzzling to me, is that the data is stored below uhs2_caps.*
> > > and that it's called "flags". It's not self-explanatory and it's not
> > > consistent with the way we use the ->set_ios() callback, for the
> > > legacy interface.
> > >
> >
> > Sorry,  I did not understand why uhs2_caps.flag is related to set_ios().
> > The bit flags are used to indicate current status of UHS2 card:
> >   - bit 0: MMC_UHS2_SUPPORT
> >              This flag indicates if current sd card  supports UHS2 mode.
>
> By looking at the code, it seems like MMC_UHS2_SUPPORT is redundant,
> at least from the mmc core point of view. Everywhere it's used, we use
> MMC_UHS2_INITIALIZED too.
>

Yes. MMC_UHS2_SUPPORT is only useful in patch set: "Add support UHS-II
for GL9755"
(https://patchwork.kernel.org/project/linux-mmc/list/?series=378627&archive=both).

I will remove it in V4.

> Moreover, in patch 2 (mmc: core: Prepare to support SD UHS-II cards) I
> added MMC_CAP2_SD_UHS2 as a generic host cap, which is being used in
> mmc_attach_sd_uhs2(). This should be sufficient as a generic cap for
> UHS2, I think.
>
> >   - bit 1: MMC_UHS2_INITIALIZED
> >              This flag indicates if current uhs2 sd card  had been initialized.
>
> In patch 2 (mmc: core: Prepare to support SD UHS-II cards), I added
> MMC_TIMING_SD_UHS2. It looks like it tries to serve a similar purpose.
>

MMC_TIMING_SD_UHS2 is used to indicate that host controller is using UHS2
timing now. But MMC_UHS2_INITIALIZED=1 means that UHS2 interface
initialization is complete. The meaning of these two flags are different.

> Moreover, I don't see where MMC_UHS2_INITIALIZED is getting set, but I
> assume it must be before we try to initialize the card by sending UHS2
> specific commands to it, right?
>

It is set in sd_uhs2_init_card():
static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *oldcard)
{
        struct mmc_card *card;
        u32 node_id;
        int err;
        [...]
        if (card->uhs2_state & MMC_UHS2_SPEED_B) {
                err = sd_uhs2_change_speed(host, node_id);
                if (err)
                       return err;
        }

        card->uhs2_state |= MMC_UHS2_INITIALIZED;

        err = sd_uhs2_legacy_init(host, card);
        if (err)
                goto err;
        [...]

}

> >   - bit 2: MMC_UHS2_2L_HD
> >              This flag indicates the speed mode of current uhs2 sd card is
> >              2L-HD mode. The host sets DCMD argument[0] bit 6
> >              according to this flag. That means this flag was checked in
> >              every MMC request.
>
> If we compare how we managed things like this for the legacy
> interface, this information is kept in the "ios->timing" variable.
>
> >   - bit 3: MMC_UHS2_APP_CMD
> >              This flag indicates if the current SD_TRAN command is an APP
> >              command. The host sets DCMD argument[0] bit 14  according to
> >              this flag.  That means this flag was checked in every MMC
> >              request.
>
> Alright, so it's a specific flag for UHS2 commands.
>
> >   - bit 4: MMC_UHS2_SPEED_B
> >              This flag indicates the speed range of current UHS2 sd card. This
> >              flag is used only during uhs2 sd card initialization.
> >
> > > It looks to me that we should rather add a new variable to the struct
> > > mmc_host and perhaps name it "uhs2_ios", to keep this data. Whether we
> > > need to create a new struct for "uhs2_ios" or if it's better to extend
> > > struct mmc_ios, I am not sure. I guess exploring this by writing the
> > > code would tell us what is best suited.
> > >
> >
> > I will add a new variable to the struct mmc_host and name it "uhs2_ios".
> > In UHS2 CCMD/DCMD command packet, DM in TMODE(bit 6 in Argument)
> > and bit APP(bit 15 in Argument) are set according to MMC_UHS2_2L_HD
> > and MMC_UHS2_APP_CMD. Hence, I plan to define struct uhs2_ios as:
> > struct sd_uhs2_ios {
> >         bool                  is_2L_HD_mode;    /* DM bit in TMODE in UHS2 DCDM
> >                                                                   *
> > argument will be set to 1 when
>
> Seems reasonable.
>
> >                                                                   *
> > this field is true. */
> >         bool                  is_APP_CMD;         /* APP bit in UHS2 CCMD/DCDM
> >                                                                   *
> > argument will be set to 1 when
> >                                                                   *
> > this field is true. */
>
> Sounds like this better belongs in the struct uhs2_command.
>

Indeed, it is more reasonable to put is_APP_CMD in uhs2_cmd. But uhs2_cmd
is allocated in mmc_start_request() and is_APP_CMD is set in mmc_app_cmd(),
which is called prior to mmc_start_request(). So I use this flag as a mark and
check it when filling uhs2_cmd in uhs2_prepare_sd_cmd().

> >         unsigned int     power_delay_ms;    /* waiting for stable power */
> > };
> >
> > As for MMC_UHS2_INITIALIZED and MMC_UHS2_SPEED_B, I plan to add a variable
> > in struct mmc_card and name it "uhs2_state", to keep current UHS2 card states.
> > struct mmc_card {
> >         struct mmc_host *host; /* the host this device belongs to */
> >         [...]
> >         struct  sd_uhs2_config  uhs2_config;   /* SD UHS-II config */
> >         u8                                  uhs2_state;     /* SD
> > UHS-II states */
> > #define MMC_UHS2_INITIALIZED    BIT(1)
> > #define MMC_UHS2_SPEED_B        BIT(2)
> >         [...]
>
> Please don't.
>
> If it's configurations of the card, the data belongs under struct
> sd_uhs2_config. If it's configuration of the host, the data typically
> belongs in the struct sd_uhs2_ios.
>
> MMC_UHS2_SPEED_B is typically a speed mode for UHS2. For the legacy
> interface in the struct mmc_ios, we have an "unsigned char timing"
> variable to keep things like these. We need something similar in the
> struct sd_uhs2_ios for this, I think. Maybe we should even turn the
> bool for "2L_HD_mode" into being part of this "timing" variable.
>

Actually, MMC_UHS2_INITIALIZED and MMC_UHS2_SPEED_B are more
like "is UHS2 interface initialization complete?" and "is current UHS2 sd card
support Range B clock?". They are not configurations but a kind of flags which
are used to tell driver:
    - MMC_UHS2_SPEED_B:     Current UHS2 sd card supports Range B clock
                                                   frequency. Driver
can execute sd_uhs2_change_speed()
                                                   after sd_uhs2_config_write().
    - MMC_UHS2_INITIALIZED: UHS2 interface handshake done. Driver can access
                                                   current UHS2 sd
card with UHS2 interface.

That's why I named it 'uhs2_state'. What do you think?

Kind regards,
Jason

> When it comes to the MMC_UHS2_INITIALIZED, if I understand correctly,
> it means that we have managed to power on the phy and are about to
> start the communication with the card. We could use a "bool" in the
> struct sd_uhs2_ios, to indicate this. Another option may be to use and
> set "MMC_TIMING_SD_UHS2" as a default speed mode in the "timing"
> variable above. No matter what, it seems like MMC_TIMING_SD_UHS2
> doesn't belong in the legacy ios->variable, as I suggested in patch2.
>
> > };
> >
> > Kind regards,
> > Jason
> >
>
> [...]
>
> Kind regards
> Uffe
