From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 21:08:55 +0200
Message-ID: <AANLkTin6zdUb2C-3GU-FySb3Pmk5iHaG5neLNSG38Tdx@mail.gmail.com>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
 <Pine.LNX.4.44L0.1012110937100.10743-100000@netrider.rowland.org>
 <AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
 <201012181607.26628.rjw@sisk.pl> <AANLkTin23vbbA7+UDzh=v060HbkLMrJjB38cs+AWScPJ@mail.gmail.com>
 <1292690407.3653.2.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1292690407.3653.2.camel-8upI4CBIZJIJvtFkdXX2HixXY32XiHfO@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-pm mailing list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Dec 18, 2010 at 6:40 PM, Johannes Berg
<johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org> wrote:
> On Sat, 2010-12-18 at 18:00 +0200, Ohad Ben-Cohen wrote:
>
>> > That's where the problem is. =A0If there's a difference, from the =
driver's
>> > point of view, between suspend and some other operation, there sho=
uld be a
>> > way to tell the driver what case it actually is dealing with.
>>
>> Yes, the problem will be solved if the driver would bypass the runti=
me
>> PM framework on system suspend. mac80211 obviously has this
>> information, and technically it's very easy to let the driver know
>> about it.
>>
>> But the difference between suspend and normal operation is really
>> artificial: in both cases mac80211 just asks the driver to power its
>> device down, and the end result is exactly the same (a GPIO line of
>> the device is de-asserted in our case). The difference between these
>> two scenarios
>> exist only because runtime PM is effectively disabled during system
>> suspend, and therefore the driver has to look for an alternative way
>> to power down the device.
>
> Sounds to me like the difference isn't really in the driver, but the
> core PM subsystem. Why does it care when powering off a device whethe=
r
> it's during suspend, or during runtime?

Agree.

If we can add a dev_pm_info bit, that would allow using runtime PM API
during suspend/resume transitions, the driver will not have to care.

Rafael what do you think ? Is that totally unacceptable ?

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
