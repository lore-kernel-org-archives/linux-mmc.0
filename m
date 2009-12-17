From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH/RFC] tmio_mmc: keep card-detect interrupts enabled
Date: Thu, 17 Dec 2009 13:12:39 -0800
Message-ID: <20091217131239.0dfd5534.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0911061127240.4389@axis700.grange>
	<c09aa50a0911090242l35d0dfb2vec0cdeff8b86d33e@mail.gmail.com>
	<Pine.LNX.4.64.0911091530030.4289@axis700.grange>
	<c09aa50a0911091218i681449e0r5cb96b9db3e0def6@mail.gmail.com>
	<Pine.LNX.4.64.0911092134440.4289@axis700.grange>
	<c09aa50a0911091736k27d66483t9012e296bfbf578a@mail.gmail.com>
	<Pine.LNX.4.64.0911282002490.3696@axis700.grange>
	<Pine.LNX.4.64.0912162223170.5283@axis700.grange>
	<Pine.LNX.4.64.0912172113510.5991@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43132 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765175AbZLQVMq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2009 16:12:46 -0500
In-Reply-To: <Pine.LNX.4.64.0912172113510.5991@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

On Thu, 17 Dec 2009 21:25:52 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> I originally submitted this [1] patch on the 6th of November, then 
> accidentally the MMC list got dropped from CC and the discussion moved to 
> another irrelevant list, Ian's last reply is at [2]. Unfortunately, Ian 
> hasn't replied to my reminders since then, and I don't see this patch 
> anywhere upstream. Is there any way we could get it into 2.6.33?

Please redo and retest it against curent mainline and do a full resend.
