Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B0C433FE
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 10:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbiDGKsu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244544AbiDGKrb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 06:47:31 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFF1C60EB
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 03:45:29 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e5e9025c20so56704667b3.7
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZKPB+9wvv6rIQRH08ia2/KIFZSDt1/H8tZlj4QiaR8=;
        b=afqSQgEUxm5kFYFDuLLjErm6KyWvNFKXSw2gqnTfuShlRad0sNZSVZaHpWhSwcolLR
         sr1nViq0ozIvJFYWv+27mTWefr0evkwEfICIYBH8yJ0BYyeDRxN82a4RUZxZT50j0HW4
         mpCl9QtJUqlKDbrTo0B2j8Sdx1kzuo0caLeaGrRg9bmfqqXyGoxtW0ChCpKTUGg8NmPp
         g9Y7JKLAwgI0x9wOj+y6ZR2Ct156tUavI2lX/LGg19tU7N12xQ75H6DDAqCw5TiQ92jx
         DjqGhlzzQWGs5XbO7xgFO+nMSLo2JzispO8zWxo6rVff43PiOUXDXfYbvNXnt/aFHO2/
         2Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZKPB+9wvv6rIQRH08ia2/KIFZSDt1/H8tZlj4QiaR8=;
        b=w6tAJYBfOrsjRMGTpu4m3MYGBWI2OPzlwpSPSHWHILS5UjrdxAQSntbv70FSzYmTLX
         z5TvTuyybsJRdefn0LyoF14qRDQK1Qvq95PhZR8ed15Bo/u4BBCxMvR5fS/LtchjC1Va
         muHFC470O0p//LIFeqwwM1LN9CXU3aCx41+5deaw5Vho1u2MvFgc+FqznfDLJ5y0exP9
         YgptePe3IyWNC2VRGVR0H+Kv3Shg22ApD34LOhS4LYWnCXfsD19nVxRJ2MO6aQiS1C0n
         qF/AiPNaRw/mIv1QFX+xCegBxGocb5UrUJFHYBExpdC+YwkHUn+3iC0MTRMghwYh8e8Z
         gpLg==
X-Gm-Message-State: AOAM530QNywBidPHxaTuKVKZwKiQBqVAVhy+WDD+AevqtFz39MC9HrOr
        l7cCt+bMS0NSfhLNhV17KcombejlvakRnHLcUOA=
X-Google-Smtp-Source: ABdhPJyYj1aUE9PiXuDmpIcBWsxF/Z7on70h17IhOi+AwUG5uRF8eH6dLrlWsz6sEYW3kC2Mnm0PvZBTkEjkOKHDvnU=
X-Received: by 2002:a0d:c6c4:0:b0:2d6:f343:fa99 with SMTP id
 i187-20020a0dc6c4000000b002d6f343fa99mr10420341ywd.142.1649328328267; Thu, 07
 Apr 2022 03:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
 <20220222033931.237638-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoDkxg1b0k4s_+F+eS8EUVM9ZabiwNc4VVQuCexLWNpsw@mail.gmail.com>
In-Reply-To: <CAPDyKFoDkxg1b0k4s_+F+eS8EUVM9ZabiwNc4VVQuCexLWNpsw@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Thu, 7 Apr 2022 18:45:17 +0800
Message-ID: <CAG0XXUGc4+8vF5paKZi9x=i_8pPpYcdCdh=Yr9zkLFe5MqNG0g@mail.gmail.com>
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

Hi Uffe,

