From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize latency
Date: Fri, 24 Jun 2011 10:58:31 +0200
Message-ID: <BANLkTi=8Awu4Z3ESizE9WDEyWNw0r9N0ug@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
	<BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
	<20110623133702.GZ23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58777 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab1FXI6d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2011 04:58:33 -0400
Received: by qwk3 with SMTP id 3so1243261qwk.19
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jun 2011 01:58:32 -0700 (PDT)
In-Reply-To: <20110623133702.GZ23234@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

On 23 June 2011 15:37, Russell King - ARM Linux <linux@arm.linux.org.uk=
> wrote:
> On Tue, Jun 21, 2011 at 11:26:27AM +0200, Per Forlin wrote:
>> Here are the results.
>
> It looks like this patch is either a no-op or slightly worse. =A0As
> people have been telling me that dsb is rather expensive, and this
> patch results in less dsbs, I'm finding these results hard to believe=
=2E
> It seems to be saying that dsb is an effective no-op on your platform=
=2E
>
The result of your patch depends on the number of sg-elements. With
your patch there is only on DSB per list instead of element I can
write a test to measure performance per number of sg-element in the
sg-list. Fixed transfer size but vary the number of sg-elements in the
list. This test may give a better understanding of the affect.

I have seen performance gain if using __raw_write instead of writel.
Writel test includes both the cost of DSB and the outer_sync, where
outer_sync is more expensive one I presume.

> So either people are wrong about dsb being expensive, the patch is
> wrong, or there's something wrong with these results/test method.
>
> You do have an error in the ported patch, as that hasn't updated the
> v7 cache cleaning code to remove the dsb() there, but that would only
> affect the write tests.
>
I will fix that mistake and also improve the test cases to measure the
cost per number of sg-elements.

I'll come back with new numbers on Monday.

Regards,
Per
