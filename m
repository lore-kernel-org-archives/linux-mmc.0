Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304EC7EE2F
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Jun 2023 14:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbjFLOVV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbjFLOUu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2023 10:20:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156224481
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 07:18:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b02fcde49aso22573775ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686579414; x=1689171414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ls3j9MtBWNjJOSq/J3gcbrvP/tYri/hNMC8Wg4iBfps=;
        b=cxGXGTs6Y3ySbrFX653AO+SW2J0hZ0DfCitImPkMyn4nUQ+JaIzLgtJ790NFCiArEB
         zBjcageqV28JV13ZHsf8hZtqa/v3LZwIGOm0BEQkGxpQYYad3TH2hm5uuRrpgBWUaGPA
         Gx/DKr7kpGk9cdpTT8ibLGYVA/iRfPjBtGKdedOmyMux0QqNCppIlZI4wUVQ4Rhpm6CB
         N6x6ltxBCWjqtt2C97sDzwHiQh/sPMbhFQEHJ7pXPAPb6GWeUqc1YYdlhVhS85+tELY9
         G8o/1KyKfLRF6DZOH7sSwrLThSbTxrraR6yTHKdpaSbJ8AXhRmG27BR7WKV2DFHWHaUr
         NseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579414; x=1689171414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls3j9MtBWNjJOSq/J3gcbrvP/tYri/hNMC8Wg4iBfps=;
        b=SQjKE2T7BBVT7D8YF/k+J/7t7ZIxAaTlB9RPilCXrY/E0JNjZ5wcKKxe/u9aBLVfg1
         8QivE6T8n2OmlyGnfi5aS4Rc0KbOMXP+iq9M/ROfoMRAwCamd9R4T2PZxkff9NPULvzj
         oMnEmvMkW6aEyNOjsaqh+s94CxWNGBMS/4INqQ2TjRUrTl0rQzc16vzAnLxx+RM4tmrV
         zbCb8xkGHMNLrQohQcwz7wM90RtnMgmcVkVh7DCSmFSFh59L3FTN1say4SVUEAA3gjGO
         oZASPsc8StxNVeX4osv+76MFTGAasDQu0oL8NUy4rP/ufIUuifXvK0om7jO3aaVpfnQ6
         gsiA==
X-Gm-Message-State: AC+VfDy5rwy/9YKahTcbQjyLwz8Jpc8EeLKlQxuw+nksefn8xAJcVVMz
        w3oncWg2wUGbV0UtckSSxtYFPXqAztCm5Ur3aZt2Kg==
X-Google-Smtp-Source: ACHHUZ4dL2M4zdpF8VCYq+IUPr3A/r6UbrjnzX6erX0UGLi2xr9QdhFRm3iUkJrNSNKf/SLO9K+ISaww1BQ8CkGPnR0=
X-Received: by 2002:a17:902:f54e:b0:1aa:e5cd:647a with SMTP id
 h14-20020a170902f54e00b001aae5cd647amr8370740plf.23.1686579414496; Mon, 12
 Jun 2023 07:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230523111114.18124-1-chevron_li@126.com> <CAPDyKFrAi04_4d-F+kNncE183ZZuD9ERL2qTb+M-nj_dNfojGA@mail.gmail.com>
 <DM4PR16MB50042091C0D48F4832427F35EA51A@DM4PR16MB5004.namprd16.prod.outlook.com>
In-Reply-To: <DM4PR16MB50042091C0D48F4832427F35EA51A@DM4PR16MB5004.namprd16.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Jun 2023 16:16:18 +0200
Message-ID: <CAPDyKFo7MWvW25YBAELHA+8kZ8xFjX2Pkgusih_p4uVLxLEgQg@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue
 when 64bit DMA mode is used.
To:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>
Cc:     Chevron Li <chevron_li@126.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Justin Wang (WH)" <justin.wang@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Jun 2023 at 03:58, Chevron Li (WH) <chevron.li@bayhubtech.com> wrote:
>
> Hi, Ulf,
>
> Yes, this patch fixes a real problem.
>
> BR,
> Chevron
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Thursday, June 8, 2023 23:53
> > To: Chevron Li <chevron_li@126.com>
> > Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Shirley Her(SC) <shirley.her@bayhubtech.com>;
> > XiaoGuang Yu (WH) <xiaoguang.yu@bayhubtech.com>; Shaper Liu (WH)
> > <shaper.liu@bayhubtech.com>; Justin Wang (WH)
> > <justin.wang@bayhubtech.com>; Chevron Li (WH)
> > <chevron.li@bayhubtech.com>
> > Subject: Re: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue
> > when 64bit DMA mode is used.
> >
> > On Tue, 23 May 2023 at 13:12, Chevron Li <chevron_li@126.com> wrote:
> > >
> > > From: Chevron Li <chevron.li@bayhubtech.com>
> > >
> > > Bayhub SD host has hardware limitation:
> > > 1.The upper 32bit address is inhibited to be written at SD Host Register
> > >   [03E][13]=0 (32bits addressing) mode, is admitted to be written only at
> > >   SD Host Register [03E][13]=1 (64bits addressing) mode.
> > > 2.Because of above item#1, need to configure SD Host Register [03E][13] to
> > >   1(64bits addressing mode) before set 64bit ADMA system address's higher
> > >   32bits SD Host Register [05F~05C] if 64 bits addressing mode is used.
> > >
> > > The hardware limitation is reasonable for below reasons:
> > > 1.Normal flow should set DMA working mode first, then do
> > >   DMA-transfer-related configuration, such as system address.
> > > 2.The hardware limitation may avoid the software to configure wrong higher
> > >   32bit address at 32bits addressing mode although it is redundant.
> > >
> > > The change that set 32bits/64bits addressing mode before set ADMA
> > address,
> > >   has no side-effect to other host IPs for below reason:
> > > The setting order is reasonable and standard: DMA Mode setting first and
> > >   then DMA address setting. It meets all DMA setting sequence.
> > >
> > > Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
> >
> > Applied for next, thanks!
> >
> > Is this material for stable kernels too, as it fixes a real problem, no?
> Yes, it fixes a real problem.

Okay, I have amended the patch by adding a stable tag to it!

[...]

Kind regards
Uffe
