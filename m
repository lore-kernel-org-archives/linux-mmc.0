From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Subject: Re: [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when
 needed in ->probe()
Date: Thu, 17 Mar 2016 16:36:35 +0900
Message-ID: <56EA5E83.5050008@jinso.co.jp>
References: <1455195595-5121-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFqZkJGPgojY52H2=4JjdR9gvJCe99_ZCv98ZNs4eUdRrg@mail.gmail.com>
 <56DCF2AD.3000806@jinso.co.jp>
 <CAPDyKFr8wrWYn2sy2rdKmmTkiLEuLOCarbL51gYr=xGJ_6C7SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www1246.sakura.ne.jp ([219.94.162.56]:58527 "EHLO
	www1246.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbcCQHg4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2016 03:36:56 -0400
In-Reply-To: <CAPDyKFr8wrWYn2sy2rdKmmTkiLEuLOCarbL51gYr=xGJ_6C7SA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Ulf,

Thank for your reply.

On 2016=E5=B9=B403=E6=9C=8816=E6=97=A5 18:53, Ulf Hansson wrote:
> On 7 March 2016 at 04:17, Nguyen Viet Dung <nv-dung@jinso.co.jp> wrot=
e:
>> Hi Ulf
>>
>> I have testted two cases use these patchs that you send.
>>
>> case01:
>> [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when ne=
eded in
>> ->probe()
>> [PATCH 2/3] mmc: sh_mmcif: Restructure ->set_ios()
>> [PATCH 3/3] mmc: sh_mmci: Get rid of wrapper function for regulators
>>
>> case02:
>> [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when ne=
eded in
>> ->probe()
>>
>> The problem of mmcif is not resolved by both two cases.
> Okay, thanks for testing!
>
> Even if it doesn't solve you original issue after a system PM resumed
> has been accomplished, does the driver still works as before? In othe=
r
> words are cards detected properly and can data transfers be done?
After a system PM resumed has been accomplished,if write data to mmc th=
en
happen kernel panic.
> The reason for my question, is that I think these patches makes some
> nice cleanups of some of the PM related code in the driver. So unless
> you see a *new* regression, I would like to apply them.
If see only this problem of mmc,i can not know effect of these patchs.

Best regards,
Nguyen Viet Dung.
