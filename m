Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63933C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 03:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiDLDep (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 23:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiDLDeo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 23:34:44 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70BF2DD4E
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 20:32:27 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ebf4b91212so89201347b3.8
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 20:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1vnSllTnpRKc0Nc7+/Q6lWSQeNkt773ODHwbjOqfRI=;
        b=iqhxYZvbs3o69TJ+ipiT8ynWMccMbBjvXXjSTM85LQFP0ql1ZQiwd09iHFEuh+oOwr
         sY/SExSsufAFR8/lN9Qu8susjnMas+6fWu+S6F0F7kG3lFJ0/1qhU7iDO5XzNfJ0O8ik
         yU+NTWrGc/vEEhlahJ+aaWBT6VzgUYIZUAA76zX8H1LykZCuVc6+jaRrR1TK6LkgsKCd
         QWw+0bMGylsC1TypLI0U3cYcSGbK5ndiNKTQAeruAfD2/7Xc0xOkQFtGKT3etd/N1iZB
         TFTpw1v8qgl/XXa+6g+WbToCByURUorQN6yxL056sZBF8sw9noVYxsZYdQl2ZkExN5cV
         IJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1vnSllTnpRKc0Nc7+/Q6lWSQeNkt773ODHwbjOqfRI=;
        b=u0enH+iNL1qxAJuQE9tkns6EQAeVUPP1kOpp4gKFlunYkTrodu6VyPWDOH0EoHd10G
         a8mrX1pU/lltWDaLwAAwEAH8GFDJQj0v0pJmJ0gpyS4grvSraJ/pzMXPSrJi4v8tm0PN
         qnMKzNIExYxR8I5mXMx6SVCztIeFIBhNtEyGcYgLIPFcYTojkdPGtaBqNqsfPJWA/JyA
         aJQS48/s5yxNy5ZM5l+d1QG5RQcdEtr3Wz67hXtX7Bu5rwGrIjriyoNmVTb/mnsPvv7h
         pH/TG9P/yNM6832m+ttfTWfUjdTrsbeP5Yg7ilCE6kMdeW5GCEYCNfhgm44fDZyclnJK
         DZXQ==
X-Gm-Message-State: AOAM531jg0qroBIk3dcTb1pgtWzrg7g7JUb7Aa8Z+yl1Qrhbh9ZjN/qs
        psyP4xrt0le4uwW0cH7NyOoJtBM8BKeS/h99CG0=
X-Google-Smtp-Source: ABdhPJw/M0DgLGsh7kZ/QZcNPOdnPCpiCknSilPXIc0oRuBbD9CMsuWq3as+YCWyx0zQ5L3cjsF8smvP4jcr9JirbYg=
X-Received: by 2002:a0d:d101:0:b0:2eb:4bd7:bcc1 with SMTP id
 t1-20020a0dd101000000b002eb4bd7bcc1mr29096310ywd.495.1649734346790; Mon, 11
 Apr 2022 20:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
 <20220222033931.237638-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoDkxg1b0k4s_+F+eS8EUVM9ZabiwNc4VVQuCexLWNpsw@mail.gmail.com>
 <CAG0XXUGc4+8vF5paKZi9x=i_8pPpYcdCdh=Yr9zkLFe5MqNG0g@mail.gmail.com> <CAPDyKFrj8DZ0Adn7+7gND0VGFj4J2TDPdQf2Vuf7mOTJD4BY+g@mail.gmail.com>
In-Reply-To: <CAPDyKFrj8DZ0Adn7+7gND0VGFj4J2TDPdQf2Vuf7mOTJD4BY+g@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Tue, 12 Apr 2022 11:32:16 +0800
Message-ID: <CAG0XXUE_mH-=oxBZhvYphk+Pyg4QoHogFk2ifQu8eniq2vzeCQ@mail.gmail.com>
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

On Thu, Apr 7, 2022 at 11:01 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 7 Apr 2022 at 12:45, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
> >
> > Hi Uffe,
> >
> > On Thu, Mar 24, 2022 at 12:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Tue, 22 Feb 2022 at 04:40, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> > > >
> > > > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > >
> > > > UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> > > > Part 1 - PHY Initialization:
> > > >          Every host controller may need their own avtivation operation to
> > > >          establish LINK between controller and card. So we add a new member
> > > >          function(uhs2_detect_init) in struct mmc_host_ops for host
> > > >          controller use.
> > > > Part 2 - Card Initialization:
> > > >          This part can be divided into 6 substeps.
> > > >          1. Send UHS-II CCMD DEVICE_INIT to card.
> > > >          2. Send UHS-II CCMD ENUMERATE to card.
> > > >          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
> > > >             of card.
> > > >          4. Host compares capabilities of host controller and card, then
> > > >             write the negotiated values to Setting field in CFG_REG of card
> > > >             through UHS-II Native Write CCMD.
> > > >          5. Switch host controller's clock to Range B if it is supported by
> > > >             both host controller and card.
> > > >          6. Execute legacy SD initialization flow.
> > > > Part 3 - Provide a function to tranaform legacy SD command packet into
> > > >          UHS-II SD-TRAN DCMD packet.
> > > >
> > > > Most of the code added above came from Intel's original patch[3].
> > > >
> > > > [3]
> > > > https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
> > > > git-send-email-yi.y.sun@intel.com/
> > > >
> > > > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > > ---
> > > >  drivers/mmc/core/sd_uhs2.c | 835 ++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 817 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > > > index 800957f74632..f1e8e30301eb 100644
> > > > --- a/drivers/mmc/core/sd_uhs2.c
> > > > +++ b/drivers/mmc/core/sd_uhs2.c
> > > > @@ -3,6 +3,7 @@
> > > >   * Copyright (C) 2021 Linaro Ltd
> > > >   *
> > > >   * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > > > + * Author: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > >   *
> > > >   * Support for SD UHS-II cards
> > > >   */
> > > > @@ -10,19 +11,31 @@
> > > >
> > > >  #include <linux/mmc/host.h>
> > > >  #include <linux/mmc/card.h>
> > > > +#include <linux/mmc/mmc.h>
> > > > +#include <linux/mmc/sd_uhs2.h>
> > > >
> > > >  #include "core.h"
> > > >  #include "bus.h"
> > > > +#include "card.h"
> > > >  #include "sd.h"
> > > > +#include "sd_ops.h"
> > > >  #include "mmc_ops.h"
> > > > +#include "sd_uhs2.h"
> > > >
> > > >  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> > > >
> > > >  static int sd_uhs2_set_ios(struct mmc_host *host)
> > > >  {
> > > >         struct mmc_ios *ios = &host->ios;
> > > > +       int err = 0;
> > > >
> > > > -       return host->ops->uhs2_set_ios(host, ios);
> > > > +       pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> > > > +                mmc_hostname(host), ios->clock, ios->power_mode, ios->vdd,
> > > > +                ios->timing);
> > > > +
> > > > +       host->ops->set_ios(host, ios);
> > >
> > > We discussed using the ->set_ios() callback in a previous version. To
> > > repeat myself, I don't think it's a good idea. UHS-II needs an
> > > entirely different power sequence than the legacy interface(s), hence
> > > I think it's simply cleaner to separate them.
> > >
> > > To move forward, I see two options.
> > > 1) Use only the ->uhs2_host_operation() ops.
> > > 2) Use a combination of the ->uhs2_set_ios() ops and the
> > > ->uhs2_host_operation() ops.
> > >
> >
> > I referred to the usage of "host->ops->set_ios" in core.c, it is called in
> > mmc_set_ios() and ".set_ios" is directed to sdhci_set_ios(), which is
> > located in mmc/host/sdhci.c. So I created sd_uhs2_set_ios() and call
> > host->ops->uhs2_set_ios() inside it. The ".uhs2_set_ios" is left to host
> > part to implement it.
>
> I see. In that case, what you are looking for is an sdhci specific
> callback, this wouldn't belong as part of the generic mmc host ops.
>
> That said, I still think we need to choose between the two options I
> suggested above. Otherwise, I fear that it will turn into a nightmare
> for the mmc host drivers to support both UHS-II and the legacy
> interface.
>
> In other words, I strongly suggest that we must not call ->set_ios()
> to manage the UHS-II interface.
>

