Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AFFC352BE
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76222192A
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587032829;
	bh=l8YCnCWs4zlmx+4DJ1NdC50mHzWs2GWhSyeh/7JSGYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AmvaycSqq387H0/R5RpJdHQ6DFhGGSqCSrg9oIsDD7VTE7VtXhU4QhIznRZ8i/TJZ
	 zZTQ7RNFC3Wn1Hn616N8zxf4BS6deC3ChwwIs+8ftlpTjYdqd0xrdwmsIC7+iGivmV
	 /h5Tl0Xq9aTaZoz8nJGp+9zD1LBb8HSZaPkwpH9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504859AbgDPK0j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504846AbgDPKZ6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Apr 2020 06:25:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543B42192A;
        Thu, 16 Apr 2020 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587032753;
        bh=l8YCnCWs4zlmx+4DJ1NdC50mHzWs2GWhSyeh/7JSGYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWCwMeYdHCKeI2jxlt+mAsjqUycG47EzB6/8xmwEDPjtAZS3awdO/n1Gri1Hz8+iJ
         l/5GQCqzxe/VUAr45AmUZnOz8ndVxon6ip1s69hqPNBwK9GgMbTPLTDejADbRfjUyo
         RWmuvv/ELyVW3IfIXQ4Vmu1JF3hQiCXMJTUn6f1Q=
Date:   Thu, 16 Apr 2020 12:25:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 19/19] staging: greybus: sdio: Respect the
 cmd->busy_timeout from the mmc core
Message-ID: <20200416102551.GB820251@kroah.com>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
 <20200414161413.3036-20-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161413.3036-20-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 14, 2020 at 06:14:13PM +0200, Ulf Hansson wrote:
> Using a fixed 1s timeout for all commands is a bit problematic.
> 
> For some commands it means waiting longer than needed for the timeout to
> expire, which may not a big issue, but still. For other commands, like for
> an erase (CMD38) that uses a R1B response, may require longer timeouts than
> 1s. In these cases, we may end up treating the command as it failed, while
> it just needed some more time to complete successfully.
> 
> Fix the problem by respecting the cmd->busy_timeout, which is provided by
> the mmc core.
> 
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: greybus-dev@lists.linaro.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
