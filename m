From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH V4] Powerpc eSDHC Recover from the ADMA error
Date: Wed, 19 Sep 2012 19:57:03 -0700
Message-ID: <20120920025702.GA13639@lizard>
References: <1348107563-16545-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51542 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab2ITC7k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 22:59:40 -0400
Received: by pbbrr13 with SMTP id rr13so3991054pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 19:59:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348107563-16545-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun.Zhang@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Thu, Sep 20, 2012 at 10:19:23AM +0800, Haijun.Zhang@freescale.com wrote:
> From: Haijun Zhang <Haijun.Zhang@freescale.com>
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> ---

This one looks perfect, thanks!

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

> changes for v4:
> 	- Correct inconsistent issue
> 
> changes for v3:
>         - Correct the if statement in function workground
> 
> changes for v2:
>         - Invert the condition of the if statement in function workground
