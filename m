From: John Tobias <john.tobias.ph@gmail.com>
Subject: SDIO - High Speed - iMX6
Date: Wed, 11 Feb 2015 16:24:17 -0800
Message-ID: <CACUGKYNPE1zAHt4Hx4c5ufuHNchVXnUOC1znCa7dT9povD_CWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:60188 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbbBLAYT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Feb 2015 19:24:19 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so6516676lbd.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2015 16:24:18 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello All,

We interface the WiLink8 (http://www.ti.com/lit/gpn/wl1807mod) in iMX6
custom board. The VIO is 1.8v and the kernel detect the chip in high
speed mode with a signal voltage of 3.3v.

Is there a way to force the kernel to use a 1.8v signal voltage?.

Regards,

John Tobias
