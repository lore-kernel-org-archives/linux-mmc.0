From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] s5pc110: SDHCI-s3c can override host capabilities
Date: Fri, 11 Jun 2010 08:06:45 +0900
Message-ID: <AANLkTinwSxo4OqWlwQE-RxpG8WubLku2-77k2q7DPphr@mail.gmail.com>
References: <20100605024053.GA23419@july>
	<20100610134304.c109811a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46574 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab0FJXGq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2010 19:06:46 -0400
Received: by pvg16 with SMTP id 16so188827pvg.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jun 2010 16:06:45 -0700 (PDT)
In-Reply-To: <20100610134304.c109811a.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org

hi,

On Fri, Jun 11, 2010 at 5:43 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 05 Jun 2010 11:40:53 +0900
> Kyungmin Park <kmpark@infradead.org> wrote:
>
>> From: Kyungmin Park <kmpark@infradead.org>
>> To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,=
 akpm@linux-foundation.org, ben-linux@fluff.org
>> Subject: [PATCH] s5pc110: SDHCI-s3c can override host capabilities
>> Date: Sat, 05 Jun 2010 11:40:53 +0900
>> User-Agent: Mutt/1.5.14 (2007-02-12)
>>
>> Each board can override the default sdhci host capabilities.
>> Some board has broken features by hardwares and support 8-bit bandwi=
dth.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> The way this patch was presented, it will go into git with an Author:
> address of "kmpark@infradead.org", but a Signed-off-by: address of
> "kyungmin.park@samsung.com". =A0Which is a little odd.
>
> The way to prevent that is to put an explicit "From:" line at the top
> of the changelog. =A0If that line is absent, people's tools will fall
> back to the From: line in the mail headers, which is what happened
> here.
>
> Please let me know if you want me to make any changes to these three
> patches.
>
No problem, please fix it freely.

Next time, I'll add the From line.
One more, mails from Marek has duplicated patches, so please ignore it.

Thank you,
Kyungmin Park
