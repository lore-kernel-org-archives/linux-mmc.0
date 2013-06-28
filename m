From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv2 2/2] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Fri, 28 Jun 2013 00:12:57 -0500
Message-ID: <51CD1B59.6020206@gmail.com>
References: <1371050331-31331-1-git-send-email-dinguyen@altera.com> <1371050331-31331-2-git-send-email-dinguyen@altera.com> <87y59vmtxu.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45129 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab3F1FNA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jun 2013 01:13:00 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so3257067iee.20
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jun 2013 22:13:00 -0700 (PDT)
In-Reply-To: <87y59vmtxu.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: dinguyen@altera.com, linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>



On 06/27/2013 10:53 AM, Chris Ball wrote:
> Hi Dinh,
> 
> On Wed, Jun 12 2013, dinguyen@altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Add platform specific functionality for the DW SD/MMC driver for
>> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
>> can use this define.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> Reviewed-by: Pavel Machek <pavel@denx.de>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Acked-by: Olof Johansson <olof@lixom.net>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com
>> CC: Seungwon Jeon <tgih.jun@samsung.com>
>> CC: Jaehoon Chung <jh80.chung@samsung.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> Cc: Olof Johansson <olof@lixom.net>
>> CC: Pavel Machek <pavel@denx.de>
>> Cc: Chris Ball <cjb@laptop.org>
>> CC: linux-mmc@vger.kernel.org
> 
> Thanks, I've taken patch 2 into mmc-next for 3.11.  Since there are no
> arch ACKs on patch 1 yet, please submit that one through arm-soc.

Thanks,

Dinh
> 
> - Chris.
> 
