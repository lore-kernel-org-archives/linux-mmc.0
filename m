From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller
Date: Tue, 19 Apr 2016 21:33:23 +0200
Message-ID: <CAPDyKFqM3VxYE+KtC++=5=Bjket0mCnLAuN3_436O_=TSMzAHA@mail.gmail.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com>
	<CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org>
	<CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org>
	<CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org>
	<CAPDyKFpYfDeT5LDfEMXxgZiHmnNx7Aau+m7Dq=+Sj+4ntrtfDw@mail.gmail.com>
	<5716592A.6000505@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38271 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbcDSTda (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 15:33:30 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so46898930wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 12:33:24 -0700 (PDT)
In-Reply-To: <5716592A.6000505@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Matt Redfearn <Matt.Redfearn@imgtec.com>, David Daney <david.daney@cavium.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

On 19 April 2016 at 18:13, David Daney <ddaney@caviumnetworks.com> wrote:
> On 04/19/2016 02:15 AM, Ulf Hansson wrote:
> [...]
>>
>>
>>  From this discussion I have understood that we clearly need a way to
>> describe mmc slots in DT!
>>
>> Unfortunate we should have discussed this before you decided to ship
>> devices with DTBs containing non accepted DT bindings, but hey better
>> late than never! :-)
>
>
> This is a point where the DT and mmc maintainers have a continual
> misunderstanding of the facts.
>
> There were requests to discuss the binding as far back as 2012:
>
> https://www.linux-mips.org/archives/linux-mips/2012-05/msg00119.html
>
> They were met with silence.

I am aware of that. I was not the maintainer of MMC back then, if I
where I would probably said the same thing as of today.

Moreover, for sure you could have been more persistent trying to get
peoples attention before you decided to deploy the DTB.

>
> The firmware containing these bindings is out in the wild.  If we deprecate
> some of the bindings, the driver will still have to support them in the
> future.
>
> In the case of OCTEON based devices, the device tree bindings are a firmware
> <--> kernel ABI as the device trees always come from the firmware and not
> some other place.

Now, I am not going spend more time arguing, instead I prefer if we
can be constructive.

As the maintainer of MMC, I have tried to be helpful by providing you
with my view on how we can move forward.

I don't think it's a big deal for you to implement something along
those lines for what I have requested, or is it?

Kind regards
Uffe
