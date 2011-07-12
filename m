From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [RFC] Kernel NULL pointer dereference for mmc
Date: Tue, 12 Jul 2011 13:40:23 +0200
Message-ID: <CAJ0pr18-UvxHwfWuVFy=TfLvWSbfRwAY1CL0EBh+fPOi6KPGRw@mail.gmail.com>
References: <4E1BCC49.6050708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50269 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab1GLLkY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2011 07:40:24 -0400
Received: by qwk3 with SMTP id 3so2314584qwk.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2011 04:40:23 -0700 (PDT)
In-Reply-To: <4E1BCC49.6050708@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 12 July 2011 06:23, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi
>
> When I tested MMC card with IOzone, i found this message..
> I tried to find what problem..but i didn't find yet..
>
> So i want to get mailing's help..Have ever seen the below message?
> (using SDHCI controller, eMMC 4.41 card, 8-bit buswidth)
>
> I didn't applied about post_req/pre_req in sdhci.c.
> (using latest kernel in mmc-tree)
>
It's fine to set post_req and pre_req to NULL (default value is NULL)
Can you post the IOzone command line?
I want to run the same IOzone command on Snowball and Pandaboard.

Thanks,
Per
