From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Help needed on an error during SD card enumeration
Date: Mon, 21 Jan 2013 19:11:39 +0530
Message-ID: <CANYdXnrSP80ex7xCr029D_AQPRWjShnrvckPt0Hu7cVYx0QicQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34255 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab3AUNlj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 08:41:39 -0500
Received: by mail-ie0-f171.google.com with SMTP id 9so5932108iec.2
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jan 2013 05:41:39 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jae hoon Chung <jh80.chung@gmail.com>

Hi All,
  I was testing a custom linux hand written driver for Synopsys
Designware IP. The log suggests following error :-

Sending Cmd 52
resp 0

Sending Cmd 52
resp 0

Sending Cmd 0
resp 0

Sending Cmd 8
resp 0x1a

Sending Cmd 5
resp 0x1a

mmc0:host doesn't support card's voltages
set_ios invoked
Poweroff Done

mmc0: error -22 whilst initializing SDIO card
eventhough I have inserted a SD card
--
regards,
Shashidhar Hiremath
