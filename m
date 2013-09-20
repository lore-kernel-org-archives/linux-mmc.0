From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Adding aliases to mmc
Date: Fri, 20 Sep 2013 11:03:12 -0600
Message-ID: <523C7FD0.3030006@wwwdotorg.org>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com> <5239C40C.9030503@wwwdotorg.org> <5239DC65.3080803@gmail.com> <5239DF55.8010308@wwwdotorg.org> <523A8A08.2060508@gmail.com> <523C7231.7040701@wwwdotorg.org> <523C79C4.1070308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <523C79C4.1070308-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 09/20/2013 10:37 AM, Dirk Behme wrote:
> Am 20.09.2013 18:05, schrieb Stephen Warren:
>> On 09/18/2013 11:22 PM, Dirk Behme wrote:
>> ...
>>> If you have an embedded system were you just care a little about boot
>>> time you don't want to do anything like U-Boot's "part uuid" every time
>>> you boot. Or even worse, you just have a minimalistic boot loader (e.g.
>>> U-Boot's SPL) which doesn't know anything about UUIDs and file systems.
>>>
>>> As mentioned above, no I don't think UUIDs work for production embedded
>>> systems.
>>
>> As I said above, whatever generates the filesystem image can easily
>> embed the appropriate UUID in the system's boot scripts or bootloader
>> environment. There's no need to run the "part" command at run-time if
>> there's a more appropriate flow for your situation.
> 
> Using a simple boot loader as an example, there are no boot scripts or
> boot loader environment. The only thing the boot loader does is loading
> the device tree and the kernel into RAM. Where do you want to embed an
> UUID in such a product?

I think the initrd would be typical.

> To my understanding, the UUID is different for each SD card/eMMC, correct?

Yes by default.

Although for an embedded product with a fixed eMMC, there's no reason
you couldn't make every device have the same UUID for the fixed device.
Obviously you wouldn't want to do that for any removable device.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
