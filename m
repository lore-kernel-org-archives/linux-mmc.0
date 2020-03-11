Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE798C10F27
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 09:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDC62192A
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 09:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBEcC9GM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgCKJbq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:31:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46874 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgCKJbo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 05:31:44 -0400
Received: by mail-vs1-f66.google.com with SMTP id z125so835507vsb.13
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2020 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Hl0Jv3Oz8PPi8EkkFOWNauIj154EpD1JLm1YWqq4Z8=;
        b=mBEcC9GMCt0x1SlaYAUWhcIiIJuCFfJ6JeCYV7K2D92bPB2OQkpsbqy1R4FuiJ6EPB
         EjTrYITft/iCMGsWcQBKC7YKXuHooYUIkn6rkmyf1CXgV9PIXs60DGy51gBtCtaxjAEe
         UJg96dHL8Jrqqssz7HaOaaV7WleEP1VAoWImhLv4PQ2P+bL0iW3AaG+Ly2L4h9wY4WxF
         KUb/IXlpjlPDmJYCSSQkd25aezWkr4jDAxD65qenzzNV+zc5uhzJb9tcjDLIFroh5I+q
         aFZcU4e2EdtWAyakGk0LDYyzSNBeOQdrO0QonaaHOzZLhrjCKM/iSsnDyVUYWbwKjLC9
         0+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Hl0Jv3Oz8PPi8EkkFOWNauIj154EpD1JLm1YWqq4Z8=;
        b=iyIi7gdBM3D+FxTIPwcIGAF111u4gQm0vnReTjnrX9PwNPMO4v5cTukYFTLjBX3osV
         zfYrfLeRtARS8FolQTI52U+7U4FQh721eTDBrdcvbfp6us1DpJtN8OwCvCKBZVtGPHPp
         RPTLUmrB2gInWtQFb8zUIq1UkFIzG0YCtv9ZBSboQGSErplfpGtVzzzebL+3wLsI3xnw
         7yRSSsPnhJCmQ9I78EMx7JXzK0gXuqNTCmVb68HMdreLJUEaqd9PxVP7gfTxgp7qi6tV
         hTzo8ZDVKX93nG/Be886USC/xfip+06Z5pe/fhxPddu9zyTsyjoomhm3aG7fwA7jXQXG
         4D8g==
X-Gm-Message-State: ANhLgQ1ysvVxgAILF5ichFeSW1Azm/x8K39Q+hqtqVP2hg0JVGeX1n+U
        GBJv06nrZ8oyvrtQwy4tqGOsvGJEyRq9/AEjTo6sOIMD
X-Google-Smtp-Source: ADFU+vuH142ykWzbc0CwABfH5ut17ar0ugGTzGVVRIjEmTBLar4vfrWZahCNzj6oC/bVqBFRlyb27hcMfxbd8PoSf2Q=
X-Received: by 2002:a67:d03:: with SMTP id 3mr654919vsn.35.1583919102205; Wed,
 11 Mar 2020 02:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
 <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
 <20200304162844.GA11727@lst.de> <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
 <20200305152337.GC4870@lst.de> <CAPDyKFovCm5r7J4pQNfV21KiyAC+VGHvowddgkdzkSE4f3UnGA@mail.gmail.com>
 <20200306141950.GA1017@lst.de>
In-Reply-To: <20200306141950.GA1017@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Mar 2020 10:31:06 +0100
Message-ID: <CAPDyKFqPzbsCJExbkhFzu=h9BXxeZWj342hZm35AJ6j2p_QLVg@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
To:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Ludovic Barre <ludovic.Barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Ludovic Barre

On Fri, 6 Mar 2020 at 15:19, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Mar 06, 2020 at 03:02:09PM +0100, Ulf Hansson wrote:
> > That makes sense to me, but we also have other bus types to consider,
> > like the amba bus for example.
> >
> > So, in principle, those buses that may get DMA capable devices
> > attached, needs to do the allocation, that's what you are proposing?
>
> Having a dma_params allocated doesn't mean all devices are dma capable,
> for example there are PCI devices that aren't as well.

Alright. I interpret the silence as that someone (me) should send a
patch, to see if Greg is fine with it.

Please tell me, if you have other ideas of how to fix this.

Kind regards
Uffe
