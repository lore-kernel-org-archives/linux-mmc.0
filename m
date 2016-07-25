From: Mauro Santos <registo.mailling@gmail.com>
Subject: rtsx_pci mmc erase support
Date: Mon, 25 Jul 2016 17:46:12 +0100
Message-ID: <5a550d59-720c-a6db-27fb-40b08e263fad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37347 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbcGYQqQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2016 12:46:16 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so165405149wmg.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Jul 2016 09:46:15 -0700 (PDT)
Received: from [192.168.10.100] (bl16-55-13.dsl.telepac.pt. [188.81.55.13])
        by smtp.gmail.com with ESMTPSA id a203sm28948374wma.0.2016.07.25.09.46.13
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2016 09:46:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello, I apologize if this is not the right place to ask but submitting
a bug report to ask a question didn't seem right.

I have a laptop with a realtek pcie card reader which uses the rtsx_pci
driver and I was wondering if mmc erase command support is not (yet?)
implemented in the driver or if support is missing because the hardware
does not support it.

Both fstrim and blkdiscard fail with cards (and fs) I know that support
this.

The card reader on my laptop:
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A
PCI Express Card Reader [10ec:522a] (rev 01)


Regards,
Mauro Santos
