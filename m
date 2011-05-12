From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: fixed wrong regulator_enable in suspend/resume
Date: Thu, 12 May 2011 10:01:49 +0100
Message-ID: <BANLkTiksx+C+6F-C5kcrzUXTquvm2NuzTQ@mail.gmail.com>
References: <4DCA3237.3080609@samsung.com>
	<m3pqnp2vvl.fsf@pullcord.laptop.org>
	<4DCB4D9B.8050706@samsung.com>
	<m3tyd0zily.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56021 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab1ELJBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2011 05:01:50 -0400
Received: by iyb14 with SMTP id 14so1054106iyb.19
        for <linux-mmc@vger.kernel.org>; Thu, 12 May 2011 02:01:50 -0700 (PDT)
In-Reply-To: <m3tyd0zily.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, May 12, 2011 at 4:46 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, May 11 2011, Jaehoon Chung wrote:
>> Hi Chris..
>>
>> I think you're confused something because my explanation.
>>
>> My means..if we use the regulator, regulator is enabled when probing=
=2E
>> Then regulator is enabling until we don't disable..
>>
>> In order to power-save, disabled the regulator when entered suspend.
>> Already in suspend function, located "regulator_disable()".
>> but also located "regulator_enable()" in suspend function.
>>
>> So i think right that "regulator_enable()" is located in resume func=
tion.
>> not in suspend function.
>
> Thanks, I agree. =A0I hadn't looked at the suspend function, but now =
I see
> that it already has the disable.
>
> Will, want to ACK this before I merge it?

Looks ok to me, although I don't have suitable hardware to test it.

Acked-by: Will Newton <will.newton@imgtec.com>
