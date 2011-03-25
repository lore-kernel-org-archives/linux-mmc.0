From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 2/2] sdio: add power_restore support with MMC_PM_KEEP_POWER mode
Date: Fri, 25 Mar 2011 13:48:53 -0400
Message-ID: <m3ei5vks56.fsf@pullcord.laptop.org>
References: <AANLkTi=CSK8nRF7CTzsq06Bk8Cr74ZcwJBf53_wWbpnv@mail.gmail.com>
	<AANLkTimvLzgO1VHAbYz0uh-TVBGdLr-aDcyaGyzS2QMi@mail.gmail.com>
	<AANLkTimevrNU+JC=KvMzpGfip7cimPMo2cmBzvPiMb9R@mail.gmail.com>
	<AANLkTi=Zh2mY8SDRR6431=ykGOLAZJfmgAoDp09aV+O_@mail.gmail.com>
	<alpine.LFD.2.00.1103251315080.11889@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.1103251315080.11889-QuJgVwGFrdf/9pzu0YdTqQ@public.gmane.org> (Nicolas
	Pitre's message of "Fri, 25 Mar 2011 13:17:34 -0400 (EDT)")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
Cc: Wilson Loi <wlsloi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 25 2011, Nicolas Pitre wrote:
> On Sat, 26 Mar 2011, Wilson Loi wrote:
>
>> Sorry, this is the first time I sent a patch.
>> 
>> There are two case for the WLAN SDIO card to do power saving.
>> 1. Totally cut off the power of WLAN network interface.
>> 2. offload the network state to WLAN SDIO firmware.
>
> Case #2 is already supported with current code.  Patches for the 
> libertas driver are in the OLPC repository (no idea if they were 
> submitted upstream yet).

Yes, they're upstream now.  libertas/if_sdio.c:if_sdio_suspend() sets
MMC_PM_KEEP_POWER if a wakeup source has been set with "ethtool wol".

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
