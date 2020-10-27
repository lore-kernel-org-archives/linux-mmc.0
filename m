Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7614C4363A
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 19:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89260204FD
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 19:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504288AbgJ0Th3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 15:37:29 -0400
Received: from verein.lst.de ([213.95.11.211]:42634 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504178AbgJ0Th3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 27 Oct 2020 15:37:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 207E667373; Tue, 27 Oct 2020 20:37:26 +0100 (CET)
Date:   Tue, 27 Oct 2020 20:37:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Message-ID: <20201027193725.GA5579@lst.de>
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn> <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com> <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn> <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com> <ba3c68fea4614434838a0a8cbc0e892a@realsil.com.cn> <CAPDyKFrDLJtDkkWsSENLDu2xLqptkjDk94YxYfkfW7UPBoG+bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrDLJtDkkWsSENLDu2xLqptkjDk94YxYfkfW7UPBoG+bg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Oct 27, 2020 at 01:54:46PM +0100, Ulf Hansson wrote:
> > For information security purpose, some companies or business users set their notebook SD as "read only".
> > Because a lot of "read only" requirements from those companies or business users, notebook vendor controls reader write protect pin to achieve it.
> > Notebook BIOS might have option to choose "read only" or not.
> > This is why we think write protect is more important than speed.
> 
> I understand that it may be used, in some way or the other to provide
> a hint to the operating system to mount it in read-only mode.
> 
> Although, if there were a real security feature involved, the internal
> FW of the SD card would also monitor the switch, to support read-only
> mode. As I understand it, that's not the common case.

Yes.  "Security" that relies on the driver to fall back to a different
mode doesn't work.

> 
> > If you prefer to consistent behavior, I can ignore the write protect switch for SD express.
> 
> At this point, I prefer if you would ignore the write protect switch
> in the SD controller driver.

Same here.

> According to Christoph, it should be possible to support read-only
> mode via PCIe/NVMe. You may need to add some tweaks to support this in
> the PCIe controller driver, but I can't advise you how to exactly do
> this.

The NVMe driver already supports write protected namespaces.

I'll ask my contact in the JEDEC SD card working group if there was
any consideration of the read-only handling for classic SD vs NVMe.
