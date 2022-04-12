Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99D1C43219
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 12:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348203AbiDLMkT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353837AbiDLMhz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 08:37:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C775F8D8
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 04:58:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p10so31694468lfa.12
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFv+W29x+SR/sDgQMbO6xLryIpDElYgbCcZIWGCsQTQ=;
        b=y7cK7foHR7lw36/+gbRShmdKnnPv8rBwZKa7trikZFYzSqXMpxGeuK1N+KdzXgE4uZ
         8FOe9y+JLYLmhkZkRlQJSrExQji5COaj1Zw1uHDmbSAT5P54xnqtwzFoQ/Lud3diYspW
         SNfAYGV/EPWS5/5mf2oJnlsJJJoXG+Og/esTrRo4YBMjXfYNRN+wPys+wlwNJQNjrFYD
         QRLBqyeBaXLElZ6ponOPKW6M7HvcPrcN51wJZJbMYFx3pvDqLxsJlkK/wYzTvwt2+vaz
         lHXRcGKmbScGxxJodx4UDFej+UNYUk/jptoL99s6pco6upM6a0816UjrMCJzlaKV7C9M
         j+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFv+W29x+SR/sDgQMbO6xLryIpDElYgbCcZIWGCsQTQ=;
        b=InlR1KMpaWMuNrXw9q43ulUcZ4uOhxPTLBwKqm4ClBsTAyDai0DgU25ttpMAcLhIcl
         t/I/K1+0ltfYlsUfvjy0pEqNPwQnReYbkYyEd6Y14hgBappoMmBJesLbkvkBEDyJz46M
         +RD24qLeQdkGqWO3pt3827uDqntbEidBetzgP2OJbtZiF6pPA9Dcpf+1jSfB9nVEcq9b
         D58BoxrOvb/vw0s5L1bXE9j7pP9u6u7J6x5zrcMbDnA2GXcH+AvpbPW0zLxKwHHVfmX3
         SUlDW8OuxR7IARwU1KvSqr2SpOjDKNtoA59oAGsuEcgUV4DZ17/UYFS5gHFverSftq5f
         P2Aw==
X-Gm-Message-State: AOAM53277/MQqtB94y5MnyY7g8iZgb/354M/GzNjhPqFrXcC6JS4/B1a
        MNW0RhuOVfspOp3Dn971/zZXuTFwk2awCv2UMLqVnA==
X-Google-Smtp-Source: ABdhPJyUvylSMb+vyRhhO1DLY0iKarDWol+LletuSFDeSyQIns8Cc4CkdWjWlPY79kzCNgvN2RTXjung2b77vpDdhAg=
X-Received: by 2002:a05:6512:2627:b0:44a:f55c:ded9 with SMTP id
 bt39-20020a056512262700b0044af55cded9mr25287697lfb.373.1649764682037; Tue, 12
 Apr 2022 04:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
 <20220222033931.237638-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoDkxg1b0k4s_+F+eS8EUVM9ZabiwNc4VVQuCexLWNpsw@mail.gmail.com>
 <CAG0XXUGc4+8vF5paKZi9x=i_8pPpYcdCdh=Yr9zkLFe5MqNG0g@mail.gmail.com>
 <CAPDyKFrj8DZ0Adn7+7gND0VGFj4J2TDPdQf2Vuf7mOTJD4BY+g@mail.gmail.com> <CAG0XXUE_mH-=oxBZhvYphk+Pyg4QoHogFk2ifQu8eniq2vzeCQ@mail.gmail.com>
In-Reply-To: <CAG0XXUE_mH-=oxBZhvYphk+Pyg4QoHogFk2ifQu8eniq2vzeCQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Apr 2022 13:57:25 +0200
Message-ID: <CAPDyKFpeXKBu_+0Ws10-EGTr6iR3VirTdg_M2CVAeqzwx6DwxA@mail.gmail.com>
Subject: Re: [PATCH V3 6/7] mmc: Implement content of UHS-II card
 initialization functions
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>
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

