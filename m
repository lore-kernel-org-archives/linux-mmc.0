From: Jonas Jensen <jonas.jensen@gmail.com>
Subject: Re: mmc: moxart: Add MOXA ART SD/MMC driver
Date: Wed, 21 May 2014 14:52:36 +0200
Message-ID: <CACmBeS1BUT_gW02=u89up8Xr+zNFD_BTsiB+3OFR3zODX5uW=g@mail.gmail.com>
References: <20140521122825.GE23396@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37783 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaEUMwg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 May 2014 08:52:36 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so6131067igb.14
        for <linux-mmc@vger.kernel.org>; Wed, 21 May 2014 05:52:36 -0700 (PDT)
In-Reply-To: <20140521122825.GE23396@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 21 May 2014 14:28, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Jonas Jensen,
>
> The patch 1b66e94e6b99: "mmc: moxart: Add MOXA ART SD/MMC driver"
> from Apr 9, 2014, leads to the following static checker warning:
>
>         drivers/mmc/host/moxart-mmc.c:691 moxart_remove()
>         warn: variable dereferenced before check 'mmc' (see line 687)


Thanks, I'll post a patch with fixes for this and bugs spotted by Arnd.

Regards,
Jonas
