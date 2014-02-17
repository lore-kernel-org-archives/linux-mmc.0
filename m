From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [RESEND PATCHv9] mmc: dw_mmc-socfpga: Remove the SOCFPGA specific
 platform for dw_mmc
Date: Mon, 17 Feb 2014 00:30:45 -0600
Message-ID: <5301AC95.3030307@gmail.com>
References: <1391609126-16088-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:35655 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbaBQGat (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 01:30:49 -0500
Received: by mail-oa0-f52.google.com with SMTP id i4so17149316oah.39
        for <linux-mmc@vger.kernel.org>; Sun, 16 Feb 2014 22:30:48 -0800 (PST)
In-Reply-To: <1391609126-16088-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org


On 2/5/14 8:05 AM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> It turns now that the only really platform specific code that is needed for
> SOCFPGA is using the SDMMC_CMD_USE_HOLD_REG in the prepare_command function.
> Since the Rockchip already has this functionality, re-use the code that is
> already in dw_mmc-pltfm.c.
>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
Please ignore this thread. I need to rework the patch base on this
discussion:

http://thread.gmane.org/gmane.linux.kernel.mmc/25039

Thanks,
Dinh
