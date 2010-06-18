From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: sdhci : reduce irq off latency
Date: Fri, 18 Jun 2010 17:26:53 +0900
Message-ID: <AANLkTimlnN-Cs3tgO1_3cM6qV7uH6TFBEEFUm_tHrcBF@mail.gmail.com>
References: <4C19E5C3.2080700@parrot.com>
	<AANLkTinZ8If_JswEhoOShRZbQSjlh1uKgFYasnsfFeRx@mail.gmail.com>
	<4C1B26CD.5070405@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33776 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756992Ab0FRIdD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2010 04:33:03 -0400
Received: by gwj15 with SMTP id 15so422074gwj.19
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2010 01:33:01 -0700 (PDT)
In-Reply-To: <4C1B26CD.5070405@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

The main problem is sdhci_send_command function. it loops at while
function infinitely.

I just modify it to use udelay at there. then it's working well.
also I reduce the granularity as 1 usec instead of 10 usec (as you sugg=
ested).
it's also works.

Thank you,
Kyungmin Park

On Fri, Jun 18, 2010 at 4:57 PM, Matthieu CASTET
<matthieu.castet@parrot.com> wrote:
> Hi,
>
> Thanks you for the test.
>
> here a new version of the patch. It doesn't replace mdelay with jiffi=
es
> anymore. It changes mdelay to udelay (the granularity of 1 ms becomes=
 10
> us).
> I didn't mesure irq off latency with this patch.
>
> Matthieu
>
>
> Kyungmin Park a =E9crit :
>>
>> Hi,
>>
>> Not good news. This patch make a hang at probe time.
>> it's tested against commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date: =A0 Fri Jun 11 19:14:04 2010 -0700
>>
>> =A0 =A0Linux 2.6.35-rc3
>>
>> Thank you,
>> Kyungmin Park
>>
>> On Thu, Jun 17, 2010 at 6:07 PM, Matthieu CASTET
>> <matthieu.castet@parrot.com> wrote:
>>>
>>> sdhci code got tasklets (sdhci_tasklet_card and sdhci_tasklet_finis=
h),
>>> that does :
>>> {
>>> spin_lock_irqsave
>>>
>>> if (cond) {
>>> sdhci_reset
>>> sdhci_reset
>>> }
>>>
>>> spin_unlock_irqrestore
>>> }
>>>
>>> sdhci_reset {
>>> ...
>>> while (read_reg) {
>>> if (timeout =3D=3D 0)
>>> =A0break;
>>> timeout--;
>>> mdelay(1);
>>> }
>>> ...
>>> }
>>>
>>>
>>> The problem is that sdhci_reset [1] does busy pooling (with a granu=
larity
>>> of
>>> 1 ms) on a register up to a timeout of 100 ms.
>>>
>>> With the current code, we got irq off during 2*1ms. With the attach=
ed
>>> patch
>>> we reduce irq off to 30 us.
>>>
>>> Note that worst case 100 ms irq off still exist.
>>>
>>> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
>>>
>>>
>
