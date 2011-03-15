From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V1] mx51 enchance the sd/mmc HW timing compatibility on
 mx51 boards.
Date: Tue, 15 Mar 2011 09:39:12 +0100
Message-ID: <20110315083912.GJ29521@pengutronix.de>
References: <1300159804-2095-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36883 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab1COIjV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 04:39:21 -0400
Content-Disposition: inline
In-Reply-To: <1300159804-2095-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, eric.miao@linaro.org

On Tue, Mar 15, 2011 at 11:30:04AM +0800, Richard Zhu wrote:
> Some cards have the CRC errors in read on mx51 BBG board.
> Configure the eSDHC pad configurations to level up the
> compatibility to fix this issue.

This one is already applied.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
