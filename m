From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: MMC patches in-flight.
Date: Thu, 2 Sep 2010 02:47:33 -0400
Message-ID: <AANLkTi=GT3skpduHToFZ3DnfvrgvAqRuZb5GpHwzYLM-@mail.gmail.com>
References: <m3tym9xbwx.fsf@pullcord.laptop.org>
	<20100902055023.GA6733@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45464 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab0IBGre convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 02:47:34 -0400
Received: by iwn5 with SMTP id 5so209742iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Sep 2010 23:47:33 -0700 (PDT)
In-Reply-To: <20100902055023.GA6733@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Sep 2, 2010 at 1:50 AM, Matt Fleming <matt@console-pimps.org> w=
rote:
> On Wed, Sep 01, 2010 at 07:49:02PM -0400, Chris Ball wrote:
>> Hi,
>>
>> Here's an attempt to summarize the state of MMC patches submitted to
>> linux-mmc@ that haven't been merged. =A0Feel free to correct anythin=
g,
>> especially if you have a patch that you think is waiting to be merge=
d
>> that I've listed without "->", or that I haven't listed at all.
>> Please also consider reviewing any patches in the "review" state.
>> Thanks!
>>
>> Patch author =A0 | Patch subject =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0| Next step
>
> [...]
>
>> Yusuke Goda =A0 =A0| tmio_mmc: Revise a limit of the data size =A0 =A0=
| resubmit
>
> This patch is actually now called,
>
> "[PATCH v2] tmio_mmc: Allow 2 byte requests in 4-bit mode" and it's i=
n
> the testing phase.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Hi, Chris

Still two patches for spec 3.0 already merged by Andrew

 Patch author   | Patch subject
Zhangfei Gao   | sdhci: support 10-bit divided clock Mode
Zhangfei Gao   | sdhci: base clock freqency change in spec 3.0

The second one should be based on the first one.

Thanks
