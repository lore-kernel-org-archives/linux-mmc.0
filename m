From: Elie De Brauwer <eliedebrauwer@gmail.com>
Subject: [PATCH] mmc: mxs-mmc driver, correct timeout calculation
Date: Sat,  9 Feb 2013 18:47:19 +0100
Message-ID: <1360432039-5941-1-git-send-email-eliedebrauwer@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:50955 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758393Ab3BIRrh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Feb 2013 12:47:37 -0500
Received: by mail-we0-f180.google.com with SMTP id k14so3763451wer.25
        for <linux-mmc@vger.kernel.org>; Sat, 09 Feb 2013 09:47:36 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Elie De Brauwer <eliedebrauwer@gmail.com>

All,

I bumped into an issue with the mxs_ns_to_ssp_ticks() function used in 
the mxs-mmc.c host. I found out during some testing  that when I requested 
a timeout of 10 msecs, I actually ended up with a 10 second-long timeout.

If you look at the mxs_ns_to_ssp_ticks function, you see that they take
the following steps:
 - store the number of clock ticks in a milliseconds
 - converts the timeout in nssec to a timeout in msec
 - multiplying these two together gives the total number of ticks
 - divide this by 4096 (*)

This flow makes sense, but in order to convert the timeout in ns to a 
timeout in seconds, one should divide by 1000000 not by 1000 (which 
gives the timeout in usecs). Which also explains the offset by a thousand
observed in my tests.

(*) 4096 is specified in o.a. the i.MX283 reference manual page 1339,
the register stores the value in the multiples of 4096 clockticks.

Below you can find trivial patch to correct this.

my 2 cents
E.

(ps, please cc me, since I'm not on the list).


Signed-off-by: Elie De Brauwer <eliedebrauwer@gmail.com>
---
 drivers/mmc/host/mxs-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 206fe49..f25f7fe 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -339,7 +339,7 @@ static unsigned short mxs_ns_to_ssp_ticks(unsigned clock_rate, unsigned ns)
 	 * and might overflow
 	 */
 	const unsigned int clock_per_ms = clock_rate / 1000;
-	const unsigned int ms = ns / 1000;
+	const unsigned int ms = ns / 1000000;
 	const unsigned int ticks = ms * clock_per_ms;
 	const unsigned int ssp_ticks = ticks / ssp_timeout_mul;
 
-- 
1.7.10.4

