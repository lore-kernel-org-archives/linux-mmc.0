From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: RE: [PATCH v2 1/1] mmc: dw_mmc: Add IDMAC 64-bit address mode
 support
Date: Wed, 14 Aug 2013 10:14:11 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2CD77D0@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2CD76FE@IN01WEMBXB.internal.synopsys.com>
 <520B0598.5070801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:40273 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759733Ab3HNKOU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Aug 2013 06:14:20 -0400
In-Reply-To: <520B0598.5070801@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Wei WANG <wei_wang@realsil.com.cn>, Ludovic Desroches <ludovic.desroches@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>

Hi Jaehoon Chung,

>On 08/14/2013 09:51 AM, Jaehoon Chung wrote:
> Hi Prabu,
> 
> If IP version is the lower than 2.70a, 64bit address mode didn't support.
> How do you control on this case?
> (If CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS is enabled and dw-mmc ip
> version is lower than 2.70a..)
It's a valid test case, thanks for reporting it.
I missed this condition check in my patch. Let me update it.

As per dw_mmc IP data book, the register offsets are different for both 32-bit and 64-bit configurations.
We can't use the driver in 32-bit address mode IDMAC if the driver was compiled with the CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS since it will have the register offset corresponds to 64-bit configuration. 
So, If there is any mismatch between software and hardware configurations, then we should not use the internal DMA. I will add this condition check and send it. 

> And I think that some code should reuse the existing code..
Let me try to reuse the existing code as much as possible and create a new patch.

Thanks & regards,
Prabu Thangamuthu.
