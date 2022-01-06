Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20974C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Jan 2022 10:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiAFKbU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Jan 2022 05:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiAFKbT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2022 05:31:19 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0F1C061245
        for <linux-mmc@vger.kernel.org>; Thu,  6 Jan 2022 02:31:18 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k69so6124285ybf.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Jan 2022 02:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOUQKM1hXhCvWMmZuUOltP2WV7ElsgZHSlhybBMaPsA=;
        b=hrf7+H7esoFOmBgwIxMSv+3Ubc/F35HmUp6S/4TAMTD1LyhFQKfZLl9lUt5cjX1g8G
         8w8nBGS2xvCJQXwFw+vo7rcm6OuU38BaWcHmyhwEy3/14JLhrs2LjKha0sBzZ/Ma7/At
         vFS3bWR3IHJ5DLlkGSqo9Mr83CYVA3ruSbiUrbAlgIy0xIiCTu2W+5S4ft7q3cG6V7lb
         8yFtxvKHTQo0GqrsVej7ZRxtOND9CnaumYTEZr3cPz1SUYzjINPOgvJe81IT70CrOKu8
         84s32MS760Yi9vzCaXcHk3urZCaEFeTQNO7+4fBNrdmXOW80GXsAaXnxaBFr4Z/sXb8c
         3Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOUQKM1hXhCvWMmZuUOltP2WV7ElsgZHSlhybBMaPsA=;
        b=KdIdzNGcdXpICaqTZ52L6t95ttB9KfLOxnaXP1Hwf6oO7CJ/DF13af1mfjWWzxruDu
         71RQ9eQsbVwA+k9H/fbx+Q5QwOoCptr+kIDb1ttCmN1HU3WR8BDd5OV8joVCauljpB5X
         crcKHfK82I6hn9YySBDrqjKr2aZsCiyB0PeZFZMoFtUr5n/+1u7WY09JROnyHWi2cv5t
         864e4b/iaORdKqSjXzcRZI0S+1faaT3pkPOJFnfQ9pNFNzBBuCp1tZWfcpEWlRvrkMhp
         qMKm/B9MF+ht2IS1jFHyiH8WfafcrsHLVBGDrHaPf4xJ5KqKVqQR5U6B9ObpPz7BGTYt
         M09w==
X-Gm-Message-State: AOAM532EV/f4eiYUNgfUHD39uTCG2ag+YSeCv19y+XIIvwqIxHUaVC6N
        9a5xHpuUuz02xVowW5AXy7BGZlsg6LpMwwqqFKmiJiAxiGI=
X-Google-Smtp-Source: ABdhPJz/ExF+QvHx9P+wq68R7jtEfwsoNCbviPTUnatrJfrLFJL0UItWbrLheZKUtN0gerXqlF//sHBF/LQm9txg9tY=
X-Received: by 2002:a05:6902:102c:: with SMTP id x12mr47185786ybt.717.1641465077896;
 Thu, 06 Jan 2022 02:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
 <20211203105103.11306-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoptpMeKS29qqMN1E-h_FMieHAKVvbAZ6vDAYPdSuvTqQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoptpMeKS29qqMN1E-h_FMieHAKVvbAZ6vDAYPdSuvTqQ@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Thu, 6 Jan 2022 18:31:07 +0800
