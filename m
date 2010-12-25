From: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 25 Dec 2010 22:54:18 +0100
Message-ID: <AANLkTinBpuPZGrOZww=DbW8Z9A0qAZGNswcanSaQKOKp@mail.gmail.com>
References: <AANLkTi=aHU57xDq+-DWrN2sJsAwx_9bZ_ofy1rOmp0VH@mail.gmail.com>
	<Pine.LNX.4.44L0.1012251046060.5079-100000@netrider.rowland.org>
	<AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ohad,

On Sat, Dec 25, 2010 at 9:58 PM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote=
:
> On Sat, Dec 25, 2010 at 6:21 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLsd9G2dDO2Ms@public.gmane.org=
u> wrote:
>> Right. =A0You may or may not realize it, but this requirement means =
that
>> the driver _must_ bypass runtime PM sometimes.
>
> http://www.spinics.net/lists/linux-pm/msg22864.html
>
>> Now you've lost me. =A0Which of the driver's handlers are you talkin=
g
>> about?
>
> The driver's handler, which is called by mac80211, and is responsible
> to power off the device.
> The _same_ handler is being called either during runtime or during a
> system transition to suspend
>
>> What races?
>
> Driver thinks power is off and device is now fully reset, but it's is=
n't really

maybe it's worth starting off with the description of chip power
states and how they are mapped to runtime PM and static PM?

Most of the WLAN chips have some very low power modes, but you're
talking about _complete_ shutdown as a suspended state for both
runtime PM and static PM, is that correct?

Thanks,
   Vitaly
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
