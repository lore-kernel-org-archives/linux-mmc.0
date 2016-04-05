From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when
 needed in ->probe()
Date: Tue, 5 Apr 2016 13:11:56 +0200
Message-ID: <CAPDyKFrNYuKmDjvz=-7OH=S32eHK=8tGwQbh8n=JEVjJM7uDmw@mail.gmail.com>
References: <1455195595-5121-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFqZkJGPgojY52H2=4JjdR9gvJCe99_ZCv98ZNs4eUdRrg@mail.gmail.com>
	<56DCF2AD.3000806@jinso.co.jp>
	<CAPDyKFr8wrWYn2sy2rdKmmTkiLEuLOCarbL51gYr=xGJ_6C7SA@mail.gmail.com>
	<56EA5E83.5050008@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34581 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807AbcDELL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2016 07:11:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id l6so18728506wml.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2016 04:11:57 -0700 (PDT)
In-Reply-To: <56EA5E83.5050008@jinso.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 17 March 2016 at 08:36, Nguyen Viet Dung <nv-dung@jinso.co.jp> wrote=
:
> Hi Ulf,
>
> Thank for your reply.
>
> On 2016=E5=B9=B403=E6=9C=8816=E6=97=A5 18:53, Ulf Hansson wrote:
>>
>> On 7 March 2016 at 04:17, Nguyen Viet Dung <nv-dung@jinso.co.jp> wro=
te:
>>>
>>> Hi Ulf
>>>
>>> I have testted two cases use these patchs that you send.
>>>
>>> case01:
>>> [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when n=
eeded
>>> in
>>> ->probe()
>>> [PATCH 2/3] mmc: sh_mmcif: Restructure ->set_ios()
>>> [PATCH 3/3] mmc: sh_mmci: Get rid of wrapper function for regulator=
s
>>>
>>> case02:
>>> [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when n=
eeded
>>> in
>>> ->probe()
>>>
>>> The problem of mmcif is not resolved by both two cases.
>>
>> Okay, thanks for testing!
>>
>> Even if it doesn't solve you original issue after a system PM resume=
d
>> has been accomplished, does the driver still works as before? In oth=
er
>> words are cards detected properly and can data transfers be done?
>
> After a system PM resumed has been accomplished,if write data to mmc =
then
> happen kernel panic.
>>
>> The reason for my question, is that I think these patches makes some
>> nice cleanups of some of the PM related code in the driver. So unles=
s
>> you see a *new* regression, I would like to apply them.
>
> If see only this problem of mmc,i can not know effect of these patchs=
=2E

As I understand your test, there are no new issues observed. For that
reason, I am going to apply patch 1->3 for next to give them some more
testing. Please tell me if any new issues pops up.

Regarding the issue you reported as a regression, unfortunate it seems
like someone with the hardware at hand needs to some debugging.

Kind regards
Uffe
