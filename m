From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Mon, 22 Feb 2010 17:50:31 +0200
Message-ID: <94a0d4531002220750g5c3568d2g79b455d07012ad39@mail.gmail.com>
References: <cover.1266847842.git.david.vrabel@csr.com>
	 <94a0d4531002220655p675f7648rdfd302ea6aeb1b58@mail.gmail.com>
	 <4B829EA6.40307@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4B829EA6.40307@csr.com>
Sender: linux-omap-owner@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 22, 2010 at 5:11 PM, David Vrabel <david.vrabel@csr.com> wr=
ote:
> Felipe Contreras wrote:
>> On Mon, Feb 22, 2010 at 4:24 PM, David Vrabel <david.vrabel@csr.com>=
 wrote:
>>> These patches add support for SDIO cards to the omap_hsmmc driver.
>>> Power management changes to prevent SDIO cards from being turned of=
f
>>> and losing all state, and card interrupts.
>>>
>>> I've been unable to test these exact patches as I only have an N900=
 for
>>> testing and the N900 support in mainline is incomplete.
>>
>> Can't you get the source code with 'apt-get source' in Maemo SDK? It=
's
>> a tarball but at least it's something.
>
> I have SDIO cards tested and working on the N900 with the Fremantle
> kernel but that's a modified 2.6.28 kernel. =C2=A0These patches are f=
or
> mainline and there are differences between mainline and the fremantle
> kernel that means they need different patches.

Ah, got it. I was wondering how exactly did you test the patches.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