On Thu, Mar 24, 2022 at 12:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 22 Feb 2022 at 04:40, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> >
> > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> >
> > UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> > Part 1 - PHY Initialization:
> >          Every host controller may need their own avtivation operation to
> >          establish LINK between controller and card. So we add a new member
> >          function(uhs2_detect_init) in struct mmc_host_ops for host
> >          controller use.
> > Part 2 - Card Initialization:
> >          This part can be divided into 6 substeps.
> >          1. Send UHS-II CCMD DEVICE_INIT to card.
> >          2. Send UHS-II CCMD ENUMERATE to card.
> >          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
> >             of card.
> >          4. Host compares capabilities of host controller and card, then
> >             write the negotiated values to Setting field in CFG_REG of card
> >             through UHS-II Native Write CCMD.
> >          5. Switch host controller's clock to Range B if it is supported by
> >             both host controller and card.
> >          6. Execute legacy SD initialization flow.
> > Part 3 - Provide a function to tranaform legacy SD command packet into
> >          UHS-II SD-TRAN DCMD packet.
> >
> > Most of the code added above came from Intel's original patch[3].
> >
> > [3]
> > https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
> > git-send-email-yi.y.sun@intel.com/
> >
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/core/sd_uhs2.c | 835 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 817 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > index 800957f74632..f1e8e30301eb 100644
> > --- a/drivers/mmc/core/sd_uhs2.c
> > +++ b/drivers/mmc/core/sd_uhs2.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2021 Linaro Ltd
> >   *
> >   * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > + * Author: Jason Lai <jason.lai@genesyslogic.com.tw>
> >   *
> >   * Support for SD UHS-II cards
> >   */
> > @@ -10,19 +11,31 @@
> >
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/card.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/sd_uhs2.h>
> >
> >  #include "core.h"
> >  #include "bus.h"
> > +#include "card.h"
> >  #include "sd.h"
> > +#include "sd_ops.h"
> >  #include "mmc_ops.h"
> > +#include "sd_uhs2.h"
> >
> >  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> >
> >  static int sd_uhs2_set_ios(struct mmc_host *host)
> >  {
> >         struct mmc_ios *ios = &host->ios;
> > +       int err = 0;
> >
> > -       return host->ops->uhs2_set_ios(host, ios);
> > +       pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> > +                mmc_hostname(host), ios->clock, ios->power_mode, ios->vdd,
> > +                ios->timing);
> > +
> > +       host->ops->set_ios(host, ios);
>
> We discussed using the ->set_ios() callback in a previous version. To
> repeat myself, I don't think it's a good idea. UHS-II needs an
> entirely different power sequence than the legacy interface(s), hence
> I think it's simply cleaner to separate them.
>
> To move forward, I see two options.
> 1) Use only the ->uhs2_host_operation() ops.
> 2) Use a combination of the ->uhs2_set_ios() ops and the
> ->uhs2_host_operation() ops.
>

I referred to the usage of "host->ops->set_ios" in core.c, it is called in
mmc_set_ios() and ".set_ios" is directed to sdhci_set_ios(), which is
located in mmc/host/sdhci.c. So I created sd_uhs2_set_ios() and call
host->ops->uhs2_set_ios() inside it. The ".uhs2_set_ios" is left to host
part to implement it.

