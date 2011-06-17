From: Daniel Drake <dsd@laptop.org>
Subject: SD8686 fast power-cycle problems
Date: Fri, 17 Jun 2011 17:39:37 +0100
Message-ID: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39037 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1FQQji (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2011 12:39:38 -0400
Received: by pzk9 with SMTP id 9so1909034pzk.19
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2011 09:39:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei.gao@marvell.com, bzhao@marvell.com, bchau@marvell.com
Cc: linux-mmc@vger.kernel.org

Hi,

Thanks for your help and explanations with earlier issues around the
power-on and reset sequence for the SD8686.

We are still struggling a little with this, in the context of enabling
runtime power management.

If we power down the card, and then *immediately* power it on again
(and performing the CMD5,5,3,7 init sequence), the card fails to
respond to the first CMD5.

We have identified two workarounds to this problem:
1. If we wait 300ms after powering off the card before turning it on
again, it works fine.

2. If we perform a SDIO I/O reset after powering on, before starting
the 5,5,3,7 sequence, it works fine.

Do you have any comments or possible explanations for this issue? Is
it something you are aware of?

Thanks,
Daniel
