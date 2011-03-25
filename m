From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC PATCH 0/1] dw_mmc: checking card busy with Status register
Date: Fri, 25 Mar 2011 10:58:17 +0000
Message-ID: <AANLkTi=gsKHmuWLZGFW+YUmp4MvPQnbVeD2XGbf8b7xB@mail.gmail.com>
References: <4D8C2F82.2040504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61949 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab1CYK6S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 06:58:18 -0400
Received: by iwn34 with SMTP id 34so927276iwn.19
        for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2011 03:58:18 -0700 (PDT)
In-Reply-To: <4D8C2F82.2040504@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Fri, Mar 25, 2011 at 6:00 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This RFC patch is applied checking card busy with status register.
>
> In Status register, bit[9] indicate the card busy or not.
> So, if we use this bit in status register, we can check the card busy or not.
>
> Maybe, didn't increased the performance, but i think this approach is decreased
> the CPU usage.
>
> Anyone, let me know how think about this patch.

Do you have any numbers to report how this patch altered CPU usage or
card throughput for you? e.g. oprofile output or dd performance
