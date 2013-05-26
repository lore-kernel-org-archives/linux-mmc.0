From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc: atmel-mci: add CONFIG_PM_SLEEP to suspend/resume functions
Date: Sun, 26 May 2013 13:57:22 -0400
Message-ID: <877gillj3x.fsf@octavius.laptop.org>
References: <000101ce44b7$68f391a0$3adab4e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43004 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633Ab3EZR51 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:57:27 -0400
In-Reply-To: <000101ce44b7$68f391a0$3adab4e0$@samsung.com> (Jingoo Han's
	message of "Mon, 29 Apr 2013 17:56:16 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Ludovic Desroches' <ludovic.desroches@atmel.com>

Hi,

On Mon, Apr 29 2013, Jingoo Han wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> build warning when CONFIG_PM_SLEEP is not selected. This is because
> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> the CONFIG_PM_SLEEP is enabled.
>
> drivers/mmc/host/atmel-mci.c:2509:12: warning: 'atmci_suspend' defined but not used [-Wunused-function]
> drivers/mmc/host/atmel-mci.c:2539:12: warning: 'atmci_resume' defined but not used [-Wunused-function]
>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
