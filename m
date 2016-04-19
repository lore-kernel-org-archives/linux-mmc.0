From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: Improve marking broken HPI through devicetree
Date: Tue, 19 Apr 2016 11:51:00 +0200
Message-ID: <CAPDyKFrhyqHYmSjrC23bHOkkz2F0QJGwbDKyryfEmoJhwkgMtg@mail.gmail.com>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
	<1461049934-12848-2-git-send-email-oliver@schinagl.nl>
	<CAPDyKFqftYtrHvcQB7te1fuWxjWtrhOGY=5DnRTnrRxHm2cQ-A@mail.gmail.com>
	<5715FD6B.5000809@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33220 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbcDSJvH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 05:51:07 -0400
Received: by mail-wm0-f53.google.com with SMTP id 127so3608316wmz.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 02:51:01 -0700 (PDT)
In-Reply-To: <5715FD6B.5000809@schinagl.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Hocko <mhocko@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wenkai Du <wenkai.du@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Hans de Goede <hdegoede@redhat.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Suchanek <hramrach@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19 April 2016 at 11:42, Olliver Schinagl <oliver@schinagl.nl> wrote:
> Hi Ulf,
>
> On 19-04-16 11:29, Ulf Hansson wrote:
>>
>> On 19 April 2016 at 09:12, Olliver Schinagl <oliver@schinagl.nl> wrote:
>>>
>>> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an mmc
>>> device as to having an broken HPI implementation. After talking some
>>> with Hans, we now think it is actually the mmc controller that can be
>>> broken and not support broken HPI's.
>>
>> I don't want us to invent a DT binding for something you *think* is a
>> HW controller issue.
>>
>> Have you really excluded that this isn't a software issue? Me
>> personally haven't been using HPI that much so I can't really tell
>> about the code robustness from the mmc core (mmc protocol point of
>> view).
>
> Well this patch goes hand in hand so to speak with the broken-hpi patch
> introduced by him, he did most of the investigation. We just discussed how
> to handle it and asked me to cook up the patch.

Well, my point is that it's more understandable about having a broken
HPI implementation for eMMC cards, but for host controllers I am not
so sure.

I don't think there is an electrical change required by the host
controller to support HPI, is just like any other command, right?
Unless I am missing something, of course.

Kind regards
Uffe
