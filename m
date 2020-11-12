Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8CC56202
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 16:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2708222240
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 16:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgKLQmR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:42:17 -0500
Received: from verein.lst.de ([213.95.11.211]:44266 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgKLQmR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Nov 2020 11:42:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 581A567373; Thu, 12 Nov 2020 17:42:13 +0100 (CET)
Date:   Thu, 12 Nov 2020 17:42:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Message-ID: <20201112164213.GA16591@lst.de>
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn> <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com> <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn> <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com> <20201023091408.GA5201@lst.de> <CAPDyKFpgEcEv8FH59ntmeQADEyCs6aiS8P0tEaru858DRQup=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpgEcEv8FH59ntmeQADEyCs6aiS8P0tEaru858DRQup=A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 23, 2020 at 02:12:19PM +0200, Ulf Hansson wrote:
> SD spec mentions the write-protect switch on SD cards, while uSD cards
> doesn't have one. In general, host drivers implement support for it
> via a dedicated GPIO line routed to one of the pins in the SD slot.
> 
> In this SD controller case, which is based upon PCI, it works a bit
> differently, as the state of the write protect pin is managed through
> the PCI interface.
> 
> If I understand you correctly, you are saying that the controller
> should be able to communicate (upwards to the block layer) its known
> write protect state for the corresponding NVMe device, during
> initialization?

I got an answer form a member of the SD commitee, and the answer is:

"The SD specification define that case very clearly as following.
If card’s access is restricted through one of the SD unique features – PSWD
Lock/Unlock,  Temporary or Permanent WP (TWP or PWP) or CPRM  then if access
attempt is done through its NVMe interface the card will restrict the access
and respond with Access denied.    The access restriction shall be removed
through the SD protocol/interface before being able to access the card through
the NVMe.
That is defined as following in the section 8.1.6  of the SD7.0 onward."

Note that if you look at the spec this means only rejecting NVMe commands
that write dta for the write protect pin.
