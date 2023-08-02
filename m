Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63641C001DF
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Aug 2023 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjHBL5I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Aug 2023 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjHBL5G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Aug 2023 07:57:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EFF2721;
        Wed,  2 Aug 2023 04:57:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EFCC68AFE; Wed,  2 Aug 2023 13:56:59 +0200 (CEST)
Date:   Wed, 2 Aug 2023 13:56:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: require EXPORT_SYMBOL_GPL symbols for symbol_get v2
Message-ID: <20230802115658.GA30268@lst.de>
References: <20230801173544.1929519-1-hch@lst.de> <ZMlEvr1Vo+475e5X@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMlEvr1Vo+475e5X@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 01, 2023 at 10:45:34AM -0700, Luis Chamberlain wrote:
> On Tue, Aug 01, 2023 at 07:35:39PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series changes symbol_get to only work on EXPORT_SYMBOL_GPL
> > as nvidia is abusing the lack of this check to bypass restrictions
> > on importing symbols from proprietary modules.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Let me know if you want this to go through the modules tree or your own.

I don't think this would fit anywhere but the modules tree.

Let me know if you want me to resend for the mmc dependency fixup or
if you want to squash it yourself.

