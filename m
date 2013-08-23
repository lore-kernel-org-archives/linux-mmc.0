From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/3 V3] mmc:sdhc: get voltage from sdhc host
Date: Thu, 22 Aug 2013 18:48:41 -0700
Message-ID: <20130823014841.GD24803@teo>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
 <1376271546-25085-4-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36549 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab3HWBso (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2013 21:48:44 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so44066pdi.14
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2013 18:48:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376271546-25085-4-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, galak@kernel.crashing.org

On Mon, Aug 12, 2013 at 09:39:06AM +0800, Haijun Zhang wrote:
> We use host->ocr_mask to hold the voltage get from device-tree
> node, In case host->ocr_mask was available, we use host->ocr_mask
> as the final available voltage can be used by MMC/SD/SDIO card.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---

Reviewed-by: Anton Vorontsov <anton@enomsg.org>
