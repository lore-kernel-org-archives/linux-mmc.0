From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Thu, 1 Nov 2012 16:57:58 +0100
Message-ID: <CA+20K0AfmJSrPO9-_-yNk4HhEVYPj8cMaa+jCZAZhp23Vb817g@mail.gmail.com>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
	<1351584769-16662-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52040 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964810Ab2KAP57 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Nov 2012 11:57:59 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2004842iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 01 Nov 2012 08:57:58 -0700 (PDT)
In-Reply-To: <1351584769-16662-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

Hi Jerry,

2012/10/30  <r66093@freescale.com>:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> In order to check whether the card has been removed, the function
> mmc_send_status() will send command CMD13 to card and ask the card
> to send its status register to sdhc driver, which will generate
> many interrupts repeatedly and make the system performance bad.
>
> Therefore, add callback function get_cd() to check whether
> the card has been removed when the driver has this callback function.
>
> If the card is present, 1 will return, if the card is absent, 0 will return.
> If the controller will not support this feature, -ENOSYS will return.

In what cases is the performance affected by this? I believe this
function is called only on some errors and on detect?

Also, we've seen cases where the card detect GPIO cannot be trusted to
tell wether the card is present or not, for instance in the corner
case when an SD-card is removed very slowly...

Kind regards, Johan
