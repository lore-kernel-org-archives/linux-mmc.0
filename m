From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH mmc-utils 0/6] mmc-utils: various cleanups
Date: Mon, 15 Jan 2018 14:00:24 +0100
Message-ID: <CAPDyKFosF1_FyhP9hyWu4qJZUAjTn5rz4s0evdLaCX7j5o03hA@mail.gmail.com>
References: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
 <CAPDyKFova9BpB7jMLav8Y3BP2426WLy=LOoj_ato7eUCeTcrxA@mail.gmail.com> <20180111205743.uinigacopk5eklgu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35396 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966047AbeAONAZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jan 2018 08:00:25 -0500
Received: by mail-io0-f174.google.com with SMTP id m11so3572803iob.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jan 2018 05:00:25 -0800 (PST)
In-Reply-To: <20180111205743.uinigacopk5eklgu@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Sascha Hauer <kernel@pengutronix.de>

On 11 January 2018 at 21:57, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Dec 21, 2017 at 03:21:33PM +0100, Ulf Hansson wrote:
>> On 21 December 2017 at 14:33, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > while trying to teach barebox to do what can be achived in Linux with
>> >
>> >         mmc enh_area set ...
>> >
>> > (not only by reading but also by stealing code from mmc-utils) I notic=
ed
>> > a few things that when fixed make it easier for me to copy code. These
>> > (and a few more) are fixed in this series.
>> >
>> > I hope I sent this series to the right people and list. If not, please
>> > excuse me not knowing it better. I'm thankful for hints where to send
>> > patches like this instead in the future.
>>
>> This is the right place!
>>
>> Chris maintains mmc-utils, however, I haven't heard from him for quite
>> a while, let's hope that he sees this!
>
> I heard nothing yet from Chris. So to ease not loosing my work I cloned
> Chris' repository to https://github.com/ukleinek/mmc-utils and pushed my
> patches there.

That's great!

Let's hope Chris gets back to this in a while.

Kind regards
Uffe
