From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 4/9] mmc: cavium: Work-around hardware bug on cn6xxx
 and cnf7xxx
Date: Mon, 20 Mar 2017 21:34:28 +0100
Message-ID: <CAK8P3a17efGLGxANiQO2htAeKNPey=HvSA16Tn-Ti7aYu2O-0A@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-5-jglauber@cavium.com>
 <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36579 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbdCTUhE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 16:37:04 -0400
In-Reply-To: <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jan Glauber <jglauber@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On Fri, Mar 17, 2017 at 3:13 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
>> Prevent data corruption on cn6xxx and cnf7xxx.
>> Due to an imperfection in the design of the MMC bus hardware,
>> + */
>> +void l2c_unlock_mem_region(u64 start, u64 len)
>> +{
>> +       u64 end;
>> +
>> +       /* Round start/end to cache line boundaries */
>> +       end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
>> +       start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
>> +
>> +       while (start <= end) {
>> +               l2c_unlock_line(start);
>> +               start += CVMX_CACHE_LINE_SIZE;
>> +       }
>> +}
>> +EXPORT_SYMBOL_GPL(l2c_unlock_mem_region);
>
> It seems like we should be able to implement these functions in the
> octeon mmc driver, instead of having to export some SoC specific APIs.
> You only need to figure out how to find the correct CACHE_LINE_SIZE,
> but that should be possible to fix.
>
> My point is really that we should avoid exporting SoC specific APIs
> which shall be called from drivers. This is old fashion.

Right, we wouldn't do this on arm64 either, so it's better not to introduce
it for mips now when you want to have an arm64 version next.
You should also try to have every driver enabled for
CONFIG_COMPILE_TEST, which doesn't work with architecture
specific hacks.

     Arnd
