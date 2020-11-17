Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91254C2D0E4
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB492222E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+SVm0x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgKQLTl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQLTl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:19:41 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D6DC0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:19:41 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id s135so4434134vkh.6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kDaqJ8kkLrue4qmrknO4SrlCDqDyyEMKmp4J+D3apo=;
        b=n+SVm0x75TPgEl2WJ1O3dWpu/BUOQS5USFeoa3EG/zbaKBr+qI0ZnoxygSJ0dCjR2l
         kW3cj9kJATreCqari33Y3ZY+l2W1weHPjZHl5hfxYqwCoo7gdBOHXqooOUHctFYpX035
         y8B3iIu1Ki0lbhDhC1Vrg8bC5Pwt8+dscWQqGnMdEfHuTmqAOftXPIPmss5z6n2o1424
         XKI/2n+5QthVosjEqzYg5Ath8Cjt6q3/njU8ZFwEQSIIj9wcqVUvvPtK9hAm95NVrUOG
         8rkW+THxSQmS9LpBA5Bw4p3CNZE86tJw8kO6yABFw7iNzwTKWHZ2zDSWXP38z4TXnchn
         ucpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kDaqJ8kkLrue4qmrknO4SrlCDqDyyEMKmp4J+D3apo=;
        b=NNdpV1MaCpKdleCQck9QeSxFV6/JuyITmbEyd/Un2HObrMFh26lElCHe/PBuuCZgYc
         rZLv61/VtZV+A+eZqrAnXWtl0ywZqIk7yTgi0+oPsjEwcTWWx9Bc/YeY55JJsSROo0pQ
         aLjWlwzPgDfke/A2CrCJXQLKj7Nkm1/HC2+hkEVAOl+IBB8HrfnJOb6NKaT1KtPxu6t+
         p0/qhszaKBd3flmOcYk/rd0hbiTm4k8W7g8c7IYaLGJBn78JL2MmG2tnMWQOE9dFGRrF
         2DNPICAtPlcWUGpmnpmG0JB5QIDi/58BvEskKwYLVfGN5Vhze56FPS15iKVedgTjv424
         FN4w==
X-Gm-Message-State: AOAM533+fRf9hpR1w4+DUZoYVYgmUnZj76yClBtu+EVKnqN+HYbp1fTC
        eK/nGz1JBB73U85GleAsiG6i+wV5BWBO6Bh3Wg1c5Q==
X-Google-Smtp-Source: ABdhPJzIMRhRV/yg9aqVSCFBpvXw/1oHcK5rRxYO0qunLo0aRYFkWT0zcVlHnzaGco4oS+K+Tg5KEGhGW3vwBUm5+YU=
X-Received: by 2002:a1f:2ed2:: with SMTP id u201mr10351361vku.7.1605611980408;
 Tue, 17 Nov 2020 03:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20201102071715.18057-1-yangbo.lu@nxp.com> <CAPDyKFp9se67D-R0ay+77n9yg93APjDMvNvJATLJ7sFXn7RvfQ@mail.gmail.com>
 <AM7PR04MB688529C142BD33F6F78DDCF9F8E20@AM7PR04MB6885.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB688529C142BD33F6F78DDCF9F8E20@AM7PR04MB6885.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:19:04 +0100
Message-ID: <CAPDyKFrWo-6BPaLcD3hJaU8-PAXXCriiBbTOR792=q=NxDE70A@mail.gmail.com>
Subject: Re: [PATCH] mmc: export sd3_bus_mode to user space
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Nov 2020 at 03:44, Y.b. Lu <yangbo.lu@nxp.com> wrote:
>
> Hi Uffe,
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Monday, November 16, 2020 7:27 PM
> > To: Y.b. Lu <yangbo.lu@nxp.com>
> > Cc: linux-mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>
> > Subject: Re: [PATCH] mmc: export sd3_bus_mode to user space
> >
> > On Mon, 2 Nov 2020 at 08:26, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> > >
> > > There was no way for user to know what UHS-I modes the SD card
> > > supporting. We might not know, even the highest speed mode
> > > failed to use and fell back to a lower speed mode.
> > >
> > > This patch is to export sd3_bus_mode to user space to check.
> >
> > Well, even if the user would know, what can it do about it?
>
> For user, they can check the card speed modes capability, if they want to know.
> For developer, they can know whether card is working on highest speed mode as expect. If not, they know there is issue needed checking.
>
> >
> > Sound like you are looking for some debugging feature instead?
>
> Yes. I think we may need a way to know whether SD card is working on the highest speed mode as expect.
> Otherwise, we are not able to realize issue if card just fall back to a lower speed mode to work.
> Any suggestion on this?
>
> Thanks a lot.

Well, perhaps we should look into extending the debugfs node for the
card. See mmc_add_card_debugfs().

[...]

Kind regards
Uffe
