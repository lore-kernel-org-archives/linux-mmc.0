From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v2] mmc : general purpose partition support.
Date: Wed, 28 Sep 2011 22:50:17 +0900
Message-ID: <CAKYAXd-=EaG02N6f2VWO0ZNCshWp6swiT-WwpOV-p+cTDL7wwA@mail.gmail.com>
References: <1316840820-2014-1-git-send-email-linkinjeon@gmail.com>
	<CACRpkdZM-F-E_RUu4JTd-1J8UeQWXiekBcnMf7Jp7m07B8SYVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZM-F-E_RUu4JTd-1J8UeQWXiekBcnMf7Jp7m07B8SYVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, adrian.hunter@intel.com, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf Hansson <Ulf.Hansson@stericsson.com>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Per Forlin <per.forlin@stericsson.com>, johan.rudholm@stericsson.com
List-Id: linux-mmc@vger.kernel.org

2011/9/28 Linus Walleij <linus.walleij@linaro.org>:
> On Sat, Sep 24, 2011 at 7:07 AM, Namjae Jeon <linkinjeon@gmail.com> w=
rote:
>
>> It allows gerneral purpose partitions in MMC Device.
>> And I try to simpliy make mmc_blk_alloc_parts using mmc_part structu=
re suggested by Andrei Warkentin.
>> After patching, we can see general purpose partitions like this.
>>> cat /proc/partitions
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 0 847872 mmcblk0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 192 4096 mmcblk0gp4
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 160 4096 mmcblk0gp3
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 128 4096 mmcblk0gp2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 96 =C2=A01052672 mmcblk0gp1
>
> We notice there are 32 minors between 128 and 96,
> how are these allocated?
You can insert maximum minors in menuconfig. I set to 32.
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 64 =C2=A01024 mmcblk0boot1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 32 =C2=A01024 mmcblk0boot0
>
> Does this mean that each GP-partition can contain an MBR and thus sev=
eral
> subpartitions so we get things like:
>
> mmcblk0gp1p1, mmcblk0gp1p2...
>
>
Yes, We can divide dos partitions(included MBR) using fdisk like your
words(mmcblk0gp1p1, mmcblk0gp1p2...)

> Yours,
> Linus Walleij
>
