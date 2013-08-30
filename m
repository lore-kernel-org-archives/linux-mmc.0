From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: mmc0: Timeout waiting for hardware interrupt.
Date: Fri, 30 Aug 2013 15:33:36 +0200
Message-ID: <CAH9NwWcdxDWHpy1O7+9SPysima72FWPPEVP_us_0KCZrv6Tv1w@mail.gmail.com>
References: <CAH9NwWcQ6528NxSShnO2Nfa4dyqD0j68wO9CqfR3i=cpGXQjNg@mail.gmail.com>
 <loom.20130823T162510-762@post.gmane.org> <CAH9NwWePDSADpVm2MzUCYHPfYLb0RrWJL=yqOCqSPwFF1e=tuw@mail.gmail.com>
 <CAH9NwWfjUQbw6-K5PCtb7KyNhgGRR0wvWu+_w-shje5zOgqarA@mail.gmail.com> <loom.20130828T090935-8@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:41284 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab3H3Nd6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 09:33:58 -0400
Received: by mail-qc0-f172.google.com with SMTP id c11so859614qcv.31
        for <linux-mmc@vger.kernel.org>; Fri, 30 Aug 2013 06:33:56 -0700 (PDT)
In-Reply-To: <loom.20130828T090935-8@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Prasanna.

> Sorry for the late reply. I had faced the similar problem in the past.
>

No problem...

> There are certain 4.5 features like BKOPS, Sanitize, cache control operations
> which uses CMD6 to trigger the operation and use DAT0 line for busy signalling
> which was not monitored for proper completion.
>
> Although in your case, eMMC is 4.41 and still BKOPS is supported. I see CMD6
> being sent before getting hardware timeout.
>
> I modified the timeout handling to consider such case (including erase as it
> also sometimes for some eMMC takes long time) and resolved these cases of
> "Timeout waiting for hardware interrupt".
>
> I'll soon present the patch in this forum for more discussions on it.

I am looking forward to get my hands on your patch :)

greets
--
Christian Gmeiner, MSc
