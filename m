From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Tue, 11 Sep 2012 00:54:30 -0700
Message-ID: <20120911075429.GA27028@lizard>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45908 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab2IKH5D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 03:57:03 -0400
Received: by pbbrr13 with SMTP id rr13so418767pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 11 Sep 2012 00:57:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chang-Ming.Huang@freescale.com
Cc: linux-mmc@vger.kernel.org

On Tue, Sep 11, 2012 at 03:12:44PM +0800, Chang-Ming.Huang@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Below SOCs don't support the cmd23 command for MMC card,
> therefore, disable it in device tree:
> P1020, P1021, P1022, P1024, P1025 and P4080
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!