Message-ID: <CAG0XXUGKJt1AhWDmgkwT5ecrBk5eP2qrinS0_cm+J8fBWJwkVA@mail.gmail.com>
Subject: Re: [PATCH 6/7] mmc: Implement content of UHS-II card initialization functions
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Wed, Dec 15, 2021 at 4:29 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> On Fri, 3 Dec 2021 at 11:51, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> >
> > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> >
> > UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> > Part 1 - PHY Initialization:
> >          Every host controller may need their own avtivation operation
> >          to establish LINK between controller and card. So we add a new
> >          member function(uhs2_detect_init) in struct mmc_host_ops for host
> >          controller use.
> > Part 2 - Card Initialization:
> >          This part can be divided into 6 substeps.
> >          1. Send UHS-II CCMD DEVICE_INIT to card.
> >          2. Send UHS-II CCMD ENUMERATE to card.
> >          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
> >             of card.
> >          4. Host compares capabilities of host controller and  card,
> >             then write the negotiated values to Setting field in CFG_REG
> >             of card through UHS-II Native Write CCMD.
> >          5. Switch host controller's clock to Range B if it is supported
> >             by both host controller and card.
> >          6. Execute legacy SD initialization flow.
> > Part 3 - Provide a function to tranaform legacy SD command packet into
> >          UHS-II SD-TRAN DCMD packet.
> >
> > Most of the code added above came from Intel's original patch[1].
> >
> > [1]
> > https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
> > git-send-email-yi.y.sun@intel.com/
> >
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/core/sd_uhs2.c | 831 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 810 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > index 24aa51a6d..d13283d54 100644
> > --- a/drivers/mmc/core/sd_uhs2.c
> > +++ b/drivers/mmc/core/sd_uhs2.c
> > @@ -3,6 +3,7 @@
> >
> >  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> >
> > -static int sd_uhs2_set_ios(struct mmc_host *host)
> > +static void sd_uhs2_set_ios(struct mmc_host *host)
>
> Please don't change the function to return void. It's better to allow
> the callback to return an error code, even if that might not be of
> benefit for your particular host variant.

I have a question about the return type of this function. In
sd_uhs2_set_ios(), we only called
host->ops->set_ios() and the return type of that function was VOID. So
is there a reason
that this function must has a non-void return type?

