From: John <john.maximus@gmail.com>
Subject: cmd5 response
Date: Sun, 17 Oct 2010 21:31:51 +0530
Message-ID: <AANLkTim9d04B+gQRWDk93DKEJ62X5epLjchXOmv0WEo7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35200 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020Ab0JQQBw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Oct 2010 12:01:52 -0400
Received: by qwa26 with SMTP id 26so21632qwa.19
        for <linux-mmc@vger.kernel.org>; Sun, 17 Oct 2010 09:01:51 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,
  I am trying to read Cis Data from u-boot.

  I find that the response to CMD5 is 0x90ff8000.
  The Number of I/O functions is 1. I use a WLAN Card. Wlan cards
usually have 2 functions. is something wrong?

   How to de-code this response - Is OCR = 0x90FF? I read that the
28,29,30 Bits are the I/O functions.

   am i missing something?

  I find that When i try to send CMD0 and CMD5 all over again. The
card does not respond.

  Are there any sample codes to read the vendor Info like Vendor ID?

Thank you very much,

Regards,
John