> Both options work for me. However, perhaps if you could incorporate
> the changes done on the host driver at next submission, it becomes
> easier for me to understand what makes best sense.
>
> > +
> > +       return err;
> >  }
> >
> >  static int sd_uhs2_power_up(struct mmc_host *host)
> > @@ -45,6 +58,43 @@ static void sd_uhs2_power_off(struct mmc_host *host)
> >         sd_uhs2_set_ios(host);
> >  }
>
> [...]
>
> >
> >  /*
> > @@ -61,6 +119,77 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
> >   */
> >  static int sd_uhs2_dev_init(struct mmc_host *host)
> >  {
> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u32 cnt;
> > +       u32 dap, gap, resp_gap;
> > +       u16 header = 0, arg = 0;
>
> No need to initiate these.
>
> > +       u32 payload[1];
>
> u32?
>

I will change it to __be32.

> > +       u8 plen = 1;
> > +       u8 gd = 0, cf = 1;
> > +       u8 resp[6] = {0};
> > +       u8 resp_len = 6;
>
> Many of these variables are just constant numbers. If it makes sense
> to add definitions for them, then please do that instead. If not, just
> give the value directly in the code.
>
> For example: plen = 1; (I assume that is payload length). This can
> just be given as an in-parameter to sd_uhs2_cmd_assemble(), without
> further explanation.
>
> The point is, sd_uhs2_cmd_assemble() should have a well described
> description of its in-parameters, so no need for further descriptions,
> I think.
>
> This comment applies to all the new code/functions that are added in
> the $subject patch. Please go through all of the code and fix this.
>

OK. I will remove these variables and use constant definitions to replace them.

>
> > +       int err;
> > +
> > +       dap = host->uhs2_caps.dap;
> > +       gap = host->uhs2_caps.gap;
> > +
> > +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> > +       arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
> > +              UHS2_NATIVE_CMD_WRITE |
> > +              UHS2_NATIVE_CMD_PLEN_4B |
> > +              (UHS2_DEV_CMD_DEVICE_INIT >> 8);
> > +
> > +       /*
> > +        * Refer to UHS-II Addendum Version 1.02 section 6.3.1.
> > +        * Max. time from DEVICE_INIT CCMD EOP reception on Device
> > +        * Rx to its SOP transmission on Device Tx(Tfwd_init_cmd) is
> > +        * 1 second.
> > +        */
> > +       cmd.busy_timeout = 1000;
> > +
> > +       /*
> > +        * Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
> > +        * When the number of the DEVICE_INIT commands is reach to
> > +        * 30 tiems, Host shall stop issuing DEVICE_INIT command
> > +        * and regard it as an error.
> > +        */
> > +       for (cnt = 0; cnt < 30; cnt++) {
> > +               payload[0] = ((dap & 0xF) << 12) |
> > +                             (cf << 11)         |
> > +                             ((gd & 0xF) << 4)  |
> > +                             (gap & 0xF);
>
> To me, it looks like the payload data deserves to be explained a bit.
> Perhaps you can add a comment explaining what pieces it consists of so
> this becomes more clear?
>

The format of Header and Payload will be listed in include/linux/mmc/sd_uhs2.h

> > +
> > +               sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,  payload, plen, resp, resp_len);
> > +
> > +               err = mmc_wait_for_cmd(host, &cmd, 0);
> > +
> > +               if (err) {
> > +                       pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                              mmc_hostname(host), __func__, err);
> > +                       return -EIO;
>
> Why do you override the original error code that was returned from
> mmc_wait_for_cmd()?
>
> Normally it's preferred to keep the error code, unless there is good
> reason not to.
>
> Again, I won't add more comments like this in the code from the
> $subject patch. But please go through it all to avoid this kind of
> thing.
>

OK.

> > +               }
> > +
> > +               if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
> > +                       pr_err("%s: DEVICE_INIT response is wrong!\n",
> > +                              mmc_hostname(host));
> > +                       return -EIO;
> > +               }
> > +
> > +               if (resp[5] & 0x8) {
> > +                       host->uhs2_caps.group_desc = gd;
> > +                       break;
>
> I suggest you do a return 0 here. In this way you can skip the check
> "if (cnt == 30)" below and just return an error code instead.
>

OK.

> > +               }
> > +               resp_gap = resp[4] & 0x0F;
> > +               if (gap == resp_gap)
> > +                       gd++;
> > +       }
> > +       if (cnt == 30) {
> > +               pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
> > +                      mmc_hostname(host));
> > +               return -EIO;
> > +       }
> > +
> >         return 0;
> >  }
> >
>
> >  static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
> >  {
> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u16 header = 0, arg = 0;
> > +       u32 cap;
> > +       int err;
> > +
> > +       header = UHS2_NATIVE_PACKET |
> > +                UHS2_PACKET_TYPE_CCMD |
> > +                card->uhs2_config.node_id;
> > +       arg = ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
> > +              UHS2_NATIVE_CMD_READ |
> > +              UHS2_NATIVE_CMD_PLEN_4B |
> > +              (UHS2_DEV_CONFIG_GEN_CAPS >> 8);
> > +
> > +       /* There is no payload because per spec, there should be
> > +        * no payload field for read CCMD.
> > +        * Plen is set in arg. Per spec, plen for read CCMD
> > +        * represents the len of read data which is assigned in payload
> > +        * of following RES (p136).
> > +        */
> > +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
>
> We are reading the configuration data here and onwards, piece by
> piece. Perhaps if you can add a small comment about each piece we are
> reading, before each call to mmc_wait_for_cmd(), that can help to
> easier understand what goes on.
>

The response read back is the content of UHS-II Register.
I will put comments about the bit fields in that register.

> [...]
>
> >  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> >  {
> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u16 header = 0, arg = 0;
> > +       u32 payload[2];
> > +       u8 nMinDataGap;
> > +       u8 plen;
> > +       int err;
> > +       u8 resp[5] = {0};
> > +       u8 resp_len = 5;
> > +
> > +       header = UHS2_NATIVE_PACKET |
> > +                UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
> > +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > +              UHS2_NATIVE_CMD_WRITE |
> > +              UHS2_NATIVE_CMD_PLEN_8B |
> > +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > +
> > +       if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> > +           host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> > +               /* Support HD */
> > +               host->uhs2_caps.flags |= MMC_UHS2_2L_HD;
>
> How is the uhs2_caps.flags field intended to be used? To me it looks
> like a way for the mmc core to exchange status/configuration
> information about the initialization process of the card, with the mmc
> host driver. Perhaps there is more too. Is that correct?
>
> If so, I think it looks quite similar for what we have in the struct
> mmc_ios, for the legacy interface(s). I am not saying we should use
> that, just trying to understand what would suit best here.
>

The usage of uhs2_caps.flags is spread out through core and host.
All operations related to it cannot be integrated into uhs2_set_ios()
simply. I recommend maintaining the status quo.

> > +               nMinDataGap = 1;
> > +       } else {
> > +               /* Only support 2L-FD so far */
> > +               host->uhs2_caps.flags &= ~MMC_UHS2_2L_HD;
> > +               nMinDataGap = 3;
> > +       }
> > +
> > +       /*
> > +        * Most UHS-II cards only support FD and 2L-HD mode. Other lane numbers
> > +        * defined in UHS-II addendem Ver1.01 are optional.
> > +        */
> > +       host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> > +       card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
>
> [...]
>
> > +static int sd_uhs2_go_dormant(struct mmc_host *host, bool hibernate, u32 node_id)
> > +{
>
> Looks like the in-parameter "hibernate" is superfluous, as it's always
> set to "false" by the caller.
>

The in-parameter "hibernate" is designed according to UHS-II
specification. We did not use
it for now. But we are not sure if it will be set to true in future
use. So I suggest keeping it.

> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u16 header = 0, arg = 0;
> > +       u32 payload[1];
> > +       u8 plen = 1;
> > +       int err;
> > +
> > +       /* Disable Normal INT */
> > +       if (!host->ops->uhs2_host_operation(host, UHS2_DISABLE_INT)) {
> > +               pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
> > +                      mmc_hostname(host), __func__);
> > +               return -EIO;
> > +       }
> > +
> > +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> > +
> > +       arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
> > +               UHS2_NATIVE_CMD_WRITE |
> > +               UHS2_NATIVE_CMD_PLEN_4B |
> > +               (UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
> > +
> > +       if (hibernate)
> > +               payload[0] = UHS2_DEV_CMD_DORMANT_HIBER;
> > +
> > +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
> > +
> > +       err = mmc_wait_for_cmd(host, &cmd, 0);
> > +       if (err) {
> > +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                      mmc_hostname(host), __func__, err);
> > +               return -EIO;
> > +       }
> > +
> > +       /* Check Dormant State in Present */
> > +       if (!host->ops->uhs2_host_operation(host, UHS2_CHECK_DORMANT)) {
> > +               pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail!\n",
> > +                      mmc_hostname(host), __func__);
> > +               return -EIO;
> > +       }
> > +
> > +       host->ops->uhs2_host_operation(host, UHS2_DISABLE_CLK);
> > +
> >         return 0;
> >  }
> >
> > +static int sd_uhs2_change_speed(struct mmc_host *host, u32 node_id)
> > +{
> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u16 header = 0, arg = 0;
> > +       int err;
> > +       int timeout = 100;
> > +
> > +       /* Change Speed Range at controller side. */
> > +       if (!host->ops->uhs2_host_operation(host, UHS2_SET_SPEED_B)) {
> > +               pr_err("%s: %s: UHS2 SET_SPEED fail!\n",
> > +                      mmc_hostname(host), __func__);
> > +               return -EIO;
> > +       }
> > +
> > +       err = sd_uhs2_go_dormant(host, false, node_id);
> > +       if (err) {
> > +               pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
> > +                      mmc_hostname(host), __func__, err);
> > +               return -EIO;
> > +       }
> > +
> > +       /* restore sd clock */
> > +       mmc_delay(5);
> > +       host->ops->uhs2_host_operation(host, UHS2_ENABLE_CLK);
>
> I think the code can be a bit better structured here. More precisely,
> since sd_uhs2_go_dormant() is the one that calls
> ->uhs2_host_operation(host, UHS2_DISABLE_INT) and
> ->uhs2_host_operation(host, UHS2_DISABLE_CLK), it's then up to
> sd_uhs2_change_speed() to restore these changes.
>
> To me, it would be more clear if both enabling and disabling of the
> clock /interrupt are managed in sd_uhs2_change_speed().
>

