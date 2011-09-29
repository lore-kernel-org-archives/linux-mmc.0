From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v2] mmc : general purpose partition support.
Date: Thu, 29 Sep 2011 17:35:04 +0900
Message-ID: <CAKYAXd9GqnmV5vz1BUa0oaHE6TBt85gJKCxRmxuR=Qno5kXAkA@mail.gmail.com>
References: <1316840820-2014-1-git-send-email-linkinjeon@gmail.com>
	<CACRpkdZM-F-E_RUu4JTd-1J8UeQWXiekBcnMf7Jp7m07B8SYVQ@mail.gmail.com>
	<CAKYAXd-=EaG02N6f2VWO0ZNCshWp6swiT-WwpOV-p+cTDL7wwA@mail.gmail.com>
	<CACRpkdaCVj1J10BeCbOgwvRAqfN=gmV-1_FYmd9W1cwFqWMiag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58528 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab1I2IfG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 04:35:06 -0400
In-Reply-To: <CACRpkdaCVj1J10BeCbOgwvRAqfN=gmV-1_FYmd9W1cwFqWMiag@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, adrian.hunter@intel.com, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf Hansson <Ulf.Hansson@stericsson.com>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Per Forlin <per.forlin@stericsson.com>, johan.rudholm@stericsson.com

2011/9/29 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Sep 28, 2011 at 3:50 PM, NamJae Jeon <linkinjeon@gmail.com> w=
rote:
>> 2011/9/28 Linus Walleij <linus.walleij@linaro.org>:
>>> On Sat, Sep 24, 2011 at 7:07 AM, Namjae Jeon <linkinjeon@gmail.com>=
 wrote:
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 64 =C2=A01024 mmcblk0boot1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 32 =C2=A01024 mmcblk0boot0
>>>
>>> Does this mean that each GP-partition can contain an MBR and thus s=
everal
>>> subpartitions so we get things like:
>>>
>>> mmcblk0gp1p1, mmcblk0gp1p2...
>>>
>> Yes, We can divide dos partitions(included MBR) using fdisk like you=
r
>> words(mmcblk0gp1p1, mmcblk0gp1p2...)
>
> OK that seems logical.
>
> If this goes in, make a mental note to patch udev default rules
> too, because currently they look like this:
>
> rules.d/60-persistent-storage.rules:KERNEL=3D=3D"mmcblk[0-9]",
> SUBSYSTEMS=3D=3D"mmc", ATTRS{name}=3D=3D"?*", ATTRS{serial}=3D=3D"?*"=
,
> ENV{ID_NAME}=3D"$attr{name}", ENV{ID_SERIAL}=3D"$attr{serial}",
> SYMLINK+=3D"disk/by-id/mmc-$env{ID_NAME}_$env{ID_SERIAL}"
> rules.d/60-persistent-storage.rules:KERNEL=3D=3D"mmcblk[0-9]p[0-9]",
> ENV{ID_NAME}=3D=3D"?*", ENV{ID_SERIAL}=3D=3D"?*",
> SYMLINK+=3D"disk/by-id/mmc-$env{ID_NAME}_$env{ID_SERIAL}-part%n"
>
> (I guess Android also has this kind of rule baked into its "big init"
> process that handles also what udev normally takes care of.)
>
> Anyway:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Thanks Linus~
I will modify a little code to improve the readability.
When I post patch v3 again, plz ack one more.
>
> Yours,
> Linus Walleij
>
