From: Suman Tripathi <stripathi@apm.com>
Subject: MMC issue with kingstone 4GB during enumeration
Date: Fri, 18 Sep 2015 12:10:59 +0530
Message-ID: <CAOHikRApM05X5UFU7vyAfPOv_p8S7XzxNXyXUJVqeR-KkR1fGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33138 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbIRGlA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Sep 2015 02:41:00 -0400
Received: by wiclk2 with SMTP id lk2so51059526wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2015 23:40:59 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Michal Simek <michal.simek@xilinx.com>

Hi,

Any clue on this below issue ? This happens with kingstone 4GB SDHC
(High speed).  After a retry it works fine.  Basically the APP command
retries and fails.
Anyone faced this before.


These are the errors reported:
[    6.015420] mmc0: card never left busy state
[    6.018371] mmc0: error -110 whilst initialising SD card

Any pointers will be very helpful
-- 
Thanks,
with regards,
Suman Tripathi
