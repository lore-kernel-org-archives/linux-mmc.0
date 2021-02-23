Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3BC433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4CF64DDC
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 11:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBWLUS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhBWLUR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Feb 2021 06:20:17 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19971C061574
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 03:19:37 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id r23so62618614ljh.1
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 03:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/4+/d5HIMl/XRPFcbY7u3fPHH9Hmv2e58iXY0vMXALw=;
        b=Ey5m0nqk5Hcah1kuHEYtpQUstT/BvyBppCuRDk7asm+Hsl6wSKK5iMqV0Ik7pXYZcN
         EVov+Q1iOuc8P95U0Bun0jEOuJJ1sN3/8nYrce/JFHbAi+huJ4uJt0iuTLsoJzuoKgHY
         C6APprt2am1DNDCHNInSSZXvNjHNMG2wI/bJCGiwlYlB7B5lg0QEnmNGKp70CTyO5x9h
         aiBAwc+YeF9vHMtgZob9+5sCxy97eqryQNG3Dc+juecbaHGYOvbzvsZ9aBQfCjozpKsm
         /pxVNFXCOLZ0U/F4lFPa24kBzxoI1GTKGL3jOooQRtNkXgOWHbX3ZQAjSjmWArk7sKZB
         uBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/4+/d5HIMl/XRPFcbY7u3fPHH9Hmv2e58iXY0vMXALw=;
        b=Ol8UEBsy6JhDmVsCuvTh/+OlRXz/tDlc4W/nGx8U8DRorxvija5VONxoGD18Wz1C3S
         t1aGAstD4CRMdUlkmUfaGNOdLRsLqfM8othftyrX6hXXNcNKcniDTC7cJGrt4RQdEjBt
         OSOIq5Wcg5TIHkHCRtc3Pc3SPPnqPO7OpIJOEG1afhR8k5PLA+T3FHo9prJqB5CA3oJr
         VouG0ouJrnP/mC8kwf8Cr8VQp1D91SqOOePdhzPXoMHNP3z5gt+sTvUtY8L8jt6tkRMN
         KTtif960KBB8DHb7ow5fA1le9CdPpH5iA867ekbxngAy7FgDfK01nUiMUa5wI+1w8rwr
         oKxA==
X-Gm-Message-State: AOAM530hyFpQ+uqZ+DXw3eHxTIrCkZVR4TrA8jqe8K9WRk5INHW03ZpZ
        BhFXq2wWdVPzdhQ5bX9Bxsw=
X-Google-Smtp-Source: ABdhPJyRXWVH+fFo44RXZZF16TkaGJh07dIC+ELDer+jUmTPtJNVYH6jGPrBKDxtl6aznupvNx5+hg==
X-Received: by 2002:a2e:5007:: with SMTP id e7mr7927882ljb.452.1614079174198;
        Tue, 23 Feb 2021 03:19:34 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id d14sm2545702lfg.128.2021.02.23.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:19:33 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 11NBJUdj011092;
        Tue, 23 Feb 2021 14:19:31 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 11NBJRkI011091;
        Tue, 23 Feb 2021 14:19:27 +0300
Date:   Tue, 23 Feb 2021 14:19:26 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout
 in __mmc_switch()
Message-ID: <20210223111926.GC2059@home.paul.comp>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
 <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp>
 <20210222201245.GW2059@home.paul.comp>
 <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
 <20210223093247.GA2059@home.paul.comp>
 <3c8007d5-4040-2a43-59a5-08579824ddff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c8007d5-4040-2a43-59a5-08579824ddff@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Adrian,

On Tue, Feb 23, 2021 at 01:01:09PM +0200, Adrian Hunter wrote:
> On 23/02/21 11:32 am, Paul Fertser wrote:
> > Hello Ulf,
> > 
> > On Tue, Feb 23, 2021 at 10:23:28AM +0100, Ulf Hansson wrote:
> >>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>> index f5dedb7f9b27..9adf735391fa 100644
> >>> --- a/drivers/mmc/core/mmc.c
> >>> +++ b/drivers/mmc/core/mmc.c
> >>> @@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
> >>>                 /* EXT_CSD value is in units of 10ms, but we store in ms */
> >>>                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
> >>>                 /* Some eMMC set the value too low so set a minimum */
> >>> -               if (card->ext_csd.part_time &&
> >>> -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> >>> +               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> >>>                         card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
> >>>
> >>>                 /* Sleep / awake timeout in 100ns units */
> >>>
> >>> I do not see any more warnings on my system.
> >>
> >> That looks like the correct fix to the problem. Do you want to send a
> >> proper patch that I can pick up or do you prefer if help to do it?
> > 
> > I've sent this as a diff precisely because 1c447116d017 was so
> > explicit about special-casing zero ext_csd timeout value, so I thought
> > probably Adrian can provide the rationale for that. I'd prefer to wait
> > for his feedback before sending a formal patch. Does this make sense?
> 
> Zero means indefinite.  Might be safer to use a higher value than
> MMC_MIN_PART_SWITCH_TIME for that case.  The maximum GENERIC_CMD6_TIME is
> 2550 ms.

Thanks for the clarification! I would guess that most likely than not
when whoever defines that value to be zero it means "I do not
care/know" rather than "the timeout must be set to more than 2550 ms,
too bad 8 bits are not enough to represent that". I'd say setting it
to DEFAULT_CMD6_TIMEOUT_MS should be safe enough since it worked
before.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
