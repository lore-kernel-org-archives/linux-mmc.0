Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE774C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 14:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKIOji (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKIOjh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 09:39:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEBC30A
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 06:39:36 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b185so16867926pfb.9
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 06:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4U/u8cbAVh+AV36yv6BZmejnrXhUdTMbrT5aDsSk86s=;
        b=LSFyt3GfAfQ6p8Z6oN7USp7eTKczhIozzEYrouVAbhawy63uTPpVi7IXYIQyD/u7aX
         hIMWcmLqkSBZaGvrIeZoY/+TAC6+Z+WgBcc64Kf/sCY5I6mvuB9WbTtu7jhgbnJdXhIG
         FNddG2D3Ksg2ou7Cn3u0OIOJ7LYnSB2LLR9X8XcVfRJJNfUH1JMqIkE3QGRKrQgBNsm4
         LrxjPevU9c2Y82VsT/XSx6X41j6OFt8hkmlLUcRHM/r0V3Pq3fY5OXfdgIURRXB74rFc
         AALHdwhprVFzxx5PVBsPlRpZBCPhiypt4Ajr8LDvG1EOIppsZjeaYMN3Cf/NRXbjcp5s
         Fqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4U/u8cbAVh+AV36yv6BZmejnrXhUdTMbrT5aDsSk86s=;
        b=ymj0t17uv9vhFAgqsC8YXA+ymcDFLrE6/kOELyJD31jJttGHdWLhJdfOiEha+USil3
         6GkcE3J+2/e1lwwq60l4w7lwnBp8w2/PozQ9s14GWu4EwiwL45RfPD05LiI0p4oVh3en
         NnuqYs6l0Tpd7kmAvnNyQAqWHcXaibEvqW83NEDZ5K+4K0nl2tQT2aphuERZ5Ff1Tzph
         +Qu3MWIPySPynhjjGYg79brPRUiraTUX75tofIizSwC54eD/2e25FvacTJnsD7iVG4iv
         aQOAWpaHyOC3iSRmWe9pzVMb0pHZO6s4jupQNslzb7mXjSaZMP7ZpbS+4R02769X3TZ2
         SGgQ==
X-Gm-Message-State: ACrzQf3PMmowfLmiVystJBM5ZeF4wVvYBMmGqKv7ZstEinCFCTkXcCAZ
        WZ7O5O4rDtxlPnZsOpW774z6/nd6ZO8mJ7eFKiT8mw==
X-Google-Smtp-Source: AMsMyM6T8MaKQNXIsd+cYOAqg2UZthGtfOWJT6Gxsrt65/G1pRHj92V5Gbkvpr4ZVQ1jxmsFVreCNFfPujcUzwdNNmw=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr53951069pgk.595.1668004776334; Wed, 09
 Nov 2022 06:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20221109025142.1565445-1-yangyingliang@huawei.com>
 <20221109025142.1565445-3-yangyingliang@huawei.com> <CAPDyKFrcguZWaFd51Bk-xkkVHEWG5gTVKfVHLpc2KuF06hfFug@mail.gmail.com>
 <774718be-ad03-8bf1-630c-a933b877cb72@huawei.com>
In-Reply-To: <774718be-ad03-8bf1-630c-a933b877cb72@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 15:38:59 +0100
Message-ID: <CAPDyKFoKM3Omo=cnQsY7ZaNV=9RiY7mS_-ddVjvtx=Jjxir9HA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: sdio: fix of node refcount leak in sdio_add_func()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Nov 2022 at 14:23, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
>
> On 2022/11/9 20:27, Ulf Hansson wrote:
> > On Wed, 9 Nov 2022 at 03:53, Yang Yingliang <yangyingliang@huawei.com> wrote:
> >> If device_add() returns error in sdio_add_func(), sdio function is not
> >> presented, so the node refcount that hold in sdio_set_of_node() can not
> >> be put in sdio_remove_func() which is called from error path. Fix this
> >> by moving of_node_put() before present check in remove() function.
> >>
> >> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >> ---
> >>   drivers/mmc/core/sdio_bus.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> >> index babf21a0adeb..266639504a94 100644
> >> --- a/drivers/mmc/core/sdio_bus.c
> >> +++ b/drivers/mmc/core/sdio_bus.c
> >> @@ -377,11 +377,11 @@ int sdio_add_func(struct sdio_func *func)
> >>    */
> >>   void sdio_remove_func(struct sdio_func *func)
> >>   {
> >> +       of_node_put(func->dev.of_node);
> >>          if (!sdio_func_present(func))
> >>                  return;
> >>
> >>          device_del(&func->dev);
> >> -       of_node_put(func->dev.of_node);
> >>          put_device(&func->dev);
> > Seems like we should call put_device() even if sdio_func_present()
> > returns false, don't you think?
> >
> > In this way, the corresponding sdio_release_func() will help to manage
> In sdio_release_func(), sdio_free_fun_cis() is called, it put refcount of
> 'func->card->dev', but the refcount isn't get until sdio_init_func()
> is successful. In this way, it's no need to put refcount of
> 'func->card->dev',
> so we can not call sdio_release_func() in patch1, and patch1 is needed.

I see.

However, in that case, it seems like we need to fix this slightly
differently. In patch1, we should not do the kfree() thing immediately
in the error patch, but rather rely on the reference counting (but in
a more clever way).

Kind regards
Uffe
