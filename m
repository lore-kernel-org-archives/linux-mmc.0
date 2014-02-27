From: Chris Ball <chris@printf.net>
Subject: Re: [PATCHv3 1/3] mmc: dw_mmc-socfpga: Remove the SOCFPGA specific platform for dw_mmc
Date: Thu, 27 Feb 2014 02:32:14 +0000
Message-ID: <864n3ls2tt.fsf@void.printf.net>
References: <1392690662-19106-1-git-send-email-dinguyen@altera.com>
	<000101cf2cb3$06156fb0$12404f10$%jun@samsung.com>
	<530CCBBB.9010503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44535 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbaB0CcY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 26 Feb 2014 21:32:24 -0500
In-Reply-To: <530CCBBB.9010503@gmail.com> (Dinh Nguyen's message of "Tue, 25
	Feb 2014 10:58:35 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, dinguyen@altera.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 'Rob Herring' <robh+dt@kernel.org>, 'Pawel Moll' <pawel.moll@arm.com>, 'Mark Rutland' <mark.rutland@arm.com>, 'Ian Campbell' <ijc+devicetree@hellion.org.uk>, 'Kumar Gala' <galak@codeaurora.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi,

On Tue, Feb 25 2014, Dinh Nguyen wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> It turns now that the only really platform specific code that is needed for
>>> SOCFPGA is using the SDMMC_CMD_USE_HOLD_REG in the prepare_command function.
>>> Since the Rockchip already has this functionality, re-use the code that is
>>> already in dw_mmc-pltfm.c.
>>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> If you're ok with this patch series, can you please apply them for 3.15?

Thanks, pushed to mmc-next for 3.15.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