OK.

> > +
> > +       /* Enable Normal INT */
> > +       if (!host->ops->uhs2_host_operation(host, UHS2_ENABLE_INT)) {
> > +               pr_err("%s: %s: UHS2 ENABLE_INT fail!\n",
> > +                      mmc_hostname(host), __func__);
> > +               return -EIO;
> > +       }
> > +
> > +       /*
> > +        * According to UHS-II Addendum Version 1.01, chapter 6.2.3, wait card
> > +        * switch to Active State
> > +        */
> > +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> > +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > +               UHS2_NATIVE_CMD_READ |
> > +               UHS2_NATIVE_CMD_PLEN_8B |
> > +               (UHS2_DEV_CONFIG_GEN_SET >> 8);
> > +       do {
> > +               sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> > +               err = mmc_wait_for_cmd(host, &cmd, 0);
> > +               if (err) {
> > +                       pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                              mmc_hostname(host), __func__, err);
> > +                       return -EIO;
> > +               }
> > +
> > +               if (cmd.resp[1] & UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE)
> > +                       break;
> > +
> > +               timeout--;
> > +               if (timeout == 0) {
> > +                       pr_err("%s: %s: Not switch to Active in 100 ms\n",
> > +                              mmc_hostname(host), __func__);
> > +                       return -EIO;
> > +               }
> > +
> > +               mmc_delay(1);
> > +       } while (1);
>
> We really want to avoid these kinds of polling loops, for several
> reasons. Please convert into using __mmc_poll_for_busy() instead.
>

