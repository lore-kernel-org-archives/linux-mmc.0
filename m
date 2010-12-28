From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Tue, 28 Dec 2010 22:41:29 +0200
Message-ID: <AANLkTikxmS0sw6HeXL5QhdzBzBU3U9+hTvsPcyJay5J6@mail.gmail.com>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
 <201012261937.21256.rjw@sisk.pl> <AANLkTinewad6YxXvn5gnJQ+HJn41Sg96319GQn9KRKWj@mail.gmail.com>
 <201012282104.06232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201012282104.06232.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 28, 2010 at 10:04 PM, Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote=
:
> On Tuesday, December 28, 2010, Ohad Ben-Cohen wrote:
>> On Sun, Dec 26, 2010 at 8:37 PM, Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wro=
te:
>> > So, it only happens during asynchronous suspend? =A0In other words=
, if suspend
>> > is synchronous, everything should be fine, right?
>>
>> Not necessarily.
>
> So it's not a race after all, is it?

There are several scenarios to the same problem.. In one of them, we
were racing against an event that caused a suspend handler of an
entirely unrelated device to fail. I'm trying very hard not to
overload this thread with irrelevant details.. but anyway this forked
discussion is a bit moot IMHO

> Second, what you'd really want to do (I guess) is:
>
> pm_runtime_put_noidle(device);
> device->bus->pm->runtime_suspend(device);

Yes, our workaround is somewhere in these lines. We're using it
regardless of the system state (runtime or suspending), and frankly,
we're happy with it, just like I said in:

http://www.spinics.net/linux/lists/linux-mmc/msg05052.html

I still call it a workaround though...
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
