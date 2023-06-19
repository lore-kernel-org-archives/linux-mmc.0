Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6FFEB64DA
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jun 2023 11:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjFSLn4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jun 2023 07:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFSLny (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 07:43:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2744100
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 04:43:53 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bf5f41a87ceso351310276.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687175033; x=1689767033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6pgkQ/5PXRzxsuylEdJsCT9j/BHNO7E/gSHcNIn62E=;
        b=Ea5Y8qHZ+nfPwjAWkAYWcVkjXNEZR7CQOu9DWVoygkp96GrkCA1ynrqYV8ArDnEEY4
         sfOXsGkICTpQahzunIs6P80Oa2ZDIIfkldz23sYi/jlCiNKhqN4z0mDGdr7q0lE/qayC
         8fdu4kp2XNNrh8XLDJ31czxjb/wrIblHnlSJ8m2349IH29ws7zCZ4pHCfZCZ6X2TVmsx
         e10LW/OTKACjf5KWmSf2xvQLvaF2Yx1LRa2RBQ+MKQ4kqUldw8Msy10z+y3BeKx128Rb
         BYM4lynQqCvD3JBOJIKASaKP+D+1sOqfada0FoDF3FUHX8B7guJi79YJNHSlaEP1842y
         LvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175033; x=1689767033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6pgkQ/5PXRzxsuylEdJsCT9j/BHNO7E/gSHcNIn62E=;
        b=Nv9OIOD47EmAmLaQ3f3g55XFTcJRh/evQiB4CiBYaC/3kq9z5a8YqnmxiqnencR3Ew
         zFJcOMchTPtLH4g5xZQ2RfFZdx06KehPFjOBQm6uvVp1L38g7tEtsnZ/waU5rLjrMfoR
         SM+pz9w199ivgYvXWBkFP+WTU+XVhgpkvktaVKD0vq6FWnoGKFPoU+xhL5htpS0EM1kD
         IHD4nt+QvO4dUZD0YWrFuJ9JGrXxNsP7VpOaMVD8zGU42QEH4caenwnVXSGDJyEqeQ9G
         bKI6TtNY11N0ki4PmffCQ0sOj9ndVNDFMuvQghQCGVx6rbbh/Eay6J3vhZSld9WQh8AN
         8NmA==
X-Gm-Message-State: AC+VfDzeVkhZ74mKepMYcJ1Q2r55nEyfJEQMlNCbSjOrKXT1P0n99NWv
        t4w9LsYc8JGt17HYj7riLJB3efK52Xrq3/xPd0HHlg==
X-Google-Smtp-Source: ACHHUZ5MR50EWahOJ022groEhKxwLnWOODDAnn5He66zXrkpBRzd25nwAIBXEBkyHtM8luqJ8KiqHJ+ep44wyMePZ64=
X-Received: by 2002:a25:824d:0:b0:ba8:6643:81e2 with SMTP id
 d13-20020a25824d000000b00ba8664381e2mr5817247ybn.54.1687175033013; Mon, 19
 Jun 2023 04:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230530213259.1776512-1-robimarko@gmail.com> <CAPDyKForsVQ_inZG9+8mWdWM6-_T6O23AiwndLg33Yh7rPYTpA@mail.gmail.com>
In-Reply-To: <CAPDyKForsVQ_inZG9+8mWdWM6-_T6O23AiwndLg33Yh7rPYTpA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Jun 2023 13:43:17 +0200
Message-ID: <CAPDyKFrOG=mCW3WBr=n081EBDkKobSK_w+b6AnVAhcp_8gC5nQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
To:     Robert Marko <robimarko@gmail.com>
Cc:     "Luca Porzio (lporzio)" <lporzio@micron.com>, windhl@126.com,
        avri.altman@wdc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Jun 2023 at 00:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Luca (Bean was added by Avri in another thread)
>
> On Tue, 30 May 2023 at 23:33, Robert Marko <robimarko@gmail.com> wrote:
> >
> > It seems that Micron MTFC4GACAJCN-1M despite advertising TRIM support does
> > not work when the core is trying to use REQ_OP_WRITE_ZEROES.
> >
> > We are seeing the following errors in OpenWrt under 6.1 on Qnap Qhora 301W
> > that we did not previously have and tracked it down to REQ_OP_WRITE_ZEROES:
> > [   18.085950] I/O error, dev loop0, sector 596 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
> >
> > Disabling TRIM makes the error go away, so lets add a quirk for this eMMC
> > to disable TRIM.
>
> Let's leave this another week or so, to allow Micron folkz to confirm
> before applying.
>
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>

Applied for next and by adding a stable tag, thanks!


Kind regards
Uffe

>
> > ---
> >  drivers/mmc/core/quirks.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > index 29b9497936df..77caa0c903f8 100644
> > --- a/drivers/mmc/core/quirks.h
> > +++ b/drivers/mmc/core/quirks.h
> > @@ -100,6 +100,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
> >         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
> >                   MMC_QUIRK_TRIM_BROKEN),
> >
> > +       /*
> > +        * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
> > +        * support being used to offload WRITE_ZEROES.
> > +        */
> > +       MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> > +                 MMC_QUIRK_TRIM_BROKEN),
> > +
> >         /*
> >          * Some SD cards reports discard support while they don't
> >          */
> > --
> > 2.40.1
> >