On Tue, 12 Apr 2022 at 05:32, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
>
> On Thu, Apr 7, 2022 at 11:01 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 7 Apr 2022 at 12:45, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
> > >
> > > Hi Uffe,
> > >
> > > On Thu, Mar 24, 2022 at 12:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Tue, 22 Feb 2022 at 04:40, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> > > > >
> > > > > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > > >
> > > > > UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> > > > > Part 1 - PHY Initialization:
> > > > >          Every host controller may need their own avtivation operation to
> > > > >          establish LINK between controller and card. So we add a new member
> > > > >          function(uhs2_detect_init) in struct mmc_host_ops for host
> > > > >          controller use.
> > > > > Part 2 - Card Initialization:
> > > > >          This part can be divided into 6 substeps.
> > > > >          1. Send UHS-II CCMD DEVICE_INIT to card.
> > > > >          2. Send UHS-II CCMD ENUMERATE to card.
> > > > >          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
> > > > >             of card.
> > > > >          4. Host compares capabilities of host controller and card, then
> > > > >             write the negotiated values to Setting field in CFG_REG of card
> > > > >             through UHS-II Native Write CCMD.
> > > > >          5. Switch host controller's clock to Range B if it is supported by
> > > > >             both host controller and card.
> > > > >          6. Execute legacy SD initialization flow.
> > > > > Part 3 - Provide a function to tranaform legacy SD command packet into
> > > > >          UHS-II SD-TRAN DCMD packet.
> > > > >
> > > > > Most of the code added above came from Intel's original patch[3].
> > > > >
> > > > > [3]
> > > > > https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
> > > > > git-send-email-yi.y.sun@intel.com/
> > > > >
> > > > > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > > > ---
> > > > >  drivers/mmc/core/sd_uhs2.c | 835 ++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 817 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > > > > index 800957f74632..f1e8e30301eb 100644
> > > > > --- a/drivers/mmc/core/sd_uhs2.c
> > > > > +++ b/drivers/mmc/core/sd_uhs2.c
> > > > > @@ -3,6 +3,7 @@
> > > > >   * Copyright (C) 2021 Linaro Ltd
> > > > >   *
> > > > >   * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > + * Author: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > > >   *
> > > > >   * Support for SD UHS-II cards
> > > > >   */
> > > > > @@ -10,19 +11,31 @@
> > > > >
> > > > >  #include <linux/mmc/host.h>
> > > > >  #include <linux/mmc/card.h>
> > > > > +#include <linux/mmc/mmc.h>
> > > > > +#include <linux/mmc/sd_uhs2.h>
> > > > >
> > > > >  #include "core.h"
> > > > >  #include "bus.h"
> > > > > +#include "card.h"
> > > > >  #include "sd.h"
> > > > > +#include "sd_ops.h"
> > > > >  #include "mmc_ops.h"
> > > > > +#include "sd_uhs2.h"
> > > > >
> > > > >  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> > > > >
> > > > >  static int sd_uhs2_set_ios(struct mmc_host *host)
> > > > >  {
> > > > >         struct mmc_ios *ios = &host->ios;
> > > > > +       int err = 0;
> > > > >
> > > > > -       return host->ops->uhs2_set_ios(host, ios);
> > > > > +       pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> > > > > +                mmc_hostname(host), ios->clock, ios->power_mode, ios->vdd,
> > > > > +                ios->timing);
> > > > > +
> > > > > +       host->ops->set_ios(host, ios);
> > > >
> > > > We discussed using the ->set_ios() callback in a previous version. To
> > > > repeat myself, I don't think it's a good idea. UHS-II needs an
> > > > entirely different power sequence than the legacy interface(s), hence
> > > > I think it's simply cleaner to separate them.
> > > >
> > > > To move forward, I see two options.
> > > > 1) Use only the ->uhs2_host_operation() ops.
> > > > 2) Use a combination of the ->uhs2_set_ios() ops and the
> > > > ->uhs2_host_operation() ops.
> > > >
> > >
> > > I referred to the usage of "host->ops->set_ios" in core.c, it is called in
> > > mmc_set_ios() and ".set_ios" is directed to sdhci_set_ios(), which is
> > > located in mmc/host/sdhci.c. So I created sd_uhs2_set_ios() and call
> > > host->ops->uhs2_set_ios() inside it. The ".uhs2_set_ios" is left to host
> > > part to implement it.
> >
> > I see. In that case, what you are looking for is an sdhci specific
> > callback, this wouldn't belong as part of the generic mmc host ops.
> >
> > That said, I still think we need to choose between the two options I
> > suggested above. Otherwise, I fear that it will turn into a nightmare
> > for the mmc host drivers to support both UHS-II and the legacy
> > interface.
> >
> > In other words, I strongly suggest that we must not call ->set_ios()
> > to manage the UHS-II interface.
> >
>
> I will defer to you. But it's a bit complicated so I need more time to think
> about how to organize these operations.  Therefore, I'll submit PATCH V4
> before sd_uhs2_set_ios() being implemented.

