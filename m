From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Sun, 28 Oct 2012 15:12:14 +0200
Message-ID: <508D2F2E.3020006@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>	<5088206C.7080101@stericsson.com>	<50893E88.9000908@codeaurora.org>	<5089549D.3060507@stericsson.com> <CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:58507 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab2J1NMc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Oct 2012 09:12:32 -0400
In-Reply-To: <CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@gmail.com>
Cc: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>, Per Forlin <per.lkml@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello,

On 10/26/2012 02:07 PM, Venkatraman S wrote:

> 
> Actually there could a lot of reasons why block layer or CFQ would not have
> inserted the request into the queue. i.e. you can see a lot of exit paths
> where blk_peek_request returns NULL, even though there could be any request
> pending in one of the CFQ requests queues.
> 
> Essentially you need to check what makes blk_fetch_request
> (cfq_dispatch_requests() ) return NULL when there is an element in
> queue, if at all.
> 

This is not important why block layer causes to blk_fetch_request() (or
blk_peek_request()) to return NULL to the MMC layer, but what is really
important - MMC layer should always be able to fetch the new arrived
request ASAP, after block layer notification (mmc_request() ) and this
is what my fix goes to implement.

And the fix is not changing block layer behavior.

Thanks

-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
