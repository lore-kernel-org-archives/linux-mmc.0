From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v9 00/12] use nonblock mmc requests to minimize latency
Date: Sat, 09 Jul 2011 18:09:45 -0400
Message-ID: <m2y607jec6.fsf@bob.laptop.org>
References: <1309539333-2606-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56692 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab1GIWJz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 18:09:55 -0400
In-Reply-To: <1309539333-2606-1-git-send-email-per.forlin@linaro.org> (Per
	Forlin's message of "Fri, 1 Jul 2011 18:55:21 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, "S, Venkatraman" <svenkatr@ti.com>

Hi Per,

On Fri, Jul 01 2011, Per Forlin wrote:
> How significant is the cache maintenance over head?
> It depends, the eMMC are much faster now
> compared to a few years ago and cache maintenance cost more due to
> multiple cache levels and speculative cache pre-fetch. In relation the
> cost for handling the caches have increased and is now a bottle neck
> dealing with fast eMMC together with DMA.

Thanks very much, I've pushed v9 of the patchset to mmc-next for 3.1
(after fixing some merge conflicts against Adrian Hunter's recent patches
and rewording some of the commit message texts).

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
