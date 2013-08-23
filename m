From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 3/3 V3] mmc:esdhc: add support to get voltage from
 device-tree
Date: Thu, 22 Aug 2013 18:46:39 -0700
Message-ID: <20130823014639.GC24803@teo>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
 <1376271546-25085-2-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39317 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab3HWBqm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2013 21:46:42 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so43231pdj.11
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2013 18:46:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376271546-25085-2-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, galak@kernel.crashing.org

On Mon, Aug 12, 2013 at 09:39:04AM +0800, Haijun Zhang wrote:
> Add suppport to get voltage from device-tree node for esdhc host,
> if voltage-ranges was specified in device-tree node we can get
> ocr_mask instead of read from host capacity register. If not voltages
> still can be get from host capacity register.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>

Acked-by: Anton Vorontsov <anton@enomsg.org>
