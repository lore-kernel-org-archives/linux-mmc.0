From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize latency
Date: Tue, 21 Jun 2011 10:09:16 +0200
Message-ID: <BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58820 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab1FUIJQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 04:09:16 -0400
Received: by qyk29 with SMTP id 29so1934030qyk.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2011 01:09:16 -0700 (PDT)
In-Reply-To: <20110621075319.GN26089@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

On 21 June 2011 09:53, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Sun, Jun 19, 2011 at 11:17:26PM +0200, Per Forlin wrote:
>> How significant is the cache maintenance over head?
>
> Per,
>
> Can you measure how much difference this has before and after your
> patch set please?
Absolutely, I can run the mmc_tests to get the measurement. The cache
affect is greater the faster the flash memory is. Currently I only
have access to a SD card (20 MiB/S). By the end of this week I can run
on eMMC (45 MiB/s) if this will be needed.

Thanks for your input,
Per
