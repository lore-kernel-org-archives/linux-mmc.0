From: =?UTF-8?B?7ZmN7IugIHNoaW4gaG9uZw==?= <hongshin@gmail.com>
Subject: BUG? a suspected race bug at sdio_irq_thread()
Date: Mon, 7 Sep 2009 19:15:37 +0900
Message-ID: <2014bcab0909070315j67c5db31gff6bc70f0b6369a5@mail.gmail.com>
References: <2014bcab0909022048n2c937af4l5bd38c501469b1c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:42019 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbZIGKPe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2009 06:15:34 -0400
Received: by ywh5 with SMTP id 5so3438423ywh.4
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2009 03:15:37 -0700 (PDT)
In-Reply-To: <2014bcab0909022048n2c937af4l5bd38c501469b1c7@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello. I am reporting a suspected race bug at sdio_irq_thread()
in drivers/mmc/core/sdio_irq.c of Linux 2.6.30.5.

I hope this report is helpful. I am not certain whether this reports
real bug or not since I do not have much background.
So, please examine the report and let me know your opinion.

sdio_irq_therad() is spawned as a sdio_card_irq_get().
This thread is stopped by sdio_card_irq_put().

sdio_irq_thread() finishes its do-while iteration
when kthread_should_stop() returns true
or a condition is satisfied (break statements at line 106)

For the later case, if sdio_irq_thread() is finished
before kthread_should_stop() returns false.

In that situation, if other thread invokes kthread_stop(),
the caller of kthread_stop() might have a problem (waiting indefinitely).

Could you examine the possibility of this type of errors please?

Thank you

Sincerely
Shin Hong