OK.

> > +
> > +       return 0;
> > +}
> > +
> > +static int sd_uhs2_get_ro(struct mmc_host *host)
> > +{
> > +       int ro;
> > +
> > +       /*
> > +        * Some systems don't feature a write-protect pin and don't need one.
> > +        * E.g. because they only have micro-SD card slot. For those systems
> > +        * assume that the SD card is always read-write.
> > +        */
> > +       if (host->caps2 & MMC_CAP2_NO_WRITE_PROTECT)
> > +               return 0;
> > +
> > +       if (!host->ops->get_ro)
> > +               return -1;
> > +
> > +       ro = host->ops->get_ro(host);
> > +
> > +       return ro;
>
> This can be replaced with mmc_sd_get_ro(). Let's avoid the open coding
> and make that function being shared instead.
>

OK.

> > +}
> > +
> >  /*
> >   * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
> >   * commands/requests to be backwards compatible through the legacy SD protocol.
> > @@ -107,9 +696,127 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> >   */
> >  static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
> >  {
> > +       int err;
> > +       u32 cid[4];
> > +       u32 ocr;
> > +       u32 rocr = 0;
> > +       int ro;
> > +
> > +       WARN_ON(!host->claimed);
>
> Drop this, it's an internal function, we should know that the host is
> claimed before calling sd_uhs2_legacy_init().
>

OK.

> > +
> > +       /* Send CMD0 to reset SD card */
> > +       mmc_go_idle(host);
> > +
> > +       /* Send CMD8 to communicate SD interface operation condition */
> > +       err = mmc_send_if_cond(host, host->ocr_avail);
> > +       if (err) {
> > +               pr_err("%s: %s: SEND_IF_COND fail!\n",
> > +                      mmc_hostname(host), __func__);
>
> Please drop these prints for every command/operation that fails. We
> already have trace/debug options for commands/requests.
>
> This applies to all the below code as well (perhaps there are few
> cases not covered by the existing trace/debug support, those may be
> converted to pr_debug().
>

OK.

> > +               return err;
> > +       }
> > +
> > +       /*
> > +        * Probe SD card working voltage.
> > +        */
> > +       err = mmc_send_app_op_cond(host, 0, &ocr);
> > +       if (err) {
> > +               pr_err("%s: %s: SD_SEND_OP_COND fail!\n",
> > +                      mmc_hostname(host), __func__);
> > +               return err;
> > +       }
> > +       card->ocr = ocr;
> > +
> > +       /*
> > +        * Some SD cards claims an out of spec VDD voltage range. Let's treat
> > +        * these bits as being in-valid and especially also bit7.
> > +        */
> > +       ocr &= ~0x7FFF;
> > +       rocr = mmc_select_voltage(host, ocr);
>
> If the host has MMC_CAP2_FULL_PWR_CYCLE set, mmc_select_voltage() may
> end up calling mmc_power_cycle(). This is not going to work for
> UHS-II.
>
> Either we need to modify mmc_select_voltage() so it becomes aware that
> it can be called for UHS-II initialization, allowing it to avoid the
> path to mmc_power_cycle() - or simply open code the part from
> mmc_select_voltage() for UHS-II here. I think I prefer the latter.
>

I will implement sd_uhs2_select_voltage() to replace mmc_select_voltage().

> > +
> > +       /*
> > +        * Some cards have zero value of rocr in UHS-II mode. Assign host's
> > +        * ocr value to rocr.
> > +        */
> > +       if (!rocr) {
> > +               if (host->ocr_avail) {
> > +                       rocr = host->ocr_avail;
>
> host->ocr_avail should really be checked in when the host driver calls
> mmc_add_host(). It must not be zero, then we should let mmc_add_host()
> return an error code. I look into this and send a patch for this
> separately.
>
> In other words, you should not need to check it here, but just trust that's set.
>

OK.

> > +               } else {
> > +                       pr_err("%s: %s: there is no valid OCR.\n",
> > +                              mmc_hostname(host), __func__);
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       /* Wait SD power on ready */
> > +       ocr = rocr;
> > +       err = mmc_send_app_op_cond(host, ocr, &rocr);
> > +       if (err) {
> > +               pr_err("%s: %s: SD_SEND_OP_COND fail!\n", mmc_hostname(host),
> > +                      __func__);
> > +               return err;
> > +       }
> > +
> > +       err = mmc_send_cid(host, cid);
> > +       if (err) {
> > +               pr_err("%s: %s: SD_SEND_CID fail!\n", mmc_hostname(host),
> > +                      __func__);
> > +               return err;
> > +       }
> > +       memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
> > +
> > +       /*
> > +        * Call the optional HC's init_card function to handle quirks.
> > +        */
> > +       if (host->ops->init_card)
> > +               host->ops->init_card(host, card);
>
> This can be removed, as it's only for the legacy interface, I think.
>

OK.

Kind regards,
Jason


> > +
> > +       /*
> > +        * For native busses:  get card RCA and quit open drain mode.
> > +        */
> > +       err = mmc_send_relative_addr(host, &card->rca);
> > +       if (err) {
> > +               pr_err("%s: %s: SD_SEND_RCA fail!\n", mmc_hostname(host),
> > +                      __func__);
> > +               return err;
> > +       }
> > +
> > +       err = mmc_sd_get_csd(card);
> > +       if (err) {
> > +               pr_err("%s: %s: SD_SEND_CSD fail!\n", mmc_hostname(host),
> > +                      __func__);
> > +               return err;
> > +       }
> > +
> > +       /*
> > +        * Select card, as all following commands rely on that.
> > +        */
> > +       err = mmc_select_card(card);
> > +       if (err) {
> > +               pr_err("%s: %s: SD_SEL_DSEL fail!\n", mmc_hostname(host),
> > +                      __func__);
> > +               return err;
> > +       }
> > +
> > +       /*
> > +        * Check if read-only switch is active.
> > +        */
> > +       ro = sd_uhs2_get_ro(host);
> > +       if (ro < 0) {
> > +               pr_warn("%s: host does not support read-only switch, assuming write-enable\n",
> > +                       mmc_hostname(host));
> > +       } else if (ro > 0) {
> > +               mmc_card_set_readonly(card);
> > +       }
> > +
> >         return 0;
> >  }
> >
> > +static void sd_uhs2_remove(struct mmc_host *host)
> > +{
> > +       mmc_remove_card(host->card);
> > +       host->card = NULL;
> > +}
> > +
> >  /*
> >   * Allocate the data structure for the mmc_card and run the UHS-II specific
> >   * initialization sequence.
> > @@ -121,16 +828,21 @@ static int sd_uhs2_init_card(struct mmc_host *host)
> >         int err;
> >
> >         err = sd_uhs2_dev_init(host);
> > -       if (err)
> > +       if (err) {
> > +               pr_err("%s: UHS2 DEVICE_INIT fail!\n", mmc_hostname(host));
> >                 return err;
> > +       }
> >
> >         err = sd_uhs2_enum(host, &node_id);
> > -       if (err)
> > +       if (err) {
> > +               pr_err("%s: UHS2 ENUMERATE fail!\n", mmc_hostname(host));
> >                 return err;
> > +       }
> >
> >         card = mmc_alloc_card(host, &sd_type);
> >         if (IS_ERR(card))
> >                 return PTR_ERR(card);
> > +       host->card = card;
> >
> >         card->uhs2_config.node_id = node_id;
> >         card->type = MMC_TYPE_SD;
> > @@ -139,6 +851,16 @@ static int sd_uhs2_init_card(struct mmc_host *host)
> >         if (err)
> >                 goto err;
> >
> > +       /* Change to Speed Range B if it is supported */
> > +       if (host->uhs2_caps.flags & MMC_UHS2_SPEED_B) {
> > +               err = sd_uhs2_change_speed(host, node_id);
> > +               if (err) {
> > +                       pr_err("%s: %s: UHS2 sd_uhs2_change_speed() fail!\n",
> > +                              mmc_hostname(host), __func__);
> > +                       return err;
> > +               }
> > +       }
> > +
> >         err = sd_uhs2_config_write(host, card);
> >         if (err)
> >                 goto err;
> > @@ -147,20 +869,13 @@ static int sd_uhs2_init_card(struct mmc_host *host)
> >         if (err)
> >                 goto err;
> >
> > -       host->card = card;
> >         return 0;
> >
> >  err:
> > -       mmc_remove_card(card);
> > +       sd_uhs2_remove(host);
> >         return err;
> >  }
>
> [...]
>
> Kind regards
> Uffe