> >  {
> >         struct mmc_ios *ios = &host->ios;
> >
> > -       return host->ops->uhs2_set_ios(host, ios);
> > +       host->ops->set_ios(host, ios);
> >  }
> >
> > -static int sd_uhs2_power_up(struct mmc_host *host)
> > +static void sd_uhs2_power_up(struct mmc_host *host)
> >  {
>
> Ditto.
>
> >         host->ios.vdd = fls(host->ocr_avail) - 1;
> >         host->ios.clock = host->f_init;
> >         host->ios.timing = MMC_TIMING_SD_UHS2;
> >         host->ios.power_mode = MMC_POWER_UP;
> >
> > -       return sd_uhs2_set_ios(host);
> > +       sd_uhs2_set_ios(host);
> >  }
> >
> >  static void sd_uhs2_power_off(struct mmc_host *host)
> > @@ -45,6 +48,50 @@ static void sd_uhs2_power_off(struct mmc_host *host)
> >         sd_uhs2_set_ios(host);
> >  }
> >
> > +/**
> > + * sd_uhs2_cmd_assemble() - build up UHS-II command packet which is embeded in
> > + *                          mmc_command structure
> > + * @cmd:       MMC command to executed
> > + * @uhs2_cmd:  UHS2 command corresponded to MMC command
> > + * @header:    Header field of UHS-II command cxpacket
> > + * @arg:       Argument field of UHS-II command packet
> > + * @payload:   Payload field of UHS-II command packet
> > + * @plen:      Payload length
> > + * @resp:      Response buffer is allocated by caller and it is used to keep
> > + *              the response of CM-TRAN command. For SD-TRAN command, uhs2_resp
> > + *              should be null and SD-TRAN command response should be stored in
> > + *              resp of mmc_command.
> > + * @resp_len:  Response buffer length
> > + *
> > + * Different from legacy SD command, there defined several types of packets
> > + * in UHS-II, which include CM-TRAN and SD-TRAN. These packets are then
> > + * transformed to differential signals and transmitted/received between
> > + * transceiver and receiver.
> > + *
> > + * The UHS-II packet structure(uhs2_cmd) are added in structure mmc_command
> > + * and be filled according to the inputed parameters provided by caller.
> > + *
> > + * For mmc requests, call this function before issuing command to SD card.
> > + * Host controller specific request function will send packet in uhs2_cmd
> > + * to UHS-II SD card.
> > + *
>
> I think we discussed the above functions description earlier. The
> above description is just way too overwhelming. What the function does
> is that fills out the uhs2_cmd data structure, that's it.
>
> As this is a static function, I wouldn't mind that you simply drop the
> entire function description above. Or try to make the description
> short and clear.

I will try to do that.

> > + */
> > +static void sd_uhs2_cmd_assemble(struct mmc_command *cmd,
> > +                             struct uhs2_command *uhs2_cmd,
> > +                             u16 header, u16 arg,
> > +                             u32 *payload, u8 plen, u8 *resp, u8 resp_len)
> > +{
> > +       uhs2_cmd->header = header;
> > +       uhs2_cmd->arg = arg;
> > +       uhs2_cmd->payload = payload;
> > +       uhs2_cmd->payload_len = plen * sizeof(u32);
> > +       uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
> > +
> > +       cmd->uhs2_cmd = uhs2_cmd;
> > +       cmd->uhs2_resp = resp;
> > +       cmd->uhs2_resp_len = resp_len;
> > +}
> > +
> >  /*
> >   * Run the phy initialization sequence, which mainly relies on the UHS-II host
> >   * to check that we reach the expected electrical state, between the host and
> > @@ -52,16 +99,98 @@ static void sd_uhs2_power_off(struct mmc_host *host)
> >   */
> >  static int sd_uhs2_phy_init(struct mmc_host *host)
> >  {
> > -       return 0;
> > +       int err = 0;
> > +
> > +       /*
> > +        * Every host controller can assign its own function which is used
> > +        * to initialize PHY.
> > +        */
> > +       err = host->ops->uhs2_detect_init(host)
>
> It looks like you didn't declare this callback as part of the struct
> mmc_host_ops, so this does not even compile. Please fix that.
>
> I also suggest moving the above comment into the header file along
> with its declaration, as it's usually where we keep this information.
>
> Moreover, to make it clear what the callback is intended for, I
> suggest renaming it to "uhs2_phy_init".

There are 5 callback functions for UHS-II:
    int   uhs2_detect_init(struct mmc_host *host);
    int   uhs2_set_reg(struct mmc_host *host, enum uhs2_action act);
    void uhs2_disable_clk(struct mmc_host *host);
    void uhs2_enable_clk(struct mmc_host *host);
    void uhs2_post_attach_sd(struct mmc_host *host);
According to your suggestion, I plan to integrate them into a single function,
named "uhs2_do_action", since they all realize the specified function by
setting the controller.

> > +       if (err) {
> > +               pr_err("%s: fail to detect UHS2!\n", mmc_hostname(host));
>
> Maybe "failed to initial phy for UHS-II", is better?

Okay. The string will be modified in the next version.

> > +       }
> > +
> > +       return err;
> >  }
> >
> >  /*
> > - * Do the early initialization of the card, by sending the device init
> > -roadcast
> > + * Do the early initialization of the card, by sending the device init broadcast
>
> Looks like you are correcting a spelling mistake, which is good.
> However, please make this a part of the patch that introduced this,
> earlier in the series.

Do you mean to create a separate patch which only contains typo correction?
If yes, should I collect such changes in previously submitted files
and put them to
a separate patch file  in the next version, even though they are the
same between
previous and next version? Or just apply this rule to later versions?

> >  /*
> >   * Read the UHS-II configuration registers (CFG_REG) of the card, by sending it
> >   * commands and by parsing the responses. Store a copy of the relevant data in
> > - * card->uhs2_config.
> > + * host->uhs2_card_prop.
>
> This isn't correct. The code below is storing the configuration in
> card->uhs2_config, which is the correct thing to do.

Okay. I will rephrase the description in the next version.

> >
> > -/*
> > +/**
> >   * Based on the card's and host's UHS-II capabilities, let's update the
> >   * configuration of the card and the host. This may also include to move to a
> >   * greater speed range/mode. Depending on the updated configuration, we may
> > -eed
> > - * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
> > + * need to do a soft reset of the card via sending it a GO_DORMANT_STATE
> > + * command.
> >   *
> >   * In the final step, let's check if the card signals "config completion",
> > -hich
> > - * indicates that the card has moved from config state into active state.
> > + * which indicates that the card has moved from config state into active state.
>
> As I said earlier, please fix spelling mistakes as part of the
> patch(es) that introduced them.
>
> >   */
> >  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> >  {
> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u16 header = 0, arg = 0;
> > +       u32 payload[2];
> > +       u8 nMinDataGap;
> > +       u8 plen;
> > +       u8 try;
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
> > +               host->flags |= MMC_UHS2_2L_HD;
> > +               nMinDataGap = 1;
> > +       } else {
> > +               /* Only support 2L-FD so far */
> > +               host->flags &= ~MMC_UHS2_2L_HD;
> > +               nMinDataGap = 3;
> > +       }
> > +
> > +       /*
> > +        * Most UHS-II cards only support FD and 2L-HD mode. Other lane numbers
> > +        * defined in UHS-II addendem Ver1.01 are optional.
> > +        */
> > +       host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> > +       card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> > +
> > +       plen = 2;
> > +       payload[0] = card->uhs2_config.n_lanes_set <<
> > +                    UHS2_DEV_CONFIG_N_LANES_POS;
> > +       payload[1] = 0;
> > +       payload[0] = cpu_to_be32(payload[0]);
> > +       payload[1] = cpu_to_be32(payload[1]);
> > +
> > +       /*
> > +        * There is no payload because per spec, there should be
> > +        * no payload field for read CCMD.
> > +        * Plen is set in arg. Per spec, plen for read CCMD
> > +        * represents the len of read data which is assigned in payload
> > +        * of following RES (p136).
> > +        */
> > +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
> > +                         NULL, 0);
> > +
> > +       err = mmc_wait_for_cmd(host, &cmd, 0);
> > +       if (err) {
> > +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                      mmc_hostname(host), __func__, err);
> > +               return -EIO;
> > +       }
> > +
> > +       arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
> > +              UHS2_NATIVE_CMD_WRITE |
> > +              UHS2_NATIVE_CMD_PLEN_8B |
> > +              (UHS2_DEV_CONFIG_PHY_SET >> 8);
> > +
> > +       for (try = 0; try < 2; try++) {
>
> This loop looks a bit odd. Perhaps you can explain why we need this
> with a comment in the code?
>
> Optionally, we could potentially also try to move some part of it into
> a separate helper function and then just call that from here instead?
> In this way, we may be able to avoid the loop altogether and thus also
> the code should become more readable. What do you think?

Agree. I will try to do it in the next version.

> > +               if (!(resp[2] & 0x80))
> > +                       break;
> > +       }
> > +
> > +       /* Set host Config Setting registers */
> > +       if (!host->ops->uhs2_set_reg ||
>
> Again, I couldn't find this callback being declared, so I guess this
> doesn't compile. Please fix that.
>
> I agree that the callback should not be optional. However, I think
> this is far too late in the initialization process to check it. This
> can be checked already when adding the host in mmc_add_host(), in case
> the host supports UHS-II, for example.
>
> Moreover, I am questioning the name of the callback. It seems like we
> are going to use it for various UHS-II operations. The name
> "uhs2_set_reg" doesn't really explain this. Maybe "uhs2_do_action", or
> if you can come up with something even better, that would be great.

Agree. As mentioned above, I plan to use uhs2_do_action to  replace 5 UHS-II
callback functions. And I will check (host->ops->uhs2_do_action) at
the beginning
of the initialization process.

> > +           host->ops->uhs2_set_reg(host, SET_CONFIG)) {
> > +               pr_err("%s: %s: UHS2 SET_CONFIG fail!\n",
> > +                       mmc_hostname(host), __func__);
> > +               return -EIO;
> > +       }
> > +
> > +static int sd_uhs2_go_dormant(struct mmc_host *host, bool hibernate, u32 node_id)
> > +{
> > +
> > +       if (host->ops->uhs2_disable_clk)
>
> Again, another callback that lacks declaration.
>
> > +               host->ops->uhs2_disable_clk(host);
>
> In fact, rather than adding another callback, we could make use of the
> "->uhs2_set_reg" callback?
>
> Or, another option would be to use the ->uhs2_set_ios(). That would be
> similar to what we do for legacy SD cards with the ->set_ios()
> callback.
>
> For example, we can do like this:
> host->ios.power_mode = MMC_POWER_ON;
> host->ios.clock = 0;
> host->ops->uhs2_set_ios(host, &host->ios);
>
> What do you think? Maybe we need a separate host->ios_uhs2 for this too?

As I mentioned above, I intend to use integrated "uhs2_do_action()".
What do you think?

> > +
> > +static int sd_uhs2_change_speed(struct mmc_host *host, u32 node_id)
> > +{
> > +
> > +       /* restore sd clock */
> > +       mmc_delay(5);
> > +       if (host->ops->uhs2_enable_clk)
> > +               host->ops->uhs2_enable_clk(host);
>
> Ditto.
>
> > +
> > +       /*
> > +        * According to UHS-II Addendum Version 1.01, chapter 6.2.3, wait card
> > +        * switch to Active State
> > +        */
> > +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
> > +                host->card->uhs2_config.node_id;
>
> Didn't you pass node_id as an in-parameter? Why can't you use that?

Oops! I missed it accidentally in the previous version. I will update
it in the next version.

> > +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> > +               UHS2_NATIVE_CMD_READ |
> > +               UHS2_NATIVE_CMD_PLEN_8B |
> > +               (UHS2_DEV_CONFIG_GEN_SET >> 8);
> >
> >
> > @@ -108,8 +724,70 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> >   * be set through a legacy CMD6. Note that, the power limit that becomes set,
> >   * survives a soft reset through the GO_DORMANT_STATE command.
> >   */
> > -static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
> > +static int sd_uhs2_legacy_init(struct mmc_host *host)
>
> Please make this change from the patch that introduced this code.

Okay.

> >  {
> > +       int err;
> > +       u32 ocr, rocr;
> > +
> > +       WARN_ON(!host->claimed);
> > +
> > +       /* Send CMD0 to reset SD card */
> > +       mmc_go_idle(host);
> > +
> > +       /* Send CMD8 to communicate SD interface operation condition */
> > +       err = mmc_send_if_cond(host, host->ocr_avail);
> > +       if (err) {
> > +               pr_err("%s: %s: SEND_IF_COND fail!\n",
> > +                      mmc_hostname(host), __func__);
> > +               return err;
> > +       }
> > +
> > +       /*
> > +        * Send host capacity support information and activate card's
> > +        * initialization process.
> > +        */
> > +       err = mmc_send_app_op_cond(host, 0, &ocr);
> > +       if (err) {
> > +               pr_err("%s: %s: SD_SEND_OP_COND fail!\n",
> > +                      mmc_hostname(host), __func__);
> > +               return err;
> > +       }
> > +
> > +       if (host->ocr_avail_sd)
> > +               host->ocr_avail = host->ocr_avail_sd;
>
> Please drop this part. I don't want to encourage host's to use
> ocr_avail_sd (for reasons that we can discuss another time).

Okay.

> If we need something specific for UHS-II, then it's better to add that.
>
> > +
> > +       /*
> > +        * Some SD cards claims an out of spec VDD voltage range. Let's treat
> > +        * these bits as being in-valid and especially also bit7.
> > +        */
> > +       ocr &= ~0x7FFF;
> > +       rocr = mmc_select_voltage(host, ocr);
> > +
> > +       /*
> > +        * Some cards have zero value of rocr in UHS-II mode. Assign host's
> > +        * ocr value to rocr.
> > +        */
> > +       if (!rocr) {
> > +               if (host->ocr_avail) {
> > +                       rocr = host->ocr_avail;
> > +               } else {
> > +                       pr_err("%s: %s: there is no valid OCR.\n",
> > +                              mmc_hostname(host), __func__);
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       /*
> > +        * Get CID, send relative address, get CSD are the same as legacy
> > +        * sd, call mmc_sd_init_card() in sd.c directly
> > +        */
> > +       err = mmc_sd_init_card(host, rocr, NULL);
> > +       if (err) {
> > +               pr_err("%s: %s: mmc_sd_init_card() fail!\n",
> > +                      mmc_hostname(host), __func__);
> > +               return err;
> > +       }
>
> So this means we will start using the host callbacks for the legacy SD
> interface, like ->set_ios() for example.

I will remove this callback and reorganize codes in this portion.

> In other words, data in host->ios.* seems to be used, both for UHS-II
> and legacy SD. That can be messy for host drivers to manage, I think.
> Maybe we should add a separate host->ios_uhs2.*, that we use solely
> for UHS2 instead?

This topic can be discussed.
The ios structure can continue to be used after adding new definitions to
certain fields, for example, adding MMC_TIMING_UHS2 for ios.timing.

> There is also another problem here. mmc_sd_init_card() will allocate a
> new struct mmc_card and assign it to host->card, if it succeeds with
> initialization.
>
> By looking at the changes below, it looks like you will assign
> host->card, with the struct mmc_card that we have allocated for UHS-II
> in sd_uhs2_init_card(), prior to calling sd_uhs2_legacy_init(). Not
> only will this lead to a memory leak, but more importantly we will
> lose all the information that we have parsed/stored from the card for
> UHS-II, right?
>
> Don't we need to keep the UHS-II information of the card around? Or is
> it okay to throw it away after initialization?
>
> What am I missing?

You are right. I will reorganize this portion.

> > +
> >         return 0;
> >  }
> >
> > @@ -124,12 +802,16 @@ static int sd_uhs2_init_card(struct mmc_host *host)
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
> > @@ -142,15 +824,26 @@ static int sd_uhs2_init_card(struct mmc_host *host)
> >         if (err)
> >                 goto err;
> >
> > +       /* Change to Speed Range B if it is supported */
> > +       if (host->flags & MMC_UHS2_SPEED_B) {
>
> I noticed that you have added the "host->flags", to keep track of
> UHS-II states and some UHS-II capabilities of the host. I would rather
> see that UHS-II host capabilities should be part of the
> host->uhs2_caps.*.

Agree. I will move the "flags" field to struct sd_uhs2_caps{} in the
next version.

> When it comes to keeping track of UHS-II states, like when we want to
> move to a new speed mode for example, that may be better to keep as a
> part of a new host->ios_uhs2.*, as I kind of indicated above.

UHS-II speed mode is only set at initialization phase and it is not
changed before hardware reset.
Hence, I think it's not necessary to place sd_uhs2_change_speed() into
host->ios_uhs2.*.
Maybe we can discuss host->ios_uhs2.* after you check my next submission.

> > +               err = sd_uhs2_change_speed(host, node_id);
> > +               if (err) {
> > +                       pr_err("%s: %s: UHS2 sd_uhs2_change_speed() fail!\n",
> > +                               mmc_hostname(host), __func__);
> > +                       return err;
> > +               }
> > +       }
> > +
> >         err = sd_uhs2_config_write(host, card);
> >         if (err)
> >                 goto err;
> >
> > -       err = sd_uhs2_legacy_init(host, card);
> > +       host->card = card;
> > +
> > +       err = sd_uhs2_legacy_init(host);
> >         if (err)
> >                 goto err;
> >
> > -       host->card = card;
>
> This is the part that will lead to the memory leak of a struct mmc_card.

I will reorganize this portion to fix this memory leak.

> >         return 0;
> >
> >  err:
> > @@ -217,6 +910,78 @@ static int sd_uhs2_hw_reset(struct mmc_host *host)
> >         return 0;
> >  }
>
> [...]
>
> I have stopped the review at this point, let's see if we can conclude
> on the way forward around my comments on the parts above, to start
> with.
>
> Kind regards
> Uffe

I will start preparing for the next version submission after receiving
your response to my question.
Thank you for your patience.

kind regards
Jason Lai
