From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v9] mmc : general purpose partition support.
Date: Wed, 5 Oct 2011 01:36:26 +0900
Message-ID: <CAKYAXd_OhouoyExiWJCzkDSTUUB4cXafLjRPbHwMYgQ6dhsr9A@mail.gmail.com>
References: <1317745057-6328-1-git-send-email-linkinjeon@gmail.com>
	<m2botwloeq.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38989 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932522Ab1JDQg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2011 12:36:28 -0400
In-Reply-To: <m2botwloeq.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, adrian.hunter@intel.com, linus.walleij@linaro.org, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf.Hansson@stericsson.com, stefan.xk.nilsson@stericsson.com, per.forlin@stericsson.com, johan.rudholm@stericsson.com

2011/10/5 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Tue, Oct 04 2011, Namjae Jeon wrote:
>> It allows gerneral purpose partitions in MMC Device.
>> And I try to simpliy make mmc_blk_alloc_parts using mmc_part structu=
re suggested by Andrei Warkentin.
>> After patching, we can see general purpose partitions like this.
>>> cat /proc/partitions
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 0 847872 mmcblk0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 192 4096 mmcblk0gp3
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 160 4096 mmcblk0gp2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 128 4096 mmcblk0gp1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 96 =C2=A01052672 mmcblk0gp0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 64 =C2=A01024 mmcblk0boot1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 32 =C2=A01024 mmcblk0boot0
>>
>> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
>
> Still doesn't apply here. =C2=A0Are you sure you're on the "mmc-next"=
 branch
> of the repository?
Hi. Chris.

I receive mmc-next you inform like this.

git clone git://dev.laptop.org/users/cjb/mmc

What I did wrong ?

Thanks.
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =C2=A0 <cjb@laptop.org> =C2=A0 <http://printf.net/>
> One Laptop Per Child
>
