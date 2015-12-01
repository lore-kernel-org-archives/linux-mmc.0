From: Chen Bough <Haibo.Chen@freescale.com>
Subject: eMMC tuning fail issue
Date: Tue, 1 Dec 2015 08:41:59 +0000
Message-ID: <BY1PR03MB138867E7C24E60866C690C129A0F0@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0144.outbound.protection.outlook.com ([157.56.110.144]:53600
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755807AbbLAImC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2015 03:42:02 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "nsanders@chromium.org" <nsanders@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, 

After
commit 197160d52e859575ff0ad1afd674ab2a825b9f83
Author: Nick Sanders <nsanders@chromium.org>
Date:   Tue May 6 18:52:38 2014 -0700

    mmc: sdhci: remove mdelay in eMMC tuning


I find Micron eMMC HS200 and HS400 can't pass tuning on i.MX7D platform, here is the log:

[    2.835581] sdhci: Tuning procedure failed, falling back to fixed sampling clock
[    2.843071] mmc1: tuning execution failed
[    2.847104] mmc1: error -5 whilst initialising MMC card

When I revert this commit, issue gone.

I'm not sure whether it is the limitation of Micron eMMC chip, or a common issue.

Does anyone meet the same issue on other platform or on other eMMC chip?


