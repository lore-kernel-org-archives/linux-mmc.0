Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCAAC00528
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jul 2023 16:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjGaQ1d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jul 2023 12:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGaQ12 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2023 12:27:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2A173F;
        Mon, 31 Jul 2023 09:27:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90AF268AA6; Mon, 31 Jul 2023 18:26:39 +0200 (CEST)
Date:   Mon, 31 Jul 2023 18:26:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-rtc@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM/pxa: use EXPORT_SYMBOL_GPL for
 sharpsl_battery_kick
Message-ID: <20230731162639.GA9441@lst.de>
References: <20230731083806.453036-1-hch@lst.de> <20230731083806.453036-2-hch@lst.de> <86b73242-94bb-4537-92ec-51da02127848@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b73242-94bb-4537-92ec-51da02127848@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jul 31, 2023 at 06:12:22PM +0200, Arnd Bergmann wrote:
> Or let me know if you want a better fix. Since sharpsl_pm.c and
> spitz.c are no longer loadable modules and just get linked together
> these days, I think the variant below would be simpler (this could
> be cleanup up further, endlessly, of course):

That actually looks way nicer, thanks!

If you give me a singoff I'll add it to the next version.
