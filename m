From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v6] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Thu, 25 Oct 2012 01:01:20 -0700
Message-ID: <20121025080120.GA23807@lizard>
References: <1351144039-30588-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:51952 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161033Ab2JYIES (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Oct 2012 04:04:18 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so664672dak.19
        for <linux-mmc@vger.kernel.org>; Thu, 25 Oct 2012 01:04:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351144039-30588-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>, Chris Ball <cjb@laptop.org>

On Thu, Oct 25, 2012 at 01:47:19PM +0800, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> CMD23 causes lots of errors in kernel on some freescale SoCs
> (P1020, P1021, P1022, P1024, P1025 and P4080) when MMC card used,
> which is because these controllers does not support CMD23,
> even on the SoCs which declares CMD23 is supported.
> Therefore, we'll not use CMD23.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---

Looks perfect, thanks a lot!

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
