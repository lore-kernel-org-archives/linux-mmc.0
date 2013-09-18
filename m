From: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Adding aliases to mmc
Date: Wed, 18 Sep 2013 19:01:25 +0200
Message-ID: <5239DC65.3080803@gmail.com>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com> <5239C40C.9030503@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5239C40C.9030503-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Am 18.09.2013 17:17, schrieb Stephen Warren:
> On 09/17/2013 12:04 PM, Fabio Estevam wrote:
>> Hi Dirk,
>>
>> I have adapted your patch at:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/111022.html
>>
>> and tested it on 3.12-rc1 on a mx6qsabresd board.
>>
>> Do you have plans to submit it? Maybe as a RFC?
>>
>> It solves the mmcblkX order issue on my tests and it would be nice we
>> could have this problem addressed.
>
> Patches to make mmc block devices have static names have been proposed
> in the past and rejected. I think the main reason is that the block
> device names are (or can be) dynamic, so anything that assumes a
> particular naming scheme is simply broken.
>
> The correct solution is to use e.g. root=UUID=xxx or root=PARTUUID=xxx,
> or similar techniques for other filesystems (e.g. /etc/fstab)

To my understanding this doesn't work if you need to have your rootfs 
on a SD card/eMMC with different UUIDs on each board (SD card/eMMC)?

Best regards

Dirk

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
