From: Ulrich Prinz <ulrich.prinz@googlemail.com>
Subject: some help for eMMC 8bit SDMA in sdhci_imx for i:MX25
Date: Tue, 28 Feb 2012 08:24:00 +0100
Message-ID: <CADveNG_VcK828JUXNJ7fN-YnhyB-Ad0JWagcn8mj6mQmL8A9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37978 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab2B1HYB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2012 02:24:01 -0500
Received: by iagj37 with SMTP id j37so843479iag.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2012 23:24:00 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

I encounter some harsh problems using eMMC 4.41 with i.MX25. Transfer
rates are 700kB/s and write is far below 100kB/s using write
reliability.
Used kernel ist 2.6.39.

Crawling code I found that several bits assigned to the defines are
not equal to what the programmers manual tells.
What I got working was the switching to 8bit interface for the
recognition phase. But in the moment of data transfer I get block
erros.

So my question is, has someone alreday 8bit transfers working with
this combination or can give me some helpful tips?

Best regards and thanks in advance
Ulrich
