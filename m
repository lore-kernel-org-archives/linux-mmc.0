Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C36C25B70
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Oct 2023 10:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjJYKjy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Oct 2023 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjJYKjx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2023 06:39:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E0F10A;
        Wed, 25 Oct 2023 03:39:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438B2C433C7;
        Wed, 25 Oct 2023 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698230390;
        bh=5j/lBZBSSL95j90cytrU3LfBhSZWwrKbVpxEzJluqtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeAYAkPlN3ibAiyeqsVeLyqMCOaBSfmU9fvClNUkmEf1ryJP4AQ6pmTlcz6uy4+ma
         omRr5r0FHOOnPogW4sUdDGeQyNHAjkJ+PIUOMATXnikizzR+syf8K+ucUA2Hfe4hsj
         oTBhtyMhLRJ/Gq8VMKBTei2MDQRSI1BSvQEtmdcg=
Date:   Wed, 25 Oct 2023 12:39:47 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] misc: rtsx: add to support new card reader rts5264
Message-ID: <2023102514-unleash-italics-37ae@gregkh>
References: <121ced554a9e4f4791018e8f6a72d586@realtek.com>
 <2023102153-paramedic-washboard-29e3@gregkh>
 <b31f74462ce240a18652643224e285dd@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31f74462ce240a18652643224e285dd@realtek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Oct 23, 2023 at 03:31:24AM +0000, Ricky WU wrote:
> > > In order to support new chip rts5264, the definitions of some internal
> > > registers and workflow have to be modified.
> > 
> > That is fine, but that should be a single patch, right?
> > 
> 
> Sorry maybe about misunderstand, The modifications mentioned here, it talk about
> some judgment expressions add "PID 5264" to make judgement in rtsx_pcr.c, 
> so only about 30 line modified in rtsx_pcr.c
> 
> > > Added rts5264.c rts5264.h for independent functions of the new chip rts5264
> > 
> > And then add new support in a new patch, this is still too big as one
> > patch to attempt to review it properly.  Would you like to review this
> > as-is?
> > 
> 
> Yes, thank you
> Because rts5264.c rts5264.h only for rts5264 (new chip).
> The past architecture of this driver was like this, and it will good for us to maintain the driver
> different chip maybe has different functions and register definitions we used to separate different .c .h

Sorry, I don't think I was clear, this needs to be broken up into
smaller pieces to be able for us to review it properly.  Please do so
and resend a new version of the patch series.

thanks,

greg k-h
