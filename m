Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15328C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Feb 2022 07:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiBVHPP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:15:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBVHPO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2022 02:15:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F63EC5D1;
        Mon, 21 Feb 2022 23:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CD89B8187C;
        Tue, 22 Feb 2022 07:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E929C340E8;
        Tue, 22 Feb 2022 07:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645514086;
        bh=42HUBcB/Xpcc3EbTCx3rh8l8f37rcOULqq05I5g7uhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmx9+EDYvsPwfCigEWjwKjdpSEwpL6ET8SPgOcFp6TsM2X9pDKOWrzzDS8V5j9PCw
         VxGI+88kENXw7ZPEQ9C8ILVGcU0+7kOzatx8TdELM2XkPET/fZtkTgZVrzfxU3Y2Hv
         egy4Pk7MlVpyGtFuo1mWD/OtTkau2hmbMZA1RJdw=
Date:   Tue, 22 Feb 2022 08:14:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Hebb <tommyhebb@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: rtsx: Let MMC core handle runtime PM
Message-ID: <YhSNZAu22OJWAlNJ@kroah.com>
References: <20220216055435.2335297-1-kai.heng.feng@canonical.com>
 <CAPDyKFrAjT2PJBg+d00Tvekujk6Bh_dsK33121Fxr9hwHi9gLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrAjT2PJBg+d00Tvekujk6Bh_dsK33121Fxr9hwHi9gLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Feb 16, 2022 at 11:29:52AM +0100, Ulf Hansson wrote:
> On Wed, 16 Feb 2022 at 06:55, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> > Since MMC core handles runtime PM reference counting, we can avoid doing
> > redundant runtime PM work in the driver. That means the only thing
> > commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") misses is
> > to always enable runtime PM, to let its parent driver enable ASPM in the
> > runtime idle routine.
> >
> > Fixes: 7499b529d97f ("mmc: rtsx: Use pm_runtime_{get,put}() to handle runtime PM")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> This looks good to me!
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Greg, do you want to funnel this through your tree - or should I wait
> for an rc containing 7499b529d97f and take it through my mmc tree?
> Either way works for me.

I will take it now, thanks.

greg k-h
