Return-Path: <SRS0=6IoW=5D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004A1C10DCE
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Mar 2020 10:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C948720770
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Mar 2020 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584528211;
	bh=qgpXpmvoODPFBgdpCT+NvuJfYW6INAfYOL+ojUmYZXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hz0yWXGQVldRl7WwcqjVX5d/KFg/TnbtESVD13jFRDKh+yEhpLnVMONNg6AJAjNFM
	 yha/fjk6r20JbpQ+ex33WkMtST04XfqyfijCdv4+x4Zoj8/NvnjlzKbz9SQj6I8Kqf
	 obfBbkH+Y0Y5317cWDSnzgtSFjEu96zKnlsSbT+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCRKn0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgCRKnZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Mar 2020 06:43:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02EB2076C;
        Wed, 18 Mar 2020 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584528204;
        bh=qgpXpmvoODPFBgdpCT+NvuJfYW6INAfYOL+ojUmYZXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/duaUqjwhyBOvqUSIpDoFo0caz2NK5PPi4FsmSNri8z1BFnkpR/Q1478GFYTHyVv
         2LNit+7D0MSz6r14hKBtHTq8lffQcrUHneIeC71jZ7dq8mgICP9HI33dTkOzh6JQ0w
         W/65wXyU6XZbtga+/b4TtSu8EZnX/Ab1LHeZfAHw=
Date:   Wed, 18 Mar 2020 11:43:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rtsx: Fixed TX/RX register and optimized TX
 parameter
Message-ID: <20200318104321.GA2303953@kroah.com>
References: <20200316025232.1167-1-ricky_wu@realtek.com>
 <CAPDyKFrWedEmZ=0trPEG8Z-11nyFX6_OB3cx7+SAdB5VW_vzgQ@mail.gmail.com>
 <6196929373bb43c8b8fbc550ad41e1fc@realtek.com>
 <CAPDyKFqfNp0uo6oY2ZkYVYknkYiyovtU2Ss4+y39AnuRi4nWVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqfNp0uo6oY2ZkYVYknkYiyovtU2Ss4+y39AnuRi4nWVQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 17, 2020 at 12:58:35PM +0100, Ulf Hansson wrote:
> On Tue, 17 Mar 2020 at 03:45, 吳昊澄 Ricky <ricky_wu@realtek.com> wrote:
> >
> >
> > > -----Original Message-----
> > > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > Sent: Monday, March 16, 2020 10:17 PM
> > > To: 吳昊澄 Ricky
> > > Cc: linux-mmc@vger.kernel.org; Linux Kernel Mailing List; Arnd Bergmann; Greg
> > > Kroah-Hartman
> > > Subject: Re: [PATCH] mmc: rtsx: Fixed TX/RX register and optimized TX
> > > parameter
> > >
> > > On Mon, 16 Mar 2020 at 03:52, <ricky_wu@realtek.com> wrote:
> > > >
> > > > From: Ricky Wu <ricky_wu@realtek.com>
> > > >
> > > > Fixed sd_change_phase TX/RX register
> > > > Optimized rts522a rts524a rts525a rts5260 rts5261 TX initial parameter
> > >
> > > I don't understand what this actually fixes. Can you try to elaborate
> > > a bit on this, please?
> > >
> > > Do you think this is needed for stable, then why?
> >
> > Yes, I think it need patch to stable
> >
> > In function sd_change_phase() whether it is TX or RX always write the same register(TX), so patch this function make RX and TX can change well.
> > At mmc stack mechanism do not tuning TX phase, so need give a stable parameter for TX phase(sdr104 sdr50 ddr50) at initial.
> 
> Alright, I took the liberty to clarify the changelog a bit according
> to this. Please have a look at my fixes branch and tell me if I should
> do some additional changes of the changelog.
> 
> Applied for fixes and by adding a stable tag, thanks!
> 
> Arnd, Greg, so I am picking this via my mmc tree, please shout at me
> (or ack it) if you have any concerns with this. :-)

No concerns at all!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
