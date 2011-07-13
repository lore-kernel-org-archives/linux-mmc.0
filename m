From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 13 Jul 2011 08:56:26 -0700
Message-ID: <871uxuqimt.fsf@ti.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
	<1309538376-23260-3-git-send-email-balajitk@ti.com>
	<8739ig8wby.fsf@ti.com>
	<5D8008F58939784290FAB48F5497519846C4113396@shsmsx502.ccr.corp.intel.com>
	<87sjqaql91.fsf@ti.com>
	<CANfBPZ-M+yrZv2r3sGYFRC4vRmD5AZ1b4FfyFYENmqH+FDgCcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANfBPZ-M+yrZv2r3sGYFRC4vRmD5AZ1b4FfyFYENmqH+FDgCcg@mail.gmail.com>
	(Venkatraman S.'s message of "Wed, 13 Jul 2011 21:04:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Balaji T K <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "kishore.kadiyala@ti.com" <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

"S, Venkatraman" <svenkatr@ti.com> writes:

> On Wed, Jul 13, 2011 at 8:29 PM, Kevin Hilman <khilman@ti.com> wrote:

[...]

>>
>> My basic question is this: why does this device need to be runtime
>> resumed during system suspend? =C2=A0Why can't it just stay runtime
>> suspended?
>>
>
> From my understanding, the runtime suspend is usually implemented to =
not
> lose the card 'context', i.e. transactions can continue after a
> runtime suspend /
> resume cycle.
>
> For system suspend, the MMC core sends a sleep command (which, in
> itself, is a transaction) to the card to go to sleep state, and for
> all practical purposes, the card is treated as 'removed'. When the
> system resumes, the card is rescanned and re-initialized.
>
> Hence, for system suspend, the MMC controller needs to be enabled to
> actually send the command which puts the card to sleep (and hence the
> resume).

Great, this is the detail I was looking for since my MMC knowledge is
quite limited. =20

So, in theory, this same sleep command could be sent during runtime
suspend as well, so that a system suspend would not have to runtime
resume, correct?  But I suppose it would result in a much higher latenc=
y
runtime resumes.  It might be worth experimenting with doing this,
possibly in combination with longer auto-suspend delay times.

Thanks for the explanation,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
