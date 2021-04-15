Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B864C433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1A261152
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 19:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhDOT3s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhDOT3r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 15:29:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54509C061574
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 12:29:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w10so17599555pgh.5
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=pTfQ6ElRzveMYG+4596oXssVf3HOzO8PnlrFcsbFyCE=;
        b=cU0QWLPJUSXRvzfmbNk9HCE5aMOlZjb8eV/vJBp6qdInriisRqlBZqvSY2oSUBxZa6
         PHKU8vK49Ow6ZFlN6/6BhLhHoWh1hr3TKSUSkBHcw18xoKyrEcHAIyPnDTDv8ZCfS8tp
         LHtXLbBq5484UHUfM54Bf8LqRKD2anjHyeF3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=pTfQ6ElRzveMYG+4596oXssVf3HOzO8PnlrFcsbFyCE=;
        b=NFtp0nkBcSIEUmb2iYhiBv0it61QgrGQIi50C4/Kt370ZGuKXaDMEb31En0/VheIEF
         9M6EKqsSvO6WpQQ3bDBI9uT6cV2VVuJqbnVb1VYsRKCzJstGh96ks/trGvM31EyoPdlC
         LM1rygES8cEraFQaUIWSw6mJAqQq1CUVrPkM8FETs8hl2sH0D5xZmJkpK7e3bsiesbqb
         AxC4wSsLJLkDp63MLL5IOxDWI04ne7XDiCbLLhJUO7agiSMvxq/lvatsHd7I/LUJji0h
         qcG+TrmC58dFaYZUDZsaWWwySpQvA0x1I2GB4ej2fjWzXoarhpJGzCK/XdH7lL/hzTVR
         I3MQ==
X-Gm-Message-State: AOAM5318mm1j9R4HMX2sc0L817SKJ4e+gxZwJDVlQvApIU56CShsx6WR
        jVuf/9OEn0QGA0kshp0t7otghw==
X-Google-Smtp-Source: ABdhPJyFAir0xQ7Bx7udarkpRVTWcbD4vVqKoIrN3fLlVVlZsf0M9MTUiwhBqi8oUnZvJZ08VuJ/uQ==
X-Received: by 2002:a63:ee42:: with SMTP id n2mr4787985pgk.37.1618514963771;
        Thu, 15 Apr 2021 12:29:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:1ddc:37d8:5171:510d])
        by smtp.gmail.com with ESMTPSA id i9sm3699276pjh.9.2021.04.15.12.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:29:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPDyKFquhnG1tGAx+GGNKM7_haThSa34FcONHGhdBwFYuryeag@mail.gmail.com>
References: <20210413003621.1403300-1-swboyd@chromium.org> <CAPDyKFquhnG1tGAx+GGNKM7_haThSa34FcONHGhdBwFYuryeag@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Don't allocate IDA for OF aliases
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 12:29:21 -0700
Message-ID: <161851496169.46595.399410018266490859@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Ulf Hansson (2021-04-15 01:56:12)
> On Tue, 13 Apr 2021 at 02:36, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > -       err =3D ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KER=
NEL);
> > -       if (err < 0) {
> > -               kfree(host);
> > -               return NULL;
> > +               index =3D ida_simple_get(&mmc_host_ida, min_idx, max_id=
x, GFP_KERNEL);
> > +               if (index < 0) {
> > +                       kfree(host);
> > +                       return NULL;
> > +               }
>=20
> This means that a DTB that is screwed up in a way that it has two mmc
> aliases with the same index, would be allowed to use the same index.
>=20
> What will happen when we continue the probe sequence in such a case?

Yeah I thought about this after sending the patch. So the problem would
be like this right?

	aliases {
		mmc1 =3D &sdhci0;
		mmc1 =3D &sdhci1;
	};

I have good news! DT won't compile it because it saw the same alias
assigned to twice. I tried it on my sc7180 board.=20

arch/arm64/boot/dts/qcom/sc7180.dtsi:35.3-18:
ERROR (duplicate_property_names): /aliases:mmc1: Duplicate property name
ERROR: Input tree has errors, aborting (use -f to force output)
arch/arm64/boot/dts/qcom/sc7180-idp.dtb] Error 2

I suppose if someone forced the compilation it may be bad, but do we
really care?

TL;DR: this seems like it isn't a problem.

>=20
> >         }
> >
> > -       host->index =3D err;
> > +       host->index =3D index;
> >
> >         dev_set_name(&host->class_dev, "mmc%d", host->index);
> >         host->ws =3D wakeup_source_register(NULL, dev_name(&host->class=
_dev));
>=20
> Another concern that could potentially be a problem, is that the
> "thread" that holds the reference that prevents ida from being
> removed, how would that react to a new mmc device to become
> re-registered with the same index?
>=20
> I wonder if we perhaps should return -EPROBE_DEFER instead, when
> ida_simple_get() fails?
>=20

Don't think so. The device (with the kobject inside) is removed, and
thus the mmc1 device will be removed, but the kobject's release function
is delayed due to the config. This means that
mmc_host_classdev_release() is called at a later time. The only thing
inside that function is the IDA removal and the kfree of the container
object. Given that nothing else is in that release function I believe it
is safe to skip IDA allocation as it won't be blocking anything in the
reserved alias case.=20

Furthermore, when the device is deleted in mmc_remove_host() there could
be other users of the device that haven't called put_device() yet.
Either way, those other users are keeping the device memory alive, but
otherwise device_del() has unlinked it from the various driver core
lists and sysfs has removed it too so it's in a state where code may be
referencing it but it's on the way out so users of the device will not
be able to do much with it during this time.

This sort of problem (if it exists which I don't think it does) would
have been there all along and can't be fixed at this level. When a
device that has an alias calls the mmc_alloc_host() function twice it
gets two different device structures created so there are two distinct
kobjects that will need to be released at some point. The index is
usually different for those two kobjects, but with aliases it turns out
it is the same. When it comes to registering that device with the same
name the second one will fail because a device with that name already
exists on the bus. This would be really hard to do given that it would
need to be the same aliased device in DT calling the mmc_add_host()
function without calling mmc_remove_host() for the first one it added in
between.

(Sorry if that is long. I'm sort of stream of conciousness writing it to
you here and not rewriting it to be more concise)
