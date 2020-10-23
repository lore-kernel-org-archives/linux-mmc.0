Return-Path: <SRS0=9HeC=D6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD1C56202
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8621241A4
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 09:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461183AbgJWJOQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Oct 2020 05:14:16 -0400
Received: from verein.lst.de ([213.95.11.211]:55330 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461148AbgJWJOM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 23 Oct 2020 05:14:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3632C67373; Fri, 23 Oct 2020 11:14:09 +0200 (CEST)
Date:   Fri, 23 Oct 2020 11:14:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Message-ID: <20201023091408.GA5201@lst.de>
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn> <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com> <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn> <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 23, 2020 at 10:02:15AM +0200, Ulf Hansson wrote:
> > > Is there no mechanism to support read-only PCIe/NVMe based storage devices?
> > > If that is the case, maybe it's simply better to not support the readonly option
> > > at all for SD express cards?
> > >
> > I think there's no mechanism to support read-only PCIe/NVMe based storage devices.
> 
> I have looped in Christoph, maybe he can give us his opinion on this.

NVMe namespaces can have a bunch of 'write protection' modes advertised
by the controller, which Linux respects.  The controller in this case would
be part of the SD-Card.  IMHO it is a quality of implementation issue
of the SD-Card/Controller to have the the write protection mode of the
namespace(s) match that of the SD interface, and the SD card spec should
talk about that if it doesn't already.
