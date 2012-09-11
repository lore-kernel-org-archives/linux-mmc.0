From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Tue, 11 Sep 2012 00:57:56 -0700
Message-ID: <20120911075755.GC27028@lizard>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50672 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab2IKIA3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 04:00:29 -0400
Received: by pbbrr13 with SMTP id rr13so422291pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 11 Sep 2012 01:00:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chang-Ming.Huang@freescale.com
Cc: linux-mmc@vger.kernel.org, Shaohui Xie <Shaohui.Xie@freescale.com>

On Tue, Sep 11, 2012 at 03:12:43PM +0800, Chang-Ming.Huang@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> CMD23 causes lots of errors in kernel on some freescale SoCs
> when mmc card used, which is because these controllers does
> not support CMD23, but even on SoCs which declare CMD23 is supported,
> so we'll not use CMD23.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>

This looks OK. For sdhci-pltfm,

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks.
