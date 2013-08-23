From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 1/3 V5] mmc:core: parse voltage from device-tree
Date: Thu, 22 Aug 2013 18:43:44 -0700
Message-ID: <20130823014344.GA24803@teo>
References: <1376459171-21016-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:61730 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab3HWBns (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2013 21:43:48 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so37333pbb.24
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2013 18:43:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376459171-21016-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com

On Wed, Aug 14, 2013 at 01:46:11PM +0800, Haijun Zhang wrote:
> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this function
> will parse it and return the available voltage mask.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>

Acked-by: Anton Vorontsov <anton@enomsg.org>

Thanks a lot!

Anton
