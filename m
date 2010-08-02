From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 3/3 v2] mmc: Add ESDHC weird voltage bits workaround
Date: Mon, 2 Aug 2010 10:52:51 +0400
Message-ID: <20100802065251.GA25697@oksana.dev.rtsoft.ru>
References: <1280461977-2023-1-git-send-email-tie-fei.zang@freescale.com>
 <20100730070624.GB20351@oksana.dev.rtsoft.ru>
 <83024545B35D6445A690EFD603E7869A07ED05@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36725 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab0HBGwz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Aug 2010 02:52:55 -0400
Received: by bwz1 with SMTP id 1so1287605bwz.19
        for <linux-mmc@vger.kernel.org>; Sun, 01 Aug 2010 23:52:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <83024545B35D6445A690EFD603E7869A07ED05@zch01exm23.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

On Mon, Aug 02, 2010 at 02:19:58PM +0800, Zang Roy-R61911 wrote:
[...]
> > For p4080 it will be 'voltage-ranges = <3200 3400>;'. So, with
> > voltage-ranges we can do fine grained VDD control without
> > introducing anything new.
> why not
>                voltage-ranges = <3300 3300>;

Right you are, both will be 3300.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
