From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCHv10 3/5] ARM: dts: exynos: unuse the slot-node and deprecate
 the supports-highspeed for dw-mmc
Date: Mon, 18 Aug 2014 12:40:12 -0500
Message-ID: <53F23A7C.3060404@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com> <1407397082-32495-4-git-send-email-jh80.chung@samsung.com> <53F1F027.7060609@samsung.com> <53F20955.2050806@suse.de> <53F22FBB.4010801@samsung.com> <53F23283.8040303@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37823 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbaHRSVQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 14:21:16 -0400
In-Reply-To: <53F23283.8040303@suse.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/18/14 12:06, Andreas F=E4rber wrote:
> Am 18.08.2014 18:54, schrieb Kukjin Kim:
>> On 08/18/14 09:10, Andreas F=E4rber wrote:
>>> Hi Jaehoon,
>>>
>>> Am 18.08.2014 14:23, schrieb Jaehoon Chung:
>>>> Socfpga and Rockchip were queued into each SoC tree.
>>>> I want to know whether this patch is queued or not into Samsung-So=
c
>>>> tree.
>>>> Do you have any other plan for this patch?
>>>
>>> It isn't applied in his tree:
>>>
>>> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git=
/
>>>
>>> In fact Kukjin has not applied any patches for 3 weeks now, which l=
ikely
>>> means he's on vacation. I am hoping he will review this and the oth=
er
>>> pending conflicting patches to decide on a merge order and fix any
>>> trivial conflicts himself. ;)
>>>
>> Oh, I thought it has been queued in previous merge window with my ac=
k.
>>
>> OK, I've applied this in my tree for 3.18.
>
> So, are you dropping the snow mmc pinctrl patch Doug asked you to que=
ue
> before this one, and are you merging this with my exynos5250
> cros-common/style cleanups yourself or do I need yet another respin?
>
Hi Andreas,

Thanks for your gentle reminder and I think I can handle it when I appl=
y=20
it in my tree :)

Note I will check them today and if any problems, I'll let you know.

- Kukjin
