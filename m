From: Michael Hunold <hunold@linuxtv.org>
Subject: SDIO_CLASS_UART and Globalsat SD-502 SDIO GPS
Date: Mon, 05 Dec 2011 13:22:01 +0100
Message-ID: <4EDCB769.2040506@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bar.sig21.net ([80.81.252.164]:36311 "EHLO bar.sig21.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932132Ab1LEMWE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Dec 2011 07:22:04 -0500
Received: from dslb-178-003-144-168.pools.arcor-ip.net ([178.3.144.168] helo=[192.168.1.135])
	by bar.sig21.net with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.69)
	(envelope-from <hunold@linuxtv.org>)
	id 1RXXYX-00085V-C0
	for linux-mmc@vger.kernel.org; Mon, 05 Dec 2011 13:22:02 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello all,

I know that this is ancient hardware, but I got my hands on a Globalsat
SD-502 SDIO GPS receiver which I'd like to use.

After adding SDIO_UART ("SDIO UART/GPS class support") the card was
correctly recognized, but unfortunately, I just received the warning

"mmc1:0000:1: need info on UART class basic setup"

on the console.

After looking at the code, it seems that support for SDIO_CLASS_UART is
simply not there (yet). :-(

There are a few screenshots in the manual that suggest that the Windows
software adds a virtual COM port with 4800bps transfer rate.

According to the datasheet, it is using "Bsquare SDIO Now!". It's
unclear if this is totally proprietary or not.

I google'd around for a few hours but I cannot find out what exactly is
missing here to get the devie running, assuming that it is a device
compatbile to SDIO_UART.

For gettting deeper into the topic, I added some debug prints to
sdio_uart_probe() and printed out the sdio_func_tuple array.

Unfortunately, only two identical tuples (code 0x21, first byte 0x0c,
second byte 0x00) are available. According to the SDIO specific
extensions, this 0x21 (= CISTPL_FUNCID) tuple should be followed by 0x22
(= CISTPL_FUNCE) but for me it isn't.

Here I am currently stuck. Does anybody know how to add support for
SDIO_CLASS_UART? Any hints are very appreciated.

CU
Michael.
