From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: Re: [PATCH 3/4] sh_mmcif: Allow the platform to specify own get_cd
 handler
Date: Thu, 26 Aug 2010 13:59:25 +0900
Message-ID: <4C75F4AD.1070804@renesas.com>
References: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
 <1282663622-20564-4-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.renesas.com ([202.234.163.13]:50215 "EHLO
	mail06.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751519Ab0HZE7q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 00:59:46 -0400
In-reply-to: <1282663622-20564-4-git-send-email-arnd@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: ian@mnementh.co.uk, sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Arnd

Thanks, your patches!

Arnd Hannemann wrote:
> In some platforms (e.g. AP4EVB) the card detect pin of a slot is not directly
> connected to the sh_mmcif controller, so that polling needs to be used. To
> overcome the overhead induced by querying the controller on each poll cycle,
> card detection can be handled in the platform code more efficiently.
> This patch exposes a get_cd hook for that purpose.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

I confirmed normal operation in the following environment.
 - AP4EVB board
 - CN7 (MMCIF)

Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>

