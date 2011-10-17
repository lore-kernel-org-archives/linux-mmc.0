From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V8] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Mon, 17 Oct 2011 20:01:10 +0530
Message-ID: <CAGxe1ZF-UdHMXXBAyH_tfnGm7AbEQ7r0NVYmu+hL53HNvhmydQ@mail.gmail.com>
References: <1318487656-8566-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2lisofsov.fsf@bob.laptop.org>
	<CAGxe1ZHgHMEzBq=eDiPUhPmQZSM33WGA9HLs_ejWnsxpLC1mTQ@mail.gmail.com>
	<m262jn944t.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41567 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760Ab1JQObL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 10:31:11 -0400
In-Reply-To: <m262jn944t.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

On 17 October 2011 18:17, Chris Ball <cjb@laptop.org> wrote:
> Hi Girish,
>
> On Mon, Oct 17 2011, Girish K S wrote:
>>>> + if (card !=3D NULL && mmc_card_mmc(card) &&
>>>
>>> !=3D NULL is unnecessary.
>>
>> This is required. Let me explain the scenario where i felt it is nec=
essary.
>
> I'm not saying that you shouldn't test whether card is NULL -- I'm
> saying that "if (card && mmc_card_mmc(card) && " would perform this
> test with fewer characters, and be idiomatic for the kernel.
>
After fetching your mmc-next branch. i can see that this patch is
already applied. How about the changes that have been pointed here?

> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
