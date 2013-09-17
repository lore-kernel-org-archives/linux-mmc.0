From: Fabio Estevam <festevam@gmail.com>
Subject: Adding aliases to mmc
Date: Tue, 17 Sep 2013 15:04:56 -0300
Message-ID: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:41343 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068Ab3IQSE5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 14:04:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@gmail.com>
Cc: linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Hi Dirk,

I have adapted your patch at:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/111022.html

and tested it on 3.12-rc1 on a mx6qsabresd board.

Do you have plans to submit it? Maybe as a RFC?

It solves the mmcblkX order issue on my tests and it would be nice we
could have this problem addressed.

Thanks,

Fabio Estevam
