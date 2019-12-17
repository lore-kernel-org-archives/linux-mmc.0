Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ABAC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 07:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2314A2082E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576567946;
	bh=QzuPXnrkCynVSV/PypAUk5qfNo2RQg1vcacokLEhrH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KnyB0RIXw8dhqBj3Uc2+v6JQHR7b/feoXAJ19kxMsmnv5Fh3HWezUUUpn3ER5FmVV
	 vvwEyoVJv6tvIEZ89OM1OSlAQ/QGcYGGGXp5Nh0Vp2DWgMEeOUk6TBm+2RiINMLzb+
	 Pk2eWhzDBxytySXD2ru7eBMHPROaNPh9bVI74t8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLQHcZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfLQHcZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 02:32:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834222067C;
        Tue, 17 Dec 2019 07:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576567945;
        bh=QzuPXnrkCynVSV/PypAUk5qfNo2RQg1vcacokLEhrH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7VzoQ4fv/U8Ve/Il0VoFYq4ZW9NRa3MDDG0TA+LnoSfAhBVdumZ7q2Mwoj4xF/64
         OeiWDl4BPIEu3XMDRaA8aHbl87Qn88ZJ5S7EA9vsJWCnZxWrK+51MlxmM3ER+ZNnRo
         76AHdn+OyL76wI3/00/Lafeo3rjOEBJEqbXK2qOc=
Date:   Tue, 17 Dec 2019 08:32:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     hushiyuan@huawei.com, ulf.hansson@linaro.org, allison@lohutok.net,
        tglx@linutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: use kzalloc instead of kmalloc and memset
Message-ID: <20191217073222.GA2472756@kroah.com>
References: <1576566037-29837-1-git-send-email-zhangpan26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576566037-29837-1-git-send-email-zhangpan26@huawei.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 17, 2019 at 03:00:37PM +0800, Pan Zhang wrote:
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
> ---
>  drivers/mmc/host/vub300.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I know I can not take patches without any changelog text, hopefully
other maintainers also do the same.

Please fix,

greg k-h
