From: "Chaiken, Alison" <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: RE: Adding aliases to mmc
Date: Fri, 20 Sep 2013 06:30:42 +0000
Message-ID: <60BA5429A0E1584BA3633194F6F993B50E7CE937@NA-MBX-03.mgc.mentorg.com>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com>,<5239C40C.9030503@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5239C40C.9030503-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Stephen Warren writes:
>Patches to make mmc block devices have static names have been proposed
>in the past and rejected. I think the main reason is that the block
>device names are (or can be) dynamic, so anything that assumes a
>particular naming scheme is simply broken.

Why may network devices have static IPs and yet storage devices can't have static names?    Isn't insisting on dynamic names the same as insisting on DHCP?   

The  distinction appears to be historical, in that DHCP has been around a long time, but no one cared about boot times of MMC-based devices until relatively recently.    Doesn't the same argument apply to all aliases, not to mention "chosen" node?   Consider what Russell King said recently:

http://thread.gmane.org/gmane.linux.kernel/1532141/focus=1532265

I understand that there is a widespread desire to institute a new level of quality control in the device-tree, but if we are agreeing on a new rule, let's be explicit about it.

-- 
Alison Chaiken
Mentor Embedded Software
Fremont CA USA
GMT-8--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
