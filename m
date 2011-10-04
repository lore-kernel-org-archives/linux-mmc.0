From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v8] mmc : general purpose partition support.
Date: Tue, 4 Oct 2011 12:49:28 +0900
Message-ID: <CAKYAXd_YKrDWC-XOyqYPgtBjbVQz6B+x8J5N1iJv9=4bwRk+tA@mail.gmail.com>
References: <1317641240-15791-1-git-send-email-linkinjeon@gmail.com>
	<m2vcs5lbtx.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64021 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab1JDDtf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2011 23:49:35 -0400
In-Reply-To: <m2vcs5lbtx.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, adrian.hunter@intel.com, linus.walleij@linaro.org, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf.Hansson@stericsson.com, stefan.xk.nilsson@stericsson.com, per.forlin@stericsson.com, johan.rudholm@stericsson.com

2011/10/4 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Mon, Oct 03 2011, Namjae Jeon wrote:
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
> v8 doesn't apply against mmc-next, please resend. =C2=A0mmc-next has =
moved to:
> =C2=A0 git://dev.laptop.org/users/cjb/mmc mmc-next
>
> (Thanks for reviewing, Andrei -- please send another ACK after v9 is
> submitted, if you don't mind.)
Hi. Chris.
I will resend patch again after rebase from moved mmc-next.
Thanks.
>
> - Chris.
> --
> Chris Ball =C2=A0 <cjb@laptop.org> =C2=A0 <http://printf.net/>
> One Laptop Per Child
>
