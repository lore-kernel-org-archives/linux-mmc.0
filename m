From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Subject: Re: [PATCH 4/4] mmc: mmci: Fix incorrect handling of HW flow control
 for SDIO
Date: Mon, 3 Oct 2011 09:31:14 +0200
Message-ID: <4E8964C2.5000300@stericsson.com>
References: <1317109616-18010-1-git-send-email-ulf.hansson@stericsson.com> <20111001161248.GG11710@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:36872 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750873Ab1JCHcK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2011 03:32:10 -0400
In-Reply-To: <20111001161248.GG11710@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

Hi Russel,

On 10/01/2011 06:12 PM, Russell King - ARM Linux wrote:
> Shouldn't this also re-enable the ST hardware flow control for non-SDIO
> cards?

I do not think that is needed. Hardware flow control is turned on per 
default for all cards thanks to the .clkreg member of the variant struct:

	mmci_set_clkreg():
		clk |= variant->clkreg_enable;
where
	static struct variant_data variant_ux500v2 = {
		.clkreg_enable          = MCI_ST_UX500_HWFCEN,

This means that HWFC will be on for all cards. This patch only disables 
it for SDIO cards (thanks to the mmc_card_sdio()-check) during 
problematic transfers (HW peculiarity), and then re-enables it again for 
SDIO cards during "normal" transfers. So the HWFC state for non-SDIO 
cards should not be touched I think.

Best Regards

Stefan Nilsson