I will defer to you. But it's a bit complicated so I need more time to think
about how to organize these operations.  Therefore, I'll submit PATCH V4
before sd_uhs2_set_ios() being implemented.

> >
> > > Both options work for me. However, perhaps if you could incorporate
> > > the changes done on the host driver at next submission, it becomes
> > > easier for me to understand what makes best sense.
> > >
> > > > +
> > > > +       return err;
> > > >  }
> > > >
>
> [...]
>
> > > >  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> > > >  {
> > > > +       struct mmc_command cmd = {0};
> > > > +       struct uhs2_command uhs2_cmd = {};
> > > > +       u16 header = 0, arg = 0;
> > > > +       u32 payload[2];
> > > > +       u8 nMinDataGap;
> > > > +       u8 plen;
> > > > +       int err;
> > > > +       u8 resp[5] = {0};
> > > > +       u8 resp_len = 5;
> > > > +
> > > > +       header = UHS2_NATIVE_PACKET |
> > > > +                UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
> > > > +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > > > +              UHS2_NATIVE_CMD_WRITE |
> > > > +              UHS2_NATIVE_CMD_PLEN_8B |
> > > > +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > > > +
> > > > +       if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> > > > +           host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> > > > +               /* Support HD */
> > > > +               host->uhs2_caps.flags |= MMC_UHS2_2L_HD;
> > >
> > > How is the uhs2_caps.flags field intended to be used? To me it looks
> > > like a way for the mmc core to exchange status/configuration
> > > information about the initialization process of the card, with the mmc
> > > host driver. Perhaps there is more too. Is that correct?
> > >
> > > If so, I think it looks quite similar for what we have in the struct
> > > mmc_ios, for the legacy interface(s). I am not saying we should use
> > > that, just trying to understand what would suit best here.
> > >
> >
> > The usage of uhs2_caps.flags is spread out through core and host.
> > All operations related to it cannot be integrated into uhs2_set_ios()
> > simply. I recommend maintaining the status quo.
>
> What is puzzling to me, is that the data is stored below uhs2_caps.*
> and that it's called "flags". It's not self-explanatory and it's not
> consistent with the way we use the ->set_ios() callback, for the
> legacy interface.
>

Sorry,  I did not understand why uhs2_caps.flag is related to set_ios().
The bit flags are used to indicate current status of UHS2 card:
  - bit 0: MMC_UHS2_SUPPORT
             This flag indicates if current sd card  supports UHS2 mode.
  - bit 1: MMC_UHS2_INITIALIZED
             This flag indicates if current uhs2 sd card  had been initialized.
  - bit 2: MMC_UHS2_2L_HD
             This flag indicates the speed mode of current uhs2 sd card is
             2L-HD mode. The host sets DCMD argument[0] bit 6
             according to this flag. That means this flag was checked in
             every MMC request.
  - bit 3: MMC_UHS2_APP_CMD
             This flag indicates if the current SD_TRAN command is an APP
             command. The host sets DCMD argument[0] bit 14  according to
             this flag.  That means this flag was checked in every MMC
             request.
  - bit 4: MMC_UHS2_SPEED_B
             This flag indicates the speed range of current UHS2 sd card. This
             flag is used only during uhs2 sd card initialization.

> It looks to me that we should rather add a new variable to the struct
> mmc_host and perhaps name it "uhs2_ios", to keep this data. Whether we
> need to create a new struct for "uhs2_ios" or if it's better to extend
> struct mmc_ios, I am not sure. I guess exploring this by writing the
> code would tell us what is best suited.
>

I will add a new variable to the struct mmc_host and name it "uhs2_ios".
In UHS2 CCMD/DCMD command packet, DM in TMODE(bit 6 in Argument)
and bit APP(bit 15 in Argument) are set according to MMC_UHS2_2L_HD
and MMC_UHS2_APP_CMD. Hence, I plan to define struct uhs2_ios as:
struct sd_uhs2_ios {
        bool                  is_2L_HD_mode;    /* DM bit in TMODE in UHS2 DCDM
                                                                  *
argument will be set to 1 when
                                                                  *
this field is true. */
        bool                  is_APP_CMD;         /* APP bit in UHS2 CCMD/DCDM
                                                                  *
argument will be set to 1 when
                                                                  *
this field is true. */
        unsigned int     power_delay_ms;    /* waiting for stable power */
};

As for MMC_UHS2_INITIALIZED and MMC_UHS2_SPEED_B, I plan to add a variable
in struct mmc_card and name it "uhs2_state", to keep current UHS2 card states.
struct mmc_card {
        struct mmc_host *host; /* the host this device belongs to */
        [...]
        struct  sd_uhs2_config  uhs2_config;   /* SD UHS-II config */
        u8                                  uhs2_state;     /* SD
UHS-II states */
#define MMC_UHS2_INITIALIZED    BIT(1)
#define MMC_UHS2_SPEED_B        BIT(2)
        [...]
};

Kind regards,
Jason

> >
> > > > +               nMinDataGap = 1;
> > > > +       } else {
> > > > +               /* Only support 2L-FD so far */
> > > > +               host->uhs2_caps.flags &= ~MMC_UHS2_2L_HD;
> > > > +               nMinDataGap = 3;
> > > > +       }
> > > > +
> > > > +       /*
> > > > +        * Most UHS-II cards only support FD and 2L-HD mode. Other lane numbers
> > > > +        * defined in UHS-II addendem Ver1.01 are optional.
> > > > +        */
> > > > +       host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> > > > +       card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> > >
> > > [...]
> > >
> > > > +static int sd_uhs2_go_dormant(struct mmc_host *host, bool hibernate, u32 node_id)
> > > > +{
> > >
> > > Looks like the in-parameter "hibernate" is superfluous, as it's always
> > > set to "false" by the caller.
> > >
> >
> > The in-parameter "hibernate" is designed according to UHS-II
> > specification. We did not use
> > it for now. But we are not sure if it will be set to true in future
> > use. So I suggest keeping it.
>
> I understand your point, but I don't agree, sorry. We don't want dead
> code around in the kernel, so please remove it.
>
> Perhaps what we can do, is to add a comment in sd_uhs2_go_dormant(),
> somewhere we default to not use hibernate, we could simply explain
> that hibernation is currently not supported.
>
> >
> > > > +       struct mmc_command cmd = {0};
> > > > +       struct uhs2_command uhs2_cmd = {};
> > > > +       u16 header = 0, arg = 0;
> > > > +       u32 payload[1];
> > > > +       u8 plen = 1;
> > > > +       int err;
> > > > +
> > > > +       /* Disable Normal INT */
> > > > +       if (!host->ops->uhs2_host_operation(host, UHS2_DISABLE_INT)) {
> > > > +               pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
> > > > +                      mmc_hostname(host), __func__);
> > > > +               return -EIO;
> > > > +       }
> > > > +
> > > > +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> > > > +
> > > > +       arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
> > > > +               UHS2_NATIVE_CMD_WRITE |
> > > > +               UHS2_NATIVE_CMD_PLEN_4B |
> > > > +               (UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
> > > > +
> > > > +       if (hibernate)
> > > > +               payload[0] = UHS2_DEV_CMD_DORMANT_HIBER;
> > > > +
> > > > +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
> > > > +
> > > > +       err = mmc_wait_for_cmd(host, &cmd, 0);
> > > > +       if (err) {
> > > > +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > > > +                      mmc_hostname(host), __func__, err);
> > > > +               return -EIO;
> > > > +       }
> > > > +
> > > > +       /* Check Dormant State in Present */
> > > > +       if (!host->ops->uhs2_host_operation(host, UHS2_CHECK_DORMANT)) {
> > > > +               pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail!\n",
> > > > +                      mmc_hostname(host), __func__);
> > > > +               return -EIO;
> > > > +       }
> > > > +
> > > > +       host->ops->uhs2_host_operation(host, UHS2_DISABLE_CLK);
> > > > +
> > > >         return 0;
> > > >  }
>
> [...]
>
> Kind regards
> Uffe
