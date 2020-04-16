Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A3FC2BB55
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 11:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D40D21841
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 11:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oH33bDG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633173AbgDPL1E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633100AbgDPL0z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 07:26:55 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39CAC061A10
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 04:26:55 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id c23so1796446vkc.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNpefsuCct6B4uZId4JS7PFlnG0t9azfDKQ0UhJ7Rz0=;
        b=oH33bDG29P2eFR0uj2731SAQsoJ8sGIizT62wdYvS1qnjl/GmqpEBWuoqQWb8wLvLc
         ByMlPaCKTWfabQtKILa6EoWp7X5glWTBhBfEgtOxg8kEtIvDu8Cxk6biWGBkSq9pyZyf
         nIHN8AJRMMPgDhN/FEm5LmVmBsHyM8cgx9F5rYpMBdhteTMXryXoY5gMTxUPyAFxAh2i
         /m3xjxAX19as/PK5ZnwujffpkmxY04XNlfWfqeVSnsvNIbo0m1d4VMgrf3/DIcGeotq0
         HGcbO/Vtp/yZB9ROiEoH92UlPQ0ZT1YbOSd3AaHxJ7eVFN5hTrpn3qPF0k96HWdD9XEL
         FcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNpefsuCct6B4uZId4JS7PFlnG0t9azfDKQ0UhJ7Rz0=;
        b=pL+wiDC+L03uJNx1brsbK+UEminPiXHPZAvo9/MkHiOszFc5ojdFO/fDgico6cHdpU
         kLZST9fBBNdtKQE7ieYh9Pia7WiJmjDQdg1QBFZtT57TBg6DO6col/FX2RIHiXEHJQr+
         iPXciy7is99dkUaz29zwkSUPGJgKPtMDGfsZ0CLb/KHNb5yVSLClfr5zpvLHZDgphQKm
         zToYVwoIwkXFof9IEYyQyhfo2JRrR/h3jk0ViWykK9R5BPxLDm0WtABfgL7nAUXKn7oV
         RCXKj7xkrM2JupQkZsvYiKS/fchRNSmo5ghq9odGKx+am1Z5gVc/ONR8eCOBJVcjIpYT
         TFJw==
X-Gm-Message-State: AGi0PuZ/9V5/xMtEgW6wAKt8+GzKpL9uagVzI6XlRwGKdfDjOzILugFm
        K2cVP5rtBTMiGogDJIVPRNRsGQfoAN2/dMZQvGAj1A==
X-Google-Smtp-Source: APiQypLcGn1fYqboLHcVfdnv/Lsv2p38zPGyTmjdkGNZzgb4SpztrL44PvzB1YPeh3KkNt/RYmmsPbYBqy7xc+E+v1c=
X-Received: by 2002:a1f:d084:: with SMTP id h126mr21651387vkg.25.1587036414671;
 Thu, 16 Apr 2020 04:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200410213043.1091851-1-martin.blumenstingl@googlemail.com>
 <CAPDyKFpsTTUaTLy--DvOr0oAB71cTBdH1pfTV63LtcKOKOsnDw@mail.gmail.com> <CAFBinCAhfgEdT383x61mh9E0y3-3MLA-fUmZj-4C-_VUdGWtGQ@mail.gmail.com>
In-Reply-To: <CAFBinCAhfgEdT383x61mh9E0y3-3MLA-fUmZj-4C-_VUdGWtGQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Apr 2020 13:26:18 +0200
Message-ID: <CAPDyKFrj6jdHe8OSvtuT7=QdreZ1YzMt=791ABSZfos8yux71A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Apr 2020 at 23:24, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf,
>
> thank you very much for taking the time to look into this!
>
> On Wed, Apr 15, 2020 at 2:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
> > Thanks for sending this! I assume it's a regression and caused by one
> > of my patches that went in for 5.7. Probably this one:
> > 0d84c3e6a5b2 mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard
> indeed, I only observed this with 5.7-rc1-ish, before everything was
> working fine
>
> > Now, even if enabling MMC_CAP_WAIT_WHILE_BUSY seems like the correct
> > thing to do, I suggest we really try understand why it works, so we
> > don't overlook some other issue that needs to be fixed.
> great, that's why I'm seeking for help!
>
> > Would you be willing to try a few debug patches, according to the below?
> sure
> while reading your suggestions I went back to the vendor driver and
> observed that they don't implement card_busy for this controller
> Thus I added the following line to meson_mx_mmc_card_busy for all of
> your tests to see what the controller sees in terms of our card busy
> implementation:
>   dev_info(mmc_dev(host->mmc), "%s read IRQC = 0x%08x\n",
>                  __func__, irqc);
>
> > First, can you double check so the original polling with CMD13 is
> > still okay, by trying the below minor change. The intent is to force
> > polling with CMD13 for the erase/discard operation.
> I have tried this one and it seems to work around the problem (before
> I reverted my change and dropped MMC_CAP_WAIT_WHILE_BUSY from
> mmc->caps)
> also I did not see meson_mx_mmc_card_busy being invoked (not even
> once, but I don't know if that's expected)

For eMMC it should be used quite frequently, as CMD6 is sent quite
often, during initialization for example (see mmc_switch() and
__mmc_switch()).

For SD cards, it's being used for erase/trim/discard and while
changing to UHS-I speed modes (1.8V I/O voltage, see
mmc_set_uhs_voltage(). The latter also requires your host driver to
implement the ->start_signal_voltage_switch() host ops, which isn't
the case (yet!?)

For SDIO cards it's being used in-between requests to make sure the
SDIO card is ready for the next command (see __mmc_start_request())

>
> [...]
> > Second, if the above works, it looks like the polling with
> > ->card_busy() isn't really working for meson-mx-sdio.c, together with
> > erase/discard. To narrow down that problem, I suggest to try with a
> > longer erase/discard timeout in a retry fashion, while using
> > ->card_busy(). Along the lines of the below:
> I have tried this one as well (before I reverted the earlier CMD13
> patch) and with MMC_CAP_WAIT_WHILE_BUSY unset in mmc->caps
> This doesn't seem to work around the issue - kernel log extract attached.
> Also I'm seeing that the the current meson_mx_mmc_card_busy
> implementation returns that the card is busy.
> example: 0x1f001f10 & 0x3c00 = 0x1c00. the busy logic in the driver
> is: !!0x1c00 = 1
>
> My conclusion is:
> - meson_mx_mmc_card_busy is not working and should be removed (because
> I don't know how to make it work). it probably never worked but we
> didn't notice until a recent change

I see.

Depending on what your driver plans to support for the future, see
above, you may need to come back to this in future.

> - set MMC_CAP_WAIT_WHILE_BUSY as per my initial patch
> - use Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the
> Amlogic Meson8 and Meson8b SoCs")
>
> Does this make sense?

Yes, I think so.

> Also please let me know if you want me to try something else

I would also suggest adding a patch that removes the ->card_busy() ops
from the meson driver - and that should probably also carry the same
fixes tag as above. Just to make sure the callback doesn't get used in
some other circumstances, when going forward.

Kind regards
Uffe
