Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA7C00528
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Aug 2023 17:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjHARpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHARpo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Aug 2023 13:45:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF510C1;
        Tue,  1 Aug 2023 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/SNNgw/0FDaNa7MTCNWJpiQbUlIU4iWNomHuRRVtt+I=; b=H9B1lsIkB15nld7dwESmfbaR7w
        WeN0JxBza+uKWmSaQBaYPxF7vfSsrbCuvkUU9fMtXortagJLx1Z7gKKPhMk0dumxD+Vat/LzD5ujW
        gmA1NquVRC4+tgo23/jsSIoUTQkYWFBAO6zhnR24V8pr92HmKcMVoZG99hcZ6fRndSfh6tVETsGT7
        zUj6K8TI3K4Ddj0Haw1c6Qoh3BPmbRKTb1aCCq5K0bPeLyBJDep2WhBhIpA01MZZZNh0eI+AUpfgA
        UndiA96n1UbMqiBbuO2GCO7v2gWTXYgQyVASSXos+NIzjzcxbsE3mZ1OACtLOJnMqn1+m+VZWtZY8
        S2xwl0xw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQtR8-002xRj-1K;
        Tue, 01 Aug 2023 17:45:34 +0000
Date:   Tue, 1 Aug 2023 10:45:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <ZMlEvr1Vo+475e5X@bombadil.infradead.org>
References: <20230801173544.1929519-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801173544.1929519-1-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 01, 2023 at 07:35:39PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series changes symbol_get to only work on EXPORT_SYMBOL_GPL
> as nvidia is abusing the lack of this check to bypass restrictions
> on importing symbols from proprietary modules.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Let me know if you want this to go through the modules tree or your own.

  Luis

