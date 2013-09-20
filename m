From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Adding aliases to mmc
Date: Fri, 20 Sep 2013 10:10:17 -0600
Message-ID: <523C7369.8060301@wwwdotorg.org>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com>,<5239C40C.9030503@wwwdotorg.org> <60BA5429A0E1584BA3633194F6F993B50E7CE937@NA-MBX-03.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <60BA5429A0E1584BA3633194F6F993B50E7CE937-0dz9ie/QGrnnlEkxMdpx1dQH9K4/4qFeAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Chaiken, Alison" <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 09/20/2013 12:30 AM, Chaiken, Alison wrote:
> Stephen Warren writes:
>> Patches to make mmc block devices have static names have been proposed
>> in the past and rejected. I think the main reason is that the block
>> device names are (or can be) dynamic, so anything that assumes a
>> particular naming scheme is simply broken.
> 
> Why may network devices have static IPs and yet storage devices can't have static names? 

Ethernet devices have MAC addresses as their unique ID. Block devices
have PARTUUIDs and filesystems have UUIDs. The IP address is keyed to
the MAC address.

(In desktop distributions these days, I believe that MAC address
typically drives device name via renaming, and then device name indexes
the network configuration, which then determines the IP. Alternatively,
MAC address drives IP address via DHCP).

To my mind, using UUIDs as the key rather than device name is exactly
the same situation, not a different one.

...
> I understand that there is a widespread desire to institute a new level of quality control in the device-tree, but if we are agreeing on a new rule, let's be explicit about it.

(please word-wrap your email)

I don't believe this has anything at all to do with device tree; my
first experience with this issue was long before DT.

The issue is that block device IDs cannot be equal to controller IDs, since:

* Mount an SD card -> assigned an ID at run-time
* Physically unplug it  -> ID kept since it's still referenced
* Plug a new card back in -> assigned a new ID at run-time

Therefore, there's no 1:1 match possible between SD/MMC controllers and
SD/MMC block device names. It's dynamic.

The same is true of USB mass storage devices too, I believe.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
