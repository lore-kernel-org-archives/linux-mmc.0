From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] mmc: Extended the mmc_ioc_cmd IOCTL to return the cmd error number
Date: Mon, 12 Dec 2011 12:40:42 +0000
Message-ID: <201112121240.42827.arnd@arndb.de>
References: <1323685416-4306-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51011 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1LLMk4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2011 07:40:56 -0500
In-Reply-To: <1323685416-4306-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Andrei Warkentin <awarkentin@vmware.com>, Kyungmin Park <kyungmin.park@samsung.com>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org

On Monday 12 December 2011, Shashidhar Hiremath wrote:
> @@ -39,6 +39,9 @@ struct mmc_ioc_cmd {
>  
>         /* DAT buffer */
>         __u64 data_ptr;
> +       /* The error status for the Command sent */
> +       unsigned int error;
> +
>  };
>  #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr

I fear you cannot do this: This changes the ABI in an incompatible way. If you
have an application built against the previous version, you will now overwrite
random data in that application when the kernel stores the error number.

You are also changing the structure layout in a way that makes it incompatible
between 32 and 64 bit processes. Why can't you just return the error value
and not return anything else in case of cmd.error != 0?

	Arnd
