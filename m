From: dinh.linux@gmail.com
Subject: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 28 Jun 2013 00:35:37 -0500
Message-ID: <1372397738-8093-1-git-send-email-dinguyen@altera.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52390 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3F1Ff5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jun 2013 01:35:57 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so3439415ieb.10
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jun 2013 22:35:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk

From: Dinh Nguyen <dinguyen@altera.com>

Hi Arnd/Olof,

If its not too late, can you please apply this patch? The SD/MMC driver
patch has been applied to Chris Ball's tree and this is the DTS bindings
for SD/MMC support on SOCFPGA.

Thanks,
Dinh

Dinh Nguyen (1):
  ARM: socfpga: dts: Add support for SD/MMC

 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   60 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   13 ++++-
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   13 +++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 ++++
 4 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

CC: Seungwon Jeon <tgih.jun@samsung.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
CC: Pavel Machek <pavel@denx.de>
Cc: Chris Ball <cjb@laptop.org>
CC: linux-mmc@vger.kernel.org
Cc: linux@arm.linux.org.uk
-- 
1.7.9.5

