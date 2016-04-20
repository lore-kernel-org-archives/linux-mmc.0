From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Wed, 20 Apr 2016 02:02:13 +0200
Message-ID: <5170197.yUbCAn9kNF@wuerfel>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <5716BEC7.5000706@caviumnetworks.com> <3904622.mKVlLT0JKv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:65505 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbcDTACj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 20:02:39 -0400
In-Reply-To: <3904622.mKVlLT0JKv@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On Wednesday 20 April 2016 01:57:08 Arnd Bergmann wrote:
> If you do this
> 
>         wait_event(&host->wq, !host->current_req);
> 
> in the request function as well as 
> 
>         wake_up(&host->wq);
> 
> after setting host->current_req to NULL, I think you end up with
> the same level of readability as the semaphore, and slightly
> better object code, and you can drop the 'WARN_ON(host->current_req);'
> which would be known to be impossible.
> 

Correction: you would still need some form of serialization to
ensure that only one thread can set the host->current_req
at any time, so it's slightly more complex, either using
a mutex around the wait_event/assignment, or doing

	wait_event(&host->wq, !cmpxchg(host->current_req, NULL, mrq));

which probably wants to be encapsulated in an inline function
or annotated with a comment.

	Arnd
