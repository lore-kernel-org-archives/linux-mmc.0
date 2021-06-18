Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD2C48BE8
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Jun 2021 22:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BCD611CD
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Jun 2021 22:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhFRWvu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhFRWvs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2021 18:51:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B99C061574
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2021 15:49:38 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q190so12110762qkd.2
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2021 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktb+B+b7YpWNqBLAg48mnhQI50UvERSDdtrZnblI9HU=;
        b=T9VFJX4YEeh7eMQHcPoLkAfNoNqF7kjS6JiPYqg59mdPb5UVdCl5tBXxbSMILgDEQ3
         9FA7csi/u30eQQd6DQNERCWTl+nKvU605QshIMF1sspYfxOhRnBhQhieQlb3qLyxsDop
         8ftxY9Oe2oh2yB2BsuxEaD6Ar1uw+qpqoPBUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktb+B+b7YpWNqBLAg48mnhQI50UvERSDdtrZnblI9HU=;
        b=Vw/BoPGfsaGUgEITI933KczqtJ0sPPve/34d0sFe5pweqQq05MiuFhB7NWyO1uHRhA
         0Go8G11RuU5WmEsResB92yksPWvweS6QtsrsRKHS0boSj6x+wonWBs31VEwpA+iHM78o
         eJOza/2alKol71x36yEKqdQJOrCXBMP79vgvfdENt2c9nNg/a9n8zRod9feAQUv/xg37
         BpZbqmZ1LtjGu7qN6AJKrtXK6JYydN3edpGOmJSU1awCj8las7BmUNZaTAy/pojuotMG
         mkZRfkU1sbLs80Umc/MIHXgXCbR2Jw2+iiwPyScLEWPrnF2A4BGdPHvyWQQDYH6MZKAW
         QQOA==
X-Gm-Message-State: AOAM531AF+nPw43aChSWkfCNFmNlyZIyOl6cFYAbsn+SpX5/y4PQ55Ih
        RIqb+WlJstUg5f4VvINE1v9yO1K8eGRmEQ==
X-Google-Smtp-Source: ABdhPJzfBfbndSSMGveXsOrLSNchofR45U6rzdX+CkNjlHCaXKMeVP4w898nvFZsmwU5HnEt8Dpm0A==
X-Received: by 2002:a05:620a:2221:: with SMTP id n1mr11485224qkh.317.1624056576933;
        Fri, 18 Jun 2021 15:49:36 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id f19sm5254128qkg.70.2021.06.18.15.49.35
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 15:49:35 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id j184so14767387qkd.6
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2021 15:49:35 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr16432816ybm.345.1624056575113;
 Fri, 18 Jun 2021 15:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <1623835535-30871-1-git-send-email-sbhanu@codeaurora.org> <585e003c-0342-4691-ab6d-8c6a930f9404@codeaurora.org>
In-Reply-To: <585e003c-0342-4691-ab6d-8c6a930f9404@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Jun 2021 15:49:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UVYxfZ_U+-spCcHpe6hGxKHG4SWbc6-DfzH8Ax13DNOQ@mail.gmail.com>
Message-ID: <CAD=FV=UVYxfZ_U+-spCcHpe6hGxKHG4SWbc6-DfzH8Ax13DNOQ@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci: Update the software timeout value for sdhc
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        cang@codeaurora.org, pragalla@codeaurora.org,
        nitirawa@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Jun 18, 2021 at 8:31 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
>
> On 6/16/2021 2:55 PM, Shaik Sajida Bhanu wrote:
> > Whenever SDHC run at clock rate 50MHZ or below, the hardware data
> > timeout value will be 21.47secs, which is approx. 22secs and we have
> > a current software timeout value as 10secs. We have to set software
> > timeout value more than the hardware data timeout value to avioid seeing
> > the below register dumps.
> >
> > [  332.953670] mmc2: Timeout waiting for hardware interrupt.
> > [  332.959608] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> > [  332.966450] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00007202
> > [  332.973256] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> > [  332.980054] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000027
> > [  332.986864] mmc2: sdhci: Present:   0x01f801f6 | Host ctl: 0x0000001f
> > [  332.993671] mmc2: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
> > [  333.000583] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> > [  333.007386] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> > [  333.014182] mmc2: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
> > [  333.020976] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > [  333.027771] mmc2: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x0000808f
> > [  333.034561] mmc2: sdhci: Cmd:       0x0000183a | Max curr: 0x00000000
> > [  333.041359] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
> > [  333.048157] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > [  333.054945] mmc2: sdhci: Host ctl2: 0x00000000
> > [  333.059657] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> > 0x0000000ffffff218
> > [  333.067178] mmc2: sdhci_msm: ----------- VENDOR REGISTER DUMP
> > -----------
> > [  333.074343] mmc2: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
> > 0x6000642c | DLL cfg2: 0x0020a000
> > [  333.083417] mmc2: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
> > 0x00000000 | DDR cfg: 0x80040873
> > [  333.092850] mmc2: sdhci_msm: Vndr func: 0x00008a9c | Vndr func2 :
> > 0xf88218a8 Vndr func3: 0x02626040
> > [  333.102371] mmc2: sdhci: ============================================
> >
> > So, set software timeout value more than hardware timeout value.
> >
> > Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> > ---
> >   drivers/mmc/host/sdhci.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index bf238ad..1386f7d 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1670,7 +1670,14 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> >       else if (!cmd->data && cmd->busy_timeout > 9000)
> >               timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
> >       else
> > -             timeout += 10 * HZ;
> > +            /*
> > +             * In some of the conditions hardware data timeout value could be
> > +             * approx 21.5 seconds and driver is setting software data timeout
> > +             * value less than the hardware data timeout value and software data
> > +             * timeout value should be more than the hardware data timeout value.
> > +             * So, set software data timeout value more than 21.5 sec i.e. 22sec.
> > +             */
> > +             timeout += 22 * HZ;
>
> This timeout is qcom SDHC specific.
> I think right way is to, define your own set_timeout op and update
> host->data_timeout
> in that as per qcom SDHC requirements.

It is? Off-thread Shaik was indicating that the problem had to do with
the inaccuracy of the "SDHCI_TIMEOUT_CONTROL" register. That seems to
be in the common SDHCI code. Specifically looking at
sdhci_calc_timeout() it can be seen that the possible hardware values
for the timeout double each time, so if you need a hardware timeout
that's slightly higher than one of the possible values you might end
up with a hardware timeout that's almost double what you want.

Assuming that the problem actually is with the inaccuracy of
SDHCI_TIMEOUT_CONTROL (I didn't walk through and validate), it
actually seems like we should generally be doubling the value we were
programming for the software timeout (in other words, not just ones
that are <= 9 seconds). I haven't done all the math, but I presume the
reason that we need 22 instead of 20 is some type of extra fudge
factor somewhere?

Maybe the only reason that Qualcomm hits this is due to the PLL that's
sourcing the SDHCI controller at a non-standard rate?

I suppose another reason maybe why people aren't hitting it is just
the random chance of what rate the integer overflow in
mmc_set_data_timeout() leaves you at? I pointed this out to Shiak and
was hoping a patch would be included for that, but I can always try to
write one later if not. To be concrete, I have
card->csd.taac_ns=5000000 and card->csd.r2w_factor=5. Multiplying
things out (and accounting for mult=100 for SD cards), I end up with a
timeout_ns of 0x3b9aca000 (16 seconds) which doesn't fit in the 32-bit
data->timeout_ns earlier. The truncation was making it look like the
card requested a max timeout of 3,115,098,112 ns = ~3.1 seconds.

-Doug
