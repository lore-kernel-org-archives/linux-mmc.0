Return-Path: <SRS0=0Sxg=EK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F458C2D0A3
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Nov 2020 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51552222C
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Nov 2020 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604494014;
	bh=bVjpYOcSIHR8c7qCYo2/k+Dz0ysenQ3/fX3gxOZOh5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bNekknyYpxncYO1qpXxItqHIUptryFCa86m9DCi0nvk5di1SdNipGH8AZbWh7VrG8
	 +HAJ2/sOtvSJaIEo5xFkLw8idnZH2cc215h0V/eo5Dg/NsGYsSnFbvrkRL2Ora1sKM
	 vAhL/SJFBI803lLS0XryS5ugqgg6+ZqcIUT9mILc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgKDMqx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Nov 2020 07:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgKDMqx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Nov 2020 07:46:53 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112A4206A4;
        Wed,  4 Nov 2020 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604494012;
        bh=bVjpYOcSIHR8c7qCYo2/k+Dz0ysenQ3/fX3gxOZOh5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAL1rHODREBJks4WHF0+L6EENawAOtfM5z9NIEMs8CAtq7FbypFD7bY01NnSdn0/k
         lOjFdOCQuZvvDoAwwkdjwGIoV8rIkfnrwwDBMZ/TS9Dhc1MmGu/gT5/VBlDSn2mplx
         Tw8KU3/fuR0MN5NJP1EtAoA9V5FsB87NyQ3nX0QU=
Date:   Wed, 4 Nov 2020 13:47:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rui Feng <rui_feng@realsil.com.cn>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 1/8] mmc: rtsx: Add test mode for RTS5261
Message-ID: <20201104124743.GA2188000@kroah.com>
References: <1604397269-2780-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFru7TbT-rFMr+BsaqcahOo1K2Lk_DFtLOpSy-QuEVpmFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFru7TbT-rFMr+BsaqcahOo1K2Lk_DFtLOpSy-QuEVpmFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 04, 2020 at 01:37:57PM +0100, Ulf Hansson wrote:
> On Tue, 3 Nov 2020 at 10:54, <rui_feng@realsil.com.cn> wrote:
> >
> > From: Rui Feng <rui_feng@realsil.com.cn>
> >
> > This patch add test mode for RTS5261.
> > If test mode is set, reader will switch to SD Express mode
> > mandatorily, and this mode is used by factory testing only.
> >
> > Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> 
> Greg,
> 
> It seems this series is best funneld via my mmc tree, due to
> dependency to recent changes I have queued.
> 
> I am fine to pick this as well, but awaiting an ack from you before I go ahead.

No objection from me at all, for all of these:

	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
