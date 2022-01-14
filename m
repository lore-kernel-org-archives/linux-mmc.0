Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14659C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Jan 2022 03:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbiANDSg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jan 2022 22:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiANDSf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jan 2022 22:18:35 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE03C061574
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jan 2022 19:18:35 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id c6so20644805ybk.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jan 2022 19:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6lhG+idPdycpEAPz9SeiBiLrqOJ+tHfZ/D5w1fAL/g=;
        b=PzupDbNcrozZ2Rb6ew8vASiwMAO6SwbJ8KvwqO909h7qKrjtEZqfMm1uALMZBkqFuP
         jAQ+wa6kfrHhbYqofAheXEF6oFOJ411YNATSU+JgxFwnLw6K7zKLQsaKX0jp/UUGCkqS
         s7a6tb+0XExh68QeKp+wppkNoEsfMlm6ow2Yi43yooqaKRHvCag6nrok7D6s7SED7Qjl
         vKksr+LpeVuSJZ4+qoXe/d8CH94up8U+BParD9H8rXurbtv1//1fyTxO3Z8AIcdA2NKD
         rTvshJrmylyTPDwHc+I2qJYHGqNUeD/5zM32p8id2ePdCDgbw9zfXOipMB8YrBZhrXuX
         C3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6lhG+idPdycpEAPz9SeiBiLrqOJ+tHfZ/D5w1fAL/g=;
        b=nBSyxKF2Xx4uqIj0zwBDZdK/4hz5frDJhH8c9CegmJg9p6kyydjt//IAeAqO+qlqya
         sKAqFAfFYTZRsWBQcwaNRpLnWov4Lghwmu7dNJP7atiTzeyoS7KF7/IUfChSMCHb8vv/
         SjTYw2lKTKVWyRAPrmf/ttDR4q89Vq1N46/3czhxw4FJwcoqaWkPMuJo61X6ylhrzjR9
         Pf0mF1sMfbYXxzRmJoGoDxaJ7JoRxSTzJtplU8B5hikG1DgXMDcmzMJV4Q1VQmYaIb7V
         no1X262CE+zTwrv3Y8fLYLGonKzgCmKLQiN1vtTULwvckxlYW7utH/1RT/dL5zffNBBM
         d2KA==
X-Gm-Message-State: AOAM531xckysShxVCCvj+kiOt4zCDY2zK3RZsxsNlGhdIDIPIZ9nIWAY
        7Mth850Hn5Fdu4BJPaz01XaAs2qzhweSrPmgChg=
X-Google-Smtp-Source: ABdhPJzS4Rs6dd7UKKPCv4J1vaEKSbkzM5ZOwhEbMkg5+x9j8OaQjrPg278y0/bQq+pyp0A+fYMOoYcWREAA8FTflVE=
X-Received: by 2002:a25:b11c:: with SMTP id g28mr9936248ybj.622.1642130314624;
 Thu, 13 Jan 2022 19:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
 <20211203105103.11306-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoptpMeKS29qqMN1E-h_FMieHAKVvbAZ6vDAYPdSuvTqQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoptpMeKS29qqMN1E-h_FMieHAKVvbAZ6vDAYPdSuvTqQ@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Fri, 14 Jan 2022 11:18:23 +0800
Message-ID: <CAG0XXUFO-NC9DOFCag9A=VEs27ZP80kPf3eTkFoFtticQksKDg@mail.gmail.com>
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
> On Fri, 3 Dec 2021 at 11:51, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
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

[...]

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

I try to make the function description more briefly:
/**
 * sd_uhs2_cmd_assemble() - build up UHS-II command packet which is embeded in
 *                          mmc_command structure
 * @cmd: MMC command to executed
 * @uhs2_cmd: UHS2 command corresponded to MMC command
 * @header: Header field of UHS-II command cxpacket
 * @arg: Argument field of UHS-II command packet
 * @payload: Payload field of UHS-II command packet
 * @plen: Payload length
 * @resp: Response buffer is allocated by caller and it is used to keep
 *              the response of CM-TRAN command. For SD-TRAN command, uhs2_resp
 *              should be null and SD-TRAN command response should be stored in
 *              resp of mmc_command.
 * @resp_len: Response buffer length
 *
 * The uhs2_command structure contains message packets which are transmited/
 * received on UHS-II bus. This function fills in the contents of uhs2_command
 * structure and embededs UHS2 command into mmc_command structure, which is used
 * in legacy SD operation functions.
 *
 */
What do you think?

kind regards,
Jason Lai

> [...]
>
> I have stopped the review at this point, let's see if we can conclude
> on the way forward around my comments on the parts above, to start
> with.
>
> Kind regards
> Uffe
