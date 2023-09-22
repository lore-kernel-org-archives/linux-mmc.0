Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3BECD4F3B
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Sep 2023 09:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjIVJ3Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Sep 2023 05:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjIVJ3O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2023 05:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500F1AB;
        Fri, 22 Sep 2023 02:29:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB70C433D9;
        Fri, 22 Sep 2023 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695374947;
        bh=t2aM7shiMBsolmhAQmRyMhH0S1BzPym6WZgDZA31JT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LD7B90GBbqSdb29gB8BawZc0/3rfHXPpNqj0xsjC+OgXOe7i0q4bmi5yuWJIpiMnW
         zUJQQ82obbV2uQEbULqs/lqbF7qG0h5M5eNqMLRzTbk4TtQiNh36LSub5NiuAZ09A/
         qf/3kw5WrCuu2GFoAf4J+SQRu2vzLAVSX4uc+KvI=
Date:   Fri, 22 Sep 2023 11:29:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for
 Micron eMMC Q2J54A
Message-ID: <2023092253-suffice-mulled-b8fa@gregkh>
References: <20230921203426.638262-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921203426.638262-1-beanhuo@iokpp.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 21, 2023 at 10:34:26PM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
> operation be allowed only after a write has occurred. Otherwise, the
> cache flush command or subsequent commands will time out.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Co-developed-by: Rafael Beims <rafael.beims@toradex.com>

Then Rafael also has to sign off on this, right?

