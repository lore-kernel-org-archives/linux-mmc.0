From: =?GB2312?B?wbrS4LfJ?= <dinuxlyf@gmail.com>
Subject: Question about ACMD42
Date: Fri, 3 Sep 2010 14:29:56 +0800
Message-ID: <AANLkTi=RUmOzwM3vzzjK=h9aQv5FV2XDmAJDWT246F0H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59237 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab0ICG36 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Sep 2010 02:29:58 -0400
Received: by wyb29 with SMTP id 29so21205wyb.19
        for <linux-mmc@vger.kernel.org>; Thu, 02 Sep 2010 23:29:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi ,
     This might be a stupid question, in  <<Physical Layer Simplified
Specification Version 2.00>>,there is a command SET_CLR_CARD_
DETECT, as spec discribed Connect[1]/Disconnect[0] the 50 KOhm pull-up
resistor on CD/DAT3 (pin 1) of
the card.
     If this command is use to switch the card beteewn the DAT[3] and
CD mode, why i don't see it's being
use in kernel. Under what circumstance we should use this command?

Regards
