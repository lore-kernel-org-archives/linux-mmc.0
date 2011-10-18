From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V9] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Tue, 18 Oct 2011 11:27:26 +0530
Message-ID: <CAGxe1ZHvRS9hek9-DSXZm1fkqPzUSVkWF5yEGXTC4K8usA31WQ@mail.gmail.com>
References: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
	<4E9D0B9F.1060303@samsung.com>
	<m2ehya6ecb.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61294 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab1JRF52 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2011 01:57:28 -0400
In-Reply-To: <m2ehya6ecb.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>

On 18 October 2011 11:17, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Tue, Oct 18 2011, Jaehoon Chung wrote:
>> Hi Girish.
>>
>> This patch is merged on mmc-next..did you know that?
>> And if deleted commit id bd3151f6c55c553bed2c0df72792841457b75bb5,
>> I will re-work for eMMC feature4.5.
>> git://git.infradead.org/users/kmpark/linux-2.6-samsung emmc4.5
>>
>> To Chris.
>> If you re-commit this patch, i also change "git pull request".
>> there are duplicated code in Notify patch, so i didn't add to cache =
patch.
>
> I think I've fixed everything up -- I merged your pull request, inclu=
ded
> Girish's new patch, and moved the #defines for the CACHE_CTRL patch o=
ver
> to that patch instead of the power class patch. =A0Would be great if =
you
> can double-check that the merge all looks okay to you.
>  missing one thing.    unsigned int        power_notify_type; in incl=
ude/linux/mmc/host.h
is not alligned to the above member, which was done in my latest patch
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
