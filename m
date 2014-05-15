From: Ashutosh Singh <embedded.ashu@gmail.com>
Subject: How to fix SDIO Operating Frequency in iMX6 device tree
Date: Thu, 15 May 2014 11:19:01 +0530
Message-ID: <CA+dawz2qxiVBzKkJVvMMU9wtfLajzN-z=ApmnZ3g8h42AncERQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:46683 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaEOFtC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 May 2014 01:49:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

I want to fixed the SDIO Operating Frequency to 25MHz for one of the
SDIO based Wifi module connected to Card slot.
How can i fixed it in my dtsi file. I am using iMX6 quard based custom board.

Thanks & Regard
Ashutosh
