Return-Path: <SRS0=uUZJ=BD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52138C433E4
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 13:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B075206D8
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 13:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGXNol (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:44:41 -0400
Received: from verein.lst.de ([213.95.11.211]:35740 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXNok (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Jul 2020 09:44:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A94A68AFE; Fri, 24 Jul 2020 15:44:37 +0200 (CEST)
Date:   Fri, 24 Jul 2020 15:44:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Rui Feng <rui_feng@realsil.com.cn>,
        linux-nvme@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
Message-ID: <20200724134437.GB3152@lst.de>
References: <20200716141534.30241-1-ulf.hansson@linaro.org> <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com> <CAPDyKFp3D8xZCSGNMm2ZOpa5f5wMwderCuAA5yLMXdjoKFoxQw@mail.gmail.com> <CAK8P3a3wLPv58uqTqyXk7+0Cxoe4vdfahzCxXOp2pdGZDkeFsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3wLPv58uqTqyXk7+0Cxoe4vdfahzCxXOp2pdGZDkeFsw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jul 24, 2020 at 03:35:47PM +0200, Arnd Bergmann wrote:
> Starting simple is generally a good idea, yes.
> 
> It would be good to have feedback from the nvme driver maintainers.
> 
> One way I can see the handshake working would be to have
> an sdexpress class_driver that provides interfaces for both mmc
> and nvme to link against. The mmc core can then create a
> class device when it finds an sd-express device and that
> class device contains a simple state machine that keeps track of
> what either side think is going on, possibly also providing
> a way to perform callbacks between the two sides.

None of this is in scope for the NVMe spec, so I don't really want
to deal with it in the NVMe driver in any way.  Given that a SD
express card just turns into a normal PCIe link if you really want
to check that something probed I think you'd want to track if any
PCIe driver is bound to the device.  Or just wait and see if we really
need anything after all.
