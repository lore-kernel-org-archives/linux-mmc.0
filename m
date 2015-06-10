From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: 3.18 SDIO driver re-attach issue
Date: Wed, 10 Jun 2015 17:30:13 +0100
Message-ID: <55786615.7020701@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:57883 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965792AbbFJQaV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jun 2015 12:30:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC List <linux-mmc@vger.kernel.org>
Cc: =?UTF-8?B?TWFya2t1IEFodmVuasOkcnZp?= <markku.ahvenjarvi@nomovok.com>

We are having an issue with 3.18 on an OMAP3517 and a TI WL1271
Wifi SDIO card attached to an hsmmc port. The module is powered
from the main 3.3/1.8V supply rails so cannot be powered down.

The wifi driver is built as a module, and when the module is
unloaded and then reloaded the driver attach fails. The issue
is sdio_bus_probe() calls the sdio_set_block_size(, func, 0)
which fails with -110 (ETIMEDOUT) on the second load.

Is it possible we need to either ignore the error, or try and
re-set the function when either the driver un-binds / if the
first sdio_set_block_size(, func, 0) call happens?

Currently we ignore the error and the wifi driver seems to be
working with the device. If there is a better fix then we would
like to know so it can be fixed properly up-stream.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
