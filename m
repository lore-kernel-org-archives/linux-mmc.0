From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: mmc0: Timeout waiting for hardware interrupt.
Date: Fri, 23 Aug 2013 18:08:43 +0200
Message-ID: <CAH9NwWePDSADpVm2MzUCYHPfYLb0RrWJL=yqOCqSPwFF1e=tuw@mail.gmail.com>
References: <CAH9NwWcQ6528NxSShnO2Nfa4dyqD0j68wO9CqfR3i=cpGXQjNg@mail.gmail.com>
 <loom.20130823T162510-762@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:50032 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825Ab3HWQJD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 12:09:03 -0400
Received: by mail-qc0-f178.google.com with SMTP id p19so434951qcv.9
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 09:09:03 -0700 (PDT)
In-Reply-To: <loom.20130823T162510-762@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Prasanna.

> What was the previous command sent before CMD13 when timeout happened?
> Can you share some 5 seconds log before the Timeout start happening?

As the log got quite big I have uploaded it.
http://dpaste.dzfl.pl/a2b30bc5

> eMMC version being used is 4.41 or 4.5?

The eMMC is a 4.41 one -
http://omapworld.com/iNAND_e_MMC_4_41_IF_data_sheet_v1_0[1].pdf

thanks
--
Christian Gmeiner, MSc
