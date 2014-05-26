From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: host: add slot argument to mmc_of_parse
Date: Mon, 26 May 2014 10:44:16 +0200
Message-ID: <CAPDyKFrZXd30wXJNsO64-Np129_53D=TVv2yBmBhsOxJa0Sm6g@mail.gmail.com>
References: <1400840721-11050-1-git-send-email-jh80.chung@samsung.com>
	<1400840721-11050-2-git-send-email-jh80.chung@samsung.com>
	<20140526080916.GE12777@ldesroches-Latitude-E6320>
	<5382FD78.3060402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43896 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaEZIoR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 04:44:17 -0400
Received: by mail-qc0-f174.google.com with SMTP id c9so3611615qcz.19
        for <linux-mmc@vger.kernel.org>; Mon, 26 May 2014 01:44:16 -0700 (PDT)
In-Reply-To: <5382FD78.3060402@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Tushar Behera <tushar.behera@linaro.org>

On 26 May 2014 10:38, Jaehoon Chung <jh80.chung@gmail.com> wrote:
> Hi,
>
> On 05/26/2014 05:09 PM, Ludovic Desroches wrote:
>> On Fri, May 23, 2014 at 07:25:19PM +0900, Jaehoon Chung wrote:
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> Some hosts manage several slots. In these case information such as the
>>> bus width, chi detect and others are into the slot node. So we have to
>>
>> /s/chi detect/chip detect
> Will fix.
>
> Tushar have suggested the rename mmc_of_parse_slot() instead of __mmc_of_parse().
> I'm not sure which name is better. How about?
>
> If never mind, i will change to mmc_of_parse_slot(), then send patch-v2.

I would prefer to keep it as is, but just because that's my taste. :-)

Kind regards
Ulf Hansson