Okay. I will do my best to continue to provide guidance and review.

Perhaps you could also have a closer look at the legacy code for
eMMC/SD, to get some inspiration on how to structure the code in a
consistent way.

>
> > >
> > > > Both options work for me. However, perhaps if you could incorporate
> > > > the changes done on the host driver at next submission, it becomes
> > > > easier for me to understand what makes best sense.
> > > >
> > > > > +
> > > > > +       return err;
> > > > >  }
> > > > >
> >
> > [...]
> >
> > > > >  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> > > > >  {
> > > > > +       struct mmc_command cmd = {0};
> > > > > +       struct uhs2_command uhs2_cmd = {};
> > > > > +       u16 header = 0, arg = 0;
> > > > > +       u32 payload[2];
> > > > > +       u8 nMinDataGap;
> > > > > +       u8 plen;
> > > > > +       int err;
> > > > > +       u8 resp[5] = {0};
> > > > > +       u8 resp_len = 5;
> > > > > +
> > > > > +       header = UHS2_NATIVE_PACKET |
> > > > > +                UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
> > > > > +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > > > > +              UHS2_NATIVE_CMD_WRITE |
> > > > > +              UHS2_NATIVE_CMD_PLEN_8B |
> > > > > +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > > > > +
> > > > > +       if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> > > > > +           host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> > > > > +               /* Support HD */
> > > > > +               host->uhs2_caps.flags |= MMC_UHS2_2L_HD;
> > > >
> > > > How is the uhs2_caps.flags field intended to be used? To me it looks
> > > > like a way for the mmc core to exchange status/configuration
> > > > information about the initialization process of the card, with the mmc
> > > > host driver. Perhaps there is more too. Is that correct?
> > > >
> > > > If so, I think it looks quite similar for what we have in the struct
> > > > mmc_ios, for the legacy interface(s). I am not saying we should use
> > > > that, just trying to understand what would suit best here.
> > > >
> > >
> > > The usage of uhs2_caps.flags is spread out through core and host.
> > > All operations related to it cannot be integrated into uhs2_set_ios()
> > > simply. I recommend maintaining the status quo.
> >
> > What is puzzling to me, is that the data is stored below uhs2_caps.*
> > and that it's called "flags". It's not self-explanatory and it's not
> > consistent with the way we use the ->set_ios() callback, for the
> > legacy interface.
> >
>
> Sorry,  I did not understand why uhs2_caps.flag is related to set_ios().
> The bit flags are used to indicate current status of UHS2 card:
>   - bit 0: MMC_UHS2_SUPPORT
>              This flag indicates if current sd card  supports UHS2 mode.

By looking at the code, it seems like MMC_UHS2_SUPPORT is redundant,
at least from the mmc core point of view. Everywhere it's used, we use
MMC_UHS2_INITIALIZED too.

Moreover, in patch 2 (mmc: core: Prepare to support SD UHS-II cards) I
added MMC_CAP2_SD_UHS2 as a generic host cap, which is being used in
mmc_attach_sd_uhs2(). This should be sufficient as a generic cap for
UHS2, I think.

>   - bit 1: MMC_UHS2_INITIALIZED
>              This flag indicates if current uhs2 sd card  had been initialized.

In patch 2 (mmc: core: Prepare to support SD UHS-II cards), I added
MMC_TIMING_SD_UHS2. It looks like it tries to serve a similar purpose.

Moreover, I don't see where MMC_UHS2_INITIALIZED is getting set, but I
assume it must be before we try to initialize the card by sending UHS2
specific commands to it, right?

>   - bit 2: MMC_UHS2_2L_HD
>              This flag indicates the speed mode of current uhs2 sd card is
>              2L-HD mode. The host sets DCMD argument[0] bit 6
>              according to this flag. That means this flag was checked in
>              every MMC request.

If we compare how we managed things like this for the legacy
interface, this information is kept in the "ios->timing" variable.

>   - bit 3: MMC_UHS2_APP_CMD
>              This flag indicates if the current SD_TRAN command is an APP
>              command. The host sets DCMD argument[0] bit 14  according to
>              this flag.  That means this flag was checked in every MMC
>              request.

Alright, so it's a specific flag for UHS2 commands.

>   - bit 4: MMC_UHS2_SPEED_B
>              This flag indicates the speed range of current UHS2 sd card. This
>              flag is used only during uhs2 sd card initialization.
>
> > It looks to me that we should rather add a new variable to the struct
> > mmc_host and perhaps name it "uhs2_ios", to keep this data. Whether we
> > need to create a new struct for "uhs2_ios" or if it's better to extend
> > struct mmc_ios, I am not sure. I guess exploring this by writing the
> > code would tell us what is best suited.
> >
>
> I will add a new variable to the struct mmc_host and name it "uhs2_ios".
> In UHS2 CCMD/DCMD command packet, DM in TMODE(bit 6 in Argument)
> and bit APP(bit 15 in Argument) are set according to MMC_UHS2_2L_HD
> and MMC_UHS2_APP_CMD. Hence, I plan to define struct uhs2_ios as:
> struct sd_uhs2_ios {
>         bool                  is_2L_HD_mode;    /* DM bit in TMODE in UHS2 DCDM
>                                                                   *
> argument will be set to 1 when

Seems reasonable.

>                                                                   *
> this field is true. */
>         bool                  is_APP_CMD;         /* APP bit in UHS2 CCMD/DCDM
>                                                                   *
> argument will be set to 1 when
>                                                                   *
> this field is true. */

Sounds like this better belongs in the struct uhs2_command.

>         unsigned int     power_delay_ms;    /* waiting for stable power */
> };
>
> As for MMC_UHS2_INITIALIZED and MMC_UHS2_SPEED_B, I plan to add a variable
> in struct mmc_card and name it "uhs2_state", to keep current UHS2 card states.
> struct mmc_card {
>         struct mmc_host *host; /* the host this device belongs to */
>         [...]
>         struct  sd_uhs2_config  uhs2_config;   /* SD UHS-II config */
>         u8                                  uhs2_state;     /* SD
> UHS-II states */
> #define MMC_UHS2_INITIALIZED    BIT(1)
> #define MMC_UHS2_SPEED_B        BIT(2)
>         [...]

Please don't.

If it's configurations of the card, the data belongs under struct
sd_uhs2_config. If it's configuration of the host, the data typically
belongs in the struct sd_uhs2_ios.

MMC_UHS2_SPEED_B is typically a speed mode for UHS2. For the legacy
interface in the struct mmc_ios, we have an "unsigned char timing"
variable to keep things like these. We need something similar in the
struct sd_uhs2_ios for this, I think. Maybe we should even turn the
bool for "2L_HD_mode" into being part of this "timing" variable.

When it comes to the MMC_UHS2_INITIALIZED, if I understand correctly,
it means that we have managed to power on the phy and are about to
start the communication with the card. We could use a "bool" in the
struct sd_uhs2_ios, to indicate this. Another option may be to use and
set "MMC_TIMING_SD_UHS2" as a default speed mode in the "timing"
variable above. No matter what, it seems like MMC_TIMING_SD_UHS2
doesn't belong in the legacy ios->variable, as I suggested in patch2.

> };
>
> Kind regards,
> Jason
>

[...]

Kind regards
Uffe
