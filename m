From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] mmc: core: Fix the HPI execution sequence
Date: Wed, 20 Jun 2012 13:01:06 -0400
Message-ID: <87y5nh3okt.fsf@octavius.laptop.org>
References: <1340184834-12700-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39408 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757380Ab2FTRBW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 13:01:22 -0400
In-Reply-To: <1340184834-12700-1-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Wed, 20 Jun 2012 15:03:54 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com, alex.lemberg@sandisk.com, Kostya <kdorfman@codeaurora.org>

Hi, trivial style comments,

On Wed, Jun 20 2012, Venkatraman S wrote:
>	switch (R1_CURRENT_STATE(status)) {
>

No newline here.

>	case R1_STATE_IDLE:
>	case R1_STATE_READY:
>	case R1_STATE_STBY: /* intentional fall through */
>		/* In idle states, HPI is not needed and the caller
>		 can issue the next intended command immediately */
>		goto out;
>		break;

This might just be personal style, but I don't think of this as
"intentional fall through" -- you're just matching multiple cases.

Case fall-through would be if the code inside the cases didn't call
goto or break at the end and kept going into the next code block,
which doesn't happen here.  Here's an elegant use of fall-through:
   http://chris.printf.net/btrfs_parse_size.txt

I don't think you should bother using break after you've already
called goto.

Also, please use:
/*
 * comment 1
 * comment 2
 */

for multiline comments instead of

/* comment 1
 comment 2 */
 
Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
