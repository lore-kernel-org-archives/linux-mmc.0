From: Michael Meng <michael.h.meng@gmail.com>
Subject: Send CMD12 to terminate the mmc writing request?
Date: Sat, 23 Apr 2011 14:49:38 +0900
Message-ID: <BANLkTi=k9fhGDJxyBkE5K2Jq9ip4-Mkpiw@mail.gmail.com>
References: <c16c6fd4-41fa-4eb0-94d1-81477fe086bc@k3g2000prl.googlegroups.com>
Reply-To: Michael.H.Meng@Gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35067 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab1DWFtj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Apr 2011 01:49:39 -0400
Received: by vxi39 with SMTP id 39so814114vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 22:49:38 -0700 (PDT)
In-Reply-To: <c16c6fd4-41fa-4eb0-94d1-81477fe086bc@k3g2000prl.googlegroups.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I am a fresher to linux kernel and now trying to add some features to
mmc driver.

One of the features is that terminate a long time writing request(e.x.
lasts 50ms or more), and make the following reading request run.

I read the JEDEC STANDARD and found that a writing operation could be
terminated with sending a STOP_TRANSMISSION(CMD12).
But I am not quite sure how I can send the command.

Here is the working flow I am working in:

1) In the function mmc_blk_issue_rq() @ drivers/mmc/card/block.c
=C2=A0 before mmc_wait_for_req() is called, check if the request to be
issued is WRITE.
=C2=A0 If it is a WRITE request, add a timer of 50ms to check whether i=
t
is a long time writing operation.
2) In the timeout callback function, get the next request in the queue
and check whether it is a READ request.
=C2=A0 If it is a READ request, send a STOP_TRANSMISSION command with
mmc_wait_for_cmd() to terminate the request.

But I got some fault messages when I sent the STOP_TRANSMISSION
command.

It seems that without completing the WRITE request sent by
mmc_wait_for_req(), the STOP_TRANSMISSION command(sent with
mmc_wait_for_cmd() ) could not be accepted, because in the function of
mmc_wait_for_cmd(), mmc_wait_for_req() is called.
And that is why I got the fault messages.

So my question is,
How to send a STOP_TRANSMISSION command to terminate the writing
request in my case.


Thanks!
